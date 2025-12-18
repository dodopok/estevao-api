# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    # Disable Datadog in test environment
    if defined?(Datadog)
      Datadog.configure do |c|
        c.tracing.enabled = false
        c.profiling.enabled = false if c.respond_to?(:profiling)
      end
    end
  end

  config.before do
    # Stub global StatsD instance used in initializer
    stub_statsd = double("statsd",
      increment: nil,
      timing: nil,
      gauge: nil,
      histogram: nil,
      distribution: nil,
      set: nil,
      event: nil,
      service_check: nil
    )

    # Replace global $statsd
    $statsd = stub_statsd

    # Also stub Datadog.statsd if the method exists
    if defined?(Datadog) && Datadog.respond_to?(:statsd)
      allow(Datadog).to receive(:statsd).and_return(stub_statsd)
    end
  end
end
