# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/onboarding", type: :request do
  let(:user) { create(:user) }
  let(:prayer_book) { create(:prayer_book) }
  let(:bible_version) { create(:bible_version) }
  let(:category) { create(:preference_category, prayer_book: prayer_book, key: "daily_office") }
  let!(:definition) { create(:preference_definition, :select_one, preference_category: category, key: "office_type", default_value: "traditional") }
  let(:Authorization) { "Bearer mock-token" }

  before do
    allow_any_instance_of(Api::V1::OnboardingController).to receive(:authenticate_user!).and_return(true)
    allow_any_instance_of(Api::V1::OnboardingController).to receive(:current_user).and_return(user)
  end

  path "/api/v1/users/onboarding" do
    post("create onboarding") do
      tags "Onboarding"
      consumes "application/json"
      produces "application/json"
      security [ { bearer_auth: [] } ]

      parameter name: "Authorization",
                in: :header,
                type: :string,
                description: "Firebase ID Token (format: Bearer <token>)",
                required: true

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          prayer_book_id: { type: :string },
          bible_version_id: { type: :string },
          mode: { type: :string, enum: %w[basic advanced] },
          preferences: { type: :object },
          completed_at: { type: :string, format: :datetime }
        },
        required: %w[prayer_book_id bible_version_id]
      }

      response(200, "successful - basic mode") do
        let(:body) do
          {
            prayer_book_id: prayer_book.code,
            bible_version_id: bible_version.code,
            mode: "basic"
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     user_id: { type: :string },
                     prayer_book_id: { type: :string },
                     bible_version_id: { type: :string },
                     mode: { type: :string },
                     preferences: { type: :object },
                     onboarding_completed: { type: :boolean },
                     completed_at: { type: :string },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["success"]).to be true
          expect(data["data"]["mode"]).to eq("basic")
          expect(data["data"]["preferences"]["office_type"]).to eq("traditional")
        end
      end

      response(200, "successful - advanced mode") do
        let(:body) do
          {
            prayer_book_id: prayer_book.code,
            bible_version_id: bible_version.code,
            mode: "advanced",
            preferences: {
              office_type: "contemporary"
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["success"]).to be true
          expect(data["data"]["mode"]).to eq("advanced")
          expect(data["data"]["preferences"]["office_type"]).to eq("contemporary")
        end
      end

      response(404, "prayer book not found") do
        let(:body) do
          {
            prayer_book_id: "nonexistent",
            bible_version_id: bible_version.code,
            mode: "basic"
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 error: {
                   type: :object,
                   properties: {
                     code: { type: :string },
                     message: { type: :string }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["success"]).to be false
          expect(data["error"]["code"]).to eq("RESOURCE_NOT_FOUND")
        end
      end

      response(400, "invalid preferences") do
        let(:body) do
          {
            prayer_book_id: prayer_book.code,
            bible_version_id: bible_version.code,
            mode: "advanced",
            preferences: {
              office_type: "invalid_value"
            }
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 error: {
                   type: :object,
                   properties: {
                     code: { type: :string },
                     message: { type: :string },
                     details: { type: :object }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["success"]).to be false
          expect(data["error"]["code"]).to eq("INVALID_PREFERENCES")
        end
      end
    end
  end

  path "/api/v1/users/me/onboarding" do
    get("show onboarding") do
      tags "Onboarding"
      produces "application/json"
      security [ { bearer_auth: [] } ]

      parameter name: "Authorization",
                in: :header,
                type: :string,
                description: "Firebase ID Token (format: Bearer <token>)",
                required: true

      response(200, "successful") do
        before do
          create(:user_onboarding,
            user: user,
            prayer_book: prayer_book,
            bible_version: bible_version,
            mode: "basic")
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     prayer_book_id: { type: :string },
                     bible_version_id: { type: :string },
                     mode: { type: :string },
                     preferences: { type: :object }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["success"]).to be true
          expect(data["data"]["prayer_book_id"]).to eq(prayer_book.code)
        end
      end

      response(404, "onboarding not found") do
        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 error: {
                   type: :object,
                   properties: {
                     code: { type: :string },
                     message: { type: :string }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["success"]).to be false
          expect(data["error"]["code"]).to eq("ONBOARDING_NOT_FOUND")
        end
      end
    end
  end

  context "without authentication" do
    before do
      allow_any_instance_of(Api::V1::OnboardingController).to receive(:authenticate_user!).and_call_original
      allow_any_instance_of(Api::V1::OnboardingController).to receive(:current_user).and_return(nil)
    end

    describe "POST /api/v1/users/onboarding" do
      it "returns 401 unauthorized" do
        post "/api/v1/users/onboarding", params: { prayer_book_id: "loc_2015", bible_version_id: "nvi" }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "GET /api/v1/users/me/onboarding" do
      it "returns 401 unauthorized" do
        get "/api/v1/users/me/onboarding"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
