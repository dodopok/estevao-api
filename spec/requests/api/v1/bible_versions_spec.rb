# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/bible_versions", type: :request do
  path "/api/v1/bible_versions" do
    get("list bible versions") do
      tags "Bible Versions"
      produces "application/json"

      response(200, "successful") do
        before do
          create(:bible_version, :nvi)
          create(:bible_version, :ara)
        end

        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       code: { type: :string },
                       name: { type: :string },
                       full_name: { type: :string },
                       language: { type: :string },
                       description: { type: :string },
                       publisher: { type: :string },
                       year: { type: :integer },
                       is_recommended: { type: :boolean },
                       license: { type: :string },
                       created_at: { type: :string, format: :datetime }
                     }
                   }
                 },
                 metadata: {
                   type: :object,
                   properties: {
                     total: { type: :integer },
                     last_updated: { type: :string, nullable: true }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["data"].length).to eq(2)
          expect(data["metadata"]["total"]).to eq(2)

          # Should be sorted by is_recommended desc, name asc
          expect(data["data"].first["code"]).to eq("NVI")
          expect(data["data"].first["is_recommended"]).to be true
        end
      end
    end
  end
end
