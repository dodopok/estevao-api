require 'rails_helper'

RSpec.describe 'Subscriptions API', type: :request do
  let(:user) { create(:user, revenue_cat_user_id: nil) }
  let(:headers) { { 'Authorization' => "Bearer #{user_token(user)}" } }

  describe 'POST /api/v1/subscription/verify' do
    let(:service) { instance_double(RevenueCatService) }

    before do
      allow(RevenueCatService).to receive(:new).and_return(service)
    end

    it 'verifies subscription and updates user' do
      allow(service).to receive(:update_user_premium_status) do |user|
        user.update!(premium_expires_at: 1.month.from_now)
        true
      end

      post '/api/v1/subscription/verify',
           params: { revenue_cat_user_id: 'rc_user_123' },
           headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:premium]).to be true
      expect(user.reload.revenue_cat_user_id).to eq('rc_user_123')
    end

    it 'returns error when revenue_cat_user_id is missing' do
      post '/api/v1/subscription/verify', headers: headers

      expect(response).to have_http_status(:unprocessable_content)
      expect(json_response[:error]).to include('required')
    end

    it 'handles no active subscription' do
      allow(service).to receive(:update_user_premium_status).and_return(false)

      post '/api/v1/subscription/verify',
           params: { revenue_cat_user_id: 'rc_user_123' },
           headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:premium]).to be false
      expect(json_response[:message]).to include('No active subscription')
    end

    it 'requires authentication' do
      post '/api/v1/subscription/verify',
           params: { revenue_cat_user_id: 'rc_user_123' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /api/v1/subscription/premium_status' do
    it 'returns premium status for premium user' do
      user.update(premium_expires_at: 1.month.from_now)
      user.preferences['preferred_audio_voice'] = 'female_1'
      user.save

      get '/api/v1/subscription/premium_status', headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:premium]).to be true
      expect(json_response[:expires_at]).to be_present
      expect(json_response[:preferred_voice]).to eq('female_1')
      expect(json_response[:available_voices]).to be_an(Array)
      expect(json_response[:available_voices].count).to eq(3)
    end

    it 'returns non-premium status' do
      get '/api/v1/subscription/premium_status', headers: headers

      expect(response).to have_http_status(:success)
      expect(json_response[:premium]).to be false
      expect(json_response[:preferred_voice]).to eq('male_1')
    end

    it 'requires authentication' do
      get '/api/v1/subscription/premium_status'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_token(user)
    # Mock Firebase token - in real tests you'd use a proper test token
    "test_token_#{user.id}"
  end
end
