require 'swagger_helper'

RSpec.describe 'api/v1/calendar', type: :request do
  def self.api_tags
    'Calendar'
  end

  def self.content_type
    'application/json'
  end

  before do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.language = 'pt-BR'
    end
  end

  let(:preferences) { { prayer_book_code: 'loc_2015' }.to_json }

  path '/api/v1/calendar/today' do
    get('today calendar') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required fields: prayer_book_code. Example: {"prayer_book_code":"loc_2015","bible_version":"nvi"}'

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

      response(400, 'missing prayer_book_code') do
        let(:preferences) { {}.to_json }
        run_test!
      end
    end
  end

  path '/api/v1/calendar/{year}/{month}/{day}' do
    parameter name: 'year', in: :path, type: :string, description: 'year'
    parameter name: 'month', in: :path, type: :string, description: 'month'
    parameter name: 'day', in: :path, type: :string, description: 'day'

    get('day calendar') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'

      response(200, 'successful') do
        let(:year) { '2024' }
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

  path '/api/v1/calendar/{year}/{month}' do
    parameter name: 'year', in: :path, type: :string, description: 'year'
    parameter name: 'month', in: :path, type: :string, description: 'month'

    get('month calendar') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'

      response(200, 'successful') do
        let(:year) { '2024' }
        let(:month) { '01' }

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

  path '/api/v1/calendar/{year}' do
    parameter name: 'year', in: :path, type: :string, description: 'year'

    get('year calendar') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'

      response(200, 'successful') do
        let(:year) { '2024' }

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
