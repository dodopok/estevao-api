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
  end
end
