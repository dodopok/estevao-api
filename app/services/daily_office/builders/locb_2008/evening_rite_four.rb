# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Evening Prayer Rite Four (Oração Vespertina IV - BCP 1928)
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
      # 7. Salmodia (Psalms) with Gloria in excelsis
      # 8. Primeira Leitura (First Reading)
      # 9. Magnificat / Cantate Domino / Bonum est confiteri (Canticle after first reading)
      # 10. Segunda Leitura (Second Reading)
      # 11. Nunc dimittis / Deus misereatur / Benedic, anima mea (Canticle after second reading)
      # 12. Credo dos Apóstolos / Niceno (Creed)
      # 13. Súplicas (Suffrages)
      # 14. Coleta do Dia (Collect of the Day)
      # 15. Coleta pela Paz (Collect for Peace)
      # 16. Coleta Contra os Perigos da Noite (Collect against Night Dangers)
      # 17. Orações Opcionais (Optional Prayers - President, Clergy, Humanity, Thanksgiving, Chrysostom)
      # 18. Graça (The Grace - conclusion)
      #
      class EveningRiteFour < Base
        private

        def assemble_office
          assemble_evening_prayer
        end

        def assemble_evening_prayer
          [
            build_opening_sentence,
            build_confession,
            build_absolution,
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
          rubric = fetch_liturgical_text("evening_4_opening_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Get seasonal sentence or resolved from preferences
          sentence_slug = resolve_opening_sentence_slug
          sentence = fetch_liturgical_text(sentence_slug)

          if sentence
            lines << line_item(sentence.content + " " + sentence.reference.to_s, type: "leader", slug: sentence.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("evening_4_exhortation_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve confession type (long or short)
          confession_type = resolve_confession_type

          case confession_type
          when :long
            exhortation = fetch_liturgical_text("evening_4_exhortation_long")
            if exhortation
              lines << line_item(exhortation.content, type: "leader", slug: exhortation.slug)
            end
          when :short
            exhortation = fetch_liturgical_text("evening_4_exhortation_short")
            if exhortation
              lines << line_item(exhortation.content, type: "leader", slug: exhortation.slug)
            end
          end

          {
            name: "Sentença de Abertura",
            slug: "opening_sentence",
            lines: lines
          }
        end

        # CONFISSÃO GERAL - General Confession
        def build_confession
          lines = []

          # Confession rubric
          rubric = fetch_liturgical_text("evening_4_confession_rubric")
          if rubric
            if rubric.title.present?
              lines << line_item(rubric.title, type: "heading")
            end
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer
          confession = fetch_liturgical_text("evening_4_confession_prayer_all")
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
          rubric = fetch_liturgical_text("evening_4_absolution_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution
          absolution = fetch_liturgical_text("evening_4_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("evening_4_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer rubric
          rubric = fetch_liturgical_text("evening_4_lords_prayer_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Oremos
          invitation = fetch_liturgical_text("evening_4_lords_prayer_invitation")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("evening_4_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric
          rubric = fetch_liturgical_text("evening_4_versicles_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Versicle 1: Abre, ó Senhor...
          versicle_1_minister = fetch_liturgical_text("evening_4_versicle_1_minister")
          if versicle_1_minister
            lines << line_item(versicle_1_minister.content, type: "leader", slug: versicle_1_minister.slug)
          end

          versicle_1_all = fetch_liturgical_text("evening_4_versicle_1_all")
          if versicle_1_all
            lines << line_item(versicle_1_all.content, type: "congregation", slug: versicle_1_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric 2
          rubric_2 = fetch_liturgical_text("evening_4_versicles_rubric_2")
          if rubric_2
            lines << line_item(rubric_2.content, type: "rubric", slug: rubric_2.slug)
            lines << line_item("", type: "spacer")
          end

          # Versicle 2: Glória ao Pai...
          versicle_2_minister = fetch_liturgical_text("evening_4_versicle_2_minister")
          if versicle_2_minister
            lines << line_item(versicle_2_minister.content, type: "leader", slug: versicle_2_minister.slug)
          end

          versicle_2_all = fetch_liturgical_text("evening_4_versicle_2_all")
          if versicle_2_all
            lines << line_item(versicle_2_all.content, type: "congregation", slug: versicle_2_all.slug)
          end

          # Versicle 3: Louvai ao Senhor...
          versicle_3_minister = fetch_liturgical_text("evening_4_versicle_3_minister")
          if versicle_3_minister
            lines << line_item(versicle_3_minister.content, type: "leader", slug: versicle_3_minister.slug)
          end

          versicle_3_all = fetch_liturgical_text("evening_4_versicle_3_all")
          if versicle_3_all
            lines << line_item(versicle_3_all.content, type: "congregation", slug: versicle_3_all.slug)
          end

          {
            name: "Declaração de Absolvição ou Remissão de Pecados",
            slug: "absolution",
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

          # Psalmody rubric
          psalmody_rubric = fetch_liturgical_text("evening_4_psalmody_rubric")
          if psalmody_rubric
            if psalmody_rubric.title.present?
              lines << line_item(psalmody_rubric.title, type: "heading")
            end
            lines << line_item(psalmody_rubric.content, type: "rubric", slug: psalmody_rubric.slug)
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

          # Gloria in excelsis
          gloria_title = fetch_liturgical_text("evening_4_gloria_in_excelsis_title")
          if gloria_title&.title.present?
            lines << line_item(gloria_title.title, type: "heading")
          end

          gloria_minister = fetch_liturgical_text("evening_4_gloria_in_excelsis_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_4_gloria_in_excelsis_all")
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
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("evening_4_first_reading_rubric")
          if rubric
            if rubric.title.present?
              lines << line_item(rubric.title, type: "heading")
            end
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          if readings[:first_reading]
            lines << line_item(readings[:first_reading][:reference], type: "heading")
            lines << line_item("", type: "spacer")

            if readings[:first_reading][:content]
              lines.concat(format_bible_content(readings[:first_reading][:content]))
              lines << line_item("", type: "spacer")
            end
          end

          {
            name: "Primeira Leitura",
            slug: "first_reading",
            lines: lines
          }
        end

        # CÂNTICO PÓS PRIMEIRA LEITURA - Canticle after First Reading (Magnificat, Cantate Domino, or Bonum est confiteri)
        def build_canticle_after_first_reading
          lines = []

          canticle_name = "Cântico"

          # Resolve canticle from preferences
          canticle_type = resolve_canticle_after_first_reading

          case canticle_type
          when :magnificat
            canticle_name = build_magnificat_canticle(lines)
          when :cantate_domino
            canticle_name = build_cantate_domino_canticle(lines)
          when :bonum_est_confiteri
            canticle_name = build_bonum_est_confiteri_canticle(lines)
          when :all
            canticle_name = build_magnificat_canticle(lines)
            lines << line_item("", type: "spacer")
            build_cantate_domino_canticle(lines)
            lines << line_item("", type: "spacer")
            build_bonum_est_confiteri_canticle(lines)
          else
            canticle_name = build_magnificat_canticle(lines)
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
          rubric = fetch_liturgical_text("evening_4_second_reading_rubric")
          if rubric
            if rubric.title.present?
              lines << line_item(rubric.title, type: "heading")
            end
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

        # CÂNTICO PÓS SEGUNDA LEITURA - Canticle after Second Reading (Nunc dimittis, Deus misereatur, or Benedic anima mea)
        def build_canticle_after_second_reading
          lines = []
          canticle_name = "Cântico"

          # Resolve canticle from preferences
          canticle_type = resolve_canticle_after_second_reading

          case canticle_type
          when :nunc_dimittis
            canticle_name = build_nunc_dimittis_canticle(lines)
          when :deus_misereatur
            canticle_name = build_deus_misereatur_canticle(lines)
          when :benedic_anima_mea
            canticle_name = build_benedic_anima_mea_canticle(lines)
          when :all
            canticle_name = build_nunc_dimittis_canticle(lines)
            lines << line_item("", type: "spacer")
            build_deus_misereatur_canticle(lines)
            lines << line_item("", type: "spacer")
            build_benedic_anima_mea_canticle(lines)
          else
            canticle_name = build_nunc_dimittis_canticle(lines)
          end

          # Creed rubric
          rubric = fetch_liturgical_text("evening_4_creed_rubric")
          if rubric
            lines << line_item("", type: "spacer")
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve creed from preferences
          creed_type = resolve_creed_type

          case creed_type
          when :apostolic
            creed = fetch_liturgical_text("evening_4_apostles_creed")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          when :nicene
            # Nicene rubric
            nicene_rubric = fetch_liturgical_text("evening_4_nicene_creed_rubric")
            if nicene_rubric
              lines << line_item(nicene_rubric.content, type: "rubric", slug: nicene_rubric.slug)
              lines << line_item("", type: "spacer")
            end

            creed = fetch_liturgical_text("evening_4_nicene_creed")
            if creed
              if creed.title.present?
                lines << line_item(creed.title, type: "heading")
              end
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          when :all
            # Apostles' Creed
            creed = fetch_liturgical_text("evening_4_apostles_creed")
            if creed
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
              lines << line_item("", type: "spacer")
            end

            # Nicene Creed
            nicene_rubric = fetch_liturgical_text("evening_4_nicene_creed_rubric")
            if nicene_rubric
              lines << line_item(nicene_rubric.content, type: "rubric", slug: nicene_rubric.slug)
              lines << line_item("", type: "spacer")
            end

            nicene_creed = fetch_liturgical_text("evening_4_nicene_creed")
            if nicene_creed
              if nicene_creed.title.present?
                lines << line_item(nicene_creed.title, type: "heading")
              end
              lines << line_item(nicene_creed.content, type: "congregation", slug: nicene_creed.slug)
            end
          else
            creed = fetch_liturgical_text("evening_4_apostles_creed")
            if creed
              if creed.title.present?
                lines << line_item(creed.title, type: "heading")
              end
              lines << line_item(creed.content, type: "congregation", slug: creed.slug)
            end
          end

          # Suffrages rubric
          rubric = fetch_liturgical_text("evening_4_suffrages_rubric")
          if rubric
            lines << line_item("", type: "spacer")
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Suffrage 1: O Senhor seja convosco...
          suffrage_1_minister = fetch_liturgical_text("evening_4_suffrage_1_minister")
          if suffrage_1_minister
            lines << line_item(suffrage_1_minister.content, type: "leader", slug: suffrage_1_minister.slug)
          end

          suffrage_1_all = fetch_liturgical_text("evening_4_suffrage_1_all")
          if suffrage_1_all
            lines << line_item(suffrage_1_all.content, type: "congregation", slug: suffrage_1_all.slug)
          end

          # Suffrage 2: Oremos
          suffrage_2_minister = fetch_liturgical_text("evening_4_suffrage_2_minister")
          if suffrage_2_minister
            lines << line_item(suffrage_2_minister.content, type: "leader", slug: suffrage_2_minister.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer (if not already said)
          lords_prayer_rubric = fetch_liturgical_text("evening_4_suffrages_lords_prayer_rubric")
          if lords_prayer_rubric
            lines << line_item(lords_prayer_rubric.content, type: "rubric", slug: lords_prayer_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("evening_4_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
            lines << line_item("", type: "spacer")
          end

          # Suffrage 3: Mostra-nos, Senhor...
          suffrage_3_minister = fetch_liturgical_text("evening_4_suffrage_3_minister")
          if suffrage_3_minister
            lines << line_item(suffrage_3_minister.content, type: "leader", slug: suffrage_3_minister.slug)
          end

          suffrage_3_all = fetch_liturgical_text("evening_4_suffrage_3_all")
          if suffrage_3_all
            lines << line_item(suffrage_3_all.content, type: "congregation", slug: suffrage_3_all.slug)
          end

          # Suffrage 4: Protege nossa Pátria...
          suffrage_4_minister = fetch_liturgical_text("evening_4_suffrage_4_minister")
          if suffrage_4_minister
            lines << line_item(suffrage_4_minister.content, type: "leader", slug: suffrage_4_minister.slug)
          end

          suffrage_4_all = fetch_liturgical_text("evening_4_suffrage_4_all")
          if suffrage_4_all
            lines << line_item(suffrage_4_all.content, type: "congregation", slug: suffrage_4_all.slug)
          end

          # Suffrage 5: Reveste de virtude...
          suffrage_5_minister = fetch_liturgical_text("evening_4_suffrage_5_minister")
          if suffrage_5_minister
            lines << line_item(suffrage_5_minister.content, type: "leader", slug: suffrage_5_minister.slug)
          end

          suffrage_5_all = fetch_liturgical_text("evening_4_suffrage_5_all")
          if suffrage_5_all
            lines << line_item(suffrage_5_all.content, type: "congregation", slug: suffrage_5_all.slug)
          end

          # Suffrage 6: Salva, Senhor...
          suffrage_6_minister = fetch_liturgical_text("evening_4_suffrage_6_minister")
          if suffrage_6_minister
            lines << line_item(suffrage_6_minister.content, type: "leader", slug: suffrage_6_minister.slug)
          end

          suffrage_6_all = fetch_liturgical_text("evening_4_suffrage_6_all")
          if suffrage_6_all
            lines << line_item(suffrage_6_all.content, type: "congregation", slug: suffrage_6_all.slug)
          end

          # Suffrage 7: Dá-nos paz...
          suffrage_7_minister = fetch_liturgical_text("evening_4_suffrage_7_minister")
          if suffrage_7_minister
            lines << line_item(suffrage_7_minister.content, type: "leader", slug: suffrage_7_minister.slug)
          end

          suffrage_7_all = fetch_liturgical_text("evening_4_suffrage_7_all")
          if suffrage_7_all
            lines << line_item(suffrage_7_all.content, type: "congregation", slug: suffrage_7_all.slug)
          end

          # Suffrage 8: Cria em nós...
          suffrage_8_minister = fetch_liturgical_text("evening_4_suffrage_8_minister")
          if suffrage_8_minister
            lines << line_item(suffrage_8_minister.content, type: "leader", slug: suffrage_8_minister.slug)
          end

          suffrage_8_all = fetch_liturgical_text("evening_4_suffrage_8_all")
          if suffrage_8_all
            lines << line_item(suffrage_8_all.content, type: "congregation", slug: suffrage_8_all.slug)
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
          rubric = fetch_liturgical_text("evening_4_collect_day_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Collect of the Day (from CollectService)
          if @collects
            lines << line_item(@collects)
            lines << line_item("", type: "spacer")
          end

          # Collect for Peace
          collect_peace = fetch_liturgical_text("evening_4_collect_peace")
          if collect_peace
            if collect_peace.title.present?
              lines << line_item(collect_peace.title, type: "heading")
            end
            lines << line_item(collect_peace.content, type: "leader", slug: collect_peace.slug)
            lines << line_item("", type: "spacer")
          end

          # Collect against Night Dangers
          collect_night = fetch_liturgical_text("evening_4_collect_night_dangers")
          if collect_night
            if collect_night.title.present?
              lines << line_item(collect_night.title, type: "heading")
            end
            lines << line_item(collect_night.content, type: "leader", slug: collect_night.slug)
          end

          {
            name: "Coleta do Dia",
            slug: "collect_of_the_day",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Optional Prayers
        # ============================================================================

        # ORAÇÕES OPCIONAIS - Optional Prayers
        def build_optional_prayers
          lines = []

          # Resolve which collects to include based on preference
          collects_to_include = resolve_general_collects

          collects_to_include.each do |collect_key|
            build_optional_collect(lines, collect_key)
            lines << line_item("", type: "spacer")
          end

          # Antiphon rubric
          rubric = fetch_liturgical_text("evening_4_antiphon_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Always include Prayer of St. Chrysostom at the end
          chrysostom = fetch_liturgical_text("evening_4_chrysostom_prayer")
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

          grace = fetch_liturgical_text("evening_4_grace")
          if grace
            if grace.title.present?
              lines << line_item(grace.title, type: "heading")
            end
            lines << line_item(grace.content, type: "leader", slug: grace.slug)
            if grace.reference.present?
              lines << line_item(grace.reference, type: "reference")
            end
          end

          grace_all = fetch_liturgical_text("evening_4_grace_all")
          if grace_all
            lines << line_item(grace_all.content, type: "congregation", slug: grace_all.slug)
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
          pref_value = preferences[:evening_4_invitatory]

          if pref_value.present? && pref_value != "random"
            return "evening_4_sentence_general_#{pref_value}"
          end

          # If random or not set, use seasonal sentence
          season = day_info[:liturgical_season]

          case season&.downcase
          when "advento"
            "evening_4_sentence_advent"
          when "natal"
            "evening_4_sentence_christmas"
          when "epifania"
            "evening_4_sentence_epiphany"
          when "quaresma"
            select_lent_sentence
          when "semana santa"
            "evening_4_sentence_good_friday"
          when "páscoa"
            select_easter_sentence
          when "ascensão"
            "evening_4_sentence_ascension"
          when "pentecostes"
            if day_info[:celebration]&.downcase&.include?("trindade")
              "evening_4_sentence_trinity"
            else
              select_pentecost_sentence
            end
          else
            select_general_sentence
          end
        end

        # Select a Lent sentence using seeded random
        def select_lent_sentence
          options = [ "evening_4_sentence_lent", "evening_4_sentence_lent_2", "evening_4_sentence_lent_3" ]
          options[seeded_random(0...options.length, key: :evening_4_sentence_lent)]
        end

        # Select an Easter sentence using seeded random
        def select_easter_sentence
          options = [ "evening_4_sentence_easter", "evening_4_sentence_easter_2" ]
          options[seeded_random(0...options.length, key: :evening_4_sentence_easter)]
        end

        # Select a Pentecost sentence using seeded random
        def select_pentecost_sentence
          options = [ "evening_4_sentence_pentecost_1", "evening_4_sentence_pentecost_2" ]
          options[seeded_random(0...options.length, key: :evening_4_sentence_pentecost)]
        end

        # Select a general sentence using seeded random
        def select_general_sentence
          options = (1..5).map { |i| "evening_4_sentence_general_#{i}" }
          options[seeded_random(0...options.length, key: :evening_4_sentence_general)]
        end

        # ============================================================================
        # SECTION: Helper Methods - Confession Type
        # ============================================================================

        # Resolve confession type from preferences
        def resolve_confession_type
          result = resolve_preference(:evening_4_confession_type, %w[long short])
          result&.to_sym || :short
        end

        # ============================================================================
        # SECTION: Helper Methods - Canticles
        # ============================================================================

        # Resolve canticle after first reading from preferences
        def resolve_canticle_after_first_reading
          result = resolve_preference(:evening_4_canticle_after_first_reading,
            %w[magnificat cantate_domino bonum_est_confiteri])
          result&.to_sym || :magnificat
        end

        # Resolve canticle after second reading from preferences
        def resolve_canticle_after_second_reading
          result = resolve_preference(:evening_4_canticle_after_second_reading,
            %w[nunc_dimittis deus_misereatur benedic_anima_mea])
          result&.to_sym || :nunc_dimittis
        end

        # Build Magnificat canticle
        def build_magnificat_canticle(lines)
          magnificat = fetch_liturgical_text("evening_4_magnificat")
          if magnificat
            if magnificat.title.present?
              lines << line_item(magnificat.title, type: "heading")
            end
            if magnificat.reference.present?
              lines << line_item(magnificat.reference, type: "reference")
            end
            lines << line_item(magnificat.content, slug: magnificat.slug)
          end
          "Magnificat"
        end

        # Build Cantate Domino canticle
        def build_cantate_domino_canticle(lines)
          cantate = fetch_liturgical_text("evening_4_cantate_domino")
          if cantate
            if cantate.title.present?
              lines << line_item(cantate.title, type: "heading")
            end
            if cantate.reference.present?
              lines << line_item(cantate.reference, type: "reference")
            end
            lines << line_item(cantate.content, slug: cantate.slug)
          end
          "Cantate Domino"
        end

        # Build Bonum est confiteri canticle
        def build_bonum_est_confiteri_canticle(lines)
          bonum = fetch_liturgical_text("evening_4_bonum_est_confiteri")
          if bonum
            if bonum.title.present?
              lines << line_item(bonum.title, type: "heading")
            end
            if bonum.reference.present?
              lines << line_item(bonum.reference, type: "reference")
            end
            lines << line_item(bonum.content, slug: bonum.slug)
          end
          "Bonum est confiteri"
        end

        # Build Nunc dimittis canticle
        def build_nunc_dimittis_canticle(lines)
          nunc = fetch_liturgical_text("evening_4_nunc_dimittis")
          if nunc
            if nunc.title.present?
              lines << line_item(nunc.title, type: "heading")
            end
            if nunc.reference.present?
              lines << line_item(nunc.reference, type: "reference")
            end
            lines << line_item(nunc.content, slug: nunc.slug)
          end
          "Nunc dimittis"
        end

        # Build Deus misereatur canticle
        def build_deus_misereatur_canticle(lines)
          deus = fetch_liturgical_text("evening_4_deus_misereatur")
          if deus
            if deus.title.present?
              lines << line_item(deus.title, type: "heading")
            end
            if deus.reference.present?
              lines << line_item(deus.reference, type: "reference")
            end
            lines << line_item(deus.content, slug: deus.slug)
          end
          "Deus misereatur"
        end

        # Build Benedic, anima mea canticle
        def build_benedic_anima_mea_canticle(lines)
          benedic = fetch_liturgical_text("evening_4_benedic_anima_mea")
          if benedic
            if benedic.title.present?
              lines << line_item(benedic.title, type: "heading")
            end
            if benedic.reference.present?
              lines << line_item(benedic.reference, type: "reference")
            end
            lines << line_item(benedic.content, slug: benedic.slug)
          end
          "Benedic, anima mea"
        end

        # ============================================================================
        # SECTION: Helper Methods - Creed
        # ============================================================================

        # Resolve creed type from preferences
        def resolve_creed_type
          result = resolve_preference(:evening_4_creed_type, %w[apostolic nicene])
          result&.to_sym || :apostolic
        end

        # ============================================================================
        # SECTION: Helper Methods - General Collects
        # ============================================================================

        # Resolve which general collects to include based on preference
        def resolve_general_collects
          pref_value = preferences[:evening_4_general_collects] || preferences[:morning_4_general_collects]

          case pref_value&.to_s
          when "for_peace"
            [ :peace ]
          when "against_dangers_of_night"
            [ :night_dangers ]
          when "for_authorities"
            [ :president ]
          when "for_clergy"
            [ :clergy ]
          when "for_all_humanity"
            [ :humanity ]
          when "general_thanksgiving"
            [ :thanksgiving ]
          when "all"
            [ :president, :clergy, :humanity, :thanksgiving ]
          when "random"
            options = [ :president, :clergy, :humanity, :thanksgiving ]
            [ options[seeded_random(0...options.length, key: :evening_4_general_collect)] ]
          else
            []
          end
        end

        # Build an optional collect
        def build_optional_collect(lines, collect_key)
          case collect_key
          when :peace
            prayer = fetch_liturgical_text("evening_4_collect_peace")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :night_dangers
            prayer = fetch_liturgical_text("evening_4_collect_night_dangers")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :president
            prayer = fetch_liturgical_text("evening_4_prayer_president")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :clergy
            prayer = fetch_liturgical_text("evening_4_prayer_clergy_people")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :humanity
            prayer = fetch_liturgical_text("evening_4_prayer_humanity")
            if prayer
              if prayer.title.present?
                lines << line_item(prayer.title, type: "heading")
              end
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
            end
          when :thanksgiving
            prayer = fetch_liturgical_text("evening_4_thanksgiving")
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
