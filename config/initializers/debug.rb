if Rails.env.development? && defined?(Rails::Server)
  require "debug/session"
  Rails.logger.info "Starting debug session"
  # the port can be anything
  DEBUGGER__.open(port: "1234", host: "0.0.0.0")
end
