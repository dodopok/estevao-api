# frozen_string_literal: true

# Concern that provides caching utilities for services
# Implements v4 cache keys with prayer_book.updated_at versioning
# and Datadog observability for hit/miss metrics
#
# @example Including in a service
#   class MyService
#     include Cacheable
#
#     def fetch_data
#       cache_fetch("my_data", expires_in: 1.day, tags: { prayer_book: "loc_2015" }) do
#         expensive_computation
#       end
#     end
#   end
#
module Cacheable
  extend ActiveSupport::Concern

  CACHE_VERSION = "v4"

  # Cache TTL constants
  module TTL
    STATIC_DATA = 30.days      # Liturgical texts, psalms, collects (never change after deploy)
    CALENDAR_YEAR = 1.year     # Liturgical calendar for a year
    DAILY_OFFICE = 1.day       # Daily office base (until midnight)
    READINGS = 1.day           # Readings and collects for a date
    PRAYER_BOOK = 1.day        # Prayer book metadata
    USER_DATA = 5.minutes      # User-specific data (completions, streaks)
  end

  included do
    # Memoized prayer book timestamp for cache key versioning
    def prayer_book_cache_version(prayer_book_code)
      @prayer_book_versions ||= {}
      @prayer_book_versions[prayer_book_code] ||= begin
        pb = PrayerBook.find_by_code(prayer_book_code)
        pb&.updated_at&.to_i || 0
      end
    end
  end

  class_methods do
    # Class-level cache version for prayer books
    def prayer_book_cache_version(prayer_book_code)
      pb = PrayerBook.find_by_code(prayer_book_code)
      pb&.updated_at&.to_i || 0
    end
  end

  private

  # Build a versioned cache key with optional prayer_book versioning
  #
  # @param parts [Array<String>] Key parts to join
  # @param prayer_book_code [String, nil] Prayer book code for versioning
  # @return [String] Full cache key
  def build_cache_key(*parts, prayer_book_code: nil)
    key_parts = [ CACHE_VERSION, *parts ]

    if prayer_book_code
      pb_version = prayer_book_cache_version(prayer_book_code)
      key_parts << "pb_#{pb_version}"
    end

    key_parts.join("/")
  end

  # Fetch from cache with Datadog metrics
  #
  # @param key [String] Cache key (will be prefixed with version)
  # @param expires_in [ActiveSupport::Duration] TTL for cache entry
  # @param tags [Hash] Additional tags for Datadog metrics
  # @param prayer_book_code [String, nil] Prayer book code for versioning
  # @yield Block to execute on cache miss
  # @return [Object] Cached or computed value
  def cache_fetch(key, expires_in:, tags: {}, prayer_book_code: nil, &block)
    full_key = if key.start_with?(CACHE_VERSION)
                 key
    else
                 build_cache_key(key, prayer_book_code: prayer_book_code)
    end

    cache_hit = true
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    result = Rails.cache.fetch(full_key, expires_in: expires_in) do
      cache_hit = false
      yield
    end

    # Record metrics
    duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) * 1000).round(2)
    record_cache_metrics(full_key, cache_hit, duration_ms, tags)

    result
  end

  # Record cache hit/miss metrics to Datadog
  #
  # @param key [String] Cache key
  # @param hit [Boolean] Whether cache was hit
  # @param duration_ms [Float] Time taken in milliseconds
  # @param tags [Hash] Additional tags
  def record_cache_metrics(key, hit, duration_ms, tags = {})
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    # Extract cache category from key (e.g., "v4/daily_office/..." -> "daily_office")
    category = extract_cache_category(key)

    metric_tags = [
      "cache_category:#{category}",
      "hit:#{hit}",
      *tags.map { |k, v| "#{k}:#{v}" }
    ]

    # Increment hit/miss counter
    if hit
      Datadog.statsd.increment("cache.hit", tags: metric_tags)
    else
      Datadog.statsd.increment("cache.miss", tags: metric_tags)
    end

    # Record timing
    Datadog.statsd.timing("cache.duration", duration_ms, tags: metric_tags)

    # Log for debugging in development
    if Rails.env.development?
      status = hit ? "HIT" : "MISS"
      Rails.logger.debug { "[Cache] #{status} #{key} (#{duration_ms}ms)" }
    end
  rescue StandardError => e
    # Don't let metrics failures affect the app
    Rails.logger.warn { "[Cache] Metrics error: #{e.message}" }
  end

  # Extract category from cache key for grouping metrics
  def extract_cache_category(key)
    # Key format: "v4/category/..." or "v4/category"
    parts = key.to_s.split("/")
    parts[1] || "unknown"
  end

  # Invalidate cache entries matching a pattern
  # Note: This only works with Redis cache store
  #
  # @param pattern [String] Key pattern to match (e.g., "v4/daily_office/*")
  def cache_delete_matched(pattern)
    Rails.cache.delete_matched(pattern)

    if defined?(Datadog) && Datadog.respond_to?(:statsd)
      Datadog.statsd.increment("cache.invalidation", tags: [ "pattern:#{pattern}" ])
    end
  rescue NotImplementedError
    # Memory store doesn't support delete_matched, log warning
    Rails.logger.warn { "[Cache] delete_matched not supported by current cache store" }
  end

  # Delete a specific cache key
  #
  # @param key [String] Cache key to delete
  def cache_delete(key)
    full_key = key.start_with?(CACHE_VERSION) ? key : build_cache_key(key)
    Rails.cache.delete(full_key)

    if defined?(Datadog) && Datadog.respond_to?(:statsd)
      Datadog.statsd.increment("cache.delete", tags: [ "key:#{extract_cache_category(full_key)}" ])
    end
  end
end
