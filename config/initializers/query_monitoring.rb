# frozen_string_literal: true

# Simple query performance monitoring for development
# Warns about slow queries and potential N+1 issues
if Rails.env.development?
  ActiveSupport::Notifications.subscribe("sql.active_record") do |_name, start, finish, _id, payload|
    duration = (finish - start) * 1000 # Convert to milliseconds

    # Warn about slow queries (>100ms in development)
    if duration > 100
      Rails.logger.warn("⚠️  SLOW QUERY (#{duration.round(1)}ms): #{payload[:sql]}")
    end

    # Detect potential N+1 queries by checking for repeated patterns
    # NOTE: This is a basic heuristic. For comprehensive N+1 detection, use the Bullet gem:
    # https://github.com/flyerhzm/bullet
    sql = payload[:sql]
    # Only check SELECT queries that include WHERE clauses with IDs
    if sql.match?(/SELECT\s+.*\s+FROM\s+\w+\s+WHERE\s+.*\bid\b.*=.*\$/i) && !sql.include?("LIMIT 1")
      # This might be an N+1 query if called repeatedly
      Thread.current[:query_patterns] ||= Hash.new(0)
      pattern = sql.gsub(/\$\d+/, "?").gsub(/\d+/, "N")
      Thread.current[:query_patterns][pattern] += 1

      # Warn if same pattern appears many times
      if Thread.current[:query_patterns][pattern] > 10
        Rails.logger.warn("⚠️  POTENTIAL N+1: #{pattern} (called #{Thread.current[:query_patterns][pattern]} times)")
        Thread.current[:query_patterns][pattern] = 0 # Reset to avoid spam
      end
    end
  end

  # Clear query patterns at the end of each request
  if defined?(ActionDispatch)
    Rails.application.config.middleware.use(Class.new do
      def initialize(app)
        @app = app
      end

      def call(env)
        Thread.current[:query_patterns] = nil
        @app.call(env)
      end
    end)
  end

  Rails.logger.info("🔍 Query performance monitoring enabled for development")
end
