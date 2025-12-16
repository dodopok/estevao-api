require 'rails_helper'

RSpec.describe BatchAudioGeneratorService do
  # Use unique prayer book code for test isolation in parallel runs
  let(:test_pb_code) { "test_pb_#{SecureRandom.hex(4)}" }
  let(:prayer_book) {
    PrayerBook.create!(code: test_pb_code, name: 'Test Prayer Book')
  }

  let!(:text1) { create(:liturgical_text, prayer_book: prayer_book, category: 'prayer') }
  let!(:text2) { create(:liturgical_text, prayer_book: prayer_book, category: 'canticle') }
  let!(:rubric) { create(:liturgical_text, prayer_book: prayer_book, category: 'rubric') }
  let(:service) { described_class.new(test_pb_code, [ 'male_1' ]) }

  after do
    # Clean up test data
    prayer_book.destroy if prayer_book.persisted?
  end

  describe 'initialization' do
    it 'raises error for non-existent prayer book' do
      expect {
        described_class.new('nonexistent')
      }.to raise_error(ArgumentError, /Prayer book not found/)
    end

    it 'raises error for invalid voice keys' do
      expect {
        described_class.new('loc_2015', [ 'invalid_voice' ])
      }.to raise_error(ArgumentError, /Invalid voice keys/)
    end

    it 'defaults to all voices when none specified' do
      service = described_class.new('loc_2015')
      expect(service.instance_variable_get(:@voice_keys)).to eq([ 'male_1', 'female_1', 'male_2' ])
    end
  end

  describe '#generate' do
    before do
      # Ensure we start with clean state for session tests
      AudioGenerationSession.where(prayer_book_code: test_pb_code).delete_all
      allow(GenerateLiturgicalAudioJob).to receive(:perform_now)
    end

    it 'creates a new session when none exists' do
      expect {
        service.generate
      }.to change { AudioGenerationSession.count }.by(1)

      session = AudioGenerationSession.last
      expect(session.prayer_book_code).to eq(test_pb_code)
      expect(session.voice_keys).to eq([ 'male_1' ])
      expect(session.total_texts).to eq(2) # 2 texts × 1 voice
    end

    it 'resumes existing running session' do
      existing_session = create(:audio_generation_session,
                                prayer_book_code: test_pb_code,
                                status: 'running',
                                current_voice_key: 'male_1',
                                current_text_id: text1.id)

      expect {
        service.generate
      }.not_to change { AudioGenerationSession.count }
    end

    it 'processes texts sequentially' do
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now).twice
      service.generate
    end

    it 'excludes rubric texts from generation' do
      # Should only process text1 and text2, not the rubric
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now).twice
      expect(GenerateLiturgicalAudioJob).not_to receive(:perform_now).with(rubric.id, anything, anything)
      service.generate
    end

    it 'counts only non-rubric texts in session total' do
      service.generate
      session = service.session
      # 2 non-rubric texts × 1 voice = 2 total
      expect(session.total_texts).to eq(2)
    end

    it 'skips texts that already have audio' do
      text1.set_audio_url('male_1', '/audio/existing.mp3')

      expect(GenerateLiturgicalAudioJob).to receive(:perform_now).once.with(text2.id, 'male_1', anything)
      service.generate
    end

    it 'marks session as completed on success' do
      service.generate
      session = service.session
      expect(session.status).to eq('completed')
      expect(session.completed_at).to be_present
    end

    it 'marks session as failed on rate limit error' do
      allow(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .and_raise(ElevenlabsAudioService::RateLimitError, 'Rate limit')

      expect {
        service.generate
      }.to raise_error(ElevenlabsAudioService::RateLimitError)

      session = service.session
      expect(session.status).to eq('failed')
      expect(session.error_log).to include('Rate limit')
    end

    it 'continues on individual text failures' do
      allow(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(text1.id, anything, anything)
        .and_raise(StandardError, 'Generation failed')

      allow(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(text2.id, anything, anything)
        .and_return(true)

      service.generate

      session = service.session
      expect(session.status).to eq('completed')
      expect(session.failed_count).to eq(1)
    end
  end

  describe 'resume functionality' do
    let(:service_multi) { described_class.new(test_pb_code, [ 'male_1', 'female_1' ]) }

    before do
      allow(GenerateLiturgicalAudioJob).to receive(:perform_now)
    end

    it 'resumes from interrupted voice' do
      session = create(:audio_generation_session,
                      prayer_book_code: test_pb_code,
                      status: 'running',
                      voice_keys: [ 'male_1', 'female_1' ],
                      current_voice_key: 'male_1',
                      current_text_id: text2.id,
                      total_texts: 4)

      # Should process text2 for male_1, then all texts for female_1
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(text2.id, 'male_1', anything)
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(text1.id, 'female_1', anything)
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(text2.id, 'female_1', anything)

      service_multi.generate
    end
  end
end
