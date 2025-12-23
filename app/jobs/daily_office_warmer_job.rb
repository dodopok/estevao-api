# frozen_string_literal: true

# Background job to pre-warm Daily Office cache for the current day
#
# This job runs at midnight (or scheduled times) to pre-generate all
# daily office combinations, ensuring fast response times for users.
#
# STRATEGY:
# - Pre-generate all 4 office types (morning, midday, evening, compline)
# - For each active prayer book
# - With default preferences
# - Cache is warmed before users wake up
#
# SCHEDULING:
# Run via cron or recurring job scheduler at strategic times:
# - 00:05 UTC (covers most timezones starting their day)
# - Can be triggered for specific timezones as needed
#
# @example Enqueue manually
#   DailyOfficeWarmerJob.perform_later
#
# @example Enqueue for specific date and prayer book
#   DailyOfficeWarmerJob.perform_later(date: "2025-12-25", prayer_book_codes: ["loc_2015"])
#
class DailyOfficeWarmerJob < ApplicationJob
  queue_as :low

  OFFICE_TYPES = %i[morning midday evening compline].freeze

  # Default preferences for warming (most common user configuration)
  DEFAULT_WARMING_PREFERENCES = {
    bible_version: "nvi",
    family_rite: false,
    lords_prayer_version: "traditional",
    confession_type: "long",
    creed_type: "apostles"
  }.freeze

  def perform(date: nil, prayer_book_codes: nil)
    target_date = parse_date(date)
    prayer_books = resolve_prayer_books(prayer_book_codes)

    Rails.logger.info "[CacheWarmer] Starting warmup for #{target_date} - #{prayer_books.size} prayer books"

    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    offices_warmed = 0
    errors = []

    prayer_books.each do |prayer_book|
      OFFICE_TYPES.each do |office_type|
        warmed = warm_office(target_date, office_type, prayer_book)
        offices_warmed += 1 if warmed
      rescue StandardError => e
        errors << { prayer_book: prayer_book.code, office_type: office_type, error: e.message }
        Rails.logger.error "[CacheWarmer] Error warming #{prayer_book.code}/#{office_type}: #{e.message}"
      end
    end

    duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) * 1000).round(2)

    # Log summary
    Rails.logger.info "[CacheWarmer] Completed: #{offices_warmed} offices warmed in #{duration_ms}ms"

    # Report metrics to Datadog
    report_metrics(offices_warmed, errors.size, duration_ms)

    # Return summary for job monitoring
    {
      date: target_date.to_s,
      offices_warmed: offices_warmed,
      errors: errors,
      duration_ms: duration_ms
    }
  end

  # Class method to warm cache for tomorrow (useful for scheduling)
  def self.warm_tomorrow
    perform_later(date: Date.tomorrow.to_s)
  end

  # Class method to warm cache for specific timezone's "today"
  def self.warm_for_timezone(timezone)
    today_in_tz = Time.current.in_time_zone(timezone).to_date
    perform_later(date: today_in_tz.to_s)
  end

  private

  def parse_date(date)
    return Date.current if date.nil?

    date.is_a?(Date) ? date : Date.parse(date)
  end

  def resolve_prayer_books(codes)
    if codes.present?
      codes.map { |code| PrayerBook.find_by_code(code) }.compact
    else
      PrayerBook.all_cached
    end
  end

  def warm_office(date, office_type, prayer_book)
    preferences = DEFAULT_WARMING_PREFERENCES.merge(
      prayer_book_code: prayer_book.code
    )

    # Generate cache key to check if already cached
    cache_key = DailyOfficeService.base_cache_key(
      date: date,
      office_type: office_type,
      preferences: preferences
    )

    # Skip if already cached
    return false if Rails.cache.exist?(cache_key)

    # Generate and cache the office
    service = DailyOfficeService.new(
      date: date,
      office_type: office_type,
      preferences: preferences
    )

    service.call

    Rails.logger.debug "[CacheWarmer] Warmed: #{prayer_book.code}/#{office_type} for #{date}"
    true
  end

  def report_metrics(offices_warmed, errors_count, duration_ms)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.gauge("cache_warmer.offices_warmed", offices_warmed)
    Datadog.statsd.gauge("cache_warmer.errors", errors_count)
    Datadog.statsd.timing("cache_warmer.duration", duration_ms)
    Datadog.statsd.increment("cache_warmer.runs")
  rescue StandardError => e
    Rails.logger.warn "[CacheWarmer] Metrics error: #{e.message}"
  end
end
