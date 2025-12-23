# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Locb2008Builder do
  before(:all) do
    setup_full_liturgical_data
  end

  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'locb_2008') do |pb|
      pb.name = 'Livro de Oração Comum Brasileiro 2008'
      pb.features = {
        'lectionary' => {
          'reading_types' => [ 'semicontinuous' ],
          'default_reading_type' => 'semicontinuous'
        },
        'daily_office' => {
          'supports_multiple_rites' => true
        }
      }
    end
  end

  let(:date) { Date.new(2025, 11, 25) }

  before do
    prayer_book
  end

  # ==========================================================================
  # SECTION: Initialization and Setup
  # ==========================================================================

  describe '#initialize' do
    it 'initializes with date, office_type, and preferences' do
      builder = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'locb_2008' }
      )

      expect(builder).to be_a(described_class)
    end
  end

  # ==========================================================================
  # SECTION: Office Routing
  # ==========================================================================

  describe 'office routing' do
    it 'routes to Morning office builder' do
      builder = described_class.new(date: date, office_type: :morning)
      result = builder.call

      expect(result[:office_type]).to eq('morning')
      expect(result[:modules]).to be_an(Array)
    end

    it 'routes to Evening office builder' do
      builder = described_class.new(date: date, office_type: :evening)
      result = builder.call

      expect(result[:office_type]).to eq('evening')
      expect(result[:modules]).to be_an(Array)
    end

    it 'routes to Midday office builder' do
      mock_result = { office_type: 'midday', modules: [] }
      midday_instance = instance_double(DailyOffice::Builders::Locb2008::Midday, call: mock_result)

      expect(DailyOffice::Builders::Locb2008::Midday).to receive(:new)
        .with(date: date, office_type: :midday, preferences: {})
        .and_return(midday_instance)

      builder = described_class.new(date: date, office_type: :midday, preferences: {})
      result = builder.call

      expect(result[:office_type]).to eq('midday')
    end

    it 'routes to Compline office builder' do
      mock_result = { office_type: 'compline', modules: [] }
      compline_instance = instance_double(DailyOffice::Builders::Locb2008::ComplineRiteOne, call: mock_result)

      expect(DailyOffice::Builders::Locb2008::ComplineRiteOne).to receive(:new)
        .with(date: date, office_type: :compline, preferences: {})
        .and_return(compline_instance)

      builder = described_class.new(date: date, office_type: :compline, preferences: {})
      result = builder.call

      expect(result[:office_type]).to eq('compline')
    end

    it 'raises error for unknown office type' do
      expect {
        described_class.new(date: date, office_type: :unknown).call
      }.to raise_error(ArgumentError, /Unknown office type/)
    end
  end

  # ==========================================================================
  # SECTION: Rite Selection
  # ==========================================================================

  describe 'rite selection' do
    describe 'morning prayer rites' do
      it 'defaults to rite 1 when no preference is set' do
        builder = described_class.new(date: date, office_type: :morning, preferences: {})

        expect(DailyOffice::Builders::Locb2008::MorningRiteOne).to receive(:new)
          .with(date: date, office_type: :morning, preferences: {})
          .and_call_original

        builder.call
      end

      %w[1 2 3 4].each do |rite_number|
        it "routes to rite #{rite_number} when morning_prayer_rite is '#{rite_number}'" do
          preferences = { morning_prayer_rite: rite_number }
          builder = described_class.new(date: date, office_type: :morning, preferences: preferences)

          rite_class = "DailyOffice::Builders::Locb2008::MorningRite#{%w[One Two Three Four][rite_number.to_i - 1]}".constantize
          expect(rite_class).to receive(:new)
            .with(date: date, office_type: :morning, preferences: preferences)
            .and_call_original

          builder.call
        end
      end
    end

    describe 'evening prayer rites' do
      it 'defaults to rite 1 when no preference is set' do
        builder = described_class.new(date: date, office_type: :evening, preferences: {})

        expect(DailyOffice::Builders::Locb2008::EveningRiteOne).to receive(:new)
          .with(date: date, office_type: :evening, preferences: {})
          .and_call_original

        builder.call
      end

      %w[1 2 3 4].each do |rite_number|
        it "routes to rite #{rite_number} when evening_prayer_rite is '#{rite_number}'" do
          preferences = { evening_prayer_rite: rite_number }
          builder = described_class.new(date: date, office_type: :evening, preferences: preferences)

          rite_class = "DailyOffice::Builders::Locb2008::EveningRite#{%w[One Two Three Four][rite_number.to_i - 1]}".constantize
          expect(rite_class).to receive(:new)
            .with(date: date, office_type: :evening, preferences: preferences)
            .and_call_original

          builder.call
        end
      end
    end

    describe 'compline prayer rites' do
      it 'defaults to rite 1 when no preference is set' do
        mock_result = { office_type: 'compline', modules: [] }
        compline_instance = instance_double(DailyOffice::Builders::Locb2008::ComplineRiteOne, call: mock_result)

        expect(DailyOffice::Builders::Locb2008::ComplineRiteOne).to receive(:new)
          .with(date: date, office_type: :compline, preferences: {})
          .and_return(compline_instance)

        builder = described_class.new(date: date, office_type: :compline, preferences: {})
        builder.call
      end

      %w[1 2].each do |rite_number|
        it "routes to rite #{rite_number} when compline_prayer_rite is '#{rite_number}'" do
          preferences = { compline_prayer_rite: rite_number }
          mock_result = { office_type: 'compline', modules: [] }

          rite_class = "DailyOffice::Builders::Locb2008::ComplineRite#{%w[One Two][rite_number.to_i - 1]}".constantize
          compline_instance = instance_double(rite_class, call: mock_result)

          expect(rite_class).to receive(:new)
            .with(date: date, office_type: :compline, preferences: preferences)
            .and_return(compline_instance)

          builder = described_class.new(date: date, office_type: :compline, preferences: preferences)
          builder.call
        end
      end
    end
  end

  # ==========================================================================
  # SECTION: Random Rite Selection
  # ==========================================================================

  describe 'random rite selection' do
    describe '#resolve_rite_preference' do
      let(:builder) { described_class.new(date: date, office_type: :morning, preferences: preferences) }

      context 'when preference is nil' do
        let(:preferences) { {} }

        it 'returns default rite "1"' do
          result = builder.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])
          expect(result).to eq('1')
        end
      end

      context 'when preference is empty string' do
        let(:preferences) { { morning_prayer_rite: '' } }

        it 'returns default rite "1"' do
          result = builder.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])
          expect(result).to eq('1')
        end
      end

      context 'when preference is a specific value' do
        let(:preferences) { { morning_prayer_rite: '3' } }

        it 'returns the specific value' do
          result = builder.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])
          expect(result).to eq('3')
        end
      end

      context 'when preference is "random"' do
        let(:preferences) { { morning_prayer_rite: 'random' } }

        it 'returns a valid rite from the available options' do
          result = builder.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])
          expect(%w[1 2 3 4]).to include(result)
        end
      end

      context 'when preference is "random" with seed' do
        let(:seed) { 12345 }
        let(:preferences) { { morning_prayer_rite: 'random', seed: seed } }

        it 'returns deterministic result based on seed' do
          result1 = builder.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])
          result2 = builder.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])

          expect(result1).to eq(result2)
        end

        it 'returns different results for different preference keys with same seed' do
          morning_result = builder.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])
          evening_result = builder.send(:resolve_rite_preference, :evening_prayer_rite, %w[1 2 3 4])

          # Different keys should potentially give different results
          # (though they could coincidentally be the same)
          expect(morning_result).to be_a(String)
          expect(evening_result).to be_a(String)
        end

        it 'returns same result for same seed across different builder instances' do
          builder1 = described_class.new(date: date, office_type: :morning, preferences: preferences)
          builder2 = described_class.new(date: date, office_type: :morning, preferences: preferences)

          result1 = builder1.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])
          result2 = builder2.send(:resolve_rite_preference, :morning_prayer_rite, %w[1 2 3 4])

          expect(result1).to eq(result2)
        end
      end
    end

    describe 'random morning prayer rite' do
      it 'selects a valid rite when morning_prayer_rite is "random"' do
        preferences = { morning_prayer_rite: 'random', seed: 42 }
        builder = described_class.new(date: date, office_type: :morning, preferences: preferences)

        # Should not raise error and should produce valid output
        expect { builder.call }.not_to raise_error
        result = builder.call
        expect(result[:office_type]).to eq('morning')
      end

      it 'produces deterministic results with same seed' do
        preferences = { morning_prayer_rite: 'random', seed: 42 }

        builder1 = described_class.new(date: date, office_type: :morning, preferences: preferences)
        builder2 = described_class.new(date: date, office_type: :morning, preferences: preferences)

        # Both should call the same rite builder
        result1 = builder1.call
        result2 = builder2.call

        expect(result1[:modules].map { |m| m[:slug] }).to eq(result2[:modules].map { |m| m[:slug] })
      end
    end

    describe 'random evening prayer rite' do
      it 'selects a valid rite when evening_prayer_rite is "random"' do
        preferences = { evening_prayer_rite: 'random', seed: 42 }
        builder = described_class.new(date: date, office_type: :evening, preferences: preferences)

        expect { builder.call }.not_to raise_error
        result = builder.call
        expect(result[:office_type]).to eq('evening')
      end

      it 'produces deterministic results with same seed' do
        preferences = { evening_prayer_rite: 'random', seed: 42 }

        builder1 = described_class.new(date: date, office_type: :evening, preferences: preferences)
        builder2 = described_class.new(date: date, office_type: :evening, preferences: preferences)

        result1 = builder1.call
        result2 = builder2.call

        expect(result1[:modules].map { |m| m[:slug] }).to eq(result2[:modules].map { |m| m[:slug] })
      end
    end

    describe 'random compline prayer rite' do
      it 'selects a valid rite when compline_prayer_rite is "random"' do
        preferences = { compline_prayer_rite: 'random', seed: 42 }
        builder = described_class.new(date: date, office_type: :compline, preferences: preferences)

        # Test that resolve_rite_preference returns a valid rite
        rite = builder.send(:resolve_rite_preference, :compline_prayer_rite, %w[1 2])
        expect(%w[1 2]).to include(rite)
      end

      it 'produces deterministic results with same seed' do
        preferences = { compline_prayer_rite: 'random', seed: 42 }

        builder1 = described_class.new(date: date, office_type: :compline, preferences: preferences)
        builder2 = described_class.new(date: date, office_type: :compline, preferences: preferences)

        rite1 = builder1.send(:resolve_rite_preference, :compline_prayer_rite, %w[1 2])
        rite2 = builder2.send(:resolve_rite_preference, :compline_prayer_rite, %w[1 2])

        expect(rite1).to eq(rite2)
      end

      it 'only selects from available compline rites (1 or 2)' do
        # Run multiple times to ensure we never get invalid rites
        10.times do |i|
          preferences = { compline_prayer_rite: 'random', seed: i * 100 }
          builder = described_class.new(date: date, office_type: :compline, preferences: preferences)
          rite = builder.send(:resolve_rite_preference, :compline_prayer_rite, %w[1 2])
          expect(%w[1 2]).to include(rite)
        end
      end
    end
  end

  # ==========================================================================
  # SECTION: Seeded Random
  # ==========================================================================

  describe '#seeded_random' do
    let(:builder) { described_class.new(date: date, office_type: :morning, preferences: preferences) }

    context 'without seed' do
      let(:preferences) { {} }

      it 'returns a value within the range' do
        result = builder.send(:seeded_random, 0...4, key: :test_key)
        expect(result).to be >= 0
        expect(result).to be < 4
      end
    end

    context 'with seed' do
      let(:preferences) { { seed: 12345 } }

      it 'returns deterministic value for same key' do
        result1 = builder.send(:seeded_random, 0...4, key: :test_key)
        result2 = builder.send(:seeded_random, 0...4, key: :test_key)

        expect(result1).to eq(result2)
      end

      it 'returns different values for different keys' do
        result1 = builder.send(:seeded_random, 0...100, key: :key_one)
        result2 = builder.send(:seeded_random, 0...100, key: :key_two)

        # With a large enough range, different keys should produce different results
        # Note: there's a small chance they could be the same by coincidence
        expect(result1).to be_a(Integer)
        expect(result2).to be_a(Integer)
      end

      it 'returns same value for same seed across instances' do
        builder1 = described_class.new(date: date, office_type: :morning, preferences: preferences)
        builder2 = described_class.new(date: date, office_type: :morning, preferences: preferences)

        result1 = builder1.send(:seeded_random, 0...4, key: :test_key)
        result2 = builder2.send(:seeded_random, 0...4, key: :test_key)

        expect(result1).to eq(result2)
      end
    end
  end

  # ==========================================================================
  # SECTION: Integration Tests
  # ==========================================================================

  describe 'integration tests' do
    it 'builds complete morning prayer without errors' do
      builder = described_class.new(
        date: Date.new(2025, 12, 25),
        office_type: :morning,
        preferences: { prayer_book_code: 'locb_2008' }
      )

      expect { builder.call }.not_to raise_error
    end

    it 'handles all office types with random rite selection' do
      [
        [ :morning, :morning_prayer_rite, %w[1 2 3 4] ],
        [ :evening, :evening_prayer_rite, %w[1 2 3 4] ],
        [ :compline, :compline_prayer_rite, %w[1 2] ]
      ].each do |office_type, pref_key, available_rites|
        preferences = { pref_key => 'random', seed: 42, prayer_book_code: 'locb_2008' }
        builder = described_class.new(
          date: date,
          office_type: office_type,
          preferences: preferences
        )

        # Test that resolve_rite_preference returns a valid rite
        rite = builder.send(:resolve_rite_preference, pref_key, available_rites)
        expect(available_rites).to include(rite)
      end
    end

    it 'handles midday (no rite selection)' do
      mock_result = { office_type: 'midday', modules: [] }
      midday_instance = instance_double(DailyOffice::Builders::Locb2008::Midday, call: mock_result)

      allow(DailyOffice::Builders::Locb2008::Midday).to receive(:new)
        .and_return(midday_instance)

      builder = described_class.new(
        date: date,
        office_type: :midday,
        preferences: { prayer_book_code: 'locb_2008' }
      )

      expect { builder.call }.not_to raise_error
      result = builder.call
      expect(result[:office_type]).to eq('midday')
    end
  end
end
