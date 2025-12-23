# frozen_string_literal: true

# Factory service that builds Daily Office content based on Prayer Book preferences
#
# This is the main entry point for generating Daily Office liturgies. It:
# - Delegates to Prayer Book-specific builders (e.g., LOC 2015)
# - Handles premium audio URL injection for authenticated users
# - Applies user preferences for Bible version, confession type, etc.
#
# CACHING STRATEGY (v4):
# Two-layer cache for maximum efficiency:
#
# 1. BASE OFFICE CACHE (shared between all users):
#    - Key: v4/daily_office/base/{date}/{office_type}/{preferences_hash}/pb_{updated_at}
#    - TTL: 1 day (until midnight)
#    - Contains: Full office structure WITHOUT user-specific data
#    - Benefit: One cache entry serves ALL users with same preferences
#
# 2. USER PERSONALIZATION (applied on top of cached base):
#    - Audio URLs are injected for premium users (from LiturgicalText cache)
#    - User completion data is NOT cached (fetched fresh from controller)
#    - This keeps user-specific logic fast and simple
#
# @example Generate Morning Prayer for today
#   service = DailyOfficeService.new(
#     date: Date.today,
#     office_type: :morning,
#     preferences: { prayer_book_code: 'loc_2015', bible_version: 'nvi' }
#   )
#   office = service.call
#
# @example Generate office with audio for premium user
#   service = DailyOfficeService.new(
#     date: Date.today,
#     office_type: :morning,
#     current_user: premium_user
#   )
#   office = service.call # Includes audio_url fields for each liturgical text
#
class DailyOfficeService
  include Cacheable

  DEFAULT_PREFERENCES = {
    prayer_book_code: "loc_2015",
    bible_version: "nvi",
    family_rite: false
  }.freeze

  attr_reader :date, :office_type, :preferences, :current_user

  def initialize(date:, office_type: :morning, preferences: {}, current_user: nil)
    @date = date.to_date
    @office_type = office_type.to_sym
    @preferences = DEFAULT_PREFERENCES.merge(preferences.symbolize_keys)
    @current_user = current_user
  end

  def call
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    # Layer 1: Get base office from cache (shared between all users)
    response = fetch_base_office

    # Layer 2: Add user-specific personalization
    personalize_response!(response)

    # Record total timing
    record_service_timing(start_time)

    response
  end

  # Class method for cache key generation (used by controller and warmer job)
  def self.base_cache_key(date:, office_type:, preferences:)
    prayer_book_code = preferences[:prayer_book_code] || "loc_2015"
    pb = PrayerBook.find_by_code(prayer_book_code)
    pb_version = pb&.updated_at&.to_i || 0

    # Build preferences hash for cache key (only preference-affecting fields)
    prefs_hash = build_preferences_hash(preferences)

    "v4/daily_office/base/#{date}/#{office_type}/#{prefs_hash}/pb_#{pb_version}"
  end

  # Build a deterministic hash of preferences that affect office generation
  # Uses ALL preferences to ensure cache correctness across different LOC configurations
  def self.build_preferences_hash(preferences)
    # Apply defaults first for consistency
    full_prefs = DEFAULT_PREFERENCES.merge(preferences.symbolize_keys)

    # Sort to ensure deterministic ordering, remove nil values
    sorted_prefs = full_prefs.compact.sort.to_h

    Digest::MD5.hexdigest(sorted_prefs.to_json)[0..11]
  end

  private

  # Fetch base office from cache or generate
  def fetch_base_office
    cache_key = self.class.base_cache_key(
      date: date,
      office_type: office_type,
      preferences: preferences
    )

    cache_fetch(
      cache_key,
      expires_in: TTL::DAILY_OFFICE,
      tags: { prayer_book: preferences[:prayer_book_code], office_type: office_type.to_s }
    ) do
      generate_base_office
    end
  end

  # Generate office without caching
  def generate_base_office
    builder = builder_for_prayer_book
    builder.call
  end

  # Apply user-specific personalization to cached response
  def personalize_response!(response)
    return response unless @current_user&.premium?

    add_audio_urls_to_response(response)
  end

  # Record service timing for monitoring
  def record_service_timing(start_time)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) * 1000).round(2)

    Datadog.statsd.timing(
      "daily_office.service.duration",
      duration_ms,
      tags: [
        "prayer_book:#{preferences[:prayer_book_code]}",
        "office_type:#{office_type}",
        "has_user:#{current_user.present?}"
      ]
    )
  rescue StandardError
    # Don't let metrics failures affect the app
  end

  def builder_for_prayer_book
    prayer_book_code = preferences[:prayer_book_code] || "loc_2015"

    builder_class = case prayer_book_code
    when "loc_2015"
                      DailyOffice::Builders::Loc2015Builder
    when "locb_2008"
                      DailyOffice::Builders::Locb2008Builder
    when "loc_2019"
                      # Future: DailyOffice::Builders::Loc2019Builder
                      DailyOffice::Builders::BaseBuilder
    when "loc_2012"
                      # Future: DailyOffice::Builders::Loc2012Builder
                      DailyOffice::Builders::BaseBuilder
    when "loc_1987", "loc_1662"
                      # Use base builder for LOCs without specific customizations
                      DailyOffice::Builders::BaseBuilder
    else
                      # Default to base builder
                      DailyOffice::Builders::BaseBuilder
    end

    builder_class.new(
      date: date,
      office_type: office_type,
      preferences: preferences
    )
  end

  # Add audio URLs to liturgical texts in the response
  # Optimized: Uses cached texts from LiturgicalText.texts_cache_for
  def add_audio_urls_to_response(response)
    return response unless response.is_a?(Hash)

    preferred_voice = @current_user.preferred_audio_voice
    prayer_book_code = preferences[:prayer_book_code]

    # Use cached texts - no additional query needed!
    texts_by_slug = LiturgicalText.texts_cache_for(prayer_book_code)
    return response if texts_by_slug.empty?

    # Add audio URLs using the cached texts
    add_audio_to_hash(response, preferred_voice, texts_by_slug)
  end

  def add_audio_to_hash(obj, voice_key, texts_by_slug)
    case obj
    when Hash
      # Check if this object has a slug (could be a module or a line)
      slug = obj[:slug] || obj["slug"]

      if slug.present?
        text = texts_by_slug[slug]
        if text
          audio_url = text.audio_url_for_voice(voice_key)
          if audio_url.present?
            obj[:audio_url] = audio_url
            obj["audio_url"] = audio_url  # Add for both symbol and string keys
          end
        end
      end

      # Recursively process all values
      obj.each_value { |v| add_audio_to_hash(v, voice_key, texts_by_slug) }
    when Array
      obj.each { |item| add_audio_to_hash(item, voice_key, texts_by_slug) }
    end

    obj
  end
end
