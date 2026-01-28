require 'rails_helper'

RSpec.describe PrayerIntention, type: :model do
  let(:user) { User.create!(firebase_uid: 'test-uid', email: 'test@example.com') }
  
  describe 'associations' do
    it { should belong_to(:user) }
  end
  
  describe 'validations' do
    subject { build(:prayer_intention, user: user) }
    
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(200) }
    it { should validate_length_of(:description).is_at_most(5000) }
    it { should validate_length_of(:answer_notes).is_at_most(2000) }
    it { should validate_presence_of(:status) }
    
    it 'validates category inclusion' do
      valid_categories = %w[personal family community world thanksgiving intercession]
      valid_categories.each do |category|
        intention = build(:prayer_intention, user: user, category: category)
        expect(intention).to be_valid
      end
      
      invalid_intention = build(:prayer_intention, user: user, category: 'invalid')
      expect(invalid_intention).not_to be_valid
      expect(invalid_intention.errors[:category]).to include('is not included in the list')
    end
    
    it 'allows blank category' do
      intention = build(:prayer_intention, user: user, category: nil)
      expect(intention).to be_valid
    end
  end
  
  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, praying: 1, answered: 2, archived: 3).with_prefix(:status) }
    
    it 'defaults to pending status' do
      intention = PrayerIntention.new(user: user, title: 'Test')
      expect(intention.status).to eq('pending')
    end
  end
  
  describe 'scopes' do
    let!(:pending_intention) { create(:prayer_intention, user: user, status: :pending) }
    let!(:praying_intention) { create(:prayer_intention, user: user, status: :praying) }
    let!(:answered_intention) { create(:prayer_intention, user: user, status: :answered) }
    let!(:archived_intention) { create(:prayer_intention, user: user, status: :archived) }
    let!(:public_intention) { create(:prayer_intention, user: user, is_private: false) }
    let!(:private_intention) { create(:prayer_intention, user: user, is_private: true) }
    let!(:enriched_intention) { create(:prayer_intention, user: user, ai_enriched_at: Time.current) }
    
    describe '.active' do
      it 'returns pending and praying intentions' do
        expect(PrayerIntention.active).to contain_exactly(pending_intention, praying_intention)
      end
    end
    
    describe '.answered' do
      it 'returns only answered intentions' do
        expect(PrayerIntention.answered).to contain_exactly(answered_intention)
      end
    end
    
    describe '.archived' do
      it 'returns only archived intentions' do
        expect(PrayerIntention.archived).to contain_exactly(archived_intention)
      end
    end
    
    describe '.public_intentions' do
      it 'returns only public intentions' do
        expect(PrayerIntention.public_intentions).to include(public_intention)
        expect(PrayerIntention.public_intentions).not_to include(private_intention)
      end
    end
    
    describe '.ai_enriched' do
      it 'returns only AI enriched intentions' do
        expect(PrayerIntention.ai_enriched).to contain_exactly(enriched_intention)
      end
    end
    
    describe '.needs_enrichment' do
      it 'returns intentions without AI enrichment' do
        expect(PrayerIntention.needs_enrichment).not_to include(enriched_intention)
      end
    end
  end
  
  describe 'callbacks' do
    describe 'strip_whitespace' do
      it 'strips whitespace from title' do
        intention = create(:prayer_intention, user: user, title: '  Test Title  ')
        expect(intention.title).to eq('Test Title')
      end
      
      it 'strips whitespace from description' do
        intention = create(:prayer_intention, user: user, description: '  Test Description  ')
        expect(intention.description).to eq('Test Description')
      end
    end
    
    describe 'set_defaults' do
      it 'sets default values on new record' do
        intention = PrayerIntention.new(user: user, title: 'Test')
        expect(intention.status).to eq('pending')
        expect(intention.is_private).to eq(true)
        expect(intention.allow_community_prayer).to eq(false)
        expect(intention.prayer_count).to eq(0)
      end
    end
  end
  
  describe '#mark_as_answered!' do
    let(:intention) { create(:prayer_intention, user: user, status: :praying) }
    
    it 'updates status to answered' do
      intention.mark_as_answered!(notes: 'Prayer answered!')
      expect(intention.reload.status).to eq('answered')
    end
    
    it 'sets answered_at timestamp' do
      intention.mark_as_answered!
      expect(intention.reload.answered_at).to be_present
    end
    
    it 'saves answer notes' do
      intention.mark_as_answered!(notes: 'God is good!')
      expect(intention.reload.answer_notes).to eq('God is good!')
    end
  end
  
  describe '#archive!' do
    let(:intention) { create(:prayer_intention, user: user, status: :answered) }
    
    it 'updates status to archived' do
      intention.archive!
      expect(intention.reload.status).to eq('archived')
    end
  end
  
  describe '#record_prayer!' do
    let(:intention) { create(:prayer_intention, user: user, prayer_count: 5) }
    
    it 'increments prayer count' do
      expect { intention.record_prayer! }.to change { intention.reload.prayer_count }.from(5).to(6)
    end
    
    it 'updates last_prayed_at timestamp' do
      intention.record_prayer!
      expect(intention.reload.last_prayed_at).to be_present
    end
  end
  
  describe '#needs_ai_enrichment?' do
    it 'returns true when never enriched' do
      intention = create(:prayer_intention, user: user, ai_enriched_at: nil)
      expect(intention.needs_ai_enrichment?).to be true
    end
    
    it 'returns false when recently enriched' do
      intention = create(:prayer_intention, user: user, ai_enriched_at: 1.minute.ago)
      expect(intention.needs_ai_enrichment?).to be false
    end
  end
  
  describe '#ai_enriched?' do
    it 'returns true when enriched' do
      intention = create(:prayer_intention, user: user, ai_enriched_at: Time.current)
      expect(intention.ai_enriched?).to be true
    end
    
    it 'returns false when not enriched' do
      intention = create(:prayer_intention, user: user, ai_enriched_at: nil)
      expect(intention.ai_enriched?).to be false
    end
  end
  
  describe '#mark_as_ai_enriched!' do
    let(:intention) { create(:prayer_intention, user: user) }
    
    it 'sets ai_enriched_at timestamp' do
      intention.mark_as_ai_enriched!
      expect(intention.reload.ai_enriched_at).to be_present
    end
    
    it 'sets ai_model_version' do
      intention.mark_as_ai_enriched!(model_version: 'perplexity-2.0')
      expect(intention.reload.ai_model_version).to eq('perplexity-2.0')
    end
    
    it 'uses default model version when not provided' do
      intention.mark_as_ai_enriched!
      expect(intention.reload.ai_model_version).to eq('perplexity-1.0')
    end
  end
  
  describe '#full_text' do
    it 'combines title and description' do
      intention = create(:prayer_intention, user: user, title: 'Healing', description: 'For my mother')
      expect(intention.full_text).to eq("Healing\n\nFor my mother")
    end
    
    it 'handles nil description' do
      intention = create(:prayer_intention, user: user, title: 'Healing', description: nil)
      expect(intention.full_text).to eq('Healing')
    end
  end
  
  describe '#viewable_by?' do
    let(:owner) { user }
    let(:other_user) { User.create!(firebase_uid: 'other-uid', email: 'other@example.com') }
    
    it 'allows owner to view' do
      intention = create(:prayer_intention, user: owner, is_private: true)
      expect(intention.viewable_by?(owner)).to be true
    end
    
    it 'allows anyone to view public intentions' do
      intention = create(:prayer_intention, user: owner, is_private: false)
      expect(intention.viewable_by?(other_user)).to be true
    end
    
    it 'does not allow others to view private intentions' do
      intention = create(:prayer_intention, user: owner, is_private: true)
      expect(intention.viewable_by?(other_user)).to be false
    end
  end
  
  describe '#prayable_by?' do
    let(:owner) { user }
    let(:other_user) { User.create!(firebase_uid: 'other-uid', email: 'other@example.com') }
    
    it 'allows owner to pray' do
      intention = create(:prayer_intention, user: owner, allow_community_prayer: false)
      expect(intention.prayable_by?(owner)).to be true
    end
    
    it 'allows community to pray when enabled' do
      intention = create(:prayer_intention, user: owner, allow_community_prayer: true)
      expect(intention.prayable_by?(other_user)).to be true
    end
    
    it 'does not allow community to pray when disabled' do
      intention = create(:prayer_intention, user: owner, allow_community_prayer: false)
      expect(intention.prayable_by?(other_user)).to be false
    end
  end
  
  describe '#prayer_stats' do
    let(:intention) { create(:prayer_intention, user: user, prayer_count: 10, last_prayed_at: 1.day.ago, created_at: 5.days.ago) }
    
    it 'returns prayer statistics' do
      stats = intention.prayer_stats
      expect(stats[:total_prayers]).to eq(10)
      expect(stats[:last_prayed]).to be_present
      expect(stats[:days_since_created]).to be >= 5
    end
  end
  
  describe '#as_json_api' do
    let(:intention) do
      create(:prayer_intention, 
        user: user,
        title: 'Test Prayer',
        spiritual_context: 'Context',
        related_scriptures: [{ book: 'Psalms', chapter: 23, verse: 1 }]
      )
    end
    
    it 'returns properly formatted JSON' do
      json = intention.as_json_api
      expect(json[:id]).to eq(intention.id)
      expect(json[:title]).to eq('Test Prayer')
      expect(json[:ai_enrichment]).to be_a(Hash)
      expect(json[:metadata]).to be_a(Hash)
      expect(json[:stats]).to be_a(Hash)
    end
  end
  
  describe '.categories' do
    it 'returns list of valid categories' do
      expect(PrayerIntention.categories).to eq(%w[personal family community world thanksgiving intercession])
    end
  end
end
