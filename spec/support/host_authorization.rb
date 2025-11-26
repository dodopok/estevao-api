# frozen_string_literal: true

# Workaround for Rails 8.1 HostAuthorization in tests
RSpec.configure do |config|
  config.before(:each, type: :request) do
    host! "example.com"
  end

  config.before(:each, type: :integration) do
    host! "example.com"
  end
end
