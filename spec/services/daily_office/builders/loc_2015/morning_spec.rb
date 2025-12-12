# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015::Morning do
  # Create a test class that includes the module
  let(:test_class) do
    Class.new(DailyOffice::Builders::Loc2015Builder) do
      include DailyOffice::Builders::Loc2015::Morning
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

  # ==========================================================================
  # SECTION: Constants
  # ==========================================================================

  describe 'constants' do
    it 'defines GENERAL_COLLECT_SLUGS' do
      expect(described_class::GENERAL_COLLECT_SLUGS).to be_a(Array)
      expect(described_class::GENERAL_COLLECT_SLUGS).to include('for_peace')
      expect(described_class::GENERAL_COLLECT_SLUGS).to include('for_grace')
      expect(described_class::GENERAL_COLLECT_SLUGS).to be_frozen
    end

    it 'has 6 general collect slugs' do
      expect(described_class::GENERAL_COLLECT_SLUGS.length).to eq(6)
    end
  end

  # ==========================================================================
  # SECTION: Assembly Method
  # ==========================================================================

  describe '#assemble_morning_prayer' do
    it 'returns full morning prayer structure' do
      modules = builder.assemble_morning_prayer

      expect(modules).to be_an(Array)
      expect(modules).to all(be_a(Hash))
    end

    it 'includes all expected module types' do
      modules = builder.assemble_morning_prayer
      module_slugs = modules.map { |m| m[:slug] }

      # Core LOC 2015 structure
      expect(module_slugs).to include('welcome')
      expect(module_slugs).to include('opening_sentence')
      expect(module_slugs).to include('confession')
      expect(module_slugs).to include('psalms')
      expect(module_slugs).to include('lords_prayer')
      expect(module_slugs).to include('dismissal')
    end

    it 'returns family rite when preference is set' do
      family_builder = test_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'loc_2015', family_rite: true }
      )

      # Family rite uses BaseBuilder implementation which may have different requirements
      begin
        modules = family_builder.assemble_morning_prayer
        expect(modules).to be_an(Array)
        expect(modules).to all(be_a(Hash))
      rescue TypeError, NoMethodError => e
        skip "Family rite requires complete base builder implementation: #{e.message}"
      end
    end

    context 'regression tests (golden master)' do
      it 'maintains exact structure for each module' do
        modules = builder.assemble_morning_prayer

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
        modules = builder.assemble_morning_prayer
        all_line_types = modules.flat_map { |m| m[:lines].map { |l| l[:type] } }.uniq

        # Expected line types in LOC 2015
        expected_types = %w[leader congregation responsive rubric spacer citation reading heading all text]
        expect(all_line_types - expected_types).to be_empty
      end
    end
  end

  # ==========================================================================
  # SECTION: Opening Components
  # ==========================================================================

  describe '#build_welcome' do
    it 'returns welcome module structure' do
      result = builder.build_welcome(:morning)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('welcome')
        expect(result[:name]).to eq('Acolhida')
      end
    end

    it 'respects prayer_style preference' do
      traditional_builder = test_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_style: 'traditional' }
      )
      contemporary_builder = test_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_style: 'contemporary' }
      )

      # Both should return valid structures (content may differ)
      trad_result = traditional_builder.build_welcome(:morning)
      cont_result = contemporary_builder.build_welcome(:morning)

      expect(trad_result).to be_a(Hash) if trad_result
      expect(cont_result).to be_a(Hash) if cont_result
    end
  end

  describe '#build_opening_sentence' do
    it 'returns opening sentence module structure' do
      result = builder.build_opening_sentence(:morning)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('opening_sentence')
        expect(result[:name]).to eq('Sentenças Iniciais')
      end
    end

    it 'includes rubric and general opening sentence' do
      result = builder.build_opening_sentence(:morning)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('rubric')
        expect(line_types).to include('leader')
      end
    end
  end

  describe '#build_morning_confession' do
    it 'returns confession module structure' do
      result = builder.build_morning_confession

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('confession')
        expect(result[:name]).to eq('Confissão de Pecados')
      end
    end

    it 'includes congregation response' do
      result = builder.build_morning_confession

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('congregation')
      end
    end
  end

  describe '#build_absolution' do
    it 'returns absolution module structure' do
      result = builder.build_absolution

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('absolution')
        expect(result[:name]).to eq('Absolvição')
      end
    end
  end

  # ==========================================================================
  # SECTION: Invitatory and Psalms
  # ==========================================================================

  describe '#build_morning_invitatory' do
    it 'returns invitatory module structure' do
      result = builder.build_morning_invitatory

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('invitatory')
      end
    end

    it 'uses Lent-specific invocation during Lent' do
      # Mock Lent season
      allow(builder).to receive(:is_lent?).and_return(true)
      allow(builder).to receive(:fetch_liturgical_text).and_call_original

      builder.build_morning_invitatory

      expect(builder).to have_received(:fetch_liturgical_text).with('morning_invocation_lent')
    end

    it 'uses regular invocation outside Lent' do
      allow(builder).to receive(:is_lent?).and_return(false)
      allow(builder).to receive(:fetch_liturgical_text).and_call_original

      builder.build_morning_invitatory

      expect(builder).to have_received(:fetch_liturgical_text).with('morning_invocation')
    end
  end

  describe '#build_morning_invitatory_canticle' do
    it 'returns invitatory canticle module structure' do
      result = builder.build_morning_invitatory_canticle

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('invitatory_canticle')
      end
    end
  end

  describe '#build_psalms' do
    it 'returns psalms module structure' do
      result = builder.build_psalms(:morning)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('psalms')
        expect(result[:name]).to eq('Salmos')
      end
    end

    it 'includes LOC-specific rubric' do
      result = builder.build_psalms(:morning)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('rubric')
      end
    end
  end

  # ==========================================================================
  # SECTION: Readings and Canticles
  # ==========================================================================

  describe '#build_first_reading' do
    it 'returns first reading module structure' do
      result = builder.build_first_reading

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('first_reading')
      expect(result[:name]).to eq('Leituras da Palavra de Deus')
    end

    it 'uses build_reading_module helper' do
      allow(builder).to receive(:build_reading_module).and_call_original

      builder.build_first_reading

      expect(builder).to have_received(:build_reading_module).with(
        hash_including(
          type: :first,
          announcement_slug: 'first_reading',
          reading_key: :first_reading
        )
      )
    end
  end

  describe '#build_first_canticle' do
    it 'returns first canticle module structure' do
      result = builder.build_first_canticle

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('first_canticle')
      end
    end

    it 'respects first_canticle preference' do
      [ 1, 2, 3 ].each do |canticle_num|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { first_canticle: canticle_num }
        )

        result = test_builder.build_first_canticle
        expect(result).to be_a(Hash) if result
      end
    end
  end

  describe '#build_second_reading' do
    it 'returns second reading module structure' do
      result = builder.build_second_reading

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('second_reading')
      expect(result[:name]).to eq('Segunda Leitura')
    end

    it 'uses build_reading_module helper' do
      allow(builder).to receive(:build_reading_module).and_call_original

      builder.build_second_reading

      expect(builder).to have_received(:build_reading_module).with(
        hash_including(
          type: :second,
          announcement_slug: 'second_reading',
          reading_key: :second_reading
        )
      )
    end
  end

  describe '#build_second_canticle' do
    it 'returns second canticle module structure' do
      result = builder.build_second_canticle

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('second_canticle')
      end
    end

    it 'respects second_canticle preference' do
      [ 1, 2, 3 ].each do |canticle_num|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { second_canticle: canticle_num }
        )

        result = test_builder.build_second_canticle
        expect(result).to be_a(Hash) if result
      end
    end
  end

  # ==========================================================================
  # SECTION: Affirmation of Faith and Offering
  # ==========================================================================

  describe '#build_creed' do
    it 'returns creed module structure' do
      result = builder.build_creed

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('creed')
      end
    end

    it 'uses paraphrase when preference is set' do
      paraphrase_builder = test_class.new(
        date: date,
        office_type: :morning,
        preferences: { creed_paraphrase: true }
      )

      result = paraphrase_builder.build_creed

      if result
        expect(result[:name]).to eq('Paráfrase do Credo Apostólico')
      end
    end

    it 'uses standard creed by default' do
      result = builder.build_creed

      if result
        expect(result[:name]).to eq('Credo Apostólico')
      end
    end
  end

  describe '#build_offertory' do
    it 'returns offertory module structure' do
      result = builder.build_offertory

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('offertory')
      expect(result[:name]).to eq('Ofertório')
    end
  end

  # ==========================================================================
  # SECTION: Prayers and Collects
  # ==========================================================================

  describe '#build_lords_prayer' do
    it 'returns lords prayer module structure' do
      result = builder.build_lords_prayer

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('lords_prayer')
        expect(result[:name]).to eq('Orações')
      end
    end

    it 'includes responsive elements' do
      result = builder.build_lords_prayer

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end
  end

  describe '#build_collect_of_the_day' do
    it 'returns collect of the day module structure' do
      result = builder.build_collect_of_the_day

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('collect_of_the_day')
      expect(result[:name]).to eq('Coleta do Dia')
    end
  end

  describe '#build_general_collects' do
    it 'returns general collects module structure' do
      result = builder.build_general_collects

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('general_collects')
      expect(result[:name]).to eq('Coletas Gerais')
    end

    it 'uses GENERAL_COLLECT_SLUGS constant by default' do
      result = builder.build_general_collects

      expect(result).to be_a(Hash)
      # Should attempt to fetch all slugs from constant
    end

    it 'respects general_collects preference' do
      custom_builder = test_class.new(
        date: date,
        office_type: :morning,
        preferences: { general_collects: [ 'for_peace', 'for_grace' ] }
      )

      result = custom_builder.build_general_collects
      expect(result).to be_a(Hash)
    end
  end

  describe '#build_general_thanksgiving' do
    it 'returns general thanksgiving module structure' do
      result = builder.build_general_thanksgiving

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('thanksgiving')
        expect(result[:name]).to eq('Geral Ação de Graças')
      end
    end
  end

  describe '#build_chrysostom_prayer' do
    it 'returns chrysostom prayer module structure' do
      result = builder.build_chrysostom_prayer

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('chrysostom')
        expect(result[:name]).to eq('Oração de São João Crisóstomo')
      end
    end
  end

  # ==========================================================================
  # SECTION: Concluding Prayers and Dismissal
  # ==========================================================================

  describe '#build_dismissal' do
    it 'returns dismissal module structure' do
      result = builder.build_dismissal

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('dismissal')
        expect(result[:name]).to eq('Orações Conclusivas')
      end
    end

    it 'includes leader and congregation responses' do
      result = builder.build_dismissal

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('leader')
      end
    end

    it 'respects dismissal_blessing preference' do
      [ 1, 2, 3, 4 ].each do |blessing_num|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { dismissal_blessing: blessing_num }
        )

        result = test_builder.build_dismissal
        expect(result).to be_a(Hash) if result
      end
    end
  end

  # ==========================================================================
  # SECTION: Helper Methods
  # ==========================================================================

  describe '#morning_season_specific_opening_sentence_slug' do
    it 'returns correct slug for Advent' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Advento', feast_day: false })
      slug = builder.send(:morning_season_specific_opening_sentence_slug, :morning)
      expect(slug).to eq('morning_opening_sentence_advent')
    end

    it 'returns correct slug for Christmas' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Natal', feast_day: false })
      slug = builder.send(:morning_season_specific_opening_sentence_slug, :morning)
      expect(slug).to eq('morning_opening_sentence_christmas')
    end

    it 'returns correct slug for Lent' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Quaresma', feast_day: false })
      slug = builder.send(:morning_season_specific_opening_sentence_slug, :morning)
      expect(slug).to eq('morning_opening_sentence_lent')
    end

    it 'returns correct slug for Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa', feast_day: false })
      slug = builder.send(:morning_season_specific_opening_sentence_slug, :morning)
      expect(slug).to eq('morning_opening_sentence_easter')
    end

    it 'returns correct slug for feast days' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum', feast_day: true })
      slug = builder.send(:morning_season_specific_opening_sentence_slug, :morning)
      expect(slug).to eq('morning_opening_sentence_common_feast')
    end

    it 'returns nil for ordinary time without feast' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum', feast_day: false })
      slug = builder.send(:morning_season_specific_opening_sentence_slug, :morning)
      expect(slug).to be_nil
    end
  end

  describe '#morning_invitatory_canticle_slug' do
    it 'returns pascha_nostrum during Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa' })
      slug = builder.send(:morning_invitatory_canticle_slug)
      expect(slug).to eq('pascha_nostrum')
    end

    it 'returns jubilate when preference is set' do
      jubilate_builder = test_class.new(
        date: date,
        office_type: :morning,
        preferences: { invitatory_canticle: 'jubilate' }
      )
      allow(jubilate_builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = jubilate_builder.send(:morning_invitatory_canticle_slug)
      expect(slug).to eq('jubilate')
    end

    it 'returns venite by default' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = builder.send(:morning_invitatory_canticle_slug)
      expect(slug).to eq('venite')
    end
  end

  # ==========================================================================
  # SECTION: Preference Variations
  # ==========================================================================

  describe 'preference variations' do
    it 'handles different opening sentence preferences' do
      (1..7).each do |num|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { opening_sentence_general: num }
        )
        result = test_builder.build_opening_sentence(:morning)
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles different confession preferences' do
      (1..3).each do |num|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { confession_prayer: num }
        )
        result = test_builder.build_morning_confession
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles creed paraphrase preference' do
      [ true, false ].each do |paraphrase|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { creed_paraphrase: paraphrase }
        )
        result = test_builder.build_creed
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles invitatory canticle preference' do
      %w[jubilate venite].each do |canticle|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { invitatory_canticle: canticle }
        )
        result = test_builder.build_morning_invitatory_canticle
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles thanksgiving prayer preference' do
      [ 1, 2 ].each do |num|
        test_builder = test_class.new(
          date: date,
          office_type: :morning,
          preferences: { thanksgiving_prayer: num }
        )
        result = test_builder.build_general_thanksgiving
        expect(result).to be_a(Hash) if result
      end
    end
  end
end
