# frozen_string_literal: true

# Factory service that builds Daily Office content based on Prayer Book preferences
#
# This is the main entry point for generating Daily Office liturgies. It:
# - Delegates to Prayer Book-specific builders (e.g., LOC 2015)
# - Handles premium audio URL injection for authenticated users
# - Applies user preferences for Bible version, confession type, etc.
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
    builder = builder_for_prayer_book
    response = builder.call

    # Add audio URLs for premium users
    add_audio_urls_to_response(response) if @current_user&.premium?

    response
  end

  private

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
