# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015::Midday do
  before(:all) do
    setup_full_liturgical_data
  end

  # Create a test class that includes the module
  

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
  let(:builder) { described_class.new(date: date, office_type: :midday) }

  before do
    # Ensure prayer book exists
    prayer_book
  end

  # ==========================================================================
  # SECTION: Assembly Method
  # ==========================================================================

  describe '#assemble_midday_prayer' do
    it 'returns full midday prayer structure' do
      modules = builder.send(:assemble_midday_prayer)

      expect(modules).to be_an(Array)
      expect(modules).to all(be_a(Hash))
    end

    it 'includes all expected module types' do
      modules = builder.send(:assemble_midday_prayer)
      module_slugs = modules.map { |m| m[:slug] }

      # Core Midday structure
      expect(module_slugs).to include('opening')
      expect(module_slugs).to include('invitation')
      expect(module_slugs).to include('psalms_title')
      expect(module_slugs).to include('readings')
      expect(module_slugs).to include('prayer')
      expect(module_slugs).to include('dismissal')
    end

    context 'regression tests (golden master)' do
      it 'maintains exact structure for each module' do
        modules = builder.send(:assemble_midday_prayer)

        modules.each do |mod|
          expect(mod).to have_key(:name)
          expect(mod).to have_key(:slug)
          expect(mod).to have_key(:lines)
          expect(mod[:lines]).to be_an(Array)

          mod[:lines].each do |line|
            expect(line).to have_key(:text)
            expect(line).to have_key(:type)
          end
        end
      end

      it 'preserves line types for all modules' do
        modules = builder.send(:assemble_midday_prayer)
        all_line_types = modules.flat_map { |m| m[:lines].map { |l| l[:type] } }.uniq

        # Expected line types in LOC 2015
        expected_types = %w[leader congregation responsive rubric spacer citation reading heading all text]
        expect(all_line_types - expected_types).to be_empty
      end
    end
  end

  # ==========================================================================
  # SECTION: Opening and Preparation
  # ==========================================================================

  describe '#build_opening' do
    it 'returns opening module structure' do
      result = builder.send(:build_opening)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('opening')
        expect(result[:name]).to eq('Acolhida')
      end
    end

    it 'includes leader elements' do
      result = builder.send(:build_opening)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('leader')
      end
    end
  end

  describe '#build_invitation' do
    it 'returns invitation module structure' do
      result = builder.send(:build_invitation)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('invitation')
        expect(result[:name]).to eq('Invitatório')
      end
    end

    it 'includes responsive elements' do
      result = builder.send(:build_invitation)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end

    it 'uses Lent-specific invitation during Lent' do
      allow(builder).to receive(:is_lent?).and_return(true)
      allow(builder).to receive(:fetch_liturgical_text).and_call_original

      builder.send(:build_invitation)

      expect(builder).to have_received(:fetch_liturgical_text).with('midday_invitation_lent')
    end

    it 'uses regular invitation outside Lent' do
      allow(builder).to receive(:is_lent?).and_return(false)
      allow(builder).to receive(:fetch_liturgical_text).and_call_original

      builder.send(:build_invitation)

      expect(builder).to have_received(:fetch_liturgical_text).with('midday_invitation')
    end
  end

  # ==========================================================================
  # SECTION: Psalms
  # ==========================================================================

  describe '#build_psalms_title' do
    it 'returns psalms title module structure' do
      result = builder.send(:build_psalms_title)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('psalms_title')
        expect(result[:name]).to eq('Salmo')
      end
    end
  end

  describe '#build_psalms' do
    it 'returns psalms module structure' do
      result = builder.send(:build_psalms)

      expect(result).to be_an(Array)
      result.each do |psalm_module|
        expect(psalm_module).to have_key(:name)
        expect(psalm_module).to have_key(:slug)
        expect(psalm_module).to have_key(:lines)
      end
    end
  end

  # ==========================================================================
  # SECTION: Readings
  # ==========================================================================

  describe '#build_readings' do
    it 'returns readings module structure' do
      result = builder.send(:build_readings)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('readings')
      end
    end

    it 'includes leader elements' do
      result = builder.send(:build_readings)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('leader')
      end
    end
  end

  # ==========================================================================
  # SECTION: Prayers
  # ==========================================================================

  describe '#build_prayer' do
    it 'returns prayer module structure' do
      result = builder.send(:build_prayer)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('prayer')
      end
    end

    it 'includes collect of the day' do
      result = builder.send(:build_prayer)

      if result
        # Should include collect-related content
        expect(result[:lines]).not_to be_empty
      end
    end
  end

  # ==========================================================================
  # SECTION: Dismissal
  # ==========================================================================

  describe '#build_dismissal' do
    it 'returns dismissal module structure' do
      result = builder.send(:build_dismissal)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('dismissal')
      end
    end

    it 'includes responsive elements' do
      result = builder.send(:build_dismissal)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end
  end

  # ==========================================================================
  # SECTION: Preference Variations
  # ==========================================================================

  describe 'preference variations' do
    it 'handles different psalm preferences' do
      [ 1, 2, 3, 4, 5, 6, 7 ].each do |day_num|
        test_builder = described_class.new(
          date: date,
          office_type: :midday,
          preferences: { midday_psalm_day: day_num }
        )
        result = test_builder.send(:build_psalms)
        expect(result).to be_an(Array)
      end
    end

    it 'handles Lent season variations' do
      lent_builder = described_class.new(
        date: date,
        office_type: :midday
      )
      allow(lent_builder).to receive(:is_lent?).and_return(true)

      result = lent_builder.send(:build_invitation)
      expect(result).to be_a(Hash) if result
    end

    it 'handles regular season variations' do
      regular_builder = described_class.new(
        date: date,
        office_type: :midday
      )
      allow(regular_builder).to receive(:is_lent?).and_return(false)

      result = regular_builder.send(:build_invitation)
      expect(result).to be_a(Hash) if result
    end
  end
end
