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
