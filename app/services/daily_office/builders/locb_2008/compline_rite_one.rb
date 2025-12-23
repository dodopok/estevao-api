# frozen_string_literal: true

module DailyOffice
  module Builders
    module Locb2008
      # LOCB 2008 Compline Prayer Rite One (Ofício de Completas I)
      #
      # This builder follows the structure from the
      # Livro de Oração Comum Brasileiro 2008, pages 109-116.
      #
      # Este Ofício serve de conclusão para as atividades do dia, induzindo à reflexão
      # e à tranquilização antes do recolher. É próprio para conclusão de reuniões de
      # estudo bíblico, meditação e oração, que se realizem à noite, especialmente na
      # Quaresma. Uma vez concluído, todos se retiram em silêncio.
      #
      # Structure:
      # 1. Abertura (Opening)
      # 2. Frases de Abertura (Brief Lessons)
      # 3. Confissão (Confession)
      # 4. Hino - Te lucis ante terminum (Hymn)
      # 5. Salmodia (Psalmody)
      # 6. A Palavra de Deus (Word of God)
      # 7. Nunc Dimittis (Canticle)
      # 8. Kyrie e Pai Nosso (Kyrie and Lord's Prayer)
      # 9. Responso (Responsory)
      # 10. Orações Finais (Final Prayers)
      # 11. Conclusão (Conclusion/Blessing)
      #
      class ComplineRiteOne < Base
        private

        def assemble_office
          assemble_compline_prayer
        end

        def assemble_compline_prayer
          [
            build_opening,
            build_hymn,
            build_psalms,
            build_word_of_god,
            build_conclusion
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening
        # ============================================================================

        def build_opening
          lines = []

          # Opening versicle
          opening_minister = fetch_liturgical_text("compline_1_opening_minister")
          if opening_minister
            lines << line_item(opening_minister.content, type: "leader", slug: opening_minister.slug)
          end

          opening_all = fetch_liturgical_text("compline_1_opening_all")
          if opening_all
            lines << line_item(opening_all.content, type: "congregation", slug: opening_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Brief lessons rubric
          rubric = fetch_liturgical_text("compline_1_brief_lesson_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve brief lesson preference
          lesson_num = resolve_preference(:compline_1_brief_lesson, 1..3) || 1

          Array(lesson_num).each do |num|
            lesson = fetch_liturgical_text("compline_1_brief_lesson_#{num}")
            if lesson
              lines << line_item(lesson.content + " " + lesson.title, type: "leader", slug: lesson.slug)
              lines << line_item("", type: "spacer")
            end
          end

          # Confession rubric
          rubric = fetch_liturgical_text("compline_1_confession_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Invitation
          invitation = fetch_liturgical_text("compline_1_confession_invitation_minister")
          if invitation
            lines << line_item(invitation.content, type: "leader", slug: invitation.slug)
            lines << line_item("", type: "spacer")
          end

          # Confession prayer
          confession = fetch_liturgical_text("compline_1_confession_prayer_all")
          if confession
            lines << line_item(confession.content, type: "congregation", slug: confession.slug)
            lines << line_item("", type: "spacer")
          end

          # Absolution
          absolution = fetch_liturgical_text("compline_1_absolution_minister")
          if absolution
            lines << line_item(absolution.content, type: "leader", slug: absolution.slug)
          end

          absolution_all = fetch_liturgical_text("compline_1_absolution_all")
          if absolution_all
            lines << line_item(absolution_all.content, type: "congregation", slug: absolution_all.slug)
          end

          {
            name: "Abertura",
            slug: "opening",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Hymn
        # ============================================================================

        def build_hymn
          lines = []

          # Hymn rubric
          rubric = fetch_liturgical_text("compline_1_hymn_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Te lucis ante terminum hymn
          hymn = fetch_liturgical_text("compline_1_hymn_te_lucis")
          if hymn
            lines << line_item(hymn.content, slug: hymn.slug)
          end

          {
            name: hymn.title || "Hino",
            type: "canticle",
            slug: "hymn",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Psalmody
        # ============================================================================

        def build_psalms
          sections = []

          psalm_mapping = {
            "psalm_4" => "compline_1_psalm_4",
            "psalm_16" => "compline_1_psalm_16",
            "psalm_17" => "compline_1_psalm_17",
            "psalm_31" => "compline_1_psalm_31",
            "psalm_91" => "compline_1_psalm_91",
            "psalm_134" => "compline_1_psalm_134",
            "psalm_139" => "compline_1_psalm_139"
          }

          # Resolve psalm preference
          selected_psalm = resolve_preference(:compline_1_psalm, psalm_mapping.keys)

          # Add psalmody rubric
          rubric = fetch_liturgical_text("compline_1_psalmody_rubric")

          Array(selected_psalm).each_with_index do |psalm_key, index|
            psalm_slug = psalm_mapping[psalm_key]
            next unless psalm_slug

            psalm = fetch_liturgical_text(psalm_slug)
            next unless psalm

            lines = []

            # Add rubric only for the first psalm
            if index.zero? && rubric
              lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
              lines << line_item("", type: "spacer")
            end

            lines << line_item(psalm.content, type: "responsive", slug: psalm.slug)
            lines << line_item("", type: "spacer")

            # Gloria Patri after psalm
            gloria_minister = fetch_liturgical_text("#{psalm_slug}_gloria_minister")
            if gloria_minister
              lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
            end

            gloria_all = fetch_liturgical_text("#{psalm_slug}_gloria_all")
            if gloria_all
              lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
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
        # SECTION: Word of God
        # ============================================================================

        def build_word_of_god
          lines = []

          # Rubric
          rubric = fetch_liturgical_text("compline_1_word_of_god_rubric")
          if rubric
            lines << line_item(rubric.title, type: "heading") if rubric.title.present?
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # References
          references = fetch_liturgical_text("compline_1_word_of_god_references")
          if references
            lines << line_item(references.content, type: "leader", slug: references.slug)
            lines << line_item("", type: "spacer")
          end

          # Response
          response_reader = fetch_liturgical_text("compline_1_word_of_god_response_reader")
          if response_reader
            lines << line_item(response_reader.content, type: "reader", slug: response_reader.slug)
          end

          response_all = fetch_liturgical_text("compline_1_word_of_god_response_all")
          if response_all
            lines << line_item(response_all.content, type: "congregation", slug: response_all.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("compline_1_nunc_dimittis_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Antiphon (before)
          antiphon = fetch_liturgical_text("compline_1_nunc_dimittis_antiphon_all")
          if antiphon
            lines << line_item(antiphon.content, type: "congregation", slug: antiphon.slug)
            lines << line_item("", type: "spacer")
          end

          # Nunc Dimittis
          nunc_dimittis = fetch_liturgical_text("compline_1_nunc_dimittis")
          if nunc_dimittis
            lines << line_item(nunc_dimittis.content, slug: nunc_dimittis.slug)
            lines << line_item("", type: "spacer")
          end

          # Gloria Patri
          gloria_minister = fetch_liturgical_text("compline_1_nunc_dimittis_gloria_minister")
          if gloria_minister
            lines << line_item(gloria_minister.content, type: "leader", slug: gloria_minister.slug)
          end

          gloria_all = fetch_liturgical_text("compline_1_nunc_dimittis_gloria_all")
          if gloria_all
            lines << line_item(gloria_all.content, type: "congregation", slug: gloria_all.slug)
            lines << line_item("", type: "spacer")
          end

          # Antiphon (repeat after)
          antiphon_repeat = fetch_liturgical_text("compline_1_nunc_dimittis_antiphon_repeat_all")
          if antiphon_repeat
            lines << line_item(antiphon_repeat.content, type: "congregation", slug: antiphon_repeat.slug)
          end

          # Kyrie
          kyrie1 = fetch_liturgical_text("compline_1_kyrie_minister")
          if kyrie1
            lines << line_item(kyrie1.content, type: "leader", slug: kyrie1.slug)
          end

          kyrie2 = fetch_liturgical_text("compline_1_kyrie_all")
          if kyrie2
            lines << line_item(kyrie2.content, type: "congregation", slug: kyrie2.slug)
          end

          kyrie3 = fetch_liturgical_text("compline_1_kyrie_minister_2")
          if kyrie3
            lines << line_item(kyrie3.content, type: "leader", slug: kyrie3.slug)
            lines << line_item("", type: "spacer")
          end

          # Lord's Prayer
          lords_prayer = fetch_liturgical_text("compline_1_lords_prayer_all")
          if lords_prayer
            lines << line_item(lords_prayer.content, type: "congregation", slug: lords_prayer.slug)
          end

          # Rubric
          rubric = fetch_liturgical_text("compline_1_responsory_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Responsory verses (1-4)
          (1..4).each do |num|
            minister = fetch_liturgical_text("compline_1_responsory_#{num}_minister")
            if minister
              lines << line_item(minister.content, type: "leader", slug: minister.slug)
            end

            all = fetch_liturgical_text("compline_1_responsory_#{num}_all")
            if all
              lines << line_item(all.content, type: "congregation", slug: all.slug)
            end
          end

          # Rubric
          rubric = fetch_liturgical_text("compline_1_final_prayers_rubric")
          if rubric
            lines << line_item(rubric.content, type: "rubric", slug: rubric.slug)
            lines << line_item("", type: "spacer")
          end

          # Resolve final prayer preference
          prayer_num = resolve_preference(:compline_1_final_prayer, 1..6) || 1

          Array(prayer_num).each do |num|
            prayer = fetch_liturgical_text("compline_1_final_prayer_#{num}")
            if prayer
              lines << line_item(prayer.content, type: "leader", slug: prayer.slug)
              lines << line_item("", type: "spacer")
            end
          end

          # Easter prayer (if in Easter season)
          if is_easter_season?
            easter_rubric = fetch_liturgical_text("compline_1_easter_prayer_rubric")
            if easter_rubric
              lines << line_item(easter_rubric.content, type: "rubric", slug: easter_rubric.slug)
              lines << line_item("", type: "spacer")
            end

            easter_prayer = fetch_liturgical_text("compline_1_easter_prayer")
            if easter_prayer
              lines << line_item(easter_prayer.content, type: "leader", slug: easter_prayer.slug)
            end
          end

          {
            name: "A Palavra de Deus",
            slug: "word_of_god",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Conclusion
        # ============================================================================

        def build_conclusion
          lines = []

          # Resolve conclusion preference
          conclusion_type = resolve_preference(:compline_1_conclusion, 1..2) || 1

          case conclusion_type
          when 1
            build_conclusion_option_1(lines)
          when 2
            build_conclusion_option_2(lines)
          else
            build_conclusion_option_1(lines)
          end

          {
            name: "Conclusão",
            slug: "conclusion",
            lines: lines
          }
        end

        private

        # ============================================================================
        # SECTION: Helper Methods
        # ============================================================================

        def build_conclusion_option_1(lines)
          # Standard conclusion
          minister1 = fetch_liturgical_text("compline_1_conclusion_1_minister")
          if minister1
            lines << line_item(minister1.content, type: "leader", slug: minister1.slug)
          end

          all1 = fetch_liturgical_text("compline_1_conclusion_1_all")
          if all1
            lines << line_item(all1.content, type: "congregation", slug: all1.slug)
          end

          minister2 = fetch_liturgical_text("compline_1_conclusion_1_minister_2")
          if minister2
            lines << line_item(minister2.content, type: "leader", slug: minister2.slug)
          end

          all2 = fetch_liturgical_text("compline_1_conclusion_1_all_2")
          if all2
            lines << line_item(all2.content, type: "congregation", slug: all2.slug)
            lines << line_item("", type: "spacer")
          end

          # Easter rubric (if in Easter season)
          if is_easter_season?
            easter_rubric = fetch_liturgical_text("compline_1_conclusion_easter_rubric")
            if easter_rubric
              lines << line_item(easter_rubric.content, type: "rubric", slug: easter_rubric.slug)
              lines << line_item("", type: "spacer")
            end
          end

          # Blessing
          blessing = fetch_liturgical_text("compline_1_conclusion_blessing_minister")
          if blessing
            lines << line_item(blessing.content, type: "leader", slug: blessing.slug)
          end

          blessing_all = fetch_liturgical_text("compline_1_conclusion_blessing_all")
          if blessing_all
            lines << line_item(blessing_all.content, type: "congregation", slug: blessing_all.slug)
          end
        end

        def build_conclusion_option_2(lines)
          # Alternative conclusion (dismissal)
          minister = fetch_liturgical_text("compline_1_conclusion_2_minister")
          if minister
            lines << line_item(minister.content, type: "leader", slug: minister.slug)
          end

          people = fetch_liturgical_text("compline_1_conclusion_2_people")
          if people
            lines << line_item(people.content, type: "congregation", slug: people.slug)
          end

          all = fetch_liturgical_text("compline_1_conclusion_2_all")
          if all
            lines << line_item(all.content, type: "congregation", slug: all.slug)
          end
        end

        def is_easter_season?
          season = day_info[:liturgical_season]&.downcase
          season == "páscoa" || season == "pascoa" || season == "easter"
        end

        def is_sunday?
          date.sunday?
        end
      end
    end
  end
end
