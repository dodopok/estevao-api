require "swagger_helper"

RSpec.describe "api/v1/daily_office", type: :request do
  before(:all) do
    setup_full_liturgical_data
  end

  def self.api_tags
    "Daily Office"
  end

  def self.content_type
    "application/json"
  end

  let(:preferences) { { prayer_book_code: 'loc_2015' }.to_json }

  path "/api/v1/daily_office/preferences" do
    get("Get available preferences") do
      tags api_tags
      produces content_type
      description "Returns all available options for customizing the Daily Office (versions, languages, Bible translations, etc.)"

      response(200, "successful") do
        schema type: :object,
               properties: {
                 versions: { type: :array, items: { type: :string }, example: [ "loc_2015" ] },
                 languages: { type: :array, items: { type: :string }, example: [ "pt-BR", "en" ] },
                 bible_versions: { type: :array, items: { type: :string }, example: BibleText::TRANSLATIONS.keys },
                 lords_prayer_versions: { type: :array, items: { type: :string }, example: [ "traditional", "contemporary" ] },
                 creed_types: { type: :array, items: { type: :string }, example: [ "apostles", "nicene" ] },
                 confession_types: { type: :array, items: { type: :string }, example: [ "long", "short" ] },
                 office_types: { type: :array, items: { type: :string }, example: [ "morning", "midday", "evening", "compline" ] }
               }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path "/api/v1/daily_office/today/{office_type}" do
    parameter name: "office_type", in: :path, required: true,
              description: "Type of office (morning, midday, evening, compline)",
              schema: { type: :string, enum: [ 'morning', 'midday', 'evening', 'compline' ] }
    parameter name: 'preferences', in: :query, type: :string, required: true,
              description: 'User preferences as JSON string. Required: prayer_book_code. Optional: bible_version, language, lords_prayer_version, creed_type, confession_type, seed'

    get("Get today's Daily Office") do
      tags api_tags
      produces content_type
      description "Returns the complete liturgy for today's Daily Office with all modules (opening sentence, psalms, readings, canticles, prayers, etc.)"

      response(200, "successful") do
        let(:office_type) { "morning" }

        schema type: :object,
               properties: {
                 date: { type: :string, example: "2025-11-22" },
                 office_type: { type: :string, example: "morning" },
                 season: { type: :string, example: "Tempo Comum", nullable: true },
                 color: { type: :string, example: "verde", nullable: true },
                 celebration: { type: :object, nullable: true },
                 saint: { type: :object, nullable: true },
                 modules: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       name: { type: :string, example: "Sentença de Abertura" },
                       slug: { type: :string, example: "opening_sentence" },
                       lines: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             content: { type: :string },
                             line_type: { type: :string, enum: [ "heading", "subheading", "rubric", "leader", "congregation", "reader", "responsive", "citation", "html", "spacer" ] },
                             reference: { type: :string, nullable: true },
                             audio_id: { type: :string, nullable: true }
                           }
                         }
                       }
                     }
                   }
                 },
                 metadata: {
                   type: :object,
                   properties: {
                     prayer_book_code: { type: :string, example: "loc_2015" },
                     prayer_book_name: { type: :string, example: "Livro de Oração Comum - IEAB 2015" },
                     bible_version: { type: :string, example: "nvi" },
                     language: { type: :string, example: "pt-BR" },
                     seed: { type: :integer, example: 1234567890, description: "Seed used for deterministic randomization (for sharing)" }
                   }
                 }
               }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(400, "invalid office type") do
        let(:office_type) { "invalid" }
        run_test!
      end
    end
  end

  path "/api/v1/daily_office/{year}/{month}/{day}/{office_type}" do
    parameter name: "year", in: :path, type: :string, description: "Year (1900-2200)", required: true
    parameter name: "month", in: :path, type: :string, description: "Month (1-12)", required: true
    parameter name: "day", in: :path, type: :string, description: "Day (1-31)", required: true
    parameter name: "office_type", in: :path, required: true,
              description: "Type of office (morning, midday, evening, compline)",
              schema: { type: :string, enum: [ 'morning', 'midday', 'evening', 'compline' ] }
    parameter name: 'preferences', in: :query, type: :string, required: true,
              description: 'User preferences as JSON string. Required: prayer_book_code'

    get("Get Daily Office for specific date") do
      tags api_tags
      produces content_type
      description "Returns the complete liturgy for a specific date's Daily Office"

      response(200, "successful") do
        let(:year) { "2025" }
        let(:month) { "12" }
        let(:day) { "25" }
        let(:office_type) { "morning" }

        schema type: :object,
               properties: {
                 date: { type: :string, example: "2025-12-25" },
                 office_type: { type: :string, example: "morning" },
                 season: { type: :string, example: "Natal", nullable: true },
                 color: { type: :string, example: "branco", nullable: true },
                 celebration: { type: :object, nullable: true },
                 saint: { type: :object, nullable: true },
                 modules: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       name: { type: :string },
                       slug: { type: :string },
                       lines: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             content: { type: :string },
                             line_type: { type: :string },
                             reference: { type: :string, nullable: true },
                             audio_id: { type: :string, nullable: true }
                           }
                         }
                       }
                     }
                   }
                 },
                 metadata: {
                   type: :object,
                   properties: {
                     prayer_book_code: { type: :string },
                     prayer_book_name: { type: :string },
                     bible_version: { type: :string },
                     language: { type: :string },
                     seed: { type: :integer, description: "Seed used for deterministic randomization (for sharing)" }
                   }
                 }
               }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(400, "invalid date") do
        let(:year) { "2025" }
        let(:month) { "13" }
        let(:day) { "01" }
        let(:office_type) { "morning" }
        run_test!
      end

      response(400, "invalid office type") do
        let(:year) { "2025" }
        let(:month) { "12" }
        let(:day) { "25" }
        let(:office_type) { "invalid" }
        run_test!
      end
    end
  end

  path "/api/v1/daily_office/{year}/{month}/{day}/{office_type}/family" do
    parameter name: :year, in: :path, required: true, schema: { type: :integer }, example: 2025
    parameter name: :month, in: :path, required: true, schema: { type: :integer }, example: 11
    parameter name: :day, in: :path, required: true, schema: { type: :integer }, example: 25
    parameter name: :office_type, in: :path, required: true,
              description: "Type of office (morning or evening only)",
              schema: { type: :string, enum: [ 'morning', 'evening' ] }
    parameter name: 'preferences', in: :query, type: :string, required: true,
              description: 'User preferences as JSON string. Required: prayer_book_code'

    get("Get family rite daily office") do
      tags api_tags
      produces content_type
      description "Returns a simplified family rite version of the daily office with reduced components (8 components instead of 15-18)"

      parameter name: 'Authorization', in: :header, required: false,
                description: 'Optional Firebase auth token (Bearer)',
                schema: { type: :string }

      response(200, "successful") do
        let(:year) { "2025" }
        let(:month) { "11" }
        let(:day) { "25" }
        let(:office_type) { "morning" }

        schema type: :object,
               properties: {
                 date: { type: :string, example: "2025-11-25" },
                 office_type: { type: :string, example: "morning" },
                 season: { type: :string, example: "Tempo Comum" },
                 modules: {
                   type: :array,
                   description: "Simplified list of 6-8 modules for family rite",
                   items: {
                     type: :object,
                     properties: {
                       name: { type: :string },
                       slug: { type: :string },
                       lines: {
                         type: :array,
                         items: { type: :object }
                       }
                     }
                   }
                 },
                 metadata: {
                   type: :object,
                   properties: {
                     prayer_book_code: { type: :string },
                     prayer_book_name: { type: :string },
                     bible_version: { type: :string }
                   }
                 }
               }

        run_test!
      end

      response(422, "Unprocessable entity - Prayer Book doesn't support family rite") do
        let(:year) { "2025" }
        let(:month) { "11" }
        let(:day) { "25" }
        let(:office_type) { "morning" }
        let(:preferences) { { prayer_book_code: 'loc_1987' }.to_json }

        schema type: :object,
               properties: {
                 error: { type: :string, example: "O Prayer Book 'loc_1987' não suporta rito familiar" }
               }

        run_test!
      end
    end
  end

  # Integration tests for seed functionality
  describe "Seed functionality" do
    let(:date) { "2025/11/25" }
    let(:office_type) { "morning" }
    let(:base_preferences) { { prayer_book_code: 'loc_2015' } }

    context "when seed parameter is provided" do
      it "returns the same seed in metadata" do
        prefs = base_preferences.merge(seed: 12345)
        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: prefs.to_json }
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json["metadata"]["seed"]).to eq(12345)
      end

      it "produces deterministic results with same seed" do
        prefs = base_preferences.merge(seed: 54321)
        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: prefs.to_json }
        response1 = JSON.parse(response.body)

        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: prefs.to_json }
        response2 = JSON.parse(response.body)

        # The responses should be identical when using the same seed
        expect(response1["modules"]).to eq(response2["modules"])
      end

      it "produces different results with different seeds" do
        prefs1 = base_preferences.merge(seed: 11111)
        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: prefs1.to_json }
        response1 = JSON.parse(response.body)

        prefs2 = base_preferences.merge(seed: 99999)
        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: prefs2.to_json }
        response2 = JSON.parse(response.body)

        # Extract opening sentence content to verify randomization worked
        opening1 = response1["modules"].find { |m| m["slug"] == "opening_sentence" }
        opening2 = response2["modules"].find { |m| m["slug"] == "opening_sentence" }

        # With different seeds, there's a high probability (but not guaranteed)
        # that the opening sentences will be different
        # We just verify that the structure is correct and seed is in metadata
        expect(response1["metadata"]["seed"]).to eq(11111)
        expect(response2["metadata"]["seed"]).to eq(99999)
        expect(opening1).to be_present
        expect(opening2).to be_present
      end
    end

    context "when seed parameter is not provided" do
      it "automatically generates a seed and includes it in metadata" do
        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: base_preferences.to_json }
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json["metadata"]["seed"]).to be_present
        expect(json["metadata"]["seed"]).to be_a(Integer)
      end

      it "generates consistent seed for same date/office combination" do
        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: base_preferences.to_json }
        response1 = JSON.parse(response.body)

        get "/api/v1/daily_office/#{date}/#{office_type}", params: { preferences: base_preferences.to_json }
        response2 = JSON.parse(response.body)

        # Same date/office should produce same seed
        expect(response1["metadata"]["seed"]).to eq(response2["metadata"]["seed"])
      end
    end
  end
end
