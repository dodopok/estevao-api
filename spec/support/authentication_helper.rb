# frozen_string_literal: true

module AuthenticationHelper
  # Mock Firebase authentication for tests
  # In production, this would verify actual Firebase tokens
  def user_token(user)
    "test_token_#{user.id}_#{user.email}"
  end

  # Stub FirebaseAuthService to return the user for test tokens
  def stub_authentication_for(user)
    allow(FirebaseAuthService).to receive(:verify_and_get_user) do |token|
      if token == user_token(user)
        user
      else
        raise FirebaseAuthService::InvalidTokenError, "Invalid test token"
      end
    end
  end

  # Stub to allow any authenticated request
  def stub_authentication
    allow(FirebaseAuthService).to receive(:verify_and_get_user) do |token|
      if token&.start_with?('test_token_')
        user_id = token.split('_')[2].to_i
        User.find(user_id)
      else
        raise FirebaseAuthService::InvalidTokenError, "No test token provided"
      end
    end
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :request

  # Automatically stub authentication for request specs
  config.before(:each, type: :request) do
    stub_authentication
  end
end
