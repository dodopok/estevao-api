# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::FcmTokens", type: :request do
  let(:user) { User.create!(email: "test@example.com", provider_uid: "firebase123") }
  let(:token) { "fake_firebase_token" }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  before do
    allow(FirebaseAuthService).to receive(:verify_and_get_user).and_return(user)
  end

  describe "POST /api/v1/users/fcm_token" do
    context "with valid parameters" do
      it "creates a new FCM token" do
        expect {
          post "/api/v1/users/fcm_token",
               params: { fcm_token: "device_token_123", platform: "android" },
               headers: headers
        }.to change(FcmToken, :count).by(1)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Token FCM salvo com sucesso")
        expect(json_response["fcm_token"]).to eq("device_token_123")
      end

      it "updates existing token's timestamp" do
        existing_token = user.fcm_tokens.create!(token: "device_token_123", platform: "android")
        old_updated_at = existing_token.updated_at

        travel_to 1.day.from_now do
          post "/api/v1/users/fcm_token",
               params: { fcm_token: "device_token_123", platform: "ios" },
               headers: headers

          expect(response).to have_http_status(:ok)
          existing_token.reload
          expect(existing_token.updated_at).to be > old_updated_at
          expect(existing_token.platform).to eq("ios")
        end
      end
    end

    context "with invalid parameters" do
      it "returns error when fcm_token is missing" do
        post "/api/v1/users/fcm_token",
             params: { platform: "android" },
             headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("FCM token is required")
      end
    end

    context "without authentication" do
      it "returns unauthorized" do
        allow(FirebaseAuthService).to receive(:verify_and_get_user).and_raise(
          FirebaseAuthService::InvalidTokenError.new("Invalid token")
        )

        post "/api/v1/users/fcm_token",
             params: { fcm_token: "device_token_123" },
             headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/v1/users/fcm_token" do
    before do
      user.fcm_tokens.create!(token: "token_to_delete", platform: "android")
    end

    context "with valid token" do
      it "deletes the FCM token" do
        expect {
          delete "/api/v1/users/fcm_token",
                 params: { fcm_token: "token_to_delete" },
                 headers: headers
        }.to change(FcmToken, :count).by(-1)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("Token FCM removido com sucesso")
      end
    end

    context "with missing token" do
      it "returns error" do
        delete "/api/v1/users/fcm_token",
               params: {},
               headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("FCM token is required")
      end
    end
  end
end
