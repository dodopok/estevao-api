# frozen_string_literal: true

module DatadogMetricsHelper
  # Track prayer completion
  def track_prayer_completion(office_type:, user_id:, date:)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.increment("prayers.completed",
      tags: [
        "office_type:#{office_type}",
        "user_premium:#{user_premium?(user_id)}",
        "day_of_week:#{date.strftime('%A').downcase}"
      ])
  end

  # Track API response time by endpoint
  def track_api_timing(endpoint:, duration:, status:)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.timing("api.response_time", duration,
      tags: [
        "endpoint:#{endpoint}",
        "status:#{status}"
      ])
  end

  # Track cache hit/miss
  def track_cache_performance(key:, hit:)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    metric = hit ? "cache.hit" : "cache.miss"
    Datadog.statsd.increment(metric,
      tags: [ "cache_key_prefix:#{key.split('/').first}" ])
  end

  # Track active users
  def track_active_user(user_id:, premium:)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.gauge("users.active",
      1,
      tags: [ "user_id:#{user_id}", "premium:#{premium}" ])
  end

  # Track background job execution
  def track_job_execution(job_name:, duration:, success:)
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.timing("jobs.execution_time", duration,
      tags: [ "job:#{job_name}", "success:#{success}" ])

    metric = success ? "jobs.success" : "jobs.failure"
    Datadog.statsd.increment(metric, tags: [ "job:#{job_name}" ])
  end

  private

  def user_premium?(user_id)
    User.find_by(id: user_id)&.premium? || false
  rescue
    false
  end
end
