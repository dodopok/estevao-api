require "swagger_helper"

RSpec.describe "api/v1/daily_office", type: :request do
  def self.api_tags
    "Daily Office"
  end

  def self.content_type
    "application/json"
  end

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
                 bible_versions: { type: :array, items: { type: :string }, example: [ "nvi", "ntlh", "arc" ] },
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
    parameter name: "office_type", in: :path, required: true, description: "Type of office (morning, midday, evening, compline)", schema: { type: :string, enum: ['morning', 'midday', 'evening', 'compline'] }
    parameter name: :prayer_book_code, in: :query, required: false, description: "Prayer book code (default: loc_2015)", schema: { type: :string, enum: ['loc_1987', 'locb_2008', 'loc_1662', 'loc_2012', 'loc_2015', 'loc_2019'] }
    parameter name: :bible_version, in: :query, required: false, description: "Bible translation (default: nvi)", schema: { type: :string, enum: ['nvi', 'ntlh', 'arc'] }
    parameter name: :language, in: :query, required: false, description: "Language (default: pt-BR)", schema: { type: :string, enum: ['pt-BR'] }
    parameter name: :lords_prayer_version, in: :query, required: false, description: "Lord's Prayer version (traditional/contemporary)", schema: { type: :string, enum: ['traditional', 'contemporary'] }
    parameter name: :creed_type, in: :query, required: false, description: "Creed type (apostles/nicene)", schema: { type: :string, enum: ['apostles', 'nicene'] }
    parameter name: :confession_type, in: :query, required: false, description: "Confession type (long/short)", schema: { type: :string, enum: ['long', 'short'] }

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
                 season: { type: :string, example: "Tempo Comum" },
                 color: { type: :string, example: "verde" },
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
                     language: { type: :string, example: "pt-BR" }
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
    parameter name: "office_type", in: :path, required: true, description: "Type of office (morning, midday, evening, compline)", schema: { type: :string, enum: ['morning', 'midday', 'evening', 'compline'] }
    parameter name: :prayer_book_code, in: :query, required: false, description: "Prayer book code (default: loc_2015)", schema: { type: :string, enum: ['loc_1987', 'locb_2008', 'loc_1662', 'loc_2012', 'loc_2015', 'loc_2019'] }
    parameter name: :bible_version, in: :query, required: false, description: "Bible translation (default: nvi)", schema: { type: :string, enum: ['nvi', 'ntlh', 'arc'] }
    parameter name: :language, in: :query, required: false, description: "Language (default: pt-BR)", schema: { type: :string, enum: ['pt-BR'] }
    parameter name: :lords_prayer_version, in: :query, required: false, description: "Lord's Prayer version (traditional/contemporary)", schema: { type: :string, enum: ['traditional', 'contemporary'] }
    parameter name: :creed_type, in: :query, required: false, description: "Creed type (apostles/nicene)", schema: { type: :string, enum: ['apostles', 'nicene'] }
    parameter name: :confession_type, in: :query, required: false, description: "Confession type (long/short)", schema: { type: :string, enum: ['long', 'short'] }

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
                 season: { type: :string, example: "Natal" },
                 color: { type: :string, example: "branco" },
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
                     language: { type: :string }
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
end
