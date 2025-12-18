# frozen_string_literal: true

module DatadogErrorTracking
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_standard_error if Rails.env.production?
  end

  private

  def handle_standard_error(exception)
    # Report to Datadog
    report_error_to_datadog(exception)

    # Log error
    Rails.logger.error "[ERROR] #{exception.class}: #{exception.message}"
    Rails.logger.error exception.backtrace.join("\n") if exception.backtrace

    # Return JSON error response
    render json: {
      error: "Internal server error",
      message: exception.message,
      trace_id: defined?(Datadog) ? Datadog::Tracing.correlation.trace_id : nil
    }, status: :internal_server_error
  end

  def report_error_to_datadog(exception, context = {})
    return unless defined?(Datadog)

    # Get current span
    span = Datadog::Tracing.active_span
    return unless span

    # Mark span as error
    span.set_error(exception)

    # Add custom error context
    span.set_tag("error.controller", controller_name)
    span.set_tag("error.action", action_name)
    span.set_tag("error.user_id", current_user&.id) if respond_to?(:current_user)
    span.set_tag("error.request_id", request.request_id)

    # Add custom context
    context.each do |key, value|
      span.set_tag("error.context.#{key}", value)
    end
  end
end
