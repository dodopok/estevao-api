require 'rails_helper'
require 'rake'

RSpec.describe 'audio rake tasks' do
  let(:prayer_book) { PrayerBook.find_or_create_by!(code: 'loc_2015') { |pb| pb.name = 'Liturgia das Horas' } }

  before(:all) do
    Rails.application.load_tasks
  end

  before do
    # Clean up
    LiturgicalText.where(prayer_book: prayer_book).delete_all
  end

  describe 'audio:generate_text' do
    let!(:prayer_text) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'prayer',
             slug: 'morning_invocation',
             content: 'Senhor, abre os nossos lábios.')
    end

    let!(:rubric_text) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'rubric',
             slug: 'instruction',
             content: 'Todos de pé dizem em uníssono:')
    end

    let(:mock_service) { instance_double(ElevenlabsAudioService) }

    before do
      # Mock STDIN and services
      allow(STDIN).to receive(:gets).and_return("yes\n")
      allow(ElevenlabsAudioService).to receive(:new).and_return(mock_service)
      allow(mock_service).to receive(:estimate_cost).and_return({
        cost_per_1000_chars: 0.30,
        estimated_cost_usd: 0.01
      })
      allow(GenerateLiturgicalAudioJob).to receive(:perform_now)

      # Clean up sessions to avoid conflicts
      AudioGenerationSession.delete_all
    end

    it 'generates audio for a specific text' do
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(prayer_text.id, 'male_1', kind_of(Integer))

      Rake::Task['audio:generate_text'].reenable
      Rake::Task['audio:generate_text'].invoke('loc_2015', 'morning_invocation', 'male_1')
    end

    it 'generates for multiple voices when specified' do
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(prayer_text.id, 'male_1', kind_of(Integer))
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(prayer_text.id, 'female_1', kind_of(Integer))

      Rake::Task['audio:generate_text'].reenable
      Rake::Task['audio:generate_text'].invoke('loc_2015', 'morning_invocation', 'male_1,female_1')
    end

    it 'generates for all voices when none specified' do
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(prayer_text.id, 'male_1', kind_of(Integer))
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(prayer_text.id, 'female_1', kind_of(Integer))
      expect(GenerateLiturgicalAudioJob).to receive(:perform_now)
        .with(prayer_text.id, 'male_2', kind_of(Integer))

      Rake::Task['audio:generate_text'].reenable
      Rake::Task['audio:generate_text'].invoke('loc_2015', 'morning_invocation')
    end

    it 'creates a temporary session for tracking' do
      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('loc_2015', 'morning_invocation', 'male_1')
      }.to change { AudioGenerationSession.count }.by(1)

      session = AudioGenerationSession.last
      expect(session.prayer_book_code).to eq('loc_2015')
      expect(session.voice_keys).to eq([ 'male_1' ])
      expect(session.status).to eq('completed')
    end

    it 'warns when generating audio for a rubric' do
      allow(STDIN).to receive(:gets).and_return("yes\n")

      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('loc_2015', 'instruction', 'male_1')
      }.to output(/WARNING.*rubric/i).to_stdout
    end

    it 'can cancel rubric generation' do
      allow(STDIN).to receive(:gets).and_return("no\n", "no\n")

      expect(GenerateLiturgicalAudioJob).not_to receive(:perform_now)

      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('loc_2015', 'instruction', 'male_1')
      }.to raise_error(SystemExit).and output(/cancelled/i).to_stdout
    end

    it 'exits with error when text not found' do
      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('loc_2015', 'nonexistent', 'male_1')
      }.to raise_error(SystemExit).and output(/ERROR.*not found/i).to_stdout
    end

    it 'exits with error when prayer book not found' do
      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('invalid_book', 'morning_invocation', 'male_1')
      }.to raise_error(SystemExit).and output(/ERROR.*not found/i).to_stdout
    end

    it 'handles invalid voice keys gracefully' do
      allow(STDIN).to receive(:gets).and_return("yes\n")

      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('loc_2015', 'morning_invocation', 'invalid_voice,male_1')
      }.to output(/Invalid voice key: invalid_voice/i).to_stdout
    end

    it 'shows progress for each voice' do
      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('loc_2015', 'morning_invocation', 'male_1')
      }.to output(/Processing male_1.*✓/m).to_stdout
    end

    it 'displays updated audio URLs after generation' do
      prayer_text.set_audio_url('male_1', '/audio/test.mp3')

      expect {
        Rake::Task['audio:generate_text'].reenable
        Rake::Task['audio:generate_text'].invoke('loc_2015', 'morning_invocation', 'male_1')
      }.to output(/Updated Audio URLs/i).to_stdout
    end
  end

  describe 'audio:estimate' do
    let!(:text1) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'prayer',
             content: 'A' * 1000)
    end

    let!(:text2) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'canticle',
             content: 'B' * 1000)
    end

    let!(:rubric) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'rubric',
             content: 'C' * 1000)
    end

    let(:mock_service) { instance_double(ElevenlabsAudioService) }

    before do
      allow(ElevenlabsAudioService).to receive(:new).and_return(mock_service)
      allow(mock_service).to receive(:estimate_cost).and_return({
        cost_per_1000_chars: 0.30,
        estimated_cost_usd: 1.80
      })
    end

    it 'excludes rubrics from character count' do
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015')
      }.to output(/Rubrics \(skipped\): 1/i).to_stdout
    end

    it 'shows correct text count excluding rubrics' do
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015')
      }.to output(/Texts for audio: 2/i).to_stdout
    end

    it 'calculates cost based on non-rubric texts only' do
      # 2 texts × 1000 chars × 3 voices = 6000 chars total
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015')
      }.to output(/Total characters \(all voices\): 6,000/i).to_stdout
    end

    it 'respects voice_keys parameter' do
      # 2 texts × 1000 chars × 1 voice = 2000 chars total
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015', 'male_1')
      }.to output(/Voices: 1 \(male_1\)/i).to_stdout
    end

    it 'handles multiple voice_keys' do
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015', 'male_1,female_1')
      }.to output(/Voices: 2 \(male_1, female_1\)/i).to_stdout
    end

    it 'mentions that rubrics are excluded in notes' do
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015')
      }.to output(/Rubrics are automatically excluded/i).to_stdout
    end

    it 'rejects invalid voice keys' do
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015', 'invalid_voice')
      }.to raise_error(SystemExit).and output(/Invalid voice key.*invalid_voice/i).to_stdout
    end

    it 'rejects slug as voice key' do
      expect {
        Rake::Task['audio:estimate'].reenable
        Rake::Task['audio:estimate'].invoke('loc_2015', 'morning_invocation')
      }.to raise_error(SystemExit).and output(/Invalid voice key.*morning_invocation/i).to_stdout
    end
  end
end
