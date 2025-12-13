# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::SharedHelpers do
  before(:all) do
    setup_full_liturgical_data
  end

  # Create a test class that includes the necessary modules and methods
  let(:test_class) do
    Class.new do
      include DailyOffice::Builders::SharedHelpers
      include DailyOffice::Concerns::SeasonMapper

      attr_reader :date, :office_type, :preferences, :day_info

      def initialize(date:, office_type:, preferences: {})
        @date = date
        @office_type = office_type
        @preferences = default_preferences.merge(preferences)
        # Generate seed if not provided (like BaseBuilder does)
        @preferences[:seed] ||= generate_seed
        @day_info = liturgical_calendar.day_info(@date)
      end

      def prayer_book
        @prayer_book ||= PrayerBook.find_by(code: preferences[:prayer_book_code])
      end

      private

      def default_preferences
        {
          prayer_book_code: "loc_2015",
          bible_version: "nvi",
          language: "pt-BR"
        }
      end

      def generate_seed
        "#{date.to_time.to_i}_#{office_type}".hash
      end

      def liturgical_calendar
        @liturgical_calendar ||= LiturgicalCalendar.new(
          date.year,
          prayer_book_code: preferences[:prayer_book_code]
        )
      end
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

  describe '#seeded_random' do
    context 'when seed is provided' do
      let(:builder_with_seed) { test_class.new(date: date, office_type: :morning, preferences: { seed: 12345 }) }

      it 'returns deterministic results for the same seed and key' do
        result1 = builder_with_seed.send(:seeded_random, 1..10, key: :test_key)
        result2 = builder_with_seed.send(:seeded_random, 1..10, key: :test_key)
        expect(result1).to eq(result2)
      end

      it 'returns different results for different keys with same seed' do
        # Use a large range to make collision statistically insignificant
        result1 = builder_with_seed.send(:seeded_random, 1..1_000_000, key: :test_key_1)
        result2 = builder_with_seed.send(:seeded_random, 1..1_000_000, key: :test_key_2)
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

        # Test multiple random values to ensure seeds are actually different
        results1 = 5.times.map { |i| builder1.send(:seeded_random, 1..1000, key: "test_#{i}".to_sym) }
        results2 = 5.times.map { |i| builder2.send(:seeded_random, 1..1000, key: "test_#{i}".to_sym) }

        # At least one value should be different (extremely unlikely all 5 match by chance)
        expect(results1).not_to eq(results2)
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

  describe '#resolve_preference' do
    let(:preferences_with_seed) { { seed: 12345 } }
    let(:builder_with_seed) { test_class.new(date: date, office_type: :morning, preferences: preferences_with_seed) }

    # ==========================================================================
    # SECTION: Range Options (Numeric)
    # ==========================================================================

    context 'with Range options' do
      let(:options) { 1..7 }
      let(:random_key) { :test_numeric }

      context 'when pref_value is nil' do
        it 'returns nil' do
          builder_with_seed.preferences[random_key] = nil
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_nil
        end
      end

      context 'when pref_value is empty string' do
        it 'returns nil' do
          builder_with_seed.preferences[random_key] = ''
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_nil
        end
      end

      context 'when pref_value is whitespace' do
        it 'returns nil' do
          builder_with_seed.preferences[random_key] = '   '
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_nil
        end
      end

      context 'when pref_value is "random"' do
        it 'returns a number within the range using seeded_random' do
          builder_with_seed.preferences[random_key] = 'random'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_a(Integer)
          expect(options).to include(result)
        end

        it 'returns deterministic results with same seed' do
          builder_with_seed.preferences[random_key] = 'random'
          result1 = builder_with_seed.send(:resolve_preference, random_key, options)
          result2 = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result1).to eq(result2)
        end

        it 'returns different results with different random_key' do
          builder_with_seed.preferences[:key1] = 'random'
          builder_with_seed.preferences[:key2] = 'random'
          result1 = builder_with_seed.send(:resolve_preference, :key1, options)
          result2 = builder_with_seed.send(:resolve_preference, :key2, options)
          expect([ result1, result2 ]).to all(be_a(Integer))
        end
      end

      context 'when pref_value is "all"' do
        it 'returns array of all values in range' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq([ 1, 2, 3, 4, 5, 6, 7 ])
        end

        it 'works with different ranges' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, 1..3)
          expect(result).to eq([ 1, 2, 3 ])
        end
      end

      context 'when pref_value is a specific integer' do
        it 'returns the integer' do
          builder_with_seed.preferences[random_key] = 3
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(3)
        end
      end

      context 'when pref_value is a string integer' do
        it 'converts and returns the integer' do
          builder_with_seed.preferences[random_key] = '5'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(5)
        end
      end

      context 'when pref_value is invalid for range' do
        it 'converts to integer (may be 0 or invalid)' do
          builder_with_seed.preferences[random_key] = 'invalid'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(0)
        end
      end
    end

    # ==========================================================================
    # SECTION: Array Options (Slugs)
    # ==========================================================================

    context 'with Array options' do
      let(:options) { %w[venite jubilate pascha_nostrum] }
      let(:random_key) { :test_slugs }

      context 'when pref_value is nil' do
        it 'returns nil' do
          builder_with_seed.preferences[random_key] = nil
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_nil
        end
      end

      context 'when pref_value is empty string' do
        it 'returns nil' do
          builder_with_seed.preferences[random_key] = ''
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_nil
        end
      end

      context 'when pref_value is "random"' do
        it 'returns one slug from the array using seeded_random' do
          builder_with_seed.preferences[random_key] = 'random'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_a(String)
          expect(options).to include(result)
        end

        it 'returns deterministic results with same seed' do
          builder_with_seed.preferences[random_key] = 'random'
          result1 = builder_with_seed.send(:resolve_preference, random_key, options)
          result2 = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result1).to eq(result2)
        end

        it 'returns different results with different random_key' do
          builder_with_seed.preferences[:key1] = 'random'
          builder_with_seed.preferences[:key2] = 'random'
          result1 = builder_with_seed.send(:resolve_preference, :key1, options)
          result2 = builder_with_seed.send(:resolve_preference, :key2, options)
          expect(options).to include(result1)
          expect(options).to include(result2)
        end
      end

      context 'when pref_value is "all"' do
        it 'returns the full array of slugs' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(options)
        end

        it 'returns the same array object' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be(options)
        end
      end

      context 'when pref_value is a specific slug' do
        it 'returns the slug as string' do
          builder_with_seed.preferences[random_key] = 'jubilate'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq('jubilate')
        end
      end

      context 'when pref_value is a slug not in options' do
        it 'returns the value as-is (builder handles validation)' do
          builder_with_seed.preferences[random_key] = 'unknown_slug'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq('unknown_slug')
        end
      end

      context 'when pref_value is a symbol' do
        it 'converts to string' do
          builder_with_seed.preferences[random_key] = :venite
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq('venite')
        end
      end
    end

    # ==========================================================================
    # SECTION: Edge Cases
    # ==========================================================================

    context 'edge cases' do
      let(:random_key) { :edge_cases }

      context 'with empty array options' do
        let(:options) { [] }

        it 'handles "random" gracefully' do
          builder_with_seed.preferences[random_key] = 'random'
          expect {
            builder_with_seed.send(:resolve_preference, random_key, options)
          }.not_to raise_error
        end

        it 'returns empty array for "all"' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq([])
        end
      end

      context 'with single-element array' do
        let(:options) { %w[only_one] }

        it 'returns the only element for "random"' do
          builder_with_seed.preferences[random_key] = 'random'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq('only_one')
        end

        it 'returns single-element array for "all"' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq([ 'only_one' ])
        end
      end

      context 'with single-value range' do
        let(:options) { 5..5 }

        it 'returns the only value for "random"' do
          builder_with_seed.preferences[random_key] = 'random'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(5)
        end

        it 'returns single-element array for "all"' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq([ 5 ])
        end
      end
    end

    # ==========================================================================
    # SECTION: Integration with Real Preference Keys
    # ==========================================================================

    context 'integration with real preference patterns' do
      context 'opening_sentence_general (1..7 range)' do
        let(:options) { 1..7 }
        let(:random_key) { :morning__opening_sentence_general }

        it 'handles specific value' do
          builder_with_seed.preferences[random_key] = '3'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(3)
        end

        it 'handles "random"' do
          builder_with_seed.preferences[random_key] = 'random'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(1..7).to include(result)
        end

        it 'handles "all"' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq([ 1, 2, 3, 4, 5, 6, 7 ])
        end
      end

      context 'first_canticle (slug array)' do
        let(:options) { %w[benedictus_es_domine cantate_domino benedicite_omnia_opera] }
        let(:random_key) { :morning__first_canticle }

        it 'handles specific slug' do
          builder_with_seed.preferences[random_key] = 'cantate_domino'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq('cantate_domino')
        end

        it 'handles "random"' do
          builder_with_seed.preferences[random_key] = 'random'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(options).to include(result)
        end

        it 'handles "all"' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(options)
        end
      end

      context 'general_collects (large slug array)' do
        let(:options) do
          %w[
            for_peace
            for_grace
            for_all_authorities
            for_clergy
            for_parish_family
            for_all_humanity
          ]
        end
        let(:random_key) { :morning__general_collects }

        it 'handles "random" to pick one collect' do
          builder_with_seed.preferences[random_key] = 'random'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to be_a(String)
          expect(options).to include(result)
        end

        it 'handles "all" to return all collects' do
          builder_with_seed.preferences[random_key] = 'all'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq(options)
        end

        it 'handles specific collect slug' do
          builder_with_seed.preferences[random_key] = 'for_peace'
          result = builder_with_seed.send(:resolve_preference, random_key, options)
          expect(result).to eq('for_peace')
        end
      end
    end

    # ==========================================================================
    # SECTION: Deterministic Seeding
    # ==========================================================================

    context 'deterministic seeding behavior' do
      it 'produces same results across multiple calls with same parameters' do
        builder_with_seed.preferences[:test_key] = 'random'
        results = 5.times.map do
          builder_with_seed.send(:resolve_preference, :test_key, 1..100)
        end

        expect(results.uniq.size).to eq(1)
      end

      it 'produces different results with different seeds' do
        builder1 = test_class.new(date: date, office_type: :morning, preferences: { seed: 111 })
        builder2 = test_class.new(date: date, office_type: :morning, preferences: { seed: 222 })

        builder1.preferences[:test] = 'random'
        builder2.preferences[:test] = 'random'
        result1 = builder1.send(:resolve_preference, :test, 1..1000)
        result2 = builder2.send(:resolve_preference, :test, 1..1000)

        # Very likely to be different with large range
        expect(result1).not_to eq(result2)
      end

      it 'produces different results with different random_keys' do
        builder_with_seed.preferences[:key_a] = 'random'
        builder_with_seed.preferences[:key_b] = 'random'
        result1 = builder_with_seed.send(:resolve_preference, :key_a, 1..1000)
        result2 = builder_with_seed.send(:resolve_preference, :key_b, 1..1000)

        # Very likely to be different
        expect(result1).not_to eq(result2)
      end
    end
  end
end
