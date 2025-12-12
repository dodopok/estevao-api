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

  # Integration test for reading_type (semicontinuous vs complementary)
  describe 'Reading Pattern Preference (LOC2015 specific)' do
    let(:prayer_book) do
      PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
        pb.name = 'Livro de Oração Comum 2015'
        pb.year = 2015
        pb.is_recommended = true
        pb.features = {
          "lectionary" => {
            "reading_type" => [ "semicontinuous", "complementary" ],
            "default_reading_type" => "semicontinuous",
            "supports_vigil" => false
          },
          "daily_office" => {
            "supports_family_rite" => false
          },
          "psalter" => {}
        }
      end
    end

    let!(:semicontinuous_reading) do
      create(:lectionary_reading,
             prayer_book: prayer_book,
             date_reference: 'july_13',
             cycle: 'A',
             service_type: 'eucharist',
             reading_type: 'semicontinuous',
             first_reading: 'Genesis 25:19-34',
             psalm: 'Psalm 119:105-112',
             second_reading: 'Romans 8:1-11',
             gospel: 'Matthew 13:1-9')
    end

    let!(:complementary_reading) do
      create(:lectionary_reading,
             prayer_book: prayer_book,
             date_reference: 'july_13',
             cycle: 'A',
             service_type: 'eucharist',
             reading_type: 'complementary',
             first_reading: 'Isaiah 55:10-13',
             psalm: 'Psalm 65:(1-8), 9-13',
             second_reading: 'Romans 8:1-11',
             gospel: 'Matthew 13:1-9')
    end

    let!(:nil_reading_type) do
      create(:lectionary_reading,
             prayer_book: prayer_book,
             date_reference: 'christmas_day',
             celebration: Celebration.find_or_create_by!(
               fixed_month: 12,
               fixed_day: 25,
               prayer_book: prayer_book
             ) { |c|
               c.name = 'Natal'
               c.celebration_type = :principal_feast
               c.rank = 0
               c.movable = false
             },
             cycle: 'all',
             service_type: 'eucharist',
             reading_type: nil, # Applies to all patterns
             first_reading: 'Isaiah 52:7-10',
             psalm: 'Psalm 98',
             second_reading: 'Hebrews 1:1-4',
             gospel: 'John 1:1-14')
    end

    context 'when user chooses semicontinuous reading pattern' do
      it 'returns semicontinuous reading when available' do
        # July 13, 2026 is a Monday in Year A
        # LOC2015Service will search for date_reference 'july_13'
        preferences_with_semicontinuous = {
          prayer_book_code: 'loc_2015',
          reading_type: 'semicontinuous'
        }.to_json

        get '/api/v1/lectionary/2026/7/13', params: { preferences: preferences_with_semicontinuous }

        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)

        # Should get semicontinuous reading
        expect(json.dig('leituras', 'primeira_leitura')).to eq('Genesis 25:19-34')
        expect(json.dig('leituras', 'salmo')).to eq('Psalm 119:105-112')
      end
    end

    context 'when user chooses complementary reading pattern' do
      it 'returns complementary reading when available' do
        preferences_with_complementary = {
          prayer_book_code: 'loc_2015',
          reading_type: 'complementary'
        }.to_json

        get '/api/v1/lectionary/2026/7/13', params: { preferences: preferences_with_complementary }

        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)

        # Should get complementary reading
        expect(json.dig('leituras', 'primeira_leitura')).to eq('Isaiah 55:10-13')
        expect(json.dig('leituras', 'salmo')).to eq('Psalm 65:(1-8), 9-13')
      end
    end

    context 'when reading_type is nil (fixed celebrations)' do
      it 'returns reading regardless of user preference' do
        # Christmas Day - has reading_type nil
        preferences_semicontinuous = {
          prayer_book_code: 'loc_2015',
          reading_type: 'semicontinuous'
        }.to_json

        get '/api/v1/lectionary/2025/12/25', params: { preferences: preferences_semicontinuous }

        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)

        # Should get the nil reading_type reading
        expect(json.dig('leituras', 'primeira_leitura')).to eq('Isaiah 52:7-10')
        expect(json.dig('leituras', 'salmo')).to eq('Psalm 98')

        # Try with complementary preference - should get same result
        preferences_complementary = {
          prayer_book_code: 'loc_2015',
          reading_type: 'complementary'
        }.to_json

        get '/api/v1/lectionary/2025/12/25', params: { preferences: preferences_complementary }

        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)

        # Same reading for both preferences
        expect(json.dig('leituras', 'primeira_leitura')).to eq('Isaiah 52:7-10')
      end
    end

    context 'when preferred reading_type is not available' do
      it 'falls back to reading with reading_type nil' do
        # Create a date reference that only has nil reading_type
        create(:lectionary_reading,
               prayer_book: prayer_book,
               date_reference: 'august_19',
               cycle: 'A',
               service_type: 'eucharist',
               reading_type: nil,
               first_reading: 'Jeremiah 23:1-8',
               psalm: 'Psalm 89',
               second_reading: 'Ephesians 2:11-22',
               gospel: 'Mark 6:30-34')

        preferences_with_semicontinuous = {
          prayer_book_code: 'loc_2015',
          reading_type: 'semicontinuous'
        }.to_json

        # 2026 is Year A
        get '/api/v1/lectionary/2026/8/19', params: { preferences: preferences_with_semicontinuous }

        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)

        # Should fallback to nil reading_type since semicontinuous doesn't exist
        expect(json.dig('leituras', 'primeira_leitura')).to eq('Jeremiah 23:1-8')
      end
    end
  end
end
