# frozen_string_literal: true

# Datadog Dashboard Configuration for Daily Office Cache Metrics
#
# This file documents the custom metrics and recommended dashboard setup
# for monitoring the Daily Office cache system in Datadog.
#
# METRICS REFERENCE:
#
# Cache Hit/Miss Metrics:
#   - cache.hit: Counter, tagged with cache_category, prayer_book
#   - cache.miss: Counter, tagged with cache_category, prayer_book
#   - cache.duration: Timing, tagged with cache_category
#   - cache.delete: Counter, tagged with key
#   - cache.invalidation: Counter, tagged with pattern
#   - cache.redis_error: Counter, tagged with method (production only)
#
# Cache Categories:
#   - liturgical_texts: Static texts (30-day TTL)
#   - psalms: Psalm data (30-day TTL)
#   - collects: Collect prayers (30-day TTL)
#   - prayer_book: Prayer book metadata (1-day TTL)
#   - calendar_day_info: Liturgical calendar day info (1-year TTL)
#   - calendar_celebration: Celebration data (1-year TTL)
#   - daily_office: Complete office response (1-day TTL)
#   - readings: Lectionary readings (1-day TTL)
#
# Cache Warmer Metrics:
#   - cache_warmer.runs: Counter
#   - cache_warmer.offices_warmed: Gauge
#   - cache_warmer.errors: Gauge
#   - cache_warmer.duration: Timing
#
# Service Metrics:
#   - daily_office.service.duration: Timing, tagged with prayer_book, office_type, has_user
#
# Rails Cache Metrics (via ActiveSupport::Notifications):
#   - rails.cache.read: Timing, tagged with hit, store
#   - rails.cache.write: Timing, tagged with store
#   - rails.cache.delete: Counter
#
# DASHBOARD SETUP (Datadog JSON):
# To create a dashboard, use the Datadog API or UI with these widgets:
#

module DatadogCacheMetrics
  # Cache category labels for consistent tagging
  CATEGORIES = %w[
    liturgical_texts
    psalms
    collects
    prayer_book
    calendar_day_info
    calendar_celebration
    daily_office
    readings
  ].freeze

  # Helper to build Datadog dashboard JSON
  def self.dashboard_definition
    {
      title: "Daily Office Cache Performance",
      description: "Monitors cache hit rates, response times, and warming job status",
      widgets: [
        # Cache Hit Rate (Percentage)
        {
          definition: {
            title: "Cache Hit Rate by Category",
            type: "timeseries",
            requests: [
              {
                q: "100 * sum:cache.hit{*} by {cache_category}.as_count() / (sum:cache.hit{*} by {cache_category}.as_count() + sum:cache.miss{*} by {cache_category}.as_count())",
                display_type: "line"
              }
            ]
          }
        },
        # Cache Hit/Miss Counts
        {
          definition: {
            title: "Cache Hits vs Misses",
            type: "timeseries",
            requests: [
              { q: "sum:cache.hit{*}.as_count()", display_type: "bars" },
              { q: "sum:cache.miss{*}.as_count()", display_type: "bars" }
            ]
          }
        },
        # Cache Duration
        {
          definition: {
            title: "Cache Lookup Duration (p95)",
            type: "timeseries",
            requests: [
              { q: "p95:cache.duration{*} by {cache_category}", display_type: "line" }
            ]
          }
        },
        # Daily Office Service Duration
        {
          definition: {
            title: "Daily Office Service Duration (p95)",
            type: "timeseries",
            requests: [
              { q: "p95:daily_office.service.duration{*} by {prayer_book}", display_type: "line" }
            ]
          }
        },
        # Cache Warmer Status
        {
          definition: {
            title: "Cache Warmer Runs",
            type: "query_value",
            requests: [
              { q: "sum:cache_warmer.runs{*}.as_count()" }
            ]
          }
        },
        # Offices Warmed per Run
        {
          definition: {
            title: "Offices Warmed per Run",
            type: "timeseries",
            requests: [
              { q: "avg:cache_warmer.offices_warmed{*}", display_type: "line" }
            ]
          }
        },
        # Cache Errors
        {
          definition: {
            title: "Cache Errors",
            type: "timeseries",
            requests: [
              { q: "sum:cache.redis_error{*}.as_count()", display_type: "line" }
            ]
          }
        },
        # Hit Rate by Prayer Book
        {
          definition: {
            title: "Hit Rate by Prayer Book",
            type: "toplist",
            requests: [
              {
                q: "100 * sum:cache.hit{*} by {prayer_book}.as_count() / (sum:cache.hit{*} by {prayer_book}.as_count() + sum:cache.miss{*} by {prayer_book}.as_count())"
              }
            ]
          }
        }
      ],
      layout_type: "ordered"
    }
  end

  # Export dashboard JSON for import into Datadog
  def self.export_dashboard_json
    JSON.pretty_generate(dashboard_definition)
  end
end

# Log available metrics on startup (development only)
if Rails.env.development?
  Rails.logger.info "[Datadog] Cache metrics configured. Categories: #{DatadogCacheMetrics::CATEGORIES.join(', ')}"
end
