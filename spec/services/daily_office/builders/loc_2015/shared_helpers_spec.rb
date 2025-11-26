# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015::SharedHelpers do
  # Create a test class that includes the module
  let(:test_class) do
    Class.new(DailyOffice::Builders::Loc2015Builder) do
      include DailyOffice::Builders::Loc2015::SharedHelpers
    end
  end

  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.features = {
        'lectionary' => {
          'reading_types' => [ 'semicontinuous' ],
          'default_reading_type' => 'semicontinuous'
        },
        'daily_office' => {
          'supports_family_rite' => true
        }
      }
    end
  end

  let(:date) { Date.new(2025, 11, 25) }
  let(:builder) { test_class.new(date: date, office_type: :morning) }

  before do
    # Ensure prayer book exists
    prayer_book
  end

  describe '#fetch_liturgical_text' do
    it 'returns nil when prayer_book is nil' do
      allow(builder).to receive(:prayer_book).and_return(nil)
      result = builder.send(:fetch_liturgical_text, 'some_slug')
      expect(result).to be_nil
    end

    it 'fetches liturgical text when prayer_book exists' do
      result = builder.send(:fetch_liturgical_text, 'morning_welcome_traditional')
      expect(result).to be_a(LiturgicalText) if result
    end
  end

  describe '#line_item' do
    it 'creates a line item with text and type' do
      result = builder.send(:line_item, 'Test text', type: 'leader')
      expect(result).to eq({ text: 'Test text', type: 'leader' })
    end

    it 'defaults to "text" type' do
      result = builder.send(:line_item, 'Test text')
      expect(result).to eq({ text: 'Test text', type: 'text' })
    end
  end

  describe '#is_lent?' do
    it 'returns true during Quaresma' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Quaresma' })
      expect(builder.send(:is_lent?)).to be true
    end

    it 'returns true during Semana Santa' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Semana Santa' })
      expect(builder.send(:is_lent?)).to be true
    end

    it 'returns false during other seasons' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa' })
      expect(builder.send(:is_lent?)).to be false
    end
  end

  describe '#season_specific_antiphon' do
    it 'returns correct slug for Advent' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Advento', feast_day: false })
      slug = builder.send(:season_specific_antiphon)
      expect(slug).to eq('morning_before_invocation_advent')
    end

    it 'returns correct slug for Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa', feast_day: false })
      slug = builder.send(:season_specific_antiphon)
      expect(slug).to eq('morning_before_invocation_easter')
    end

    it 'returns nil for ordinary time without feast' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum', feast_day: false })
      slug = builder.send(:season_specific_antiphon)
      expect(slug).to be_nil
    end
  end
end
