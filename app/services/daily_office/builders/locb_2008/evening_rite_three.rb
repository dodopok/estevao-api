# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Evening Prayer Rite Three (Oração Vespertina III)
      #
      # This builder follows the structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 81-87.
      #
      # Structure:
      # 1. Acolhida (Welcome)
      # 2. Frase Bíblica (Scripture Sentence)
      # 3. Hino (Hymn)
      # 4. Convite à Confissão (Invitation to Confession)
      # 5. Confissão (Confession)
      # 6. Declaração de Perdão (Absolution)
      # 7. Responso (Response)
      # 8. Cântico Invitatório (Salmo 134 or Phos hilaron)
      # 9. Salmodia (Psalms)
      # 10. Leitura do Antigo Testamento (OT Reading)
      # 11. Cântico - Pós Primeira Leitura (Magnificat or Benedic, anima mea)
      # 12. Leitura do Novo Testamento (NT Reading)
      # 13. Sermão (Sermon)
      # 14. Cântico - Pós Segunda Leitura (Nunc dimittis, Cântico da glória de Cristo, or Glória e honra)
      # 15. Credo dos Apóstolos (Creed)
      # 16. Orações e Kyrie (Prayers)
      # 17. Pai Nosso (Lord's Prayer)
      # 18. Responsório (Responsory)
      # 19. Coleta do Dia (Collect of the Day)
      # 20. Oração Final (Final Prayer - 1, 2, or 3)
      # 21. Conclusão/Despedida (Conclusion/Dismissal)
      #
      class EveningRiteThree < Base
        private

        def assemble_office
          assemble_evening_prayer
        end

        def assemble_evening_prayer
          [
            build_welcome,
            build_canticle_invitatory,
            build_psalms,
            build_ot_reading,
            build_canticle_after_first_reading,
            build_nt_reading,
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

          welcome = fetch_liturgical_text("evening_3_welcome_minister")
          if welcome
            lines << line_item(welcome.content, type: "leader", slug: welcome.slug)
          end

          rubric = fetch_liturgical_text("evening_3_scripture_sentence_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
          end

          # Invitation to confession
          invitation = fetch_liturgical_text("evening_3_confession_invitation_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Alternative rubric
          alt_rubric = fetch_liturgical_text("evening_3_confession_alternative_rubric")
          if alt_rubric
            lines << line_item(alt_rubric.content, type: "rubric", slug: alt_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession intro
          confession_minister = fetch_liturgical_text("evening_3_confession_minister")
          if confession_minister
            lines << line_item(confession_minister.content, type: "leader", slug: confession_minister.slug)
          end

          # Confession prayer
          confession = fetch_liturgical_text("evening_3_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
          end

          absolution = fetch_liturgical_text("evening_3_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("evening_3_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Rubric about omitting penitential section
          omit_rubric = fetch_liturgical_text("evening_3_penitential_omit_rubric")
          if omit_rubric
            lines << line_item(omit_rubric.content, type: "rubric", slug: omit_rubric.slug)
          end

          # Response 1: Senhor, abre os nossos lábios...
          response_1_minister = fetch_liturgical_text("evening_3_response_1_minister")
          if response_1_minister
            lines << line_item(response_1_minister.content, type: "leader", slug: response_1_minister.slug)
          end

          response_1_all = fetch_liturgical_text("evening_3_response_1_all")
          if response_1_all
            lines << line_item(response_1_all.content, type: "congregation", slug: response_1_all.slug)
          end

          # Response 2: Adoremos o Senhor...
          response_2_minister = fetch_liturgical_text("evening_3_response_2_minister")
          if response_2_minister
            lines << line_item(response_2_minister.content, type: "leader", slug: response_2_minister.slug)
          end

          response_2_all = fetch_liturgical_text("evening_3_response_2_all")
          if response_2_all
            lines << line_item(response_2_all.content, type: "congregation", slug: response_2_all.slug)
          end

          # Response 3: Glória ao Pai...
          response_3_minister = fetch_liturgical_text("evening_3_response_3_minister")
          if response_3_minister
            lines << line_item(response_3_minister.content, type: "leader", slug: response_3_minister.slug)
          end

          response_3_all = fetch_liturgical_text("evening_3_response_3_all")
          if response_3_all
            lines << line_item(response_3_all.content, type: "congregation", slug: response_3_all.slug)
          end

          {
            name: "Acolhida",
            slug: "welcome",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Canticles
        # ============================================================================

        # CÂNTICO INVITATÓRIO - Invitatory Canticle (Salmo 134 or Phos hilaron)
        def build_canticle_invitatory
          lines = []
          canticle_name = "Cântico"

          # Rubric
          rubric = fetch_liturgical_text("evening_3_canticle_invitatory_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve canticle from preferences
          canticle_type = resolve_invitatory_canticle

          case canticle_type
          when "1", :psalm_134
            canticle_name = build_psalm_134_canticle(lines)
          when "2", :phos_hilaron
            canticle_name = build_phos_hilaron_canticle(lines)
          when :all
            canticle_name = build_psalm_134_canticle(lines)
            lines << line_item("", type: "spacer")
            build_phos_hilaron_canticle(lines)
          else
            canticle_name = build_psalm_134_canticle(lines)
          end

          {
            name: canticle_name,
            slug: "canticle_invitatory",
            lines: lines
          }
        end

        # CÂNTICO - PÓS PRIMEIRA LEITURA (Magnificat or Benedic, anima mea)
        def build_canticle_after_first_reading
          lines = []
          canticle_name = "Cântico"

          # Rubric
          rubric = fetch_liturgical_text("evening_3_canticle_after_reading_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve canticle from preferences
          canticle_type = resolve_canticle_post_first_reading

          case canticle_type
          when :magnificat
            canticle_name = build_magnificat_canticle(lines)
          when :benedic_anima_mea
            canticle_name = build_benedic_anima_mea_canticle(lines)
          when :all
            canticle_name = build_magnificat_canticle(lines)
            lines << line_item("", type: "spacer")
            build_benedic_anima_mea_canticle(lines)
          else
            canticle_name = build_magnificat_canticle(lines)
          end

          {
            name: canticle_name,
            slug: "canticle_after_first_reading",
            lines: lines
          }
        end

        # CÂNTICO - PÓS SEGUNDA LEITURA (Nunc dimittis, Cântico da glória de Cristo, or Glória e honra)
        def build_canticle_after_second_reading
          lines = []
          canticle_name = "Cântico"

          # Rubric
          rubric = fetch_liturgical_text("evening_3_sermon_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve canticle from preferences
          canticle_type = resolve_canticle_post_second_reading

          case canticle_type
          when :nunc_dimittis
            canticle_name = build_nunc_dimittis_canticle(lines)
          when :canticle_of_christ_glory
            canticle_name = build_canticle_christ_glory(lines)
          when :gloria_et_honor
            canticle_name = build_gloria_et_honor_canticle(lines)
          when :all
            canticle_name = build_nunc_dimittis_canticle(lines)
            lines << line_item("", type: "spacer")
            build_canticle_christ_glory(lines)
            lines << line_item("", type: "spacer")
            build_gloria_et_honor_canticle(lines)
          else
            canticle_name = build_nunc_dimittis_canticle(lines)
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
          rubric = fetch_liturgical_text("evening_3_psalms_rubric")
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
          gloria_minister = fetch_liturgical_text("evening_3_psalms_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_psalms_gloria_all")
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
          rubric = fetch_liturgical_text("evening_3_ot_reading_rubric")
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
          response_reader = fetch_liturgical_text("evening_3_ot_reading_response_reader")
          if response_reader
            lines << line_item(response_reader.content, type: "leader", slug: response_reader.slug)
          end

          response_all = fetch_liturgical_text("evening_3_ot_reading_response_all")
          if response_all
            lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence = fetch_liturgical_text("evening_3_silence_rubric")
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
          rubric = fetch_liturgical_text("evening_3_nt_reading_rubric")
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
          response_reader = fetch_liturgical_text("evening_3_nt_reading_response_reader")
          if response_reader
            lines << line_item(response_reader.content, type: "leader", slug: response_reader.slug)
          end

          response_all = fetch_liturgical_text("evening_3_nt_reading_response_all")
          if response_all
            lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence = fetch_liturgical_text("evening_3_silence_rubric")
          if silence
            lines << line_item(silence.content, type: "rubric", slug: silence.slug)
          end

          {
            name: "Leitura do Novo Testamento",
            slug: "nt_reading",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Creed
        # ============================================================================

        # CREDO DOS APÓSTOLOS - Apostles' Creed
        def build_creed
          lines = []

          creed = fetch_liturgical_text("evening_3_creed_all")
          if creed
            lines << line_item(creed.title)
            lines << line_item("", type: "spacer")
            lines << line_item(creed.content, type: "congregation", slug: creed.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("evening_3_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Kyrie
          kyrie_1_minister = fetch_liturgical_text("evening_3_kyrie_1_minister")
          if kyrie_1_minister
            lines << line_item(kyrie_1_minister.content, type: "leader", slug: kyrie_1_minister.slug)
          end

          kyrie_1_all = fetch_liturgical_text("evening_3_kyrie_1_all")
          if kyrie_1_all
            lines << line_item(kyrie_1_all.content, type: "congregation", slug: kyrie_1_all.slug)
          end

          kyrie_2_minister = fetch_liturgical_text("evening_3_kyrie_2_minister")
          if kyrie_2_minister
            lines << line_item(kyrie_2_minister.content, type: "leader", slug: kyrie_2_minister.slug)
          end

          # Oremos
          invitation = fetch_liturgical_text("evening_3_prayers_invitation")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("evening_3_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
          end

          # Responsory
          build_responsory(lines)

          # Rubric
          rubric = fetch_liturgical_text("evening_3_collect_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Collect of the Day (from CollectService)
          lines.concat(build_collect_lines(@collects))

          # Resolve which final prayer to use from preferences
          option = resolve_conclusion_prayer

          prayer = fetch_liturgical_text("evening_3_final_prayer_#{option}")
          if prayer
            lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
          end

          # Other prayers rubric
          other_rubric = fetch_liturgical_text("evening_3_other_prayers_rubric")
          if other_rubric
            lines << line_item(other_rubric.content, type: "rubric", slug: other_rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Dismissal
          dismissal = fetch_liturgical_text("evening_3_conclusion_dismissal_minister")
          if dismissal
            lines << line_item(dismissal.content, type: "leader", slug: dismissal.slug)
          end

          dismissal_people = fetch_liturgical_text("evening_3_conclusion_dismissal_people")
          if dismissal_people
            lines << line_item(dismissal_people.content, type: "congregation", slug: dismissal_people.slug)
          end

          dismissal_all = fetch_liturgical_text("evening_3_conclusion_dismissal_all")
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

        # Resolve invitatory canticle from preferences
        def resolve_invitatory_canticle
          result = resolve_preference(:evening_3_invitating_canticle, %w[1 2])
          result || "1"
        end

        # Resolve canticle post first reading from preferences
        def resolve_canticle_post_first_reading
          result = resolve_preference(:evening_3_canticle_post_first_reading, %w[magnificat benedic_anima_mea])
          result&.to_sym || :magnificat
        end

        # Resolve canticle post second reading from preferences
        def resolve_canticle_post_second_reading
          result = resolve_preference(:evening_3_canticle_post_second_reading, %w[nunc_dimittis canticle_of_christ_glory gloria_et_honor])
          result&.to_sym || :nunc_dimittis
        end

        # Resolve conclusion prayer option from preferences
        def resolve_conclusion_prayer
          result = resolve_preference(:evening_3_conclusion, 1..3)
          result || 1
        end

        # Build Psalm 134 canticle
        def build_psalm_134_canticle(lines)
          psalm = fetch_liturgical_text("evening_3_psalm_134")
          if psalm
            lines << line_item(psalm.content, slug: psalm.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_3_psalm_134_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_psalm_134_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          format_canticle_name(psalm)
        end

        # Build Phos hilaron canticle
        def build_phos_hilaron_canticle(lines)
          phos = fetch_liturgical_text("evening_3_phos_hilaron")
          if phos
            lines << line_item(phos.content, slug: phos.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_3_phos_hilaron_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_phos_hilaron_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          format_canticle_name(phos)
        end

        # Build Magnificat canticle
        def build_magnificat_canticle(lines)
          magnificat = fetch_liturgical_text("evening_3_magnificat")
          if magnificat
            lines << line_item(magnificat.content, slug: magnificat.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_3_magnificat_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_magnificat_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          format_canticle_name(magnificat)
        end

        # Build Benedic anima mea canticle
        def build_benedic_anima_mea_canticle(lines)
          canticle = fetch_liturgical_text("evening_3_benedic_anima_mea")
          if canticle
            lines << line_item(canticle.content, slug: canticle.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_3_benedic_anima_mea_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_benedic_anima_mea_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          format_canticle_name(canticle)
        end

        # Build Nunc dimittis canticle
        def build_nunc_dimittis_canticle(lines)
          nunc = fetch_liturgical_text("evening_3_nunc_dimittis")
          if nunc
            lines << line_item(nunc.content, slug: nunc.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_3_nunc_dimittis_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_nunc_dimittis_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          format_canticle_name(nunc)
        end

        # Build Cântico da glória de Cristo
        def build_canticle_christ_glory(lines)
          canticle = fetch_liturgical_text("evening_3_canticle_christ_glory")
          if canticle
            lines << line_item(canticle.content, slug: canticle.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_3_canticle_christ_glory_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_canticle_christ_glory_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          format_canticle_name(canticle)
        end

        # Build Glória e honra canticle
        def build_gloria_et_honor_canticle(lines)
          canticle = fetch_liturgical_text("evening_3_gloria_et_honor")
          if canticle
            lines << line_item(canticle.content, slug: canticle.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("evening_3_gloria_et_honor_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("evening_3_gloria_et_honor_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          format_canticle_name(canticle)
        end

        # Build responsory
        def build_responsory(lines)
          rubric = fetch_liturgical_text("evening_3_responsory_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          (1..7).each do |i|
            minister = fetch_liturgical_text("evening_3_responsory_#{i}_minister")
            if minister
              lines << line_item(minister.content, type: "leader", slug: minister.slug)
            end

            all = fetch_liturgical_text("evening_3_responsory_#{i}_all")
            if all
              lines << line_item(all.content, type: "congregation", slug: all.slug)
            end
          end
        end
      end
    end
  end
end
