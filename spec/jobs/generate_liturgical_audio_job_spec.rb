require 'rails_helper'

RSpec.describe GenerateLiturgicalAudioJob, type: :job do
  let(:prayer_book) { PrayerBook.find_or_create_by!(code: 'loc_2015') { |pb| pb.name = 'Liturgia das Horas' } }
  let(:text) { create(:liturgical_text, prayer_book: prayer_book, content: 'Test content', slug: 'test_slug') }
  let(:session) { create(:audio_generation_session, prayer_book_code: 'loc_2015') }
  let(:service) { instance_double(ElevenlabsAudioService) }

  before do
    allow(ElevenlabsAudioService).to receive(:new).and_return(service)
    allow(service).to receive(:generate_audio).and_return('audio_binary_data')
    allow(FileUtils).to receive(:mkdir_p)
    allow(FileUtils).to receive(:cp)
    allow(File).to receive(:binwrite)
    allow(File).to receive(:exist?).and_return(false)
  end

  describe '#perform' do
    it 'generates audio and saves to file system' do
      expect(service).to receive(:generate_audio).with('Test content', 'male_1')
      expect(File).to receive(:binwrite).with(anything, 'audio_binary_data')

      described_class.perform_now(text.id, 'male_1', session.id)
    end

    it 'updates liturgical text with audio URL' do
      described_class.perform_now(text.id, 'male_1', session.id)

      text.reload
      expect(text.audio_url_for_voice('male_1')).to be_present
      expect(text.audio_url_for_voice('male_1')).to include('/audio/loc_2015/male_1/')
    end

    it 'updates session progress' do
      described_class.perform_now(text.id, 'male_1', session.id)

      session.reload
      expect(session.processed_count).to eq(1)
      expect(session.current_voice_key).to eq('male_1')
      expect(session.current_text_id).to eq(text.id)
    end

    it 'sets audio generation status to completed when all voices done' do
      text.set_audio_url('male_1', '/audio/male.mp3')
      text.set_audio_url('female_1', '/audio/female.mp3')

      described_class.perform_now(text.id, 'male_2', session.id)

      expect(text.reload.audio_generation_status).to eq('completed')
    end

    it 'sets audio generation status to partial when some voices done' do
      described_class.perform_now(text.id, 'male_1', session.id)

      expect(text.reload.audio_generation_status).to eq('partial')
    end

    it 'creates backup of existing audio file' do
      text.set_audio_url('male_1', '/audio/existing.mp3')

      existing_path = Rails.root.join('public', 'audio', 'loc_2015', 'male_1', text.audio_filename('male_1'))
      allow(File).to receive(:exist?).with(existing_path).and_return(true)

      expect(FileUtils).to receive(:cp).with(existing_path, anything)

      described_class.perform_now(text.id, 'male_1', session.id)
    end

    it 're-raises rate limit errors' do
      allow(service).to receive(:generate_audio)
        .and_raise(ElevenlabsAudioService::RateLimitError, 'Rate limit')

      expect {
        described_class.perform_now(text.id, 'male_1', session.id)
      }.to raise_error(ElevenlabsAudioService::RateLimitError)
    end

    it 'updates session failed count on other errors' do
      allow(service).to receive(:generate_audio).and_raise(StandardError, 'API error')

      expect {
        described_class.perform_now(text.id, 'male_1', session.id)
      }.to raise_error(StandardError)

      expect(session.reload.failed_count).to eq(1)
      expect(text.reload.audio_generation_status).to eq('failed')
    end

    it 'creates directory structure if it does not exist' do
      expect(FileUtils).to receive(:mkdir_p).with(
        Rails.root.join('public', 'audio', 'loc_2015', 'male_1').to_s
      )

      described_class.perform_now(text.id, 'male_1', session.id)
    end
  end
end
