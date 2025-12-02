require 'swagger_helper'

RSpec.describe 'api/v1/celebrations', type: :request do
  before(:all) do
    setup_liturgical_foundation
    setup_basic_celebrations
  end

  def self.api_tags
    'Celebrations'
  end

  def self.content_type
    'application/json'
  end

  let(:preferences) { { prayer_book_code: 'loc_2015' }.to_json }

  path '/api/v1/celebrations/search' do
    get('search celebration') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'
      parameter name: 'q', in: :query, type: :string, required: false, description: 'Search query'

      response(200, 'successful') do
        let(:q) { 'natal' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/celebrations/types' do
    get('types celebration') do
      tags api_tags
      produces content_type

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/celebrations/date/{month}/{day}' do
    parameter name: 'month', in: :path, type: :string, description: 'month'
    parameter name: 'day', in: :path, type: :string, description: 'day'

    get('by_date celebration') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'

      response(200, 'successful') do
        let(:month) { '01' }
        let(:day) { '01' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/celebrations' do
    get('list celebrations') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/celebrations/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show celebration') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'

      response(200, 'successful') do
        let(:id) do
          prayer_book = PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
            pb.name = 'Livro de Oração Comum 2015'
            pb.year = 2015
            pb.is_recommended = true
          end
          celebration = Celebration.create!(
            name: 'Teste',
            celebration_type: :principal_feast,
            rank: 50,
            prayer_book: prayer_book
          )
          celebration.id
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
