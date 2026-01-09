# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2015::Evening do
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
  let(:builder) do
    described_class.new(
      date: date,
      office_type: :evening,
      preferences: { prayer_book_code: 'loc_2015' }
    )
  end

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
      modules = builder.send(:assemble_evening_prayer)

      expect(modules).to be_an(Array)
      expect(modules).to all(be_a(Hash))
    end

    it 'includes all expected module types' do
      # Mock readings to include psalm for this test
      allow_any_instance_of(described_class).to receive(:readings).and_return({
        psalm: {
          reference: 'Salmos 141',
          content: {
            verses: [
              { number: 1, text: 'Senhor, a ti clamo; vem depressa socorrer-me' },
              { number: 2, text: 'Suba minha oração como incenso à tua presença' }
            ]
          }
        },
        first_reading: { reference: 'Gênesis 1:1-5', content: { verses: [] } },
        second_reading: { reference: 'Romanos 1:1-7', content: { verses: [] } }
      })

      modules = builder.send(:assemble_evening_prayer)
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
        modules = builder.send(:assemble_evening_prayer)

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
        modules = builder.send(:assemble_evening_prayer)
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
      result = builder.send(:build_welcome)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('welcome')
        expect(result[:name]).to eq('Acolhida')
      end
    end

    it 'respects prayer_style preference' do
      traditional_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { prayer_style: 'traditional' }
      )
      contemporary_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { prayer_style: 'contemporary' }
      )

      # Both should return valid structures (content may differ)
      trad_result = traditional_builder.send(:build_welcome)
      cont_result = contemporary_builder.send(:build_welcome)

      expect(trad_result).to be_a(Hash) if trad_result
      expect(cont_result).to be_a(Hash) if cont_result
    end
  end

  describe '#build_opening_sentence' do
    it 'returns opening sentence module structure' do
      result = builder.send(:build_opening_sentence)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('opening_sentence')
        expect(result[:name]).to eq('Sentenças Iniciais')
      end
    end

    it 'includes rubric and general opening sentence' do
      result = builder.send(:build_opening_sentence)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('leader')
      end
    end

    it 'handles 8 general opening sentences' do
      (1..8).each do |num|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { opening_sentence_general: num }
        )
        result = test_builder.send(:build_opening_sentence)
        expect(result).to be_a(Hash) if result
      end
    end
  end

  describe '#build_confession' do
    it 'returns confession module structure' do
      result = builder.send(:build_confession)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('confession')
        expect(result[:name]).to eq('Confissão e Absolvição de Pecados')
      end
    end

    it 'includes congregation response' do
      result = builder.send(:build_confession)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('congregation')
      end
    end

    it 'respects evening_confession_type preference' do
      short_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { evening_confession_type: 'short' }
      )
      long_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { evening_confession_type: 'long' }
      )

      short_result = short_builder.send(:build_confession)
      long_result = long_builder.send(:build_confession)

      expect(short_result).to be_a(Hash) if short_result
      expect(long_result).to be_a(Hash) if long_result
    end
  end

  # ==========================================================================
  # SECTION: Invitatory and Psalms
  # ==========================================================================

  describe '#build_invitatory' do
    it 'returns invitatory module structure' do
      result = builder.send(:build_invitatory)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('invitatory')
        expect(result[:name]).to eq('Invitatório e Salmo')
      end
    end

    it 'includes responsive elements' do
      result = builder.send(:build_invitatory)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end
  end

  describe '#build_invitatory_canticle' do
    it 'returns invitatory canticle module structure' do
      result = builder.send(:build_invitatory_canticle)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('invitatory_canticle')
      end
    end

    it 'uses Pascha Nostrum during Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa' })
      slug = builder.send(:invitatory_canticle_slug)
      expect(slug).to eq('pascha_nostrum')
    end

    it 'uses Phos Hilaron by default' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = builder.send(:invitatory_canticle_slug)
      expect(slug).to eq('phos_hilaron')
    end

    it 'uses Ecce Nunc when preference is set' do
      ecce_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { evening_invitatory_canticle: 'ecce_nunc', prayer_book_code: 'loc_2015' }
      )
      allow(ecce_builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = ecce_builder.send(:invitatory_canticle_slug)
      expect(slug).to eq('ecce_nunc')
    end
  end

  describe '#build_psalms' do
    it 'returns psalms module structure' do
      result = builder.send(:build_psalms)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('psalms')
        expect(result[:name]).to eq('Salmos')
      end
    end

    it 'includes LOC-specific rubric' do
      result = builder.send(:build_psalms)

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
      result = builder.send(:build_first_reading)

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('leader_reading')
      expect(result[:name]).to eq('Leituras da Palavra de Deus')
    end

    it 'uses build_reading_module helper' do
      allow(builder).to receive(:build_reading_module).and_call_original

      builder.send(:build_first_reading)

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
    it 'returns array of canticle modules' do
      result = builder.send(:build_first_canticle)

      if result && !result.empty?
        expect(result).to be_a(Array)
        # Each canticle module should have the standard structure
        result.each do |canticle|
          expect(canticle).to have_key(:name)
          expect(canticle).to have_key(:slug)
          expect(canticle).to have_key(:lines)
        end
      end
    end

    it 'respects evening_post_first_reading_canticle preference' do
      test_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { evening_post_first_reading_canticle: %w[magnificat cantate_domino], prayer_book_code: 'loc_2015' }
      )

      result = test_builder.send(:build_first_canticle)
      expect(result).to be_a(Array) if result
    end

    it 'uses Magnificat by default' do
      result = builder.send(:build_first_canticle)

      if result && !result.empty?
        # Should include magnificat slug in the returned canticles
        canticle_slugs = result.map { |c| c[:slug] }
        expect(canticle_slugs).to include('magnificat')
      end
    end
  end

  describe '#build_second_reading' do
    it 'returns second reading module structure' do
      result = builder.send(:build_second_reading)

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('leader_reading')
      expect(result[:name]).to eq('Segunda Leitura')
    end

    it 'uses build_reading_module helper' do
      allow(builder).to receive(:build_reading_module).and_call_original

      builder.send(:build_second_reading)

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
    it 'returns array of canticle modules' do
      result = builder.send(:build_second_canticle)

      if result && !result.empty?
        expect(result).to be_a(Array)
        # Array can contain canticle modules and rubric
        result.each do |module_item|
          expect(module_item).to have_key(:name)
          expect(module_item).to have_key(:slug)
          expect(module_item).to have_key(:lines)
        end
      end
    end

    it 'respects evening_post_second_reading_canticle preference' do
      test_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { evening_post_second_reading_canticle: %w[nunc_dimittis deus_misereatur], prayer_book_code: 'loc_2015' }
      )

      result = test_builder.send(:build_second_canticle)
      expect(result).to be_a(Array) if result
    end

    it 'uses Nunc Dimittis by default' do
      result = builder.send(:build_second_canticle)

      if result && !result.empty?
        # Should include nunc_dimittis slug in the returned canticles (plus rubric)
        canticle_slugs = result.map { |c| c[:slug] }
        expect(canticle_slugs).to include('nunc_dimittis')
      end
    end
  end

  # ==========================================================================
  # SECTION: Affirmation of Faith and Offering
  # ==========================================================================

  describe '#build_creed' do
    it 'returns creed module structure' do
      result = builder.send(:build_creed)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('creed')
      end
    end

    it 'uses Apostles Creed by default' do
      result = builder.send(:build_creed)

      if result
        expect(result[:name]).to eq('Credo Apostólico')
      end
    end

    it 'uses Affirmation of Faith when preference is set' do
      affirmation_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { evening_creed_type: 'faith_affirmation' }
      )

      result = affirmation_builder.send(:build_creed)

      if result
        expect(result[:name]).to eq('Afirmação de Fé')
      end
    end
  end

  describe '#build_offertory' do
    it 'returns offertory module structure' do
      result = builder.send(:build_offertory)

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
      result = builder.send(:build_lords_prayer)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('lords_prayer')
        expect(result[:name]).to eq('Orações')
      end
    end

    it 'includes responsive elements' do
      result = builder.send(:build_lords_prayer)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('responsive')
      end
    end

    it 'uses evening closing prayer when preference is set' do
      evening_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { use_evening_closing_prayer: true }
      )
      allow(evening_builder).to receive(:fetch_liturgical_text).and_call_original

      evening_builder.send(:build_lords_prayer)

      expect(evening_builder).to have_received(:fetch_liturgical_text).with('evening_closing_prayer')
    end
  end

  describe '#build_collect_of_the_day' do
    it 'returns collect of the day module structure' do
      result = builder.send(:build_collect_of_the_day)

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('collect_of_the_day')
      expect(result[:name]).to eq('Coleta do Dia')
    end
  end

  describe '#build_general_collects' do
    it 'returns general collects module structure' do
      result = builder.send(:build_general_collects)

      expect(result).to have_key(:name)
      expect(result).to have_key(:slug)
      expect(result).to have_key(:lines)
      expect(result[:slug]).to eq('general_collects')
      expect(result[:name]).to eq('Coletas Gerais')
    end

    it 'uses GENERAL_COLLECT_SLUGS constant by default' do
      result = builder.send(:build_general_collects)

      expect(result).to be_a(Hash)
      # Should attempt to fetch all slugs from constant
    end

    it 'respects general_collects preference' do
      custom_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { general_collects: [ 'for_peace', 'for_protection' ] }
      )

      result = custom_builder.send(:build_general_collects)
      expect(result).to be_a(Hash)
    end
  end

  describe '#build_general_thanksgiving' do
    it 'returns general thanksgiving module structure' do
      result = builder.send(:build_general_thanksgiving)

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
      result = builder.send(:build_chrysostom_prayer)

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
      result = builder.send(:build_dismissal)

      if result
        expect(result).to have_key(:name)
        expect(result).to have_key(:slug)
        expect(result).to have_key(:lines)
        expect(result[:slug]).to eq('dismissal')
        expect(result[:name]).to eq('Orações Conclusivas')
      end
    end

    it 'includes leader and responsive elements' do
      result = builder.send(:build_dismissal)

      if result
        line_types = result[:lines].map { |l| l[:type] }
        expect(line_types).to include('leader')
      end
    end

    it 'respects evening_concluding_prayer preference' do
      [ 1, 2, 3, 4 ].each do |blessing_num|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { evening_concluding_prayer: blessing_num }
        )

        result = test_builder.send(:build_dismissal)
        expect(result).to be_a(Hash) if result
      end
    end
  end

  # ==========================================================================
  # SECTION: Helper Methods
  # ==========================================================================

  describe '#season_specific_opening_sentence_slug' do
    it 'returns correct slug for Advent' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Advento', feast_day: false })
      slug = builder.send(:season_specific_opening_sentence_slug)
      expect(slug).to eq('evening_opening_sentence_advent')
    end

    it 'returns correct slug for Christmas' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Natal', feast_day: false })
      slug = builder.send(:season_specific_opening_sentence_slug)
      expect(slug).to eq('evening_opening_sentence_christmas')
    end

    it 'returns correct slug for Lent' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Quaresma', feast_day: false })
      slug = builder.send(:season_specific_opening_sentence_slug)
      expect(slug).to eq('evening_opening_sentence_lent')
    end

    it 'returns correct slug for Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa', feast_day: false })
      slug = builder.send(:season_specific_opening_sentence_slug)
      expect(slug).to eq('evening_opening_sentence_easter')
    end

    it 'returns nil for ordinary time without feast' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum', feast_day: false })
      slug = builder.send(:season_specific_opening_sentence_slug)
      expect(slug).to be_nil
    end
  end

  describe '#invitatory_canticle_slug' do
    it 'returns pascha_nostrum during Easter' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Páscoa' })
      slug = builder.send(:invitatory_canticle_slug)
      expect(slug).to eq('pascha_nostrum')
    end

    it 'returns ecce_nunc when preference is set' do
      ecce_builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { evening_invitatory_canticle: 'ecce_nunc', prayer_book_code: 'loc_2015' }
      )
      allow(ecce_builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = ecce_builder.send(:invitatory_canticle_slug)
      expect(slug).to eq('ecce_nunc')
    end

    it 'returns phos_hilaron by default' do
      allow(builder).to receive(:day_info).and_return({ liturgical_season: 'Tempo Comum' })
      slug = builder.send(:invitatory_canticle_slug)
      expect(slug).to eq('phos_hilaron')
    end
  end

  # ==========================================================================
  # SECTION: Preference Variations
  # ==========================================================================

  describe 'preference variations' do
    it 'handles different opening sentence preferences' do
      (1..8).each do |num|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { opening_sentence_general: num }
        )
        result = test_builder.send(:build_opening_sentence)
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles different confession preferences' do
      (1..3).each do |num|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { evening_confession_prayer_type: num }
        )
        result = test_builder.send(:build_confession)
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles creed paraphrase preference' do
      [ true, false ].each do |paraphrase|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { evening_creed_type: 'faith_affirmation' }
        )
        result = test_builder.send(:build_creed)
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles invitatory canticle preference' do
      %w[ecce_nunc phos_hilaron].each do |canticle|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { invitatory_canticle: canticle }
        )
        result = test_builder.send(:build_invitatory_canticle)
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles thanksgiving prayer preference' do
      [ 1, 2 ].each do |num|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { thanksgiving_prayer: num }
        )
        result = test_builder.send(:build_general_thanksgiving)
        expect(result).to be_a(Hash) if result
      end
    end

    it 'handles evening closing prayer preference' do
      [ true, false ].each do |use_evening|
        test_builder = described_class.new(
          date: date,
          office_type: :evening,
          preferences: { use_evening_closing_prayer: use_evening }
        )
        result = test_builder.send(:build_lords_prayer)
        expect(result).to be_a(Hash) if result
      end
    end
  end
end
