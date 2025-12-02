# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/preferences", type: :request do
  path "/api/v1/prayer_books/{prayer_book_code}/preferences" do
    get("get prayer book preferences") do
      tags "Preferences"
      produces "application/json"
      parameter name: :prayer_book_code, in: :path, type: :string, description: "Prayer book code"

      response(200, "successful") do
        let(:prayer_book) { create(:prayer_book) }
        let(:prayer_book_code) { prayer_book.code }

        before do
          category = create(:preference_category, prayer_book: prayer_book, key: "daily_office", name: "Daily Office", position: 1)
          create(:preference_definition, :select_one, preference_category: category, key: "office_type", position: 1)
          create(:preference_definition, :toggle, preference_category: category, key: "show_rubrics", position: 2)
        end

        schema type: :object,
               properties: {
                 prayer_book_id: { type: :string },
                 prayer_book_name: { type: :string },
                 categories: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string },
                       key: { type: :string },
                       name: { type: :string },
                       description: { type: :string },
                       icon: { type: :string },
                       order: { type: :integer },
                       preferences: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             id: { type: :string },
                             key: { type: :string },
                             name: { type: :string },
                             type: { type: :string },
                             required: { type: :boolean },
                             default_value: {}
                           }
                         }
                       }
                     }
                   }
                 },
                 metadata: {
                   type: :object,
                   properties: {
                     total_categories: { type: :integer },
                     total_preferences: { type: :integer },
                     version: { type: :string }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["prayer_book_id"]).to eq(prayer_book.code)
          expect(data["categories"].length).to eq(1)
          expect(data["categories"].first["preferences"].length).to eq(2)
          expect(data["metadata"]["total_categories"]).to eq(1)
          expect(data["metadata"]["total_preferences"]).to eq(2)
        end
      end

      response(404, "prayer book not found") do
        let(:prayer_book_code) { "nonexistent" }

        schema type: :object,
               properties: {
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
          expect(data["error"]["code"]).to eq("PRAYER_BOOK_NOT_FOUND")
        end
      end
    end
  end
end
