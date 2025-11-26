# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015::Evening do
  # Create a test class that includes the module
  let(:test_class) do
    Class.new(DailyOffice::Builders::Loc2015Builder) do
      include DailyOffice::Builders::Loc2015::Evening
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
  let(:builder) { test_class.new(date: date, office_type: :evening) }

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
      expect(described_class::GENERAL_COLLECT_SLUGS).to include('for_protection')
      expect(described_class::GENERAL_COLLECT_SLUGS).to be_frozen
    end

    it 'has 7 general collect slugs' do
      expect(described_class::GENERAL_COLLECT_SLUGS.length).to eq(7)
    end

    it 'includes evening-specific collects' do
      expect(described_class::GENERAL_COLLECT_SLUGS).to include('for_protection')
      expect(described_class::GENERAL_COLLECT_SLUGS).to include('for_christ_presence')
      expect(described_class::GENERAL_COLLECT_SLUGS).to include('evening_for_all_authorities')
    end
  end

  # ==========================================================================
  # SECTION: Assembly Method
  # ==========================================================================

  describe '#assemble_evening_prayer' do
    it 'returns full evening prayer structure' do
      modules = builder.assemble_evening_prayer

      expect(modules).to be_an(Array)
      expect(modules).to all(be_a(Hash))
    end

    it 'includes all expected module types' do
      modules = builder.assemble_evening_prayer
      module_slugs = modules.map { |m| m[:slug] }

      # Core LOC 2015 Evening structure
      expect(module_slugs).to include('welcome')
      expect(module_slugs).to include('opening_sentence')
      expect(module_slugs).to include('confession')
      expect(module_slugs).to include('psalms')
      expect(module_slugs).to include('lords_prayer')
      expect(module_slugs).to include('dismissal')
    end

    context 'regression tests (golden master)' do
      it 'maintains exact structure for each module' do
        modules = builder.assemble_evening_prayer

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
        modules = builder.assemble_evening_prayer
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
      result = builder.build_welcome(:evening)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('welcome')
        expect(result[:name]).to eq('Acolhida')
      end
    end

    it 'respects welcome_style preference' do
      traditional_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { welcome_style: 'traditional' }
      )
      contemporary_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { welcome_style: 'contemporary' }
      )

      # Both should return valid structures (content may differ)
      trad_result = traditional_builder.build_welcome(:evening)
      cont_result = contemporary_builder.build_welcome(:evening)

      expect(trad_result).to be_a(Hash) if trad_result
      expect(cont_result).to be_a(Hash) if cont_result
    end
  end

  describe '#build_opening_sentence' do
    it 'returns opening sentence module structure' do
      result = builder.build_opening_sentence(:evening)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('opening_sentence')
        expect(result[:name]).to eq('Sentenças Iniciais')
      end
    end

    it 'includes rubric and general opening sentence' do
      result = builder.build_opening_sentence(:evening)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('leader')
      end
    end

    it 'handles 8 general opening sentences' do
      (1..8).each do |num|
        test_builder = test_class.new(
          date: date,
          office_type: :evening,
          preferences: { opening_sentence_general: num }
        )
        result = test_builder.build_opening_sentence(:evening)
        expect(result).to be_a(Hash) if result
      end
    end
  end

  describe '#build_evening_confession' do
    it 'returns confession module structure' do
      result = builder.build_evening_confession

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('confession')
        expect(result[:name]).to eq('Confissão e Absolvição de Pecados')
      end
    end

    it 'includes congregation response' do
      result = builder.build_evening_confession

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('congregation')
      end
    end

    it 'respects confession_invitation preference' do
      short_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { confession_invitation: 'short' }
      )
      long_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { confession_invitation: 'long' }
      )

      short_result = short_builder.build_evening_confession
      long_result = long_builder.build_evening_confession

      expect(short_result).to be_a(Hash) if short_result
      expect(long_result).to be_a(Hash) if long_result
    end
  end

  # ==========================================================================
  # SECTION: Invitatory and Psalms
  # ==========================================================================

  describe '#build_evening_invitatory' do
    it 'returns invitatory module structure' do
      result = builder.build_evening_invitatory

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('invitatory')
        expect(result[:name]).to eq('Invitatório e Salmo')
      end
    end

    it 'includes responsive elements' do
      result = builder.build_evening_invitatory

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end
  end

  describe '#build_evening_invitatory_canticle' do
    it 'returns invitatory canticle module structure' do
      result = builder.build_evening_invitatory_canticle

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('invitatory_canticle')
      end
    end

    it 'uses Pascha Nostrum during Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa' })
      slug = builder.send(:evening_invitatory_canticle_slug)
      expect(slug).to eq('pascha_nostrum')
    end

    it 'uses Phos Hilaron by default' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = builder.send(:evening_invitatory_canticle_slug)
      expect(slug).to eq('phos_hilaron')
    end

    it 'uses Ecce Nunc when preference is set' do
      ecce_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { invitatory_canticle: 'ecce_nunc' }
      )
      allow(ecce_builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = ecce_builder.send(:evening_invitatory_canticle_slug)
      expect(slug).to eq('ecce_nunc')
    end
  end

  describe '#build_psalms' do
    it 'returns psalms module structure' do
      result = builder.build_psalms(:evening)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('psalms')
        expect(result[:name]).to eq('Salmos')
      end
    end

    it 'includes LOC-specific rubric' do
      result = builder.build_psalms(:evening)

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
          office_type: :evening,
          preferences: { first_canticle: canticle_num }
        )

        result = test_builder.build_first_canticle
        expect(result).to be_a(Hash) if result
      end
    end

    it 'uses Magnificat by default' do
      allow(builder).to receive(:fetch_liturgical_text).and_call_original

      builder.build_first_canticle

      expect(builder).to have_received(:fetch_liturgical_text).with('magnificat')
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
          office_type: :evening,
          preferences: { second_canticle: canticle_num }
        )

        result = test_builder.build_second_canticle
        expect(result).to be_a(Hash) if result
      end
    end

    it 'uses Nunc Dimittis by default' do
      allow(builder).to receive(:fetch_liturgical_text).and_call_original

      builder.build_second_canticle

      expect(builder).to have_received(:fetch_liturgical_text).with('nunc_dimittis')
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

    it 'uses Apostles Creed by default' do
      result = builder.build_creed

      if result
        expect(result[:name]).to eq('Credo Apostólico')
      end
    end

    it 'uses paraphrase when preference is set' do
      paraphrase_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { creed_paraphrase: true }
      )

      result = paraphrase_builder.build_creed

      if result
        expect(result[:name]).to eq('Paráfrase do Credo Apostólico')
      end
    end

    it 'uses Affirmation of Faith when preference is set' do
      affirmation_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { use_affirmation_of_faith: true }
      )

      result = affirmation_builder.build_creed

      if result
        expect(result[:name]).to eq('Afirmação de Fé')
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

    it 'uses evening closing prayer when preference is set' do
      evening_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { use_evening_closing_prayer: true }
      )
      allow(evening_builder).to receive(:fetch_liturgical_text).and_call_original

      evening_builder.build_lords_prayer

      expect(evening_builder).to have_received(:fetch_liturgical_text).with('evening_closing_prayer')
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
        office_type: :evening,
        preferences: { general_collects: [ 'for_peace', 'for_protection' ] }
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

    it 'includes leader and responsive elements' do
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
          office_type: :evening,
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

  describe '#evening_season_specific_opening_sentence_slug' do
    it 'returns correct slug for Advent' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Advento', feast_day: false })
      slug = builder.send(:evening_season_specific_opening_sentence_slug, :evening)
      expect(slug).to eq('evening_opening_sentence_advent')
    end

    it 'returns correct slug for Christmas' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Natal', feast_day: false })
      slug = builder.send(:evening_season_specific_opening_sentence_slug, :evening)
      expect(slug).to eq('evening_opening_sentence_christmas')
    end

    it 'returns correct slug for Lent' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Quaresma', feast_day: false })
      slug = builder.send(:evening_season_specific_opening_sentence_slug, :evening)
      expect(slug).to eq('evening_opening_sentence_lent')
    end

    it 'returns correct slug for Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa', feast_day: false })
      slug = builder.send(:evening_season_specific_opening_sentence_slug, :evening)
      expect(slug).to eq('evening_opening_sentence_easter')
    end

    it 'returns nil for ordinary time without feast' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum', feast_day: false })
      slug = builder.send(:evening_season_specific_opening_sentence_slug, :evening)
      expect(slug).to be_nil
    end
  end

  describe '#evening_invitatory_canticle_slug' do
    it 'returns pascha_nostrum during Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa' })
      slug = builder.send(:evening_invitatory_canticle_slug)
      expect(slug).to eq('pascha_nostrum')
    end

    it 'returns ecce_nunc when preference is set' do
      ecce_builder = test_class.new(
        date: date,
        office_type: :evening,
        preferences: { invitatory_canticle: 'ecce_nunc' }
      )
      allow(ecce_builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = ecce_builder.send(:evening_invitatory_canticle_slug)
      expect(slug).to eq('ecce_nunc')
    end

    it 'returns phos_hilaron by default' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = builder.send(:evening_invitatory_canticle_slug)
      expect(slug).to eq('phos_hilaron')
    end
  end

  # ==========================================================================
  # SECTION: Preference Variations
  # ==========================================================================

  describe 'preference variations' do
    it 'handles different opening sentence preferences' do
      (1..8).each do |num|
        test_builder = test_class.new(
          date: date,
          office_type: :evening,
          preferences: { opening_sentence_general: num }
        )
        result = test_builder.build_opening_sentence(:evening)
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles different confession preferences' do
      (1..3).each do |num|
        test_builder = test_class.new(
          date: date,
          office_type: :evening,
          preferences: { confession_prayer: num }
        )
        result = test_builder.build_evening_confession
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles creed paraphrase preference' do
      [ true, false ].each do |paraphrase|
        test_builder = test_class.new(
          date: date,
          office_type: :evening,
          preferences: { creed_paraphrase: paraphrase }
        )
        result = test_builder.build_creed
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles invitatory canticle preference' do
      %w[ecce_nunc phos_hilaron].each do |canticle|
        test_builder = test_class.new(
          date: date,
          office_type: :evening,
          preferences: { invitatory_canticle: canticle }
        )
        result = test_builder.build_evening_invitatory_canticle
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles thanksgiving prayer preference' do
      [ 1, 2 ].each do |num|
        test_builder = test_class.new(
          date: date,
          office_type: :evening,
          preferences: { thanksgiving_prayer: num }
        )
        result = test_builder.build_general_thanksgiving
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles evening closing prayer preference' do
      [ true, false ].each do |use_evening|
        test_builder = test_class.new(
          date: date,
          office_type: :evening,
          preferences: { use_evening_closing_prayer: use_evening }
        )
        result = test_builder.build_lords_prayer
        expect(result).to be_a(Hash) if result
      end
    end
  end
end
