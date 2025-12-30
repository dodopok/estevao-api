# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Morning Prayer Rite Four (Oração Matutina IV - BCP 1928)
      #
      # This builder follows the traditional structure from the
      # Book of Common Prayer 1928, adapted for the
      # Livro de Oração Comum Brasileiro 2008.
      #
      # Structure:
      # 1. Sentença de Abertura (Opening Sentence - seasonal)
      # 2. Exortação à Confissão (Exhortation - long or short)
      # 3. Confissão Geral (General Confession)
      # 4. Absolvição (Absolution)
      # 5. Oração Dominical (Lord's Prayer)
      # 6. Versículos e Responsos (Versicles and Responses)
      # 7. Venite (with seasonal antiphons)
      # 8. Salmodia (Psalms)
      # 9. Primeira Leitura (First Reading)
      # 10. Te Deum / Benedictus es / Benedicite (Canticle after first reading)
      # 11. Segunda Leitura (Second Reading)
      # 12. Benedictus / Jubilate Deo (Canticle after second reading)
      # 13. Credo dos Apóstolos / Niceno (Creed)
      # 14. Súplicas (Suffrages)
      # 15. Coleta do Dia (Collect of the Day)
      # 16. Coleta pela Paz (Collect for Peace)
      # 17. Coleta pela Graça (Collect for Grace)
      # 18. Orações Opcionais (Optional Prayers - President, Clergy, Humanity, Thanksgiving, Chrysostom)
      # 19. Graça (The Grace - conclusion)
      #
      class MorningRiteFour < Base
        private

        def assemble_office
          assemble_morning_prayer
        end

        def assemble_morning_prayer
          [
            build_opening_sentence,
            build_exhortation,
            build_confession,
            build_absolution,
            build_venite,
            build_psalms,
            build_first_reading,
            build_canticle_after_first_reading,
            build_second_reading,
            build_canticle_after_second_reading,
            build_collect_of_the_day,
            build_optional_prayers,
            build_conclusion
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening Sentence
        # ============================================================================

        # SENTENÇA DE ABERTURA - Opening Scripture Sentence
        def build_opening_sentence
          lines = []

          # Opening rubric
          rubric = fetch_liturgical_text("morning_4_opening_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Get seasonal sentence or resolved from preferences
          sentence_slug = resolve_opening_sentence_slug
          sentence = fetch_liturgical_text(sentence_slug)

          if sentence
            lines << line_item(sentence.content + " " + sentence.reference, type: "leader", slug: sentence.slug)
          end

          {
            name: "Sentença de Abertura",
            slug: "opening_sentence",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Exhortation and Confession
        # ============================================================================

        # EXORTAÇÃO À CONFISSÃO - Exhortation to Confession
        def build_exhortation
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("morning_4_exhortation_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve confession type (long or short)
          confession_type = resolve_confession_type

          case confession_type
          when :long
            exhortation = fetch_liturgical_text("morning_4_exhortation_long")
            if exhortation
              lines << line_item(exhortation.content, type: "leader", slug: exhortation.slug)
            end
          when :short
            exhortation = fetch_liturgical_text("morning_4_exhortation_short")
            if exhortation
              lines << line_item(exhortation.content, type: "leader", slug: exhortation.slug)
            end
          end

          {
            name: "Exortação à Confissão",
            slug: "exhortation",
            lines: lines
          }
        end

        # CONFISSÃO GERAL - General Confession
        def build_confession
          lines = []

          # Confession rubric
          rubric = fetch_liturgical_text("morning_4_confession_rubric")
          if rubric
            if rubric.title.present?
              lines << line_item(rubric.title, type: "heading")
            end
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer
          confession = fetch_liturgical_text("morning_4_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
          end

          {
            name: "Confissão Geral",
            slug: "confession",
            lines: lines
          }
        end

        # DECLARAÇÃO DE ABSOLVIÇÃO - Absolution
        def build_absolution
          lines = []

          # Absolution rubric
          rubric = fetch_liturgical_text("morning_4_absolution_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution
          absolution = fetch_liturgical_text("morning_4_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("morning_4_lords_prayer_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("morning_4_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("morning_4_versicles_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Versicle 1: Abre, ó Senhor...
          versicle_1_minister = fetch_liturgical_text("morning_4_versicle_1_minister")
          if versicle_1_minister
            lines << line_item(versicle_1_minister.content, type: "leader", slug: versicle_1_minister.slug)
          end

          versicle_1_all = fetch_liturgical_text("morning_4_versicle_1_all")
          if versicle_1_all
            lines << line_item(versicle_1_all.content, type: "congregation", slug: versicle_1_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric 2
          rubric_2 = fetch_liturgical_text("morning_4_versicles_rubric_2")
          if rubric_2
            lines << line_item(rubric_2.content, type: "rubric", slug: rubric_2.slug)
            lines << line_item("", type: "spacer")
          end

          # Versicle 2: Glória ao Pai...
          versicle_2_minister = fetch_liturgical_text("morning_4_versicle_2_minister")
          if versicle_2_minister
            lines << line_item(versicle_2_minister.content, type: "leader", slug: versicle_2_minister.slug)
          end

          versicle_2_all = fetch_liturgical_text("morning_4_versicle_2_all")
          if versicle_2_all
            lines << line_item(versicle_2_all.content, type: "congregation", slug: versicle_2_all.slug)
          end

          # Versicle 3: Louvai ao Senhor...
          versicle_3_minister = fetch_liturgical_text("morning_4_versicle_3_minister")
          if versicle_3_minister
            lines << line_item(versicle_3_minister.content, type: "leader", slug: versicle_3_minister.slug)
          end

          versicle_3_all = fetch_liturgical_text("morning_4_versicle_3_all")
          if versicle_3_all
            lines << line_item(versicle_3_all.content, type: "congregation", slug: versicle_3_all.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("morning_4_venite_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Antiphon rubric
          antiphon_rubric = fetch_liturgical_text("morning_4_venite_antiphon_rubric")
          if antiphon_rubric
            lines << line_item(antiphon_rubric.content, type: "rubric", slug: antiphon_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Get seasonal antiphon
          antiphon_slug = resolve_venite_antiphon_slug
          antiphon = fetch_liturgical_text(antiphon_slug)
          if antiphon
            lines << line_item(antiphon.content, type: "antiphon", slug: antiphon.slug)
            lines << line_item("", type: "spacer")
          end

          {
            name: "Declaração de Absolvição ou Remissão de Pecados",
            slug: "absolution",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Venite
        # ============================================================================

        # VENITE - with seasonal antiphons
        def build_venite
          lines = []
          # Venite text
          venite = fetch_liturgical_text("morning_4_venite")
          if venite
            if venite.title.present?
              lines << line_item(venite.title, type: "heading")
            end
            lines << line_item(venite.content, slug: venite.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("morning_4_gloria_patri_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_4_gloria_patri_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Venite",
            slug: "venite",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Psalms
        # ============================================================================

        # SALMODIA - Psalms
        def build_psalms
          psalm_ref = readings[:psalm]
          return nil unless psalm_ref&.dig(:reference)

          lines = []

          # Gloria Patri rubric
          gloria_rubric = fetch_liturgical_text("morning_4_venite_gloria_rubric")
          if gloria_rubric
            lines << line_item(gloria_rubric.content, type: "rubric", slug: gloria_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Add psalm reference as heading
          lines << line_item(psalm_ref[:reference], type: "heading")
          lines << line_item("", type: "spacer")

          # Add psalm text from Bible (if available in readings)
          if psalm_ref[:content]
            lines.concat(format_bible_content(psalm_ref[:content]))
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("morning_4_gloria_patri_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_4_gloria_patri_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Salmodia",
            slug: "psalms",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Scripture Readings
        # ============================================================================

        # PRIMEIRA LEITURA - First Reading
        def build_first_reading
          build_reading_module(
            type: :first,
            announcement_slug: "morning_4_reading_introduction",
            rubric_slugs: {
              pre: "morning_4_first_reading_rubric",
              post: "",
              response: "",
              end: "morning_4_canticle_after_first_reading_rubric"
            },
            reading_key: :first_reading,
            module_name: "Primeira Leitura"
          )
        end

        # CÂNTICO PÓS PRIMEIRA LEITURA - Canticle after First Reading (Te Deum, Benedictus es, or Benedicite)
        def build_canticle_after_first_reading
          lines = []

          canticle_name = "Cântico"

          # Resolve canticle from preferences
          canticle_type = resolve_canticle_after_first_reading

          case canticle_type
          when :te_deum
            canticle_name = build_te_deum_canticle(lines)
          when :benedictus_es_domine
            canticle_name = build_benedictus_es_canticle(lines)
          when :benedicite_omnia_opera_domini
            canticle_name = build_benedicite_canticle(lines)
          when :all
            canticle_name = build_te_deum_canticle(lines)
            lines << line_item("", type: "spacer")
            build_benedictus_es_canticle(lines)
            lines << line_item("", type: "spacer")
            build_benedicite_canticle(lines)
          else
            canticle_name = build_te_deum_canticle(lines)
          end

          {
            name: canticle_name,
            slug: "canticle_after_first_reading",
            lines: lines
          }
        end

        # SEGUNDA LEITURA - Second Reading
        def build_second_reading
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("morning_4_second_reading_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          if readings[:second_reading]
            lines << line_item(readings[:second_reading][:reference], type: "heading")
            lines << line_item("", type: "spacer")

            if readings[:second_reading][:content]
              lines.concat(format_bible_content(readings[:second_reading][:content]))
              lines << line_item("", type: "spacer")
            end
          end

          {
            name: "Segunda Leitura",
            slug: "second_reading",
            lines: lines
          }
        end

        # CÂNTICO PÓS SEGUNDA LEITURA - Canticle after Second Reading (Benedictus or Jubilate Deo)
        def build_canticle_after_second_reading
          lines = []
          canticle_name = "Cântico"

          # Resolve canticle from preferences
          canticle_type = resolve_canticle_after_second_reading

          case canticle_type
          when :benedictur, :benedictus
            canticle_name = build_benedictus_canticle(lines)
          when :jubilate_deo
            canticle_name = build_jubilate_canticle(lines)
          when :all
            canticle_name = build_benedictus_canticle(lines)
            lines << line_item("", type: "spacer")
            build_jubilate_canticle(lines)
          else
            canticle_name = build_benedictus_canticle(lines)
          end

          # Rubric
          rubric = fetch_liturgical_text("morning_4_creed_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          creed_name = "Credo dos Apóstolos"

          # Resolve creed from preferences
          creed_type = resolve_creed_type

          case creed_type
          when :apostolic
            creed = fetch_liturgical_text("morning_4_creed_all")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          when :nicene
            # Nicene rubric
            nicene_rubric = fetch_liturgical_text("morning_4_nicene_creed_rubric")
            if nicene_rubric
              lines << line_item(nicene_rubric.content, type: "rubric", slug: nicene_rubric.slug)
              lines << line_item("", type: "spacer")
            end

            creed = fetch_liturgical_text("morning_4_nicene_creed_all")
            if creed
              if creed.title.present?
                lines << line_item(creed.title, type: "heading")
              end
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
              creed_name = "Credo Niceno"
            end
          when :all
            # Apostles' Creed
            creed = fetch_liturgical_text("morning_4_creed_all")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
              lines << line_item("", type: "spacer")
            end

            # Nicene Creed
            nicene_rubric = fetch_liturgical_text("morning_4_nicene_creed_rubric")
            if nicene_rubric
              lines << line_item(nicene_rubric.content, type: "rubric", slug: nicene_rubric.slug)
              lines << line_item("", type: "spacer")
            end

            nicene_creed = fetch_liturgical_text("morning_4_nicene_creed_all")
            if nicene_creed
              lines << line_item(nicene_creed.content, type: "congregation", slug: nicene_creed.slug)
            end
          else
            creed = fetch_liturgical_text("morning_4_creed_all")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          end

          # Suffrages rubric
          rubric = fetch_liturgical_text("morning_4_suffrages_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Suffrage 1: O Senhor seja convosco...
          suffrage_1_minister = fetch_liturgical_text("morning_4_suffrage_1_minister")
          if suffrage_1_minister
            lines << line_item(suffrage_1_minister.content, type: "leader", slug: suffrage_1_minister.slug)
          end

          suffrage_1_all = fetch_liturgical_text("morning_4_suffrage_1_all")
          if suffrage_1_all
            lines << line_item(suffrage_1_all.content, type: "congregation", slug: suffrage_1_all.slug)
          end

          # Suffrage 2: Oremos
          suffrage_2_minister = fetch_liturgical_text("morning_4_suffrage_2_minister")
          if suffrage_2_minister
            lines << line_item(suffrage_2_minister.content, type: "leader", slug: suffrage_2_minister.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer rubric (if not already said)
          lords_prayer_rubric = fetch_liturgical_text("morning_4_lords_prayer_suffrage_rubric")
          if lords_prayer_rubric
            lines << line_item(lords_prayer_rubric.content, type: "rubric", slug: lords_prayer_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Suffrage 3: Mostra-nos, Senhor...
          suffrage_3_minister = fetch_liturgical_text("morning_4_suffrage_3_minister")
          if suffrage_3_minister
            lines << line_item(suffrage_3_minister.content, type: "leader", slug: suffrage_3_minister.slug)
          end

          suffrage_3_all = fetch_liturgical_text("morning_4_suffrage_3_all")
          if suffrage_3_all
            lines << line_item(suffrage_3_all.content, type: "congregation", slug: suffrage_3_all.slug)
          end

          # Suffrage 4: Cria em nós...
          suffrage_4_minister = fetch_liturgical_text("morning_4_suffrage_4_minister")
          if suffrage_4_minister
            lines << line_item(suffrage_4_minister.content, type: "leader", slug: suffrage_4_minister.slug)
          end

          suffrage_4_all = fetch_liturgical_text("morning_4_suffrage_4_all")
          if suffrage_4_all
            lines << line_item(suffrage_4_all.content, type: "congregation", slug: suffrage_4_all.slug)
          end

          {
            name: canticle_name,
            slug: "canticle_after_second_reading",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Collects
        # ============================================================================

        # COLETA DO DIA - Collect of the Day
        def build_collect_of_the_day
          lines = []

          # Rubric for collect
          rubric = fetch_liturgical_text("morning_4_collect_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Collect of the Day (from CollectService)
          lines.concat(build_collect_lines(@collects))

          {
            name: "Coleta do Dia",
            slug: "collect_of_the_day",
            lines: lines
          }
        end

        # COLETA PELA PAZ - Collect for Peace
        def build_collect_peace
          lines = []

          collect = fetch_liturgical_text("morning_4_collect_peace")
          if collect
            if collect.title.present?
              lines << line_item(collect.title, type: "heading")
            end
            lines << line_item(collect.content, type: "leader", slug: collect.slug)
          end

          {
            name: "Coleta pela Paz",
            slug: "collect_peace",
            lines: lines
          }
        end

        # COLETA PELA GRAÇA - Collect for Grace
        def build_collect_grace
          lines = []

          collect = fetch_liturgical_text("morning_4_collect_grace")
          if collect
            if collect.title.present?
              lines << line_item(collect.title, type: "heading")
            end
            lines << line_item(collect.content, type: "leader", slug: collect.slug)
          end

          {
            name: "Coleta pela Graça",
            slug: "collect_grace",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Optional Prayers
        # ============================================================================

        # ORAÇÕES OPCIONAIS - Optional Prayers
        def build_optional_prayers
          lines = []

          # Optional prayers rubric
          rubric = fetch_liturgical_text("morning_4_optional_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve which collects to include based on preference
          collects_to_include = resolve_general_collects

          collects_to_include.each do |collect_key|
            build_optional_collect(lines, collect_key)
            lines << line_item("", type: "spacer")
          end

          # Always include Prayer of St. Chrysostom at the end
          chrysostom = fetch_liturgical_text("morning_4_prayer_chrysostom")
          if chrysostom
            if chrysostom.title.present?
              lines << line_item(chrysostom.title, type: "heading")
            end
            lines << line_item(chrysostom.content, type: "leader", slug: chrysostom.slug)
          end

          {
            name: "Orações",
            slug: "optional_prayers",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Conclusion
        # ============================================================================

        # GRAÇA - The Grace (Conclusion)
        def build_conclusion
          lines = []

          grace = fetch_liturgical_text("morning_4_grace")
          if grace
            if grace.title.present?
              lines << line_item(grace.title, type: "heading")
            end
            lines << line_item(grace.content, type: "leader", slug: grace.slug)
            if grace.reference.present?
              lines << line_item(grace.reference, type: "reference")
            end
          end

          {
            name: "Graça",
            slug: "conclusion",
            lines: lines
          }
        end

        private

        # ============================================================================
        # SECTION: Helper Methods - Opening Sentence
        # ============================================================================

        # Resolve opening sentence based on preferences and season
        def resolve_opening_sentence_slug
          # First check preference
          pref_value = preferences[:morning_4_invitatory]

          if pref_value.present? && pref_value != "random"
            return "morning_4_sentence_general_#{pref_value}"
          end

          # If random or not set, use seasonal sentence
          season = day_info[:liturgical_season]

          case season&.downcase
          when "advento"
            "morning_4_sentence_advent_1"
          when "natal"
            "morning_4_sentence_christmas"
          when "epifania"
            "morning_4_sentence_epiphany_1"
          when "quaresma", "semana santa"
            select_penitential_sentence
          when "páscoa"
            select_easter_sentence
          when "pentecostes"
            select_pentecost_sentence
          else
            select_general_sentence
          end
        end

        # Select a penitential sentence using seeded random
        def select_penitential_sentence
          options = (1..6).map { |i| "morning_4_sentence_penitential_#{i}" }
          options[seeded_random(0...options.length, key: :morning_4_sentence_penitential)]
        end

        # Select an Easter sentence using seeded random
        def select_easter_sentence
          options = [ "morning_4_sentence_easter", "morning_4_sentence_easter_2" ]
          options[seeded_random(0...options.length, key: :morning_4_sentence_easter)]
        end

        # Select a Pentecost sentence using seeded random
        def select_pentecost_sentence
          options = [ "morning_4_sentence_pentecost_1", "morning_4_sentence_pentecost_2" ]
          options[seeded_random(0...options.length, key: :morning_4_sentence_pentecost)]
        end

        # Select a general sentence using seeded random
        def select_general_sentence
          options = (1..7).map { |i| "morning_4_sentence_general_#{i}" }
          options[seeded_random(0...options.length, key: :morning_4_sentence_general)]
        end

        # ============================================================================
        # SECTION: Helper Methods - Confession Type
        # ============================================================================

        # Resolve confession type from preferences
        def resolve_confession_type
          result = resolve_preference(:morning_4_confession_type, %w[long short])
          result&.to_sym || :long
        end

        # ============================================================================
        # SECTION: Helper Methods - Venite Antiphon
        # ============================================================================

        # Resolve Venite antiphon based on season
        def resolve_venite_antiphon_slug
          season = day_info[:liturgical_season]
          celebration = day_info[:celebration]

          # Check for specific celebrations
          if celebration&.downcase&.include?("purificação") || celebration&.downcase&.include?("anunciação")
            return "morning_4_venite_antiphon_purification"
          elsif celebration&.downcase&.include?("transfiguração")
            return "morning_4_venite_antiphon_epiphany"
          end

          case season&.downcase
          when "advento"
            "morning_4_venite_antiphon_advent"
          when "natal"
            "morning_4_venite_antiphon_christmas"
          when "epifania"
            "morning_4_venite_antiphon_epiphany"
          when "páscoa"
            "morning_4_venite_antiphon_easter"
          when "ascensão"
            "morning_4_venite_antiphon_ascension"
          when "pentecostes"
            if celebration&.downcase&.include?("trindade")
              "morning_4_venite_antiphon_trinity"
            else
              "morning_4_venite_antiphon_pentecost"
            end
          else
            "morning_4_venite_antiphon_feasts"
          end
        end

        # ============================================================================
        # SECTION: Helper Methods - Canticles
        # ============================================================================

        # Resolve canticle after first reading from preferences
        def resolve_canticle_after_first_reading
          result = resolve_preference(:morning_4_canticle_after_first_reading,
            %w[te_deum benedictus_es_domine benedicite_omnia_opera_domini])
          result&.to_sym || :te_deum
        end

        # Resolve canticle after second reading from preferences
        def resolve_canticle_after_second_reading
          result = resolve_preference(:morning_4_canticle_after_second_reading,
            %w[benedictur jubilate_deo])
          result&.to_sym || :benedictur
        end

        # Build Te Deum canticle
        def build_te_deum_canticle(lines)
          te_deum = fetch_liturgical_text("morning_4_te_deum")
          if te_deum
            lines << line_item(te_deum.content, slug: te_deum.slug)
          end
          "Te Deum Laudamus"
        end

        # Build Benedictus es Domine canticle
        def build_benedictus_es_canticle(lines)
          benedictus_es = fetch_liturgical_text("morning_4_benedictus_es")
          if benedictus_es
            lines << line_item(benedictus_es.content, slug: benedictus_es.slug)
          end
          "Benedictus es, Domine"
        end

        # Build Benedicite canticle
        def build_benedicite_canticle(lines)
          benedicite = fetch_liturgical_text("morning_4_benedicite")
          if benedicite
            lines << line_item(benedicite.content, slug: benedicite.slug)
          end
          "Benedicite, omnia opera Domini"
        end

        # Build Benedictus canticle
        def build_benedictus_canticle(lines)
          benedictus = fetch_liturgical_text("morning_4_benedictus")
          if benedictus
            if benedictus.reference.present?
              lines << line_item(benedictus.reference, type: "reference")
            end
            lines << line_item(benedictus.content, slug: benedictus.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("morning_4_gloria_patri_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_4_gloria_patri_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          "Benedictus"
        end

        # Build Jubilate Deo canticle
        def build_jubilate_canticle(lines)
          jubilate = fetch_liturgical_text("morning_4_jubilate")
          if jubilate
            if jubilate.reference.present?
              lines << line_item(jubilate.reference, type: "reference")
            end
            lines << line_item(jubilate.content, slug: jubilate.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("morning_4_gloria_patri_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_4_gloria_patri_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          "Jubilate Deo"
        end

        # ============================================================================
        # SECTION: Helper Methods - Creed
        # ============================================================================

        # Resolve creed type from preferences
        def resolve_creed_type
          result = resolve_preference(:morning_4_creed_type, %w[apostolic nicene])
          result&.to_sym || :apostolic
        end

        # ============================================================================
        # SECTION: Helper Methods - General Collects
        # ============================================================================

        # Resolve which general collects to include based on preference
        def resolve_general_collects
          pref_value = preferences[:morning_4_general_collects]

          case pref_value&.to_s
          when "for_peace"
            [ :peace ]
          when "for_grace"
            [ :grace ]
          when "for_authorities_1"
            [ :president ]
          when "for_authorities_2"
            [ :president_alt ]
          when "for_clergy"
            [ :clergy ]
          when "for_all_humanity"
            [ :humanity ]
          when "general_thanksgiving"
            [ :thanksgiving ]
          when "all"
            [ :peace, :grace, :president, :president_alt, :clergy, :humanity, :thanksgiving ]
          when "random"
            options = [ :peace, :grace, :president, :president_alt, :clergy, :humanity, :thanksgiving ]
            [ options[seeded_random(0...options.length, key: :morning_4_general_collect)] ]
          else
            [ :peace, :grace ]
          end
        end

        # Build an optional collect
        def build_optional_collect(lines, collect_key)
          case collect_key
          when :peace
            prayer = fetch_liturgical_text("morning_4_collect_peace")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :grace
            prayer = fetch_liturgical_text("morning_4_collect_grace")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :president
            prayer = fetch_liturgical_text("morning_4_prayer_president")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :president_alt
            prayer = fetch_liturgical_text("morning_4_prayer_president_alt")
            if prayer
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :clergy
            prayer = fetch_liturgical_text("morning_4_prayer_clergy")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :humanity
            prayer = fetch_liturgical_text("morning_4_prayer_humanity")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :thanksgiving
            prayer = fetch_liturgical_text("morning_4_general_thanksgiving")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          end
        end
      end
    end
  end
end
