require 'swagger_helper'

RSpec.describe 'api/v1/lectionary', type: :request do
  before(:all) do
    setup_liturgical_foundation
    setup_basic_celebrations
  end

  def self.api_tags
    'Lectionary'
  end

  def self.content_type
    'application/json'
  end

  let(:preferences) { { prayer_book_code: 'loc_2015' }.to_json }

  path '/api/v1/lectionary/{year}/{month}/{day}' do
    parameter name: 'year', in: :path, type: :string, description: 'year'
    parameter name: 'month', in: :path, type: :string, description: 'month'
    parameter name: 'day', in: :path, type: :string, description: 'day'

    get('day lectionary') do
      tags api_tags
      produces content_type
      security [ { bearer_auth: [] }, {} ]
      parameter name: 'Authorization', in: :header, type: :string, required: false,
                description: 'Optional Firebase auth token (Bearer)'
      parameter name: 'preferences', in: :query, type: :string, required: true,
                description: 'User preferences as JSON string. Required: prayer_book_code'

      response(200, 'successful') do
        let(:year) { '2025' }
        let(:month) { '12' }
        let(:day) { '25' }

        before do
          prayer_book = PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
            pb.name = 'Livro de Oração Comum 2015'
            pb.year = 2015
            pb.is_recommended = true
          end

          celebration = Celebration.find_or_create_by!(
            fixed_month: 12,
            fixed_day: 25,
            prayer_book: prayer_book
          ) do |c|
            c.name = 'Natal'
            c.celebration_type = :principal_feast
            c.rank = 0
            c.movable = false
            c.liturgical_color = 'branco'
          end

          create(:lectionary_reading,
            prayer_book: prayer_book,
            celebration: celebration,
            service_type: 'eucharist',
            cycle: 'all',
            reading_type: 'semicontinuous',
            first_reading: 'Isaiah 52:7-10',
            psalm: 'Psalm 98',
            second_reading: 'Hebrews 1:1-4',
            gospel: 'John 1:1-14')
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

  path '/api/v1/lectionary/{year}/{month}/{day}/all_services' do
    parameter name: 'year', in: :path, type: :string, description: 'year'
    parameter name: 'month', in: :path, type: :string, description: 'month'
    parameter name: 'day', in: :path, type: :string, description: 'day'

    get('all_services lectionary') do
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

  path '/api/v1/lectionary/cycle/{year}' do
    parameter name: 'year', in: :path, type: :string, description: 'year'

    get('cycle_info lectionary') do
      tags api_tags
      produces content_type
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
