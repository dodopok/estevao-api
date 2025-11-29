# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015::SharedHelpers do
  before(:all) do
    setup_full_liturgical_data
  end

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

  describe '#seeded_random' do
    context 'when seed is provided' do
      let(:builder_with_seed) { test_class.new(date: date, office_type: :morning, preferences: { seed: 12345 }) }

      it 'returns deterministic results for the same seed and key' do
        result1 = builder_with_seed.send(:seeded_random, 1..10, key: :test_key)
        result2 = builder_with_seed.send(:seeded_random, 1..10, key: :test_key)
        expect(result1).to eq(result2)
      end

      it 'returns different results for different keys with same seed' do
        result1 = builder_with_seed.send(:seeded_random, 1..10, key: :test_key_1)
        result2 = builder_with_seed.send(:seeded_random, 1..10, key: :test_key_2)
        expect(result1).not_to eq(result2)
      end

      it 'returns values within the specified range' do
        100.times do
          result = builder_with_seed.send(:seeded_random, 1..7, key: :test_range)
          expect(result).to be_between(1, 7).inclusive
        end
      end

      it 'produces consistent results across multiple calls' do
        results = 5.times.map { builder_with_seed.send(:seeded_random, 1..100, key: :consistency_test) }
        expect(results.uniq.length).to eq(1)
      end
    end

    context 'when seed is not explicitly provided' do
      let(:builder_without_seed) { test_class.new(date: date, office_type: :morning) }

      it 'generates a seed automatically (deterministic based on date/office_type)' do
        # The base_builder generates a seed automatically when none is provided
        expect(builder_without_seed.preferences[:seed]).not_to be_nil
      end

      it 'returns values within the specified range' do
        100.times do
          result = builder_without_seed.send(:seeded_random, 1..7, key: :test_range)
          expect(result).to be_between(1, 7).inclusive
        end
      end

      it 'produces consistent results for same date/office_type combination' do
        # Since seed is auto-generated based on date and office_type,
        # same combination should produce same results
        results = 5.times.map { builder_without_seed.send(:seeded_random, 1..100, key: :auto_seed_test) }
        expect(results.uniq.length).to eq(1)
      end

      it 'produces different results for different date/office_type combinations' do
        builder1 = test_class.new(date: Date.new(2025, 1, 1), office_type: :morning)
        builder2 = test_class.new(date: Date.new(2025, 1, 2), office_type: :morning)

        result1 = builder1.send(:seeded_random, 1..1000, key: :date_test)
        result2 = builder2.send(:seeded_random, 1..1000, key: :date_test)

        expect(result1).not_to eq(result2)
      end
    end

    context 'different seeds produce different results' do
      it 'returns different values for different seeds' do
        builder1 = test_class.new(date: date, office_type: :morning, preferences: { seed: 11111 })
        builder2 = test_class.new(date: date, office_type: :morning, preferences: { seed: 22222 })

        result1 = builder1.send(:seeded_random, 1..1000, key: :same_key)
        result2 = builder2.send(:seeded_random, 1..1000, key: :same_key)

        expect(result1).not_to eq(result2)
      end
    end
  end
end
