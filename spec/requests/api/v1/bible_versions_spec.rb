# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/bible_versions", type: :request do
  path "/api/v1/bible_versions" do
    get("list bible versions") do
      tags "Bible Versions"
      produces "application/json"

      response(200, "successful") do
        before do
          BibleVersion.find_by(code: "nvi") || create(:bible_version, :nvi)
          BibleVersion.find_by(code: "ara") || create(:bible_version, :ara)
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
          expect(data["data"].length).to be >= 2
          expect(data["metadata"]["total"]).to eq(BibleVersion.count)

          # Should be sorted by is_recommended desc, name asc
          nvi = data["data"].find { |v| v["code"] == "NVI" }
          expect(nvi).to be_present
          expect(nvi["is_recommended"]).to be true
        end
      end
    end
  end
end
