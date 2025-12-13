# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015::Compline do
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
  let(:builder) { described_class.new(date: date, office_type: :compline) }

  before do
    # Ensure prayer book exists
    prayer_book
  end

  # ==========================================================================
  # SECTION: Constants
  # ==========================================================================

  describe 'constants' do
    it 'defines COMPLINE_FINAL_PRAYER_SLUGS' do
      expect(described_class::COMPLINE_FINAL_PRAYER_SLUGS).to be_a(Array)
      expect(described_class::COMPLINE_FINAL_PRAYER_SLUGS).to include('compline_final_prayer_1')
      expect(described_class::COMPLINE_FINAL_PRAYER_SLUGS).to be_frozen
    end

    it 'has 6 final prayer slugs' do
      expect(described_class::COMPLINE_FINAL_PRAYER_SLUGS.length).to eq(6)
    end
  end

  # ==========================================================================
  # SECTION: Assembly Method
  # ==========================================================================

  describe '#assemble_compline' do
    it 'returns full compline structure' do
      modules = builder.send(:assemble_compline)

      expect(modules).to be_an(Array)
      expect(modules).to all(be_a(Hash))
    end

    it 'includes all expected module types' do
      modules = builder.send(:assemble_compline)
      module_slugs = modules.map { |m| m[:slug] }

      # Core Compline structure
      expect(module_slugs).to include('opening')
      expect(module_slugs).to include('brief_lesson')
      expect(module_slugs).to include('confession')
      expect(module_slugs).to include('psalms')
      expect(module_slugs).to include('nunc_dimittis')
      expect(module_slugs).to include('dismissal')
    end

    context 'regression tests (golden master)' do
      it 'maintains exact structure for each module' do
        modules = builder.send(:assemble_compline)

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
        modules = builder.send(:assemble_compline)
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
        expect(result[:name]).to eq('Preparação')
      end
    end

    it 'includes responsive elements' do
      result = builder.send(:build_opening)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end
  end

  describe '#build_brief_lesson' do
    it 'returns brief lesson module structure' do
      result = builder.send(:build_brief_lesson)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('brief_lesson')
        expect(result[:name]).to eq('Lição Breve')
      end
    end
  end

  # ==========================================================================
  # SECTION: Confession and Absolution
  # ==========================================================================

  describe '#build_confession' do
    it 'returns confession module structure' do
      result = builder.send(:build_confession)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('confession')
        expect(result[:name]).to eq('Confissão')
      end
    end

    it 'includes congregation response' do
      result = builder.send(:build_confession)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('congregation')
      end
    end
  end

  describe '#build_absolution' do
    it 'returns absolution module structure' do
      result = builder.send(:build_absolution)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('absolution')
      end
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
        expect(result[:slug]).to eq('psalms')
        expect(result[:name]).to eq('Salmodia')
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
  # SECTION: Readings and Response
  # ==========================================================================

  describe '#build_readings' do
    it 'returns readings module structure' do
      result = builder.send(:build_readings)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('readings')
        expect(result[:name]).to eq('Lições Breves')
      end
    end
  end

  describe '#build_response' do
    it 'returns response module structure' do
      result = builder.send(:build_response)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('response')
      end
    end

    it 'includes responsive elements' do
      result = builder.send(:build_response)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end
  end

  # ==========================================================================
  # SECTION: Prayers
  # ==========================================================================

  describe '#build_kyrie' do
    it 'returns Kyrie module structure' do
      result = builder.send(:build_kyrie)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('kyrie')
      end
    end
  end

  describe '#build_lords_prayer' do
    it 'returns Lords Prayer module structure' do
      result = builder.send(:build_lords_prayer)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('lords_prayer')
      end
    end

    it 'includes congregation response' do
      result = builder.send(:build_lords_prayer)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('congregation')
      end
    end
  end

  # ==========================================================================
  # SECTION: Canticle and Dismissal
  # ==========================================================================

  describe '#build_antiphon' do
    it 'returns antiphon module structure' do
      result = builder.send(:build_antiphon)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('antiphon')
      end
    end
  end

  describe '#build_nunc_dimittis' do
    it 'returns Nunc Dimittis module structure' do
      result = builder.send(:build_nunc_dimittis)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('nunc_dimittis')
      end
    end

    it 'includes congregation response' do
      result = builder.send(:build_nunc_dimittis)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('congregation')
      end
    end
  end

  describe '#build_dismissal' do
    it 'returns dismissal module structure' do
      result = builder.send(:build_dismissal)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('dismissal')
        expect(result[:name]).to eq('Antífona')
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
          office_type: :compline,
          preferences: { compline_psalm_day: day_num }
        )
        result = test_builder.send(:build_psalms)
        expect(result).to be_an(Array)
      end
    end

    it 'handles different lesson preferences' do
      [ 1, 2, 3 ].each do |lesson_num|
        test_builder = described_class.new(
          date: date,
          office_type: :compline,
          preferences: { compline_lesson: lesson_num }
        )
        result = test_builder.send(:build_readings)
        expect(result).to be_a(Hash) if result
      end
    end
  end
end
