class ApplicationController < ActionController::API
  include DatadogMetricsHelper
  include DatadogErrorTracking

  before_action :set_json_headers
  around_action :track_request_timing

  private

  def set_json_headers
    response.headers["Content-Type"] = "application/json; charset=utf-8"
    response.headers["Content-Disposition"] = "inline"
  end

  def track_request_timing
    start_time = Time.current
    yield
  ensure
    duration = ((Time.current - start_time) * 1000).round  # milliseconds
    track_api_timing(
      endpoint: "#{controller_name}##{action_name}",
      duration: duration,
      status: response.status
    )
  end
end
