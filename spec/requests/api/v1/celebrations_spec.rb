require 'swagger_helper'

RSpec.describe 'api/v1/celebrations', type: :request do
  def self.api_tags
    'Celebrations'
  end

  def self.content_type
    'application/json'
  end

  path '/api/v1/celebrations/search' do
    get('search celebration') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'prayer_book_code', in: :query, required: false,
                description: 'Prayer book code (default: loc_2015). If authenticated, uses user\'s preference if not provided',
                schema: {
                  type: :string,
                  enum: [ 'loc_1987', 'locb_2008', 'loc_1662', 'loc_2012', 'loc_2015', 'loc_2019' ]
                }
      parameter name: 'q', in: :query, type: :string, required: false, description: 'Search query'

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
      parameter name: 'prayer_book_code', in: :query, required: false,
                description: 'Prayer book code (default: loc_2015). If authenticated, uses user\'s preference if not provided',
                schema: {
                  type: :string,
                  enum: [ 'loc_1987', 'locb_2008', 'loc_1662', 'loc_2012', 'loc_2015', 'loc_2019' ]
                }

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
      parameter name: 'prayer_book_code', in: :query, required: false,
                description: 'Prayer book code (default: loc_2015). If authenticated, uses user\'s preference if not provided',
                schema: {
                  type: :string,
                  enum: [ 'loc_1987', 'locb_2008', 'loc_1662', 'loc_2012', 'loc_2015', 'loc_2019' ]
                }

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
      parameter name: 'prayer_book_code', in: :query, required: false,
                description: 'Prayer book code (default: loc_2015). If authenticated, uses user\'s preference if not provided',
                schema: {
                  type: :string,
                  enum: [ 'loc_1987', 'locb_2008', 'loc_1662', 'loc_2012', 'loc_2015', 'loc_2019' ]
                }

      response(200, 'successful') do
        let(:id) { '1' }

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
