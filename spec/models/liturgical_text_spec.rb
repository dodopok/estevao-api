require 'rails_helper'

RSpec.describe LiturgicalText, type: :model do
  let(:prayer_book) { PrayerBook.find_or_create_by!(code: 'loc_2015') { |pb| pb.name = 'Liturgia das Horas' } }
  let(:liturgical_text) { create(:liturgical_text, prayer_book: prayer_book, slug: 'test_text') }

  describe 'associations' do
    it { should belong_to(:prayer_book) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:content) }
  end

  describe 'constants' do
    it 'has available voices' do
      expect(LiturgicalText::AVAILABLE_VOICES).to eq(%w[male_1 female_1 male_2])
    end

    it 'has audio statuses' do
      expect(LiturgicalText::AUDIO_STATUSES).to include('pending', 'completed', 'partial', 'failed')
    end
  end

  describe '#audio_url_for_voice' do
    it 'returns nil when no audio exists' do
      expect(liturgical_text.audio_url_for_voice('male_1')).to be_nil
    end

    it 'returns audio URL when it exists' do
      liturgical_text.update(audio_urls: { 'male_1' => '/audio/test.mp3' })
      expect(liturgical_text.audio_url_for_voice('male_1')).to eq('/audio/test.mp3')
    end

    it 'accepts symbol as voice key' do
      liturgical_text.update(audio_urls: { 'female_1' => '/audio/female.mp3' })
      expect(liturgical_text.audio_url_for_voice(:female_1)).to eq('/audio/female.mp3')
    end
  end

  describe '#set_audio_url' do
    it 'sets audio URL for a voice' do
      liturgical_text.set_audio_url('male_1', '/audio/new.mp3')
      expect(liturgical_text.audio_url_for_voice('male_1')).to eq('/audio/new.mp3')
    end

    it 'preserves existing URLs for other voices' do
      liturgical_text.update(audio_urls: { 'male_1' => '/audio/male.mp3' })
      liturgical_text.set_audio_url('female_1', '/audio/female.mp3')

      expect(liturgical_text.audio_url_for_voice('male_1')).to eq('/audio/male.mp3')
      expect(liturgical_text.audio_url_for_voice('female_1')).to eq('/audio/female.mp3')
    end
  end

  describe '#audio_filename' do
    it 'generates filename with prayer_book, id, and slug' do
      expect(liturgical_text.audio_filename('male_1')).to eq("#{prayer_book.code}_#{liturgical_text.id}_test_text.mp3")
    end
  end

  describe '#audio_filename_with_timestamp' do
    it 'generates filename with timestamp' do
      filename = liturgical_text.audio_filename_with_timestamp('male_1')
      expect(filename).to include("#{prayer_book.code}_#{liturgical_text.id}")
      expect(filename).to include(".mp3")
      expect(filename).to match(/_\d{14}\.mp3$/) # Matches timestamp format
    end
  end

  describe '#voices_generated' do
    it 'returns empty array when no voices generated' do
      expect(liturgical_text.voices_generated).to eq([])
    end

    it 'returns voices that have been generated' do
      liturgical_text.update(audio_urls: {
        'male_1' => '/audio/male1.mp3',
        'female_1' => '/audio/female.mp3'
      })
      expect(liturgical_text.voices_generated).to match_array([ 'male_1', 'female_1' ])
    end
  end

  describe '#voices_pending' do
    it 'returns all voices when none generated' do
      expect(liturgical_text.voices_pending).to match_array([ 'male_1', 'female_1', 'male_2' ])
    end

    it 'returns only voices not yet generated' do
      liturgical_text.update(audio_urls: { 'male_1' => '/audio/male1.mp3' })
      expect(liturgical_text.voices_pending).to match_array([ 'female_1', 'male_2' ])
    end
  end

  describe '.find_text' do
    let!(:findable_text) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             slug: 'findable_slug')
    end

    it 'finds text by slug and prayer book code' do
      result = LiturgicalText.find_text('findable_slug', prayer_book_code: prayer_book.code)
      expect(result).to eq(findable_text)
    end

    it 'returns nil when text not found' do
      result = LiturgicalText.find_text('nonexistent', prayer_book_code: prayer_book.code)
      expect(result).to be_nil
    end
  end

  describe '.for_audio_generation' do
    let!(:prayer_text) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'prayer',
             slug: 'invocation')
    end

    let!(:rubric_text) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'rubric',
             slug: 'instruction')
    end

    let!(:canticle_text) do
      create(:liturgical_text,
             prayer_book: prayer_book,
             category: 'canticle',
             slug: 'gloria')
    end

    it 'includes non-rubric texts' do
      result = LiturgicalText.for_audio_generation
      expect(result).to include(prayer_text, canticle_text)
    end

    it 'excludes rubric texts' do
      result = LiturgicalText.for_audio_generation
      expect(result).not_to include(rubric_text)
    end

    it 'can be chained with other scopes' do
      result = LiturgicalText.for_prayer_book(prayer_book.code).for_audio_generation
      expect(result).to include(prayer_text, canticle_text)
      expect(result).not_to include(rubric_text)
    end
  end
end
