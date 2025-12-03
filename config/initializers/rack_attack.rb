# frozen_string_literal: true

class Rack::Attack
  # Throttle onboarding requests to 10 per hour per IP
  throttle("onboarding/ip", limit: 60, period: 1.hour) do |req|
    if req.path == "/api/v1/users/onboarding" && req.post?
      req.ip
    end
  end

  # Throttle onboarding requests to 10 per hour per user (by Authorization header)
  throttle("onboarding/user", limit: 60, period: 1.hour) do |req|
    if req.path == "/api/v1/users/onboarding" && req.post?
      # Extract user identifier from Authorization header if present
      auth_header = req.get_header("HTTP_AUTHORIZATION")
      auth_header&.split("Bearer ")&.last&.first(50) if auth_header&.start_with?("Bearer ")
    end
  end

  # General API rate limiting: 100 requests per minute per IP
  throttle("api/ip", limit: 100, period: 1.minute) do |req|
    req.ip if req.path.start_with?("/api/")
  end

  # Custom response for rate limited requests
  self.throttled_responder = lambda do |req|
    match_data = req.env["rack.attack.match_data"]
    now = match_data[:epoch_time]
    retry_after = match_data[:period] - (now % match_data[:period])

    [
      429,
      {
        "Content-Type" => "application/json",
        "Retry-After" => retry_after.to_s
      },
      [ {
        success: false,
        error: {
          code: "RATE_LIMIT_EXCEEDED",
          message: "Too many requests. Please try again later.",
          retry_after: retry_after.to_i
        }
      }.to_json ]
    ]
  end

  # Allow all requests from localhost in development/test
  safelist("allow-localhost") do |req|
    req.ip == "127.0.0.1" || req.ip == "::1" if Rails.env.development? || Rails.env.test?
  end
end
