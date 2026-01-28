require 'rails_helper'

RSpec.describe EnrichPrayerIntentionJob, type: :job do
  let(:user) { create(:user) }
  let(:prayer_intention) { create(:prayer_intention, user: user, title: 'Healing', description: 'For my mother') }
  let(:perplexity_service) { instance_double(PerplexityApiService) }
  let(:enrichment_data) do
    {
      spiritual_context: 'Biblical perspective on healing...',
      related_scriptures: [
        {
          book: 'James',
          chapter: 5,
          verse: 14,
          reference: 'James 5:14',
          text: 'Is anyone among you sick?'
        }
      ],
      suggested_prayers: [
        {
          title: 'Prayer for Healing (BCP)',
          text: 'Heavenly Father, giver of life...'
        }
      ],
      theological_insights: 'Christian understanding of healing...',
      reflection_prompts: ['How can you trust God in this?']
    }
  end
  
  before do
    allow(PerplexityApiService).to receive(:new).and_return(perplexity_service)
    allow(perplexity_service).to receive(:enrich_prayer_intention).and_return(enrichment_data)
  end
  
  describe '#perform' do
    it 'enriches prayer intention with AI data' do
      described_class.perform_now(prayer_intention.id)
      
      prayer_intention.reload
      expect(prayer_intention.spiritual_context).to eq('Biblical perspective on healing...')
      expect(prayer_intention.related_scriptures).to be_an(Array)
      expect(prayer_intention.suggested_prayers).to be_an(Array)
      expect(prayer_intention.theological_insights).to be_present
      expect(prayer_intention.reflection_prompts).to be_an(Array)
    end
    
    it 'marks prayer intention as AI enriched' do
      described_class.perform_now(prayer_intention.id)
      
      prayer_intention.reload
      expect(prayer_intention.ai_enriched_at).to be_present
      expect(prayer_intention.ai_model_version).to eq(PerplexityApiService::DEFAULT_MODEL)
    end
    
    it 'logs the enrichment process' do
      expect(Rails.logger).to receive(:info).with(/Starting AI enrichment for PrayerIntention/)
      expect(Rails.logger).to receive(:info).with(/Successfully enriched PrayerIntention/)
      
      described_class.perform_now(prayer_intention.id)
    end
    
    it 'skips enrichment if already enriched and up to date' do
      prayer_intention.mark_as_ai_enriched!
      
      expect(perplexity_service).not_to receive(:enrich_prayer_intention)
      expect(Rails.logger).to receive(:info).with(/already enriched, skipping/)
      
      described_class.perform_now(prayer_intention.id)
    end
    
    it 'calls Perplexity API service' do
      expect(perplexity_service).to receive(:enrich_prayer_intention).with(prayer_intention)
      
      described_class.perform_now(prayer_intention.id)
    end
  end
  
  describe 'error handling' do
    it 'logs error when prayer intention not found' do
      expect(Rails.logger).to receive(:error).with(/not found/)
      
      expect {
        described_class.perform_now(999999)
      }.not_to raise_error
    end
    
    it 'raises error on API failure for retry' do
      allow(perplexity_service).to receive(:enrich_prayer_intention)
        .and_raise(PerplexityApiService::PerplexityError, 'API Error')
      
      expect(Rails.logger).to receive(:error).with(/Failed to enrich PrayerIntention/)
      
      expect {
        described_class.perform_now(prayer_intention.id)
      }.to raise_error(PerplexityApiService::PerplexityError)
    end
    
    it 'handles rate limit errors' do
      allow(perplexity_service).to receive(:enrich_prayer_intention)
        .and_raise(PerplexityApiService::RateLimitError, 'Rate limited')
      
      expect {
        described_class.perform_now(prayer_intention.id)
      }.to raise_error(PerplexityApiService::RateLimitError)
    end
  end
  
  describe 'retry behavior' do
    it 'retries on PerplexityError' do
      expect(described_class).to have_been_enqueued.with(prayer_intention.id).on_queue('default')
        .exactly(0).times
      
      # Test that retry_on is configured
      expect(described_class.retry_on_block_for(PerplexityApiService::PerplexityError)).to be_present
    end
    
    it 'retries on RateLimitError' do
      expect(described_class.retry_on_block_for(PerplexityApiService::RateLimitError)).to be_present
    end
    
    it 'discards on AuthenticationError' do
      expect(described_class.discard_on_block_for(PerplexityApiService::AuthenticationError)).to be_present
    end
  end
  
  describe 'user notification' do
    let(:notification_service) { class_double(NotificationService) }
    
    before do
      allow(NotificationService).to receive(:send_notification)
    end
    
    context 'when user has FCM tokens' do
      before do
        create(:fcm_token, user: user, token: 'test-token')
      end
      
      it 'sends notification to user' do
        expect(NotificationService).to receive(:send_notification).with(
          user: user,
          title: 'Prayer Enriched',
          body: include(prayer_intention.title),
          data: hash_including(
            type: 'prayer_intention_enriched',
            prayer_intention_id: prayer_intention.id
          )
        )
        
        described_class.perform_now(prayer_intention.id)
      end
      
      it 'does not fail job if notification fails' do
        allow(NotificationService).to receive(:send_notification)
          .and_raise(StandardError, 'Notification error')
        
        expect(Rails.logger).to receive(:warn).with(/Failed to send enrichment notification/)
        
        expect {
          described_class.perform_now(prayer_intention.id)
        }.not_to raise_error
      end
    end
    
    context 'when user has no FCM tokens' do
      it 'does not send notification' do
        expect(NotificationService).not_to receive(:send_notification)
        
        described_class.perform_now(prayer_intention.id)
      end
    end
  end
  
  describe 'job configuration' do
    it 'queues on default queue' do
      expect(described_class.new.queue_name).to eq('default')
    end
    
    it 'has timeout configured' do
      expect(described_class.timeout).to eq(2.minutes)
    end
  end
  
  describe 'integration test' do
    it 'performs full enrichment flow', :vcr do
      # This test would use VCR to record actual API responses
      # For now, we'll use mocked data
      
      described_class.perform_now(prayer_intention.id)
      
      prayer_intention.reload
      
      # Verify all fields are populated
      expect(prayer_intention.ai_enriched?).to be true
      expect(prayer_intention.spiritual_context).to be_present
      expect(prayer_intention.related_scriptures).to be_an(Array)
      expect(prayer_intention.suggested_prayers).to be_an(Array)
      expect(prayer_intention.theological_insights).to be_present
      expect(prayer_intention.reflection_prompts).to be_an(Array)
      
      # Verify metadata
      expect(prayer_intention.ai_enriched_at).to be_within(1.second).of(Time.current)
      expect(prayer_intention.ai_model_version).to be_present
    end
  end
end
