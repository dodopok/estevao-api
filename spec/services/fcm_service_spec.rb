# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

RSpec.describe FcmService do
  let(:user) { create(:user) }
  let!(:fcm_token) { create(:fcm_token, user: user, token: "test_device_token_123") }
  let(:notification) { { title: "Test Title", body: "Test Body", data: { type: "test" } } }

  let(:valid_credentials_json) do
    {
      type: "service_account",
      project_id: "test-project-id",
      private_key_id: "key123",
      private_key: OpenSSL::PKey::RSA.new(2048).to_pem,
      client_email: "test@test-project-id.iam.gserviceaccount.com",
      client_id: "123456789",
      auth_uri: "https://accounts.google.com/o/oauth2/auth",
      token_uri: "https://oauth2.googleapis.com/token",
      auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
      client_x509_cert_url: "https://www.googleapis.com/robot/v1/metadata/x509/test%40test-project-id.iam.gserviceaccount.com"
    }.to_json
  end

  before do
    # Reset memoized values between tests
    FcmService.instance_variable_set(:@credentials_json, nil)
    FcmService.instance_variable_set(:@project_id, nil)
    FcmService.instance_variable_set(:@authorizer, nil)
  end

  describe ".configured?" do
    context "when FIREBASE_CREDENTIALS is set" do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(valid_credentials_json)
        allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return(nil)
        allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)
      end

      it "returns true" do
        expect(FcmService.configured?).to be true
      end
    end

    context "when no credentials are set" do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(nil)
        allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return(nil)
        allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)
      end

      it "returns false" do
        expect(FcmService.configured?).to be false
      end
    end
  end

  describe ".configuration_status" do
    context "when configured via FIREBASE_CREDENTIALS" do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(valid_credentials_json)
        allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return(nil)
        allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)
      end

      it "returns correct status" do
        status = FcmService.configuration_status

        expect(status[:configured]).to be true
        expect(status[:has_credentials]).to be true
        expect(status[:has_project_id]).to be true
        expect(status[:project_id]).to eq("test-project-id")
        expect(status[:credentials_source]).to eq("FIREBASE_CREDENTIALS env var")
      end
    end

    context "when not configured" do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(nil)
        allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return(nil)
        allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)
      end

      it "returns not configured status" do
        status = FcmService.configuration_status

        expect(status[:configured]).to be false
        expect(status[:has_credentials]).to be false
        expect(status[:credentials_source]).to eq("not configured")
      end
    end
  end

  describe ".send_to_user" do
    context "when FCM is not configured" do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(nil)
        allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return(nil)
        allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)
      end

      it "returns error" do
        result = FcmService.send_to_user(user, notification)

        expect(result[:success]).to be false
        expect(result[:error]).to include("FCM not configured")
      end
    end

    context "when user has no active tokens" do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(valid_credentials_json)
        allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return(nil)
        allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)

        fcm_token.update!(updated_at: 90.days.ago)
      end

      it "returns error about no active tokens" do
        result = FcmService.send_to_user(user, notification)

        expect(result[:success]).to be false
        expect(result[:error]).to eq("No active tokens")
      end
    end

    context "when FCM is configured and user has active tokens" do
      before do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(valid_credentials_json)
        allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return("test-project-id")
        allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)

        # Mock Google Auth
        mock_authorizer = instance_double(Google::Auth::ServiceAccountCredentials)
        allow(Google::Auth::ServiceAccountCredentials).to receive(:make_creds).and_return(mock_authorizer)
        allow(mock_authorizer).to receive(:fetch_access_token!).and_return({ "access_token" => "mock_token" })
        allow(mock_authorizer).to receive(:access_token).and_return("mock_token")
      end

      it "sends notification successfully" do
        stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
          .to_return(status: 200, body: { name: "projects/test-project-id/messages/123" }.to_json)

        result = FcmService.send_to_user(user, notification)

        expect(result[:success]).to be true
        expect(result[:sent]).to eq(1)
        expect(result[:total]).to eq(1)
      end

      it "handles FCM error response" do
        stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
          .to_return(status: 400, body: { error: { message: "Invalid request" } }.to_json)

        result = FcmService.send_to_user(user, notification)

        expect(result[:success]).to be false
        expect(result[:error]).to include("Invalid request")
      end

      it "removes invalid tokens when FCM returns UNREGISTERED" do
        stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
          .to_return(
            status: 404,
            body: {
              error: {
                message: "Requested entity was not found.",
                details: [ { errorCode: "UNREGISTERED" } ]
              }
            }.to_json
          )

        expect {
          FcmService.send_to_user(user, notification)
        }.to change { user.fcm_tokens.count }.from(1).to(0)
      end

      it "sends to multiple tokens" do
        create(:fcm_token, user: user, token: "second_device_token")

        stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
          .to_return(status: 200, body: { name: "projects/test-project-id/messages/123" }.to_json)

        result = FcmService.send_to_user(user, notification)

        expect(result[:success]).to be true
        expect(result[:sent]).to eq(2)
        expect(result[:total]).to eq(2)
      end
    end
  end

  describe ".send_to_token" do
    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(valid_credentials_json)
      allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return("test-project-id")
      allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)

      mock_authorizer = instance_double(Google::Auth::ServiceAccountCredentials)
      allow(Google::Auth::ServiceAccountCredentials).to receive(:make_creds).and_return(mock_authorizer)
      allow(mock_authorizer).to receive(:fetch_access_token!).and_return({ "access_token" => "mock_token" })
      allow(mock_authorizer).to receive(:access_token).and_return("mock_token")
    end

    it "sends notification to a specific token" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .with(
          headers: {
            "Authorization" => "Bearer mock_token",
            "Content-Type" => "application/json"
          }
        )
        .to_return(status: 200, body: { name: "projects/test-project-id/messages/123" }.to_json)

      result = FcmService.send_to_token("test_token", notification)

      expect(result[:success]).to be true
      expect(result[:token]).to eq("test_token")
    end

    it "includes correct message structure" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .with { |request|
          body = JSON.parse(request.body)
          message = body["message"]

          message["token"] == "test_token" &&
            message["notification"]["title"] == "Test Title" &&
            message["notification"]["body"] == "Test Body" &&
            message["android"]["priority"] == "high" &&
            message["apns"]["headers"]["apns-priority"] == "10"
        }
        .to_return(status: 200, body: { name: "projects/test-project-id/messages/123" }.to_json)

      FcmService.send_to_token("test_token", notification)
    end

    it "marks token as invalid on 404 response" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .to_return(status: 404, body: { error: { message: "Not found" } }.to_json)

      result = FcmService.send_to_token("invalid_token", notification)

      expect(result[:success]).to be false
      expect(result[:invalid_token]).to be true
    end

    it "handles network errors gracefully" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .to_raise(Errno::ECONNREFUSED)

      result = FcmService.send_to_token("test_token", notification)

      expect(result[:success]).to be false
      expect(result[:error]).to include("Connection refused")
      expect(result[:invalid_token]).to be false
    end
  end

  describe ".send_batch" do
    let(:user2) { create(:user) }
    let!(:fcm_token2) { create(:fcm_token, user: user2, token: "user2_token") }

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(valid_credentials_json)
      allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return("test-project-id")
      allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)

      mock_authorizer = instance_double(Google::Auth::ServiceAccountCredentials)
      allow(Google::Auth::ServiceAccountCredentials).to receive(:make_creds).and_return(mock_authorizer)
      allow(mock_authorizer).to receive(:fetch_access_token!).and_return({ "access_token" => "mock_token" })
      allow(mock_authorizer).to receive(:access_token).and_return("mock_token")
    end

    it "sends notifications to multiple users" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .to_return(status: 200, body: { name: "projects/test-project-id/messages/123" }.to_json)

      users = User.where(id: [ user.id, user2.id ])
      result = FcmService.send_batch(users, notification)

      expect(result[:success]).to eq(2)
      expect(result[:failed]).to eq(0)
      expect(result[:errors]).to be_empty
    end

    it "tracks failed notifications" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .to_return(
          { status: 200, body: { name: "projects/test-project-id/messages/123" }.to_json },
          { status: 400, body: { error: { message: "Invalid token" } }.to_json }
        )

      users = User.where(id: [ user.id, user2.id ])
      result = FcmService.send_batch(users, notification)

      expect(result[:success]).to eq(1)
      expect(result[:failed]).to eq(1)
      expect(result[:errors].size).to eq(1)
    end
  end

  describe "message structure" do
    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("FIREBASE_CREDENTIALS").and_return(valid_credentials_json)
      allow(ENV).to receive(:[]).with("FIREBASE_PROJECT_ID").and_return("test-project-id")
      allow(ENV).to receive(:[]).with("GOOGLE_APPLICATION_CREDENTIALS").and_return(nil)

      mock_authorizer = instance_double(Google::Auth::ServiceAccountCredentials)
      allow(Google::Auth::ServiceAccountCredentials).to receive(:make_creds).and_return(mock_authorizer)
      allow(mock_authorizer).to receive(:fetch_access_token!).and_return({ "access_token" => "mock_token" })
      allow(mock_authorizer).to receive(:access_token).and_return("mock_token")
    end

    it "includes Android-specific configuration" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .with { |request|
          body = JSON.parse(request.body)
          android = body.dig("message", "android")

          android["priority"] == "high" &&
            android.dig("notification", "channel_id") == "ordo_channel" &&
            android.dig("notification", "sound") == "default"
        }
        .to_return(status: 200, body: {}.to_json)

      FcmService.send_to_token("token", notification)
    end

    it "includes APNs-specific configuration for iOS" do
      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .with { |request|
          body = JSON.parse(request.body)
          apns = body.dig("message", "apns")

          apns.dig("headers", "apns-priority") == "10" &&
            apns.dig("headers", "apns-push-type") == "alert" &&
            apns.dig("payload", "aps", "sound") == "default" &&
            apns.dig("payload", "aps", "badge") == 1
        }
        .to_return(status: 200, body: {}.to_json)

      FcmService.send_to_token("token", notification)
    end

    it "converts data values to strings" do
      notification_with_data = {
        title: "Test",
        body: "Body",
        data: { count: 5, enabled: true, nested: { key: "value" } }
      }

      stub_request(:post, "https://fcm.googleapis.com/v1/projects/test-project-id/messages:send")
        .with { |request|
          body = JSON.parse(request.body)
          data = body.dig("message", "data")

          data["count"] == "5" && data["enabled"] == "true"
        }
        .to_return(status: 200, body: {}.to_json)

      FcmService.send_to_token("token", notification_with_data)
    end
  end
end
