# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015Builder do
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

  before do
    # Ensure prayer book exists
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
        preferences: { prayer_book_code: 'loc_2015' }
      )

      expect(builder.date).to eq(date)
      expect(builder.office_type).to eq(:morning)
      expect(builder.preferences[:prayer_book_code]).to eq('loc_2015')
    end

    it 'initializes component builders' do
      builder = described_class.new(date: date, office_type: :morning)

      expect(builder.psalm_builder).to be_a(DailyOffice::Components::PsalmBuilder)
      expect(builder.canticle_builder).to be_a(DailyOffice::Components::CanticleBuilder)
      expect(builder.reading_builder).to be_a(DailyOffice::Components::ReadingBuilder)
      expect(builder.prayer_builder).to be_a(DailyOffice::Components::PrayerBuilder)
    end
  end

  describe '#call' do
    it 'returns structured daily office data' do
      builder = described_class.new(date: date, office_type: :morning)
      result = builder.call

      expect(result).to be_a(Hash)
      expect(result[:date]).to eq('2025-11-25')
      expect(result[:office_type]).to eq('morning')
      expect(result[:modules]).to be_an(Array)
      expect(result[:metadata]).to be_a(Hash)
    end

    it 'includes LOC 2015 specific modules' do
      builder = described_class.new(date: date, office_type: :morning)
      result = builder.call
      module_slugs = result[:modules].map { |m| m[:slug] }

      expect(module_slugs).to include('welcome') # LOC 2015 specific
      expect(module_slugs).to include('offertory') # LOC 2015 specific
    end
  end

  # ==========================================================================
  # SECTION: Included Modules
  # ==========================================================================

  describe 'included modules' do
    it 'includes SeasonMapper module' do
      expect(described_class.ancestors).to include(DailyOffice::Concerns::SeasonMapper)
    end

    it 'includes ReadingFormatter module' do
      expect(described_class.ancestors).to include(DailyOffice::Concerns::ReadingFormatter)
    end

    it 'includes Loc2015::SharedHelpers module' do
      expect(described_class.ancestors).to include(DailyOffice::Builders::Loc2015::SharedHelpers)
    end

    it 'includes Loc2015::Morning module' do
      expect(described_class.ancestors).to include(DailyOffice::Builders::Loc2015::Morning)
    end

    it 'includes Loc2015::Evening module' do
      expect(described_class.ancestors).to include(DailyOffice::Builders::Loc2015::Evening)
    end

    it 'includes Loc2015::Midday module' do
      expect(described_class.ancestors).to include(DailyOffice::Builders::Loc2015::Midday)
    end

    it 'includes Loc2015::Compline module' do
      expect(described_class.ancestors).to include(DailyOffice::Builders::Loc2015::Compline)
    end
  end

  # ==========================================================================
  # SECTION: Integration Tests
  # ==========================================================================

  describe 'integration tests' do
    it 'builds complete morning prayer without errors' do
      builder = described_class.new(
        date: Date.new(2025, 12, 25), # Christmas
        office_type: :morning,
        preferences: { prayer_book_code: 'loc_2015' }
      )

      expect { builder.call }.not_to raise_error
    end

    it 'handles different liturgical seasons' do
      seasons = [
        Date.new(2025, 12, 1),  # Advent
        Date.new(2025, 12, 25), # Christmas
        Date.new(2025, 3, 5),   # Lent (approximate)
        Date.new(2025, 4, 20),  # Easter (approximate)
        Date.new(2025, 8, 15)   # Ordinary Time
      ]

      seasons.each do |test_date|
        builder = described_class.new(
          date: test_date,
          office_type: :morning,
          preferences: { prayer_book_code: 'loc_2015' }
        )

        expect { builder.call }.not_to raise_error
        result = builder.call
        expect(result[:modules]).to be_an(Array)
        expect(result[:modules]).not_to be_empty
      end
    end

    it 'handles all preference combinations' do
      preferences_combinations = [
        { prayer_style: 'traditional' },
        { prayer_style: 'contemporary' },
        { creed_paraphrase: true },
        { creed_paraphrase: false },
        { first_canticle: 2 },
        { second_canticle: 3 },
        { invitatory_canticle: 'jubilate' },
        { general_collects: [ 'for_peace', 'for_grace' ] }
      ]

      preferences_combinations.each do |prefs|
        builder = described_class.new(
          date: date,
          office_type: :morning,
          preferences: prefs.merge(prayer_book_code: 'loc_2015')
        )

        expect { builder.call }.not_to raise_error
      end
    end

    it 'handles different office types' do
      [ :morning, :evening, :midday, :compline ].each do |office_type|
        builder = described_class.new(
          date: date,
          office_type: office_type,
          preferences: { prayer_book_code: 'loc_2015' }
        )

        expect { builder.call }.not_to raise_error
        result = builder.call
        expect(result[:office_type]).to eq(office_type.to_s)
      end
    end
  end
end
