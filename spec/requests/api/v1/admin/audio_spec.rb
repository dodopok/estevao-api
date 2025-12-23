require 'rails_helper'

RSpec.describe 'Admin Audio API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{user_token(user)}" } }
  let!(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015_test_audio') do |pb|
      pb.name = 'Liturgia das Horas'
      pb.language = 'pt-BR'
      pb.year = 2015
    end
  end

  describe 'GET /api/v1/admin/audio/generation_status' do
    before do
      # Clean up existing texts from previous tests/seeds
      LiturgicalText.delete_all
      # Create some liturgical texts with explicit prayer_book to avoid factory creating new ones
      create_list(:liturgical_text, 5, prayer_book: prayer_book)
    end

    it 'returns overall progress statistics' do
      get '/api/v1/admin/audio/generation_status', headers: headers

      expect(response).to have_http_status(:success)

      overall = json_response[:overall_progress]
      expect(overall[:total_texts]).to eq(5)
      expect(overall[:total_voices]).to eq(3)
      expect(overall[:total_possible_audio_files]).to eq(15)
      expect(overall[:completion_percentage]).to be_a(Numeric)
    end

    it 'shows active session if one exists' do
      session = create(:audio_generation_session,
                      prayer_book_code: 'loc_2015',
                      status: 'running',
                      total_texts: 10,
                      processed_count: 5)

      get '/api/v1/admin/audio/generation_status', headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:active_session]).to be_present
      expect(json_response[:active_session][:status]).to eq('running')
      expect(json_response[:active_session][:progress_percentage]).to eq(50.0)
    end

    it 'shows nil active session when none running' do
      create(:audio_generation_session, status: 'completed')

      get '/api/v1/admin/audio/generation_status', headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:active_session]).to be_nil
    end

    it 'shows recent sessions' do
      # Create 12 completed sessions (to avoid "already running" validation)
      create_list(:audio_generation_session, 12,
                  prayer_book_code: 'loc_2015',
                  status: 'completed')

      get '/api/v1/admin/audio/generation_status', headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:recent_sessions]).to be_an(Array)
      expect(json_response[:recent_sessions].count).to eq(10) # Limited to 10
    end

    it 'includes available voices information' do
      get '/api/v1/admin/audio/generation_status', headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:available_voices]).to be_an(Array)
      expect(json_response[:available_voices].count).to eq(3)

      first_voice = json_response[:available_voices].first
      expect(first_voice).to have_key(:key)
      expect(first_voice).to have_key(:name)
    end

    it 'requires authentication' do
      get '/api/v1/admin/audio/generation_status'

      expect(response).to have_http_status(:unauthorized)
    end

    # TODO: When admin authentication is implemented
    # it 'requires admin privileges' do
    #   get '/api/v1/admin/audio/generation_status', headers: headers
    #   expect(response).to have_http_status(:forbidden)
    # end
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_token(user)
    "test_token_#{user.id}"
  end
end
