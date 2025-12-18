class ApplicationJob < ActiveJob::Base
  include DatadogMetricsHelper

  around_perform :track_job_metrics

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  private

  def track_job_metrics
    start_time = Time.current
    success = false
    yield
    success = true
  rescue => e
    raise
  ensure
    duration = ((Time.current - start_time) * 1000).round
    track_job_execution(
      job_name: self.class.name,
      duration: duration,
      success: success
    )
  end
end
