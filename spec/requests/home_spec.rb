require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    before do
      host! 'example.com'
    end

    it "returns API information" do
      get "/"

      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(%r{application/json})

      json = JSON.parse(response.body)
      expect(json["api"]).to eq("Calendário Litúrgico Anglicano")
      expect(json["version"]).to eq("1.0")
      expect(json["docs"]).to eq("/api-docs")
      expect(json["endpoints"]).not_to be_nil
    end

    it "includes all API endpoint categories" do
      get "/"

      json = JSON.parse(response.body)
      endpoints = json["endpoints"]

      expect(endpoints).to include(
        "calendar",
        "celebrations",
        "lectionary",
        "daily_office",
        "users",
        "onboarding",
        "completions",
        "journals",
        "notifications",
        "prayer_books",
        "bible_versions",
        "shared_offices",
        "life_rules"
      )
    end

    it "includes user account deletion endpoint" do
      get "/"

      json = JSON.parse(response.body)
      expect(json.dig("endpoints", "users", "delete_account")).to eq("DELETE /api/v1/users/me")
    end
  end
end
