# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Compline Prayer Rite Two (Ofício de Completas II)
      #
      # This builder follows the structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 117-122.
      #
      # Este Ofício serve de conclusão para as atividades do dia, induzindo à reflexão
      # e à tranquilização antes do recolher. Uma vez concluído, todos se retiram em silêncio.
      #
      # Structure:
      # 1. Abertura (Opening)
      # 2. Lição Breve (Brief Lesson)
      # 3. Confissão (Confession)
      # 4. Declaração de Perdão (Absolution)
      # 5. Salmodia (Psalmody) - Salmos 4, 91, 134
      # 6. Hino - Te lucis ante terminum (Hymn)
      # 7. Leitura Bíblica (Bible Reading)
      # 8. Responsório Breve (Brief Responsory)
      # 9. Kyrie e Pai Nosso (Kyrie and Lord's Prayer)
      # 10. Versículos e Respostas (Versicles and Responses)
      # 11. Orações Finais (Final Prayers)
      # 12. Nunc Dimittis (Canticle)
      # 13. Conclusão (Conclusion/Blessing)
      #
      class ComplineRiteTwo < Base
        private

        def assemble_office
          assemble_compline_prayer
        end

        def assemble_compline_prayer
          [
            build_opening,
            build_psalms,
            build_hymn,
            build_word_of_god
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening
        # ============================================================================

        def build_opening
          lines = []

          # Opening rubric
          rubric = fetch_liturgical_text("compline_2_opening_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Opening versicle
          opening_minister = fetch_liturgical_text("compline_2_opening_minister")
          if opening_minister
            lines << line_item(opening_minister.content, type: "leader", slug: opening_minister.slug)
          end

          opening_all = fetch_liturgical_text("compline_2_opening_all")
          if opening_all
            lines << line_item(opening_all.content, type: "congregation", slug: opening_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Brief lesson rubric
          rubric = fetch_liturgical_text("compline_2_brief_lesson_rubric")
          if rubric
            lines << line_item(rubric.title, type: "heading") if rubric.title.present?
            lines << line_item("", type: "spacer")
          end

          # Brief lesson
          lesson = fetch_liturgical_text("compline_2_brief_lesson_minister")
          if lesson
            lines << line_item(lesson.content, type: "leader", slug: lesson.slug)
          end

          lesson_all = fetch_liturgical_text("compline_2_brief_lesson_all")
          if lesson_all
            lines << line_item(lesson_all.content, type: "congregation", slug: lesson_all.slug)
          end

          lesson_2 = fetch_liturgical_text("compline_2_brief_lesson_minister_2")
          if lesson_2
            lines << line_item(lesson_2.content, type: "leader", slug: lesson_2.slug)
          end

          lesson_all_2 = fetch_liturgical_text("compline_2_brief_lesson_all_2")
          if lesson_all_2
            lines << line_item(lesson_all_2.content, type: "congregation", slug: lesson_all_2.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession title
          confession_title = fetch_liturgical_text("compline_2_confession_title")
          if confession_title
            lines << line_item(confession_title.title, type: "heading") if confession_title.title.present?
            lines << line_item("", type: "spacer")
          end

          # Confession invitation
          invitation = fetch_liturgical_text("compline_2_confession_invitation_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
          end

          # Confession prayer
          confession = fetch_liturgical_text("compline_2_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution rubric
          absolution_rubric = fetch_liturgical_text("compline_2_absolution_rubric")
          if absolution_rubric
            lines << line_item(absolution_rubric.title, type: "heading") if absolution_rubric.title.present?
            lines << line_item("", type: "spacer")
          end

          # Absolution
          absolution = fetch_liturgical_text("compline_2_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("compline_2_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
          end

          # Absolution versicles
          absolution_2 = fetch_liturgical_text("compline_2_absolution_minister_2")
          if absolution_2
            lines << line_item(absolution_2.content, type: "leader", slug: absolution_2.slug)
          end

          absolution_all_2 = fetch_liturgical_text("compline_2_absolution_all_2")
          if absolution_all_2
            lines << line_item(absolution_all_2.content, type: "congregation", slug: absolution_all_2.slug)
          end

          absolution_3 = fetch_liturgical_text("compline_2_absolution_minister_3")
          if absolution_3
            lines << line_item(absolution_3.content, type: "leader", slug: absolution_3.slug)
          end

          absolution_all_3 = fetch_liturgical_text("compline_2_absolution_all_3")
          if absolution_all_3
            lines << line_item(absolution_all_3.content, type: "congregation", slug: absolution_all_3.slug)
          end

          # Gloria
          gloria = fetch_liturgical_text("compline_2_gloria_minister")
          if gloria
            lines << line_item(gloria.content, type: "leader", slug: gloria.slug)
          end

          gloria_all = fetch_liturgical_text("compline_2_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
          end

          {
            name: "Abertura",
            slug: "opening",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Psalmody
        # ============================================================================

        def build_psalms
          sections = []

          psalm_mapping = {
            "psalm_4" => "compline_2_psalm_4",
            "psalm_91" => "compline_2_psalm_91",
            "psalm_134" => "compline_2_psalm_134"
          }

          # Resolve psalm preference
          selected_psalm = resolve_preference(:compline_2_psalm, psalm_mapping.keys)

          Array(selected_psalm).each do |psalm_key|
            psalm_slug = psalm_mapping[psalm_key]
            next unless psalm_slug

            psalm = fetch_liturgical_text(psalm_slug)
            next unless psalm

            lines = []

            lines << line_item(psalm.content, type: "responsive", slug: psalm.slug)
            lines << line_item("", type: "spacer")

            # Gloria Patri after psalm (not for hymn)
            unless psalm_key == "te_lucis_ante_terminum"
              gloria_minister = fetch_liturgical_text("#{psalm_slug}_gloria_minister")
              if gloria_minister
                lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
              end

              gloria_all = fetch_liturgical_text("#{psalm_slug}_gloria_all")
              if gloria_all
                lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
              end
            end

            sections << {
              name: psalm.title || "Salmo",
              type: "canticle",
              slug: psalm_slug,
              reference: psalm.reference,
              lines: lines
            }
          end

          sections
        end

        # ============================================================================
        # SECTION: Hymn
        # ============================================================================

        def build_hymn
          lines = []

          # Hymn rubric
          rubric = fetch_liturgical_text("compline_2_hymn_rubric")
          if rubric
            lines << line_item(rubric.title, type: "heading") if rubric.title.present?
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Te lucis ante terminum hymn
          hymn = fetch_liturgical_text("compline_2_hymn_te_lucis")
          if hymn
            lines << line_item(hymn.content, slug: hymn.slug)
          end

          {
            name: hymn&.title || "Hino",
            type: "canticle",
            slug: "hymn",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Word of God
        # ============================================================================

        def build_word_of_god
          lines = []

          # Reading rubric
          rubric = fetch_liturgical_text("compline_2_reading_rubric")
          if rubric
            lines << line_item(rubric.title, type: "heading") if rubric.title.present?
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Response rubric
          rubric_response = fetch_liturgical_text("compline_2_reading_rubric_response")
          if rubric_response
            lines << line_item(rubric_response.content, type: "rubric", slug: rubric_response.slug)
            lines << line_item("", type: "spacer")
          end

          # Response
          response_reader = fetch_liturgical_text("compline_2_reading_response_reader")
          if response_reader
            lines << line_item(response_reader.content, type: "reader", slug: response_reader.slug)
          end

          response_all = fetch_liturgical_text("compline_2_reading_response_all")
          if response_all
            lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Responsory rubric
          responsory_rubric = fetch_liturgical_text("compline_2_responsory_rubric")
          if responsory_rubric
            lines << line_item(responsory_rubric.title, type: "heading") if responsory_rubric.title.present?
            lines << line_item("", type: "spacer")
          end

          # Responsory verses (1-4)
          (1..4).each do |num|
            minister = fetch_liturgical_text("compline_2_responsory_#{num}_minister")
            if minister
              lines << line_item(minister.content, type: "leader", slug: minister.slug)
            end

            all = fetch_liturgical_text("compline_2_responsory_#{num}_all")
            if all
              lines << line_item(all.content, type: "congregation", slug: all.slug)
            end
          end

          lines << line_item("", type: "spacer")

          # Kyrie rubric
          kyrie_rubric = fetch_liturgical_text("compline_2_kyrie_rubric")
          if kyrie_rubric
            lines << line_item(kyrie_rubric.title, type: "heading") if kyrie_rubric.title.present?
            lines << line_item("", type: "spacer")
          end

          # Kyrie
          kyrie1 = fetch_liturgical_text("compline_2_kyrie_minister")
          if kyrie1
            lines << line_item(kyrie1.content, type: "leader", slug: kyrie1.slug)
          end

          kyrie2 = fetch_liturgical_text("compline_2_kyrie_all")
          if kyrie2
            lines << line_item(kyrie2.content, type: "congregation", slug: kyrie2.slug)
          end

          kyrie3 = fetch_liturgical_text("compline_2_kyrie_minister_2")
          if kyrie3
            lines << line_item(kyrie3.content, type: "leader", slug: kyrie3.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("compline_2_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
            lines << line_item("", type: "spacer")
          end

          # Versicles and Responses
          (1..4).each do |num|
            minister = fetch_liturgical_text("compline_2_versicle_#{num}_minister")
            if minister
              lines << line_item(minister.content, type: "leader", slug: minister.slug)
            end

            all = fetch_liturgical_text("compline_2_versicle_#{num}_all")
            if all
              lines << line_item(all.content, type: "congregation", slug: all.slug)
            end
          end

          lines << line_item("", type: "spacer")

          # Final prayers rubric
          rubric = fetch_liturgical_text("compline_2_final_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve final prayer preference
          prayer_num = resolve_preference(:compline_2_final_prayer, 1..5) || 1

          Array(prayer_num).each do |num|
            prayer = fetch_liturgical_text("compline_2_final_prayer_#{num}")
            if prayer
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
              lines << line_item("", type: "spacer")
            end
          end

          # Antiphon after prayers
          antiphon = fetch_liturgical_text("compline_2_final_prayers_response_all")
          if antiphon
            lines << line_item(antiphon.content, type: "congregation", slug: antiphon.slug)
            lines << line_item("", type: "spacer")
          end

          # Nunc Dimittis rubric
          nunc_rubric = fetch_liturgical_text("compline_2_nunc_dimittis_rubric")
          if nunc_rubric
            lines << line_item(nunc_rubric.title, type: "heading") if nunc_rubric.title.present?
            lines << line_item("", type: "spacer")
          end

          # Nunc Dimittis
          nunc_dimittis = fetch_liturgical_text("compline_2_nunc_dimittis")
          if nunc_dimittis
            lines << line_item(nunc_dimittis.content, slug: nunc_dimittis.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("compline_2_nunc_dimittis_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("compline_2_nunc_dimittis_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Antiphon (repeat after)
          antiphon_repeat = fetch_liturgical_text("compline_2_nunc_dimittis_antiphon_repeat_all")
          if antiphon_repeat
            lines << line_item(antiphon_repeat.content, type: "congregation", slug: antiphon_repeat.slug)
          end

          # Conclusion versicle
          versicle = fetch_liturgical_text("compline_2_conclusion_versicle_minister")
          if versicle
            lines << line_item(versicle.content, type: "leader", slug: versicle.slug)
          end

          versicle_all = fetch_liturgical_text("compline_2_conclusion_versicle_all")
          if versicle_all
            lines << line_item(versicle_all.content, type: "congregation", slug: versicle_all.slug)
            lines << line_item("", type: "spacer")
          end

          # The Lord be with you
          minister1 = fetch_liturgical_text("compline_2_conclusion_1_minister")
          if minister1
            lines << line_item(minister1.content, type: "leader", slug: minister1.slug)
          end

          all1 = fetch_liturgical_text("compline_2_conclusion_1_all")
          if all1
            lines << line_item(all1.content, type: "congregation", slug: all1.slug)
          end

          # Let us bless the Lord
          minister2 = fetch_liturgical_text("compline_2_conclusion_2_minister")
          if minister2
            lines << line_item(minister2.content, type: "leader", slug: minister2.slug)
          end

          all2 = fetch_liturgical_text("compline_2_conclusion_2_all")
          if all2
            lines << line_item(all2.content, type: "congregation", slug: all2.slug)
            lines << line_item("", type: "spacer")
          end

          # Blessing
          blessing = fetch_liturgical_text("compline_2_blessing_minister")
          if blessing
            lines << line_item(blessing.content, type: "leader", slug: blessing.slug)
          end

          blessing_all = fetch_liturgical_text("compline_2_blessing_all")
          if blessing_all
            lines << line_item(blessing_all.content, type: "congregation", slug: blessing_all.slug)
          end

          # Final blessing
          final_blessing = fetch_liturgical_text("compline_2_final_blessing_minister")
          if final_blessing
            lines << line_item(final_blessing.content, type: "leader", slug: final_blessing.slug)
          end

          final_blessing_all = fetch_liturgical_text("compline_2_final_blessing_all")
          if final_blessing_all
            lines << line_item(final_blessing_all.content, type: "congregation", slug: final_blessing_all.slug)
          end

          {
            name: "A Palavra de Deus",
            slug: "word_of_god",
            lines: lines
          }
        end
      end
    end
  end
end
