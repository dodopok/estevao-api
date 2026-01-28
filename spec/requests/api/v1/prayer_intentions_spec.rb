require 'rails_helper'

RSpec.describe 'Api::V1::PrayerIntentions', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, firebase_uid: 'other-uid', email: 'other@example.com') }
  let(:headers) { { 'Authorization' => "Bearer #{generate_jwt_token(user)}" } }
  let(:other_headers) { { 'Authorization' => "Bearer #{generate_jwt_token(other_user)}" } }
  
  describe 'GET /api/v1/prayer_intentions' do
    let!(:user_intentions) { create_list(:prayer_intention, 3, user: user) }
    let!(:other_user_intentions) { create_list(:prayer_intention, 2, user: other_user) }
    
    it 'returns user\'s prayer intentions' do
      get '/api/v1/prayer_intentions', headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].length).to eq(3)
      expect(json['meta']).to include('current_page', 'total_pages', 'total_count')
    end
    
    it 'does not return other users\' private intentions' do
      get '/api/v1/prayer_intentions', headers: headers
      
      json = JSON.parse(response.body)
      intention_user_ids = json['prayer_intentions'].map { |i| i['metadata']['user_id'] }
      expect(intention_user_ids).to all(eq(user.id))
    end
    
    it 'filters by status' do
      create(:prayer_intention, user: user, status: :answered)
      create(:prayer_intention, user: user, status: :pending)
      
      get '/api/v1/prayer_intentions', params: { status: 'answered' }, headers: headers
      
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].all? { |i| i['status'] == 'answered' }).to be true
    end
    
    it 'filters by category' do
      create(:prayer_intention, user: user, category: 'personal')
      create(:prayer_intention, user: user, category: 'family')
      
      get '/api/v1/prayer_intentions', params: { category: 'personal' }, headers: headers
      
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].all? { |i| i['category'] == 'personal' }).to be true
    end
    
    it 'filters by AI enrichment status' do
      create(:prayer_intention, user: user, :ai_enriched)
      create(:prayer_intention, user: user)
      
      get '/api/v1/prayer_intentions', params: { enriched: true }, headers: headers
      
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].all? { |i| i['ai_enrichment']['enriched_at'].present? }).to be true
    end
    
    it 'searches by title and description' do
      create(:prayer_intention, user: user, title: 'Healing prayer')
      create(:prayer_intention, user: user, title: 'Guidance needed')
      
      get '/api/v1/prayer_intentions', params: { search: 'healing' }, headers: headers
      
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].length).to eq(1)
      expect(json['prayer_intentions'].first['title']).to include('Healing')
    end
    
    it 'paginates results' do
      create_list(:prayer_intention, 25, user: user)
      
      get '/api/v1/prayer_intentions', params: { per_page: 10, page: 1 }, headers: headers
      
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].length).to eq(10)
      expect(json['meta']['current_page']).to eq(1)
      expect(json['meta']['total_pages']).to eq(3)
    end
    
    it 'requires authentication' do
      get '/api/v1/prayer_intentions'
      
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
  describe 'GET /api/v1/prayer_intentions/:id' do
    let(:intention) { create(:prayer_intention, user: user) }
    
    it 'returns the prayer intention' do
      get "/api/v1/prayer_intentions/#{intention.id}", headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['prayer_intention']['id']).to eq(intention.id)
      expect(json['prayer_intention']['title']).to eq(intention.title)
    end
    
    it 'returns 404 for non-existent intention' do
      get '/api/v1/prayer_intentions/99999', headers: headers
      
      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Prayer intention not found')
    end
    
    it 'does not allow viewing other users\' private intentions' do
      other_intention = create(:prayer_intention, user: other_user, is_private: true)
      
      get "/api/v1/prayer_intentions/#{other_intention.id}", headers: headers
      
      expect(response).to have_http_status(:forbidden)
    end
    
    it 'allows viewing public intentions from other users' do
      public_intention = create(:prayer_intention, user: other_user, is_private: false)
      
      get "/api/v1/prayer_intentions/#{public_intention.id}", headers: headers
      
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe 'POST /api/v1/prayer_intentions' do
    let(:valid_params) do
      {
        prayer_intention: {
          title: 'Healing for my mother',
          description: 'Praying for complete healing',
          category: 'intercession'
        }
      }
    end
    
    it 'creates a prayer intention' do
      expect {
        post '/api/v1/prayer_intentions', params: valid_params, headers: headers
      }.to change(PrayerIntention, :count).by(1)
      
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['prayer_intention']['title']).to eq('Healing for my mother')
      expect(json['message']).to eq('Prayer intention created successfully')
    end
    
    it 'associates intention with current user' do
      post '/api/v1/prayer_intentions', params: valid_params, headers: headers
      
      intention = PrayerIntention.last
      expect(intention.user_id).to eq(user.id)
    end
    
    it 'triggers async enrichment when auto_enrich is true' do
      params = valid_params.merge(auto_enrich: true)
      
      expect(EnrichPrayerIntentionJob).to receive(:perform_later)
      
      post '/api/v1/prayer_intentions', params: params, headers: headers
    end
    
    it 'returns errors for invalid data' do
      invalid_params = { prayer_intention: { title: 'ab' } } # Too short
      
      post '/api/v1/prayer_intentions', params: invalid_params, headers: headers
      
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']).to be_present
    end
    
    it 'validates category inclusion' do
      invalid_params = valid_params.deep_merge(prayer_intention: { category: 'invalid' })
      
      post '/api/v1/prayer_intentions', params: invalid_params, headers: headers
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  
  describe 'PATCH /api/v1/prayer_intentions/:id' do
    let(:intention) { create(:prayer_intention, user: user, title: 'Original title') }
    
    it 'updates the prayer intention' do
      patch "/api/v1/prayer_intentions/#{intention.id}",
            params: { prayer_intention: { title: 'Updated title' } },
            headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['prayer_intention']['title']).to eq('Updated title')
      expect(intention.reload.title).to eq('Updated title')
    end
    
    it 'does not allow updating other users\' intentions' do
      other_intention = create(:prayer_intention, user: other_user)
      
      patch "/api/v1/prayer_intentions/#{other_intention.id}",
            params: { prayer_intention: { title: 'Hacked' } },
            headers: headers
      
      expect(response).to have_http_status(:forbidden)
    end
    
    it 'returns errors for invalid updates' do
      patch "/api/v1/prayer_intentions/#{intention.id}",
            params: { prayer_intention: { title: '' } },
            headers: headers
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  
  describe 'DELETE /api/v1/prayer_intentions/:id' do
    let(:intention) { create(:prayer_intention, user: user) }
    
    it 'deletes the prayer intention' do
      intention # Create it first
      
      expect {
        delete "/api/v1/prayer_intentions/#{intention.id}", headers: headers
      }.to change(PrayerIntention, :count).by(-1)
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['message']).to eq('Prayer intention deleted successfully')
    end
    
    it 'does not allow deleting other users\' intentions' do
      other_intention = create(:prayer_intention, user: other_user)
      
      expect {
        delete "/api/v1/prayer_intentions/#{other_intention.id}", headers: headers
      }.not_to change(PrayerIntention, :count)
      
      expect(response).to have_http_status(:forbidden)
    end
  end
  
  describe 'POST /api/v1/prayer_intentions/:id/enrich' do
    let(:intention) { create(:prayer_intention, user: user) }
    
    it 'triggers AI enrichment' do
      expect(EnrichPrayerIntentionJob).to receive(:perform_later).with(intention.id)
      
      post "/api/v1/prayer_intentions/#{intention.id}/enrich", headers: headers
      
      expect(response).to have_http_status(:accepted)
      json = JSON.parse(response.body)
      expect(json['message']).to include('AI enrichment started')
    end
    
    it 'does not re-enrich without force flag' do
      intention.mark_as_ai_enriched!
      
      expect(EnrichPrayerIntentionJob).not_to receive(:perform_later)
      
      post "/api/v1/prayer_intentions/#{intention.id}/enrich", headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['message']).to include('already enriched')
    end
    
    it 're-enriches with force=true' do
      intention.mark_as_ai_enriched!
      
      expect(EnrichPrayerIntentionJob).to receive(:perform_later).with(intention.id)
      
      post "/api/v1/prayer_intentions/#{intention.id}/enrich",
           params: { force: true },
           headers: headers
      
      expect(response).to have_http_status(:accepted)
    end
  end
  
  describe 'POST /api/v1/prayer_intentions/:id/mark_answered' do
    let(:intention) { create(:prayer_intention, user: user, status: :praying) }
    
    it 'marks the prayer as answered' do
      post "/api/v1/prayer_intentions/#{intention.id}/mark_answered",
           params: { answer_notes: 'God provided healing' },
           headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['prayer_intention']['status']).to eq('answered')
      expect(json['prayer_intention']['answer_notes']).to eq('God provided healing')
      
      intention.reload
      expect(intention.answered_at).to be_present
    end
    
    it 'works without answer notes' do
      post "/api/v1/prayer_intentions/#{intention.id}/mark_answered", headers: headers
      
      expect(response).to have_http_status(:ok)
      expect(intention.reload.status).to eq('answered')
    end
  end
  
  describe 'POST /api/v1/prayer_intentions/:id/record_prayer' do
    context 'for own intention' do
      let(:intention) { create(:prayer_intention, user: user, prayer_count: 5) }
      
      it 'records the prayer' do
        post "/api/v1/prayer_intentions/#{intention.id}/record_prayer", headers: headers
        
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Prayer recorded')
        
        intention.reload
        expect(intention.prayer_count).to eq(6)
        expect(intention.last_prayed_at).to be_present
      end
    end
    
    context 'for community prayer enabled intention' do
      let(:intention) { create(:prayer_intention, user: other_user, allow_community_prayer: true) }
      
      it 'allows recording prayer' do
        post "/api/v1/prayer_intentions/#{intention.id}/record_prayer", headers: headers
        
        expect(response).to have_http_status(:ok)
        expect(intention.reload.prayer_count).to eq(1)
      end
    end
    
    context 'for private intention without permission' do
      let(:intention) { create(:prayer_intention, user: other_user, allow_community_prayer: false) }
      
      it 'denies recording prayer' do
        post "/api/v1/prayer_intentions/#{intention.id}/record_prayer", headers: headers
        
        expect(response).to have_http_status(:forbidden)
        expect(intention.reload.prayer_count).to eq(0)
      end
    end
  end
  
  describe 'POST /api/v1/prayer_intentions/:id/archive' do
    let(:intention) { create(:prayer_intention, user: user, status: :answered) }
    
    it 'archives the prayer intention' do
      post "/api/v1/prayer_intentions/#{intention.id}/archive", headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['prayer_intention']['status']).to eq('archived')
      expect(intention.reload.status).to eq('archived')
    end
  end
  
  describe 'GET /api/v1/prayer_intentions/categories' do
    it 'returns available categories' do
      get '/api/v1/prayer_intentions/categories', headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['categories']).to be_an(Array)
      expect(json['categories'].first).to have_key('value')
      expect(json['categories'].first).to have_key('label')
    end
  end
  
  describe 'GET /api/v1/prayer_intentions/stats' do
    before do
      create_list(:prayer_intention, 3, user: user, status: :pending)
      create_list(:prayer_intention, 2, user: user, status: :answered)
      create(:prayer_intention, user: user, status: :archived)
      create(:prayer_intention, user: user, :ai_enriched)
      create(:prayer_intention, user: user, category: 'personal', prayer_count: 10)
      create(:prayer_intention, user: user, category: 'family', prayer_count: 5)
    end
    
    it 'returns user statistics' do
      get '/api/v1/prayer_intentions/stats', headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      stats = json['stats']
      
      expect(stats['total']).to eq(8)
      expect(stats['active']).to eq(3)
      expect(stats['answered']).to eq(2)
      expect(stats['archived']).to eq(1)
      expect(stats['ai_enriched']).to eq(1)
      expect(stats['total_prayers']).to eq(15)
      expect(stats['by_category']).to be_a(Hash)
    end
  end
  
  describe 'GET /api/v1/prayer_intentions/community' do
    let!(:public_intentions) do
      create_list(:prayer_intention, 3,
                  user: other_user,
                  is_private: false,
                  allow_community_prayer: true)
    end
    let!(:private_intentions) do
      create_list(:prayer_intention, 2,
                  user: other_user,
                  is_private: true)
    end
    
    it 'returns public community prayer intentions' do
      get '/api/v1/prayer_intentions/community', headers: headers
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].length).to eq(3)
    end
    
    it 'filters by category' do
      public_intentions.first.update(category: 'world')
      
      get '/api/v1/prayer_intentions/community',
          params: { category: 'world' },
          headers: headers
      
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].all? { |i| i['category'] == 'world' }).to be true
    end
    
    it 'paginates community intentions' do
      create_list(:prayer_intention, 25,
                  user: other_user,
                  is_private: false,
                  allow_community_prayer: true)
      
      get '/api/v1/prayer_intentions/community',
          params: { per_page: 10 },
          headers: headers
      
      json = JSON.parse(response.body)
      expect(json['prayer_intentions'].length).to eq(10)
      expect(json['meta']['total_count']).to eq(28)
    end
  end
  
  # Helper method to generate JWT token for testing
  def generate_jwt_token(user)
    # This should match your actual JWT generation logic
    # Placeholder implementation
    payload = {
      user_id: user.id,
      firebase_uid: user.firebase_uid,
      exp: 24.hours.from_now.to_i
    }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
  end
end
