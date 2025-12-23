# frozen_string_literal: true

return unless defined?(Datadog)

# Only initialize Datadog in production and staging
return if Rails.env.test?

Datadog.configure do |c|
  # APM Configuration
  c.tracing.enabled = true

  # Service name - appears in Datadog APM
  c.service = "estevao-api"

  # Environment (production, staging, development)
  c.env = Rails.env

  # Version tracking (for deployments)
  # Only set version if we have a valid value to avoid "version:" tag error
  app_version = ENV.fetch("APP_VERSION", nil) || `git rev-parse --short HEAD 2>/dev/null`.strip.presence
  c.version = app_version if app_version.present?

  # Tags for filtering and grouping
  c.tags = {
    team: "backend",
    app: "ordo",
    deployment: ENV.fetch("DEPLOYMENT_TYPE", "railway")
  }

  # ============================================
  # TRACING (APM) CONFIGURATION
  # ============================================

  # Sample rate: 100% in non-production, 50% in production for cost control
  c.tracing.sampling.default_rate = Rails.env.production? ? 0.5 : 1.0

  # Distributed tracing headers (v2 API)
  c.tracing.propagation_style_extract = [ "b3multi" ]
  c.tracing.propagation_style_inject = [ "b3multi" ]

  # Rails instrumentation
  c.tracing.instrument :rails,
    service_name: "estevao-api-rails",
    request_queuing: true,
    middleware: true,
    exception_controller: true

  # Database instrumentation (ActiveRecord)
  c.tracing.instrument :pg,
    service_name: "estevao-api-postgres",
    peer_service: "postgresql"

  # HTTP client instrumentation (for external APIs)
  c.tracing.instrument :http,
    service_name: "estevao-api-http",
    split_by_domain: true  # Track Firebase, RevenueCat, ElevenLabs separately

  # Redis/Cache instrumentation (Solid Cache uses Redis-like interface)
  c.tracing.instrument :redis,
    service_name: "estevao-api-cache"

  # Rack instrumentation
  c.tracing.instrument :rack,
    service_name: "estevao-api-rack"

  # ActionCable instrumentation (Solid Cable)
  c.tracing.instrument :action_cable,
    service_name: "estevao-api-cable"

  # Active Job instrumentation (Solid Queue)
  c.tracing.instrument :active_job,
    service_name: "estevao-api-jobs"

  # ============================================
  # LOGGING CONFIGURATION
  # ============================================

  # Enable log injection (adds trace_id, span_id to logs)
  c.tracing.log_injection = true

  # Logger
  c.logger.instance = Rails.logger
  c.logger.level = ::Logger::INFO

  # Diagnostics - disable debug to avoid polluting console with trace logs
  c.diagnostics.startup_logs.enabled = !Rails.env.production?
  c.diagnostics.debug = false

  # ============================================
  # PROFILING (Optional - CPU/Memory profiling)
  # ============================================

  # Enable continuous profiler in production only
  if Rails.env.production?
    c.profiling.enabled = true
    c.profiling.allocation_enabled = true
  end
end

# ============================================
# CUSTOM METRICS CLIENT (DogStatsD)
# ============================================

require "datadog/statsd"

# Initialize StatsD client for custom metrics
$statsd = Datadog::Statsd.new(
  ENV.fetch("DD_AGENT_HOST", "localhost"),
  ENV.fetch("DD_DOGSTATSD_PORT", 8125).to_i,
  namespace: "estevao_api",
  tags: [
    "env:#{Rails.env}",
    "service:estevao-api"
  ]
)

# Make it available globally
module Datadog
  def self.statsd
    $statsd
  end
end

# Log successful initialization
Rails.logger.info "[Datadog] Initialized with service=#{Datadog.configuration.service}, env=#{Datadog.configuration.env}"
