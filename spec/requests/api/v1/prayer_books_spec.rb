require "swagger_helper"

RSpec.describe "api/v1/prayer_books", type: :request do
  before(:all) do
    setup_liturgical_foundation
  end

  def self.api_tags
    "Prayer Books"
  end

  def self.content_type
    "application/json"
  end

  path "/api/v1/prayer_books" do
    get("list prayer books") do
      tags api_tags
      produces content_type
      description "Returns all available Prayer Books (LOCs), ordered by default and year"

      response(200, "successful") do
        schema type: :object,
               properties: {
                 prayer_books: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       code: { type: :string, example: "loc_2015" },
                       name: { type: :string, example: "Livro de Oração Comum - IEAB 2015" },
                       year: { type: :integer, example: 2015 },
                       jurisdiction: { type: :string, example: "Igreja Episcopal Anglicana do Brasil", nullable: true },
                       description: { type: :string, nullable: true },
                       thumbnail_url: { type: :string, nullable: true },
                       pdf_url: { type: :string, nullable: true },
                       is_default: { type: :boolean, example: true }
                     },
                     required: %w[code name year is_default]
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
    end
  end

  path "/api/v1/prayer_books/{code}" do
    parameter name: "code", in: :path, type: :string, description: "Prayer book code (e.g., loc_2015, loc_1987)", required: true

    get("show prayer book") do
      tags api_tags
      produces content_type
      description "Returns details of a specific Prayer Book by its code"

      response(200, "successful") do
        let(:code) { "loc_2015" }

        schema type: :object,
               properties: {
                 code: { type: :string, example: "loc_2015" },
                 name: { type: :string, example: "Livro de Oração Comum - IEAB 2015" },
                 year: { type: :integer, example: 2015 },
                 jurisdiction: { type: :string, example: "Igreja Episcopal Anglicana do Brasil", nullable: true },
                 description: { type: :string, nullable: true },
                 thumbnail_url: { type: :string, nullable: true },
                 pdf_url: { type: :string, nullable: true },
                 is_default: { type: :boolean, example: true }
               },
               required: %w[code name year is_default]

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, "not found") do
        let(:code) { "invalid_code" }

        schema type: :object,
               properties: {
                 error: { type: :string, example: "Prayer book not found" }
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
end
