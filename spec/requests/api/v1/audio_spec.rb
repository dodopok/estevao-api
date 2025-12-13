require 'rails_helper'

RSpec.describe 'Audio API', type: :request do
  let(:prayer_book) { PrayerBook.find_or_create_by!(code: 'loc_2015') { |pb| pb.name = 'Liturgia das Horas' } }
  let(:text) do
    create(:liturgical_text,
           prayer_book: prayer_book,
           slug: 'test_text',
           title: 'Test Liturgical Text',
           audio_urls: { 'male_1' => '/audio/loc_2015/male_1/loc_2015_1_test_text.mp3' })
  end
  let(:premium_user) { create(:user, premium_expires_at: 1.month.from_now) }
  let(:regular_user) { create(:user, premium_expires_at: nil) }
  let(:premium_headers) { { 'Authorization' => "Bearer #{user_token(premium_user)}" } }
  let(:regular_headers) { { 'Authorization' => "Bearer #{user_token(regular_user)}" } }

  describe 'GET /api/v1/audio/voice_samples' do
    it 'returns voice samples without premium requirement' do
      get '/api/v1/audio/voice_samples', headers: regular_headers

      expect(response).to have_http_status(:success)
      expect(json_response[:voices]).to be_an(Array)
      expect(json_response[:voices].count).to eq(3)
      expect(json_response[:default_voice]).to eq('male_1')

      first_voice = json_response[:voices].first
      expect(first_voice).to have_key(:key)
      expect(first_voice).to have_key(:name)
      expect(first_voice).to have_key(:gender)
      expect(first_voice).to have_key(:sample_url)
    end

    it 'requires authentication' do
      get '/api/v1/audio/voice_samples'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /api/v1/audio/url/:prayer_book/:voice/:slug' do
    before { text } # Create the text

    it 'returns audio URL for premium users' do
      get '/api/v1/audio/url/loc_2015/male_1/test_text', headers: premium_headers

      expect(response).to have_http_status(:success)
      expect(json_response[:audio_url]).to include('/audio/loc_2015/male_1/')
      expect(json_response[:voice]).to eq('male_1')
      expect(json_response[:slug]).to eq('test_text')
      expect(json_response[:title]).to eq('Test Liturgical Text')
    end

    it 'rejects non-premium users' do
      get '/api/v1/audio/url/loc_2015/male_1/test_text', headers: regular_headers

      expect(response).to have_http_status(:forbidden)
      expect(json_response[:error]).to include('Premium subscription required')
    end

    it 'returns 404 for non-existent text' do
      get '/api/v1/audio/url/loc_2015/male_1/nonexistent', headers: premium_headers

      expect(response).to have_http_status(:not_found)
      expect(json_response[:error]).to include('not found')
    end

    it 'returns 404 when audio not generated for voice' do
      get '/api/v1/audio/url/loc_2015/female_1/test_text', headers: premium_headers

      expect(response).to have_http_status(:not_found)
      expect(json_response[:error]).to include('not yet generated')
      expect(json_response[:available_voices]).to include('male_1')
    end

    it 'validates voice key' do
      get '/api/v1/audio/url/loc_2015/invalid_voice/test_text', headers: premium_headers

      expect(response).to have_http_status(:unprocessable_content)
      expect(json_response[:error]).to include('Invalid voice')
      expect(json_response[:available_voices]).to be_present
    end

    it 'requires authentication' do
      get '/api/v1/audio/url/loc_2015/male_1/test_text'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_token(user)
    "test_token_#{user.id}"
  end
end
