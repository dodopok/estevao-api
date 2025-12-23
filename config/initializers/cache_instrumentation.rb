# frozen_string_literal: true

# Cache instrumentation for Datadog metrics
# Subscribes to ActiveSupport::Notifications to track cache operations

return unless defined?(Datadog) && Rails.env.production?

ActiveSupport::Notifications.subscribe("cache_read.active_support") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  next unless Datadog.respond_to?(:statsd)

  tags = [
    "hit:#{event.payload[:hit]}",
    "store:#{Rails.cache.class.name.demodulize.underscore}"
  ]

  Datadog.statsd.timing("rails.cache.read", event.duration, tags: tags)
end

ActiveSupport::Notifications.subscribe("cache_write.active_support") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  next unless Datadog.respond_to?(:statsd)

  tags = [ "store:#{Rails.cache.class.name.demodulize.underscore}" ]
  Datadog.statsd.timing("rails.cache.write", event.duration, tags: tags)
end

ActiveSupport::Notifications.subscribe("cache_delete.active_support") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  next unless Datadog.respond_to?(:statsd)

  Datadog.statsd.increment("rails.cache.delete")
end

$stdout.puts "[Cache] Datadog instrumentation enabled"
