# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Morning Prayer Rite Three (Oração Matutina III)
      #
      # This builder follows the structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 43-51.
      #
      # Structure:
      # 1. Acolhida (Welcome)
      # 2. Frase Bíblica (Scripture Sentence)
      # 3. Hino (Hymn)
      # 4. Convite à Confissão (Invitation to Confession)
      # 5. Confissão (Confession)
      # 6. Declaração de Perdão (Absolution)
      # 7. Responso (Response)
      # 8. Cântico - Antes da Leitura (Venite or Jubilate)
      # 9. Salmodia (Psalms)
      # 10. Leitura do Antigo Testamento (OT Reading)
      # 11. Cântico - Pós Primeira Leitura (Benedictus, Benedic anima mea, or Magna et mirabilia)
      # 12. Leitura do Novo Testamento (NT Reading)
      # 13. Sermão (Sermon)
      # 14. Cântico - Pós Segunda Leitura (Te Deum, Gloria in excelsis, or Salvador do Mundo in Lent)
      # 15. Credo dos Apóstolos (Creed)
      # 16. Orações e Kyrie (Prayers)
      # 17. Pai Nosso (Lord's Prayer)
      # 18. Responsório (Responsory - option 1 or 2)
      # 19. Coleta do Dia (Collect of the Day)
      # 20. Oração Final (Final Prayer - 1, 2, or 3)
      # 21. Conclusão/Despedida (Conclusion/Dismissal)
      #
      class MorningRiteThree < Base
        private

        def assemble_office
          assemble_morning_prayer
        end

        def assemble_morning_prayer
          [
            build_welcome,
            build_scripture_sentence,
            build_hymn,
            build_confession,
            build_absolution,
            build_canticle_before_reading,
            build_psalms,
            build_ot_reading,
            build_canticle_after_first_reading,
            build_nt_reading,
            build_sermon,
            build_canticle_after_second_reading,
            build_creed
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening Components
        # ============================================================================

        # ACOLHIDA - Welcome
        def build_welcome
          lines = []

          welcome = fetch_liturgical_text("morning_3_welcome_minister")
          if welcome
            lines << line_item(welcome.content, type: "leader", slug: welcome.slug)
          end

          {
            name: "Acolhida",
            slug: "welcome",
            lines: lines
          }
        end

        # FRASE BÍBLICA - Scripture Sentence
        def build_scripture_sentence
          lines = []

          rubric = fetch_liturgical_text("morning_3_scripture_sentence_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Frase Bíblica",
            slug: "scripture_sentence",
            lines: lines
          }
        end

        # HINO - Hymn
        def build_hymn
          lines = []

          rubric = fetch_liturgical_text("morning_3_hymn_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Hino",
            slug: "hymn",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Confession
        # ============================================================================

        # CONFISSÃO - Confession
        def build_confession
          lines = []

          # Invitation to confession
          invitation = fetch_liturgical_text("morning_3_confession_invitation_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Alternative rubric
          alt_rubric = fetch_liturgical_text("morning_3_confession_alternative_rubric")
          if alt_rubric
            lines << line_item(alt_rubric.content, type: "rubric", slug: alt_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession intro
          confession_minister = fetch_liturgical_text("morning_3_confession_minister")
          if confession_minister
            lines << line_item(confession_minister.content, type: "leader", slug: confession_minister.slug)
          end

          # Confession prayer
          confession = fetch_liturgical_text("morning_3_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
          end

          {
            name: "Convite à Confissão",
            slug: "confession",
            lines: lines
          }
        end

        # DECLARAÇÃO DE PERDÃO - Absolution
        def build_absolution
          lines = []

          absolution = fetch_liturgical_text("morning_3_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("morning_3_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric about omitting penitential section
          omit_rubric = fetch_liturgical_text("morning_3_penitential_omit_rubric")
          if omit_rubric
            lines << line_item(omit_rubric.content, type: "rubric", slug: omit_rubric.slug)
          end

          # Response 1: Senhor, abre os nossos lábios...
          response_1_minister = fetch_liturgical_text("morning_3_response_1_minister")
          if response_1_minister
            lines << line_item(response_1_minister.content, type: "leader", slug: response_1_minister.slug)
          end

          response_1_all = fetch_liturgical_text("morning_3_response_1_all")
          if response_1_all
            lines << line_item(response_1_all.content, type: "congregation", slug: response_1_all.slug)
          end

          # Response 2: Adoremos o Senhor...
          response_2_minister = fetch_liturgical_text("morning_3_response_2_minister")
          if response_2_minister
            lines << line_item(response_2_minister.content, type: "leader", slug: response_2_minister.slug)
          end

          response_2_all = fetch_liturgical_text("morning_3_response_2_all")
          if response_2_all
            lines << line_item(response_2_all.content, type: "congregation", slug: response_2_all.slug)
          end

          # Response 3: Glória ao Pai...
          response_3_minister = fetch_liturgical_text("morning_3_response_3_minister")
          if response_3_minister
            lines << line_item(response_3_minister.content, type: "leader", slug: response_3_minister.slug)
          end

          response_3_all = fetch_liturgical_text("morning_3_response_3_all")
          if response_3_all
            lines << line_item(response_3_all.content, type: "congregation", slug: response_3_all.slug)
          end

          {
            name: "Declaração de Perdão",
            slug: "absolution",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Canticles
        # ============================================================================

        # CÂNTICO - ANTES DA LEITURA (Venite or Jubilate)
        def build_canticle_before_reading
          lines = []
          canticle_name = "Cântico"

          # Rubric
          rubric = fetch_liturgical_text("morning_3_canticle_before_reading_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Check if Easter - use Easter antiphons
          if easter_season?
            build_easter_antiphons(lines)
            canticle_name = "Antífonas da Páscoa"
          else
            # Resolve canticle from preferences
            canticle_type = resolve_canticle_before_reading

            case canticle_type
            when :venite
              canticle_name = build_venite_canticle(lines)
            when :jubilate_deo
              canticle_name = build_jubilate_canticle(lines)
            else
              canticle_name = build_venite_canticle(lines)
            end
          end

          {
            name: canticle_name,
            slug: "canticle_before_reading",
            lines: lines
          }
        end

        # CÂNTICO - PÓS PRIMEIRA LEITURA (Benedictus, Benedic anima mea, or Magna et mirabilia)
        def build_canticle_after_first_reading
          lines = []
          canticle_name = "Cântico"

          # Rubric
          rubric = fetch_liturgical_text("morning_3_canticle_after_reading_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve canticle from preferences
          canticle_type = resolve_canticle_after_reading

          case canticle_type
          when :benedictus
            canticle_name = build_benedictus_canticle(lines)
          when :benedic_anima_mea
            canticle_name = build_benedic_anima_mea_canticle(lines)
          when :magna_et_mirabilia
            canticle_name = build_magna_et_mirabilia_canticle(lines)
          else
            canticle_name = build_benedictus_canticle(lines)
          end

          {
            name: canticle_name,
            slug: "canticle_after_first_reading",
            lines: lines
          }
        end

        # CÂNTICO - PÓS SEGUNDA LEITURA (Te Deum, Gloria in excelsis, or Salvador do Mundo in Lent)
        def build_canticle_after_second_reading
          lines = []
          canticle_name = "Cântico"

          # Rubric
          rubric = fetch_liturgical_text("morning_3_canticle_after_second_reading_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # In Lent, use Salvador do Mundo
          if lent_season?
            canticle_name = build_savior_of_the_world_canticle(lines)
          else
            # Resolve canticle from preferences
            canticle_type = resolve_canticle_after_second_reading

            case canticle_type
            when :te_deum
              canticle_name = build_te_deum_canticle(lines)
            when :gloria_in_excelsis
              canticle_name = build_gloria_in_excelsis_canticle(lines)
            else
              canticle_name = build_te_deum_canticle(lines)
            end
          end

          {
            name: canticle_name,
            slug: "canticle_after_second_reading",
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

          # Psalm rubric
          rubric = fetch_liturgical_text("morning_3_psalms_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
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
          gloria_minister = fetch_liturgical_text("morning_3_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("morning_3_psalms_gloria_all")
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

        # LEITURA DO ANTIGO TESTAMENTO - Old Testament Reading
        def build_ot_reading
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("morning_3_ot_reading_rubric")
          if rubric
            lines << line_item(rubric.title, type: "heading")
            lines << line_item("", type: "spacer")
          end

          if readings[:first_reading]
            lines << line_item(readings[:first_reading][:reference])
            lines << line_item("", type: "spacer")

            if readings[:first_reading][:content]
              lines.concat(format_bible_content(readings[:first_reading][:content]))
              lines << line_item("", type: "spacer")
            end
          end

          # Response
          response_reader = fetch_liturgical_text("morning_3_ot_reading_response_reader")
          if response_reader
            lines << line_item(response_reader.content, type: "leader", slug: response_reader.slug)
          end

          response_all = fetch_liturgical_text("morning_3_ot_reading_response_all")
          if response_all
            lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence = fetch_liturgical_text("morning_3_silence_rubric")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
          end

          {
            name: "Leitura do Antigo Testamento",
            slug: "ot_reading",
            lines: lines
          }
        end

        # LEITURA DO NOVO TESTAMENTO - New Testament Reading
        def build_nt_reading
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("morning_3_nt_reading_rubric")
          if rubric
            lines << line_item(rubric.title, type: "heading")
            lines << line_item("", type: "spacer")
          end

          if readings[:second_reading]
            lines << line_item(readings[:second_reading][:reference])
            lines << line_item("", type: "spacer")

            if readings[:second_reading][:content]
              lines.concat(format_bible_content(readings[:second_reading][:content]))
              lines << line_item("", type: "spacer")
            end
          end

          # Response
          response_reader = fetch_liturgical_text("morning_3_nt_reading_response_reader")
          if response_reader
            lines << line_item(response_reader.content, type: "leader", slug: response_reader.slug)
          end

          response_all = fetch_liturgical_text("morning_3_nt_reading_response_all")
          if response_all
            lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence = fetch_liturgical_text("morning_3_silence_rubric")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
          end

          {
            name: "Leitura do Novo Testamento",
            slug: "nt_reading",
            lines: lines
          }
        end

        # SERMÃO - Sermon
        def build_sermon
          lines = []

          rubric = fetch_liturgical_text("morning_3_sermon_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          {
            name: "Sermão",
            slug: "sermon",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Creed
        # ============================================================================

        # CREDO DOS APÓSTOLOS - Apostles' Creed
        def build_creed
          lines = []

          creed = fetch_liturgical_text("morning_3_creed_all")
          if creed
            lines << line_item(creed.title)
            lines << line_item("", type: "spacer")
            lines << line_item(creed.content, type: "congregation", slug: creed.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("morning_3_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Oremos
          invitation = fetch_liturgical_text("morning_3_prayers_invitation")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Kyrie
          kyrie_1_minister = fetch_liturgical_text("morning_3_kyrie_1_minister")
          if kyrie_1_minister
            lines << line_item(kyrie_1_minister.content, type: "leader", slug: kyrie_1_minister.slug)
          end

          kyrie_1_all = fetch_liturgical_text("morning_3_kyrie_1_all")
          if kyrie_1_all
            lines << line_item(kyrie_1_all.content, type: "congregation", slug: kyrie_1_all.slug)
          end

          kyrie_2_minister = fetch_liturgical_text("morning_3_kyrie_2_minister")
          if kyrie_2_minister
            lines << line_item(kyrie_2_minister.content, type: "leader", slug: kyrie_2_minister.slug)
          end

          lords_prayer = fetch_liturgical_text("morning_3_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.title)
            lines << line_item("", type: "spacer")
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
          end

          # Resolve responsory option from preferences
          option = resolve_prayer_conclusion

          case option
          when 1, "1"
            build_responsory_long(lines)
          when 2, "2"
            build_responsory_short(lines)
          else
            build_responsory_long(lines)
          end

          # Rubric
          rubric = fetch_liturgical_text("morning_3_collect_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Collect of the Day (from CollectService)
          lines.concat(build_collect_lines(@collects))

          # Resolve which final prayer to use from preferences
          option = resolve_conclusion_prayer

          prayer = fetch_liturgical_text("morning_3_final_prayer_#{option}")
          if prayer
            lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
          end

          # Other prayers rubric
          other_rubric = fetch_liturgical_text("morning_3_other_prayers_rubric")
          if other_rubric
            lines << line_item(other_rubric.content, type: "rubric", slug: other_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Dismissal
          dismissal = fetch_liturgical_text("morning_3_conclusion_dismissal_minister")
          if dismissal
            lines << line_item(dismissal.content, type: "leader", slug: dismissal.slug)
          end

          dismissal_people = fetch_liturgical_text("morning_3_conclusion_dismissal_people")
          if dismissal_people
            lines << line_item(dismissal_people.content, type: "congregation", slug: dismissal_people.slug)
          end

          dismissal_all = fetch_liturgical_text("morning_3_conclusion_dismissal_all")
          if dismissal_all
            lines << line_item(dismissal_all.content, type: "congregation", slug: dismissal_all.slug)
          end

          {
            name: "Credo dos Apóstolos",
            slug: "creed",
            lines: lines
          }
        end

        private

        # ============================================================================
        # SECTION: Helper Methods
        # ============================================================================

        # Format canticle name with title and reference
        def format_canticle_name(canticle)
          return "Cântico" unless canticle

          if canticle.respond_to?(:subtitle) && canticle.subtitle.present?
            "#{canticle.title} (#{canticle.subtitle})"
          else
            canticle.title || "Cântico"
          end
        end

        # Check if it's Easter season
        def easter_season?
          season = day_info[:liturgical_season]
          season&.downcase == "páscoa"
        end

        # Check if it's Lent season
        def lent_season?
          season = day_info[:liturgical_season]
          season&.downcase == "quaresma"
        end

        # Resolve canticle before reading from preferences
        def resolve_canticle_before_reading
          result = resolve_preference(:morning_3_canticle_before_reading, [ "venite", "jubilate_deo" ])
          result&.to_sym || :venite
        end

        # Resolve canticle after reading from preferences
        def resolve_canticle_after_reading
          result = resolve_preference(:morning_3_canticle_after_reading, [ "benedictus", "benedic_anima_mea", "magna_et_mirabilia" ])
          result&.to_sym || :benedictus
        end

        # Resolve canticle after second reading from preferences
        def resolve_canticle_after_second_reading
          result = resolve_preference(:morning_3_canticle_after_second_reading, [ "te_deum", "gloria_in_excelsis" ])
          result&.to_sym || :te_deum
        end

        # Resolve prayer conclusion option from preferences
        def resolve_prayer_conclusion
          result = resolve_preference(:morning_3_prayer_conclusion, 1..2)
          result || 1
        end

        # Resolve conclusion prayer option from preferences
        def resolve_conclusion_prayer
          result = resolve_preference(:morning_3_conclusion, 1..3)
          result || 1
        end

        # Build Easter antiphons
        def build_easter_antiphons(lines)
          rubric = fetch_liturgical_text("morning_3_easter_antiphons_rubric")
          if rubric
            lines << line_item(rubric.title, type: "heading")
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          (1..3).each do |i|
            antiphon = fetch_liturgical_text("morning_3_easter_antiphon_#{i}")
            if antiphon
              lines << line_item(antiphon.content, slug: antiphon.slug)
              lines << line_item("", type: "spacer")
            end
          end
        end

        # Build Venite canticle
        def build_venite_canticle(lines)
          venite = fetch_liturgical_text("morning_3_venite")
          if venite
            lines << line_item(venite.subtitle, type: "rubric") if venite.respond_to?(:subtitle) && venite.subtitle
            lines << line_item("", type: "spacer")
            lines << line_item(venite.content, slug: venite.slug)
            format_canticle_name(venite)
          else
            "Cântico"
          end
        end

        # Build Jubilate canticle
        def build_jubilate_canticle(lines)
          jubilate = fetch_liturgical_text("morning_3_jubilate")
          if jubilate
            lines << line_item(jubilate.subtitle, type: "rubric") if jubilate.respond_to?(:subtitle) && jubilate.subtitle
            lines << line_item("", type: "spacer")
            lines << line_item(jubilate.content, slug: jubilate.slug)
            format_canticle_name(jubilate)
          else
            "Cântico"
          end
        end

        # Build Benedictus canticle
        def build_benedictus_canticle(lines)
          benedictus = fetch_liturgical_text("morning_3_benedictus")
          if benedictus
            lines << line_item(benedictus.subtitle, type: "rubric") if benedictus.respond_to?(:subtitle) && benedictus.subtitle
            lines << line_item("", type: "spacer")
            lines << line_item(benedictus.content, slug: benedictus.slug)
            format_canticle_name(benedictus)
          else
            "Cântico"
          end
        end

        # Build Benedic anima mea canticle
        def build_benedic_anima_mea_canticle(lines)
          canticle = fetch_liturgical_text("morning_3_benedic_anima_mea")
          if canticle
            lines << line_item(canticle.subtitle, type: "rubric") if canticle.respond_to?(:subtitle) && canticle.subtitle
            lines << line_item("", type: "spacer")
            lines << line_item(canticle.content, slug: canticle.slug)
            format_canticle_name(canticle)
          else
            "Cântico"
          end
        end

        # Build Magna et mirabilia canticle
        def build_magna_et_mirabilia_canticle(lines)
          canticle = fetch_liturgical_text("morning_3_magna_et_mirabilia")
          if canticle
            lines << line_item(canticle.subtitle, type: "rubric") if canticle.respond_to?(:subtitle) && canticle.subtitle
            lines << line_item("", type: "spacer")
            lines << line_item(canticle.content, slug: canticle.slug)
            format_canticle_name(canticle)
          else
            "Cântico"
          end
        end

        # Build Te Deum canticle
        def build_te_deum_canticle(lines)
          te_deum = fetch_liturgical_text("morning_3_te_deum")
          if te_deum
            lines << line_item("", type: "spacer")
            lines << line_item(te_deum.content, slug: te_deum.slug)
            format_canticle_name(te_deum)
          else
            "Cântico"
          end
        end

        # Build Gloria in excelsis canticle
        def build_gloria_in_excelsis_canticle(lines)
          canticle = fetch_liturgical_text("morning_3_gloria_in_excelsis")
          if canticle
            lines << line_item("", type: "spacer")
            lines << line_item(canticle.content, slug: canticle.slug)
            format_canticle_name(canticle)
          else
            "Cântico"
          end
        end

        # Build Salvador do Mundo canticle (for Lent)
        def build_savior_of_the_world_canticle(lines)
          rubric = fetch_liturgical_text("morning_3_savior_of_the_world_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          canticle = fetch_liturgical_text("morning_3_savior_of_the_world")
          if canticle
            lines << line_item("", type: "spacer")
            lines << line_item(canticle.content, slug: canticle.slug)
            format_canticle_name(canticle)
          else
            "Cântico"
          end
        end

        # Build long responsory (option 1)
        def build_responsory_long(lines)
          rubric = fetch_liturgical_text("morning_3_responsory_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          (1..7).each do |i|
            minister = fetch_liturgical_text("morning_3_responsory_1_#{i}_minister")
            if minister
              lines << line_item(minister.content, type: "leader", slug: minister.slug)
            end

            all = fetch_liturgical_text("morning_3_responsory_1_#{i}_all")
            if all
              lines << line_item(all.content, type: "congregation", slug: all.slug)
            end
          end
        end

        # Build short responsory (option 2)
        def build_responsory_short(lines)
          rubric = fetch_liturgical_text("morning_3_responsory_2_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          responsory = fetch_liturgical_text("morning_3_responsory_2_all")
          if responsory
            lines << line_item(responsory.content, type: "congregation", slug: responsory.slug)
          end
        end
      end
    end
  end
end
