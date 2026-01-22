require 'rails_helper'

RSpec.describe 'Api::V1::Calendar Optimization', type: :request do
  let(:prayer_book) { PrayerBook.create!(code: 'loc_2015', name: 'Livro de Oração Comum 2015') }
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:params) { { preferences: { prayer_book_code: 'loc_2015' }.to_json } }

  before do
    prayer_book
  end

  describe 'GET /api/v1/calendar/:year/:month' do
    it 'returns optimized calendar for the month' do
      get '/api/v1/calendar/2026/01', params: params, headers: headers

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Expect an array of days (31 days in Jan)
      expect(json).to be_an(Array)
      expect(json.length).to eq(31)

      first_day = json.first
      expect(first_day).to include(
        'date',
        'color',
        'celebration_name',
        'week_name'
      )
      
      # Should not include heavy fields
      expect(first_day).not_to include('readings')
      expect(first_day).not_to include('collect')
      
      # Should not include Portuguese localization fields mentioned to be removed
      expect(first_day).not_to include('day_of_week')
      
      # Check specific data correctness (Jan 1st 2026 is Circumcision/Holy Name)
      expect(first_day['date']).to eq('2026-01-01')
      # Depending on PB, color is usually white
      expect(first_day['color']).to eq('white').or eq('branco') 
    end
  end

  describe 'GET /api/v1/calendar/:year' do
    it 'returns optimized calendar for the year' do
      get '/api/v1/calendar/2026', params: params, headers: headers

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Expect an array of days (365 days in 2026)
      expect(json).to be_an(Array)
      expect(json.length).to eq(365)
      
      first_day = json.first
      expect(first_day).to include(
        'date',
        'color',
        'celebration_name',
        'week_name'
      )
    end
  end
end
