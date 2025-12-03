# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Api::V1::SharedOffices", type: :request do
  def self.api_tags
    "Shared Offices"
  end

  def self.content_type
    "application/json"
  end

  path "/api/v1/shared_offices" do
    post("Create shared office link") do
      tags api_tags
      consumes content_type
      produces content_type
      description "Creates a shareable link for an office configuration including preferences and seed"

      parameter name: :shared_office_params, in: :body, schema: {
        type: :object,
        properties: {
          date: { type: :string, format: :date, example: "2025-12-03", description: "Date of the office (YYYY-MM-DD)" },
          office_type: { type: :string, enum: %w[morning midday evening compline], example: "morning", description: "Type of office" },
          prayer_book_code: { type: :string, example: "loc_2015", description: "Prayer book code" },
          seed: { type: :integer, example: 12345678, description: "Randomization seed for deterministic office generation" },
          preferences: {
            type: :object,
            description: "User preferences for the office",
            properties: {
              bible_version: { type: :string, example: "nvi" },
              lords_prayer_version: { type: :string, example: "traditional" },
              confession_type: { type: :string, example: "long" },
              creed_type: { type: :string, example: "apostles" }
            }
          }
        },
        required: %w[date office_type prayer_book_code seed]
      }

      response(201, "created") do
        let(:shared_office_params) do
          {
            date: "2025-12-03",
            office_type: "morning",
            prayer_book_code: "loc_2015",
            seed: 12345678,
            preferences: { bible_version: "nvi" }
          }
        end

        schema type: :object,
               properties: {
                 short_code: { type: :string, example: "zHaD2NJ", description: "Unique 7-character code for the shared link" },
                 share_path: { type: :string, example: "/o/zHaD2NJ", description: "Path to use in the app deep link" },
                 expires_at: { type: :string, format: "date-time", example: "2026-01-02T12:00:00Z", description: "Expiration timestamp (30 days from creation)" },
                 date: { type: :string, format: :date, example: "2025-12-03" },
                 office_type: { type: :string, example: "morning" },
                 prayer_book_code: { type: :string, example: "loc_2015" }
               },
               required: %w[short_code share_path expires_at date office_type prayer_book_code]

        run_test!
      end

      response(400, "bad request - missing required parameters") do
        let(:shared_office_params) do
          {
            date: "2025-12-03",
            office_type: "morning"
            # missing prayer_book_code and seed
          }
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: "Parâmetros obrigatórios faltando: prayer_book_code, seed" }
               }

        run_test!
      end

      response(400, "bad request - invalid office type") do
        let(:shared_office_params) do
          {
            date: "2025-12-03",
            office_type: "invalid",
            prayer_book_code: "loc_2015",
            seed: 12345678
          }
        end

        schema type: :object,
               properties: {
                 error: { type: :string, example: "Tipo de ofício inválido. Use: morning, midday, evening, compline" }
               }

        run_test!
      end
    end
  end

  path "/api/v1/shared_offices/{code}" do
    get("Get shared office by code") do
      tags api_tags
      produces content_type
      description "Returns the shared office data for a given short code. Use this data to open the office with the same configuration."

      parameter name: :code, in: :path, type: :string, description: "The 7-character short code", example: "zHaD2NJ"

      response(200, "successful") do
        let!(:shared_office) { create(:shared_office, :with_preferences) }
        let(:code) { shared_office.short_code }

        schema type: :object,
               properties: {
                 short_code: { type: :string, example: "zHaD2NJ" },
                 date: { type: :string, format: :date, example: "2025-12-03" },
                 office_type: { type: :string, example: "morning" },
                 prayer_book_code: { type: :string, example: "loc_2015" },
                 seed: { type: :integer, example: 12345678, description: "Use this seed when generating the office" },
                 preferences: {
                   type: :object,
                   description: "Preferences to apply when generating the office",
                   properties: {
                     bible_version: { type: :string, example: "nvi" },
                     lords_prayer_version: { type: :string, example: "traditional" },
                     confession_type: { type: :string, example: "long" },
                     creed_type: { type: :string, example: "apostles" }
                   }
                 },
                 expires_at: { type: :string, format: "date-time", example: "2026-01-02T12:00:00Z" },
                 created_by: { type: :string, nullable: true, example: "João Silva", description: "Name of the user who created the link (if authenticated)" }
               },
               required: %w[short_code date office_type prayer_book_code seed preferences expires_at]

        run_test!
      end

      response(404, "not found") do
        let(:code) { "INVALID" }

        schema type: :object,
               properties: {
                 error: { type: :string, example: "Link não encontrado" }
               }

        run_test!
      end

      response(410, "gone - link expired") do
        let!(:expired_office) { create(:shared_office, :expired) }
        let(:code) { expired_office.short_code }

        schema type: :object,
               properties: {
                 error: { type: :string, example: "Este link expirou" }
               }

        run_test!
      end
    end
  end
end
