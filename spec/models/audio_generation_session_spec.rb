require 'rails_helper'

RSpec.describe AudioGenerationSession, type: :model do
  let(:session) do
    create(:audio_generation_session,
           prayer_book_code: 'loc_2015',
           voice_keys: [ 'male_1', 'female_1' ],
           total_texts: 100)
  end

  describe 'validations' do
    it { should validate_presence_of(:prayer_book_code) }
    it { should validate_presence_of(:status) }

    it 'prevents concurrent sessions for the same prayer book' do
      create(:audio_generation_session, prayer_book_code: 'loc_2015', status: 'running')

      duplicate = build(:audio_generation_session, prayer_book_code: 'loc_2015', status: 'running')
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:base]).to include(/already running/)
    end

    it 'allows concurrent sessions for different prayer books' do
      create(:audio_generation_session, prayer_book_code: 'loc_2015', status: 'running')

      different = build(:audio_generation_session, prayer_book_code: 'loc_2019', status: 'running')
      expect(different).to be_valid
    end

    it 'allows new session when previous is completed' do
      create(:audio_generation_session, prayer_book_code: 'loc_2015', status: 'completed')

      new_session = build(:audio_generation_session, prayer_book_code: 'loc_2015', status: 'running')
      expect(new_session).to be_valid
    end
  end

  describe 'scopes' do
    it 'returns running sessions' do
      running = create(:audio_generation_session, status: 'running', prayer_book_code: 'loc_2015')
      create(:audio_generation_session, status: 'completed', prayer_book_code: 'loc_2019')

      expect(AudioGenerationSession.running).to include(running)
      expect(AudioGenerationSession.running.count).to eq(1)
    end

    it 'filters by prayer book' do
      loc_session = create(:audio_generation_session, prayer_book_code: 'loc_2015')
      create(:audio_generation_session, prayer_book_code: 'loc_2019')

      expect(AudioGenerationSession.for_prayer_book('loc_2015')).to include(loc_session)
      expect(AudioGenerationSession.for_prayer_book('loc_2015').count).to eq(1)
    end
  end

  describe '#update_progress' do
    it 'updates current position and counts' do
      session.update_progress('female_1', 50, 45, 5)

      expect(session.current_voice_key).to eq('female_1')
      expect(session.current_text_id).to eq(50)
      expect(session.processed_count).to eq(45)
      expect(session.failed_count).to eq(5)
    end
  end

  describe '#mark_completed' do
    it 'sets status to completed and clears current position' do
      session.update(current_voice_key: 'male_1', current_text_id: 10)
      session.mark_completed

      expect(session.status).to eq('completed')
      expect(session.completed_at).to be_present
      expect(session.current_voice_key).to be_nil
      expect(session.current_text_id).to be_nil
    end
  end

  describe '#mark_failed' do
    it 'sets status to failed and appends error log' do
      session.mark_failed('Rate limit exceeded')

      expect(session.status).to eq('failed')
      expect(session.completed_at).to be_present
      expect(session.error_log).to include('Rate limit exceeded')
    end

    it 'appends to existing error log' do
      session.update(error_log: 'First error')
      session.mark_failed('Second error')

      expect(session.error_log).to include('First error')
      expect(session.error_log).to include('Second error')
    end
  end

  describe '#resume_from' do
    it 'returns nil for non-running sessions' do
      session.update(status: 'completed')
      expect(session.resume_from).to be_nil
    end

    it 'returns current position for running sessions' do
      session.update(current_voice_key: 'female_1', current_text_id: 25)

      result = session.resume_from
      expect(result[:voice_key]).to eq('female_1')
      expect(result[:text_id]).to eq(25)
    end
  end
end
