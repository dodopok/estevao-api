module DailyOffice
  module Builders
    module Loc2015
      class Compline < Base
        # Compline (Oração da Noite/Completas) specific implementation
        # Final collects available for Compline
        COMPLINE_FINAL_PRAYER_SLUGS = %w[
          compline_final_prayer_1
          compline_final_prayer_2
          compline_final_prayer_3
          compline_final_prayer_4
          compline_final_prayer_5
          compline_final_prayer_6
        ].freeze

        private

        def assemble_office
          assemble_compline
        end

        def assemble_compline
          [
            build_opening,
            build_brief_lesson,
            build_confession,
            build_absolution,
            build_psalms_title,
            build_psalms,
            build_readings,
            build_response,
            build_kyrie,
            build_lords_prayer,
            build_antiphon,
            build_nunc_dimittis,
            build_dismissal
          ].flatten.compact
        end

        # ============================================================================
        # SECTION: Opening and Preparation
        # ============================================================================

        # 1. OPENING/PREPARATION
        def build_opening
          lines = []

          # Opening rubric
          rubric = fetch_liturgical_text("compline_rubric_opening")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Preparation sentence
          preparation = fetch_liturgical_text("compline_preparation")
          if preparation
            lines << line_item(preparation.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          # Post-preparation rubric
          post_prep_rubric = fetch_liturgical_text("compline_rubric_post_preparation")
          if post_prep_rubric
            lines << line_item(post_prep_rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          return nil if lines.empty?

          {
            name: "Preparação",
            slug: "opening",
            lines: lines
          }
        end

        def build_brief_lesson
          lines = []

          # Brief lesson
          brief_lesson = fetch_liturgical_text("compline_brief_lesson")
          if brief_lesson
            lines << line_item(brief_lesson.content, type: "leader")
            lines << line_item("", type: "spacer")
          end

          # Silence rubric
          silence_rubric = fetch_liturgical_text("compline_rubric_silence")
          lines << line_item(silence_rubric.content, type: "rubric") if silence_rubric

          return nil if lines.empty?

          {
            name: "Lição Breve",
            slug: "brief_lesson",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Confession and Absolution
        # ============================================================================

        # 2. CONFESSION
        def build_confession
          lines = []

          # Confession prayer
          confession = fetch_liturgical_text("compline_confession")
          return nil unless confession

          lines << line_item(confession.content, type: "congregation")
          lines << line_item("", type: "spacer")

          # Silence rubric
          silence_rubric = fetch_liturgical_text("compline_rubric_silence")
          lines << line_item(silence_rubric.content, type: "rubric") if silence_rubric

          # Post-confession response
          post_confession = fetch_liturgical_text("compline_post_confession")
          if post_confession
            lines << line_item(post_confession.content, type: "congregation")
          end

          {
            name: "Confissão",
            slug: "confession",
            lines: lines
          }
        end

        # 3. ABSOLUTION
        def build_absolution
          lines = []

          # Absolution prayer
          absolution = fetch_liturgical_text("compline_absolution")
          return nil unless absolution

          lines << line_item(absolution.content, type: "responsive")
          lines << line_item("", type: "spacer")

          # Post-absolution rubric (mentions hymn)
          rubric = fetch_liturgical_text("compline_rubric_post_absolution")
          lines << line_item(rubric.content, type: "rubric") if rubric

          {
            name: "Súplica de Perdão",
            slug: "absolution",
            lines: lines
          }
        end

        def build_psalms_title
          lines = []

          # Rubric before psalms
          rubric = fetch_liturgical_text("compline_rubric_before_psalms")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
          end

          return nil if lines.empty?

          {
            name: "Salmodia",
            slug: "psalms",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Psalms
        # ============================================================================

        # 4. PSALMS
        def build_psalms
          psalm_slugs = {
            1 => "cum_invocarem",    # Psalm 4
            2 => "qui_habitat",      # Psalm 91
            3 => "ecce_nunc"         # Psalm 134
          }

          # Get selected psalms from preferences using resolve_preference
          selected_psalms = Array(resolve_preference(
            :compline_inviting_canticle,
            [ 1, 2, 3 ]
          ) || [ 1, 2, 3 ])

          # Return array of psalm modules (one per psalm)
          modules = selected_psalms.map do |psalm_num|
            psalm = fetch_liturgical_text(psalm_slugs[psalm_num])
            next unless psalm

            {
              name: [psalm.title, psalm.reference&.then { |ref| "(#{ref})" }].compact.join(" ").presence || "Salmo",
              slug: psalm_slugs[psalm_num],
              lines: [
                line_item(psalm.content, type: "congregation")
              ]
            }
          end.compact

          # Add silence rubric as separate module after all psalms
          silence_rubric = fetch_liturgical_text("compline_rubric_silence")
          if silence_rubric && modules.any?
            modules << {
              name: "",
              slug: "rubric_silence",
              lines: [
                line_item(silence_rubric.content, type: "rubric")
              ]
            }
          end

          modules
        end

        # ============================================================================
        # SECTION: Readings and Responsory
        # ============================================================================

        # 5. READINGS
        def build_readings
          lines = []

          # Rubric before lessons
          rubric = fetch_liturgical_text("compline_rubric_before_lessons")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Brief lesson (3 options: Jeremiah, Matthew, Hebrews)
          lesson_num = resolve_preference(:compline_brief_lesson, 1..3) 
          lesson = fetch_liturgical_text("compline_brief_lesson_#{lesson_num}")
          if lesson
            lines << line_item(lesson.content, type: "leader")
            lines << line_item("", type: "spacer")
          end

          # Post-lessons rubric (mentions Te Lucis hymn)
          post_rubric = fetch_liturgical_text("compline_rubric_post_lessons")
          lines << line_item(post_rubric.content, type: "rubric") if post_rubric

          # Silence rubric
          silence_rubric = fetch_liturgical_text("compline_rubric_silence")
          lines << line_item(silence_rubric.content, type: "rubric") if silence_rubric

          return nil if lines.empty?

          {
            name: "Lições Breves",
            slug: "readings",
            lines: lines
          }
        end

        # 6. BRIEF RESPONSE
        def build_response
          response = fetch_liturgical_text("compline_brief_response")
          return nil unless response

          {
            name: "Responsório Breve",
            slug: "response",
            lines: [
              line_item(response.content, type: "responsive")
            ]
          }
        end

        # ============================================================================
        # SECTION: Kyrie and Prayers
        # ============================================================================

        # 7. KYRIE
        def build_kyrie
          # Choose translated or original based on preference
          kyrie_slug = preferences[:office_type] == "traditional" ? "kyrie_original" : "kyrie_translated"
          kyrie = fetch_liturgical_text(kyrie_slug)
          return nil unless kyrie

          {
            name: "Kyrie Eleison",
            slug: "kyrie",
            lines: [
              line_item(kyrie.content, type: "congregation")
            ]
          }
        end

        # 8. LORD'S PRAYER
        def build_lords_prayer
          lines = []

          # Rubric before prayers
          rubric = fetch_liturgical_text("rubric_before_prayers")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Our Father (Compline version - said silently until end)
          our_father = fetch_liturgical_text("compline_our_father")
          if our_father
            lines << line_item(our_father.content, type: "congregation")
            lines << line_item("", type: "spacer")
          end

          # Starting prayer responses
          starting_prayer = fetch_liturgical_text("compline_starting_prayer")
          lines << line_item(starting_prayer.content, type: "responsive") if starting_prayer

          return nil if lines.empty?

          # Rubric before final prayers
          rubric = fetch_liturgical_text("compline_rubric_before_final_prayer")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Final prayers (6 options - can select multiple)
          selected_collects = resolve_preference(:compline_final_prayer, 1..6)

          Array(selected_collects).each_with_index do |collect_num, index|
            collect = fetch_liturgical_text("compline_final_prayer_#{collect_num}")
            if collect
              lines << line_item(collect.content, type: "leader")
              # Add spacer between collects, but not after the last one
              lines << line_item("", type: "spacer") if index < Array(selected_collects).length - 1
            end
          end

          # Rubric before antiphon
          rubric = fetch_liturgical_text("compline_rubric_before_antiphon")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          return nil if lines.empty?

          {
            name: "Orações",
            slug: "lords_prayer",
            lines: lines
          }
        end

        def build_antiphon
          lines = []

          # Antiphon
          antiphon = fetch_liturgical_text("compline_antiphon")
          if antiphon
            lines << line_item(antiphon.content, type: "congregation")
          end

          {
            name: "Antífona",
            slug: "antiphon",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Nunc Dimittis and Dismissal
        # ============================================================================

        # 10. NUNC DIMITTIS
        def build_nunc_dimittis
          lines = []

          # Nunc Dimittis (Song of Simeon)
          nunc_dimittis = fetch_liturgical_text("nunc_dimittis")
          return nil unless nunc_dimittis

          lines << line_item(nunc_dimittis.content, type: "congregation")

          {
            name: "Nunc Dimittis",
            slug: "nunc_dimittis",
            lines: lines
          }
        end

        # 11. DISMISSAL
        def build_dismissal
          lines = []

          # Antiphon
          antiphon = fetch_liturgical_text("compline_antiphon")
          if antiphon
            lines << line_item(antiphon.content, type: "congregation")
          end

          # Final prayer
          final_prayer = fetch_liturgical_text("compline_final_prayer")
          if final_prayer
            lines << line_item(final_prayer.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          # Final rubric (no blessing, leave in silence)
          rubric = fetch_liturgical_text("compline_final_rubric")
          lines << line_item(rubric.content, type: "rubric") if rubric

          return nil if lines.empty?

          {
            name: "Antífona",
            slug: "dismissal",
            lines: lines
          }
        end
      end
    end
  end
end
