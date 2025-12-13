module DailyOffice
  module Builders
    module Loc2015
      class Midday < Base
        # Midday Prayer (Oração do Meio-Dia) specific implementation

        private

        def assemble_office
          assemble_midday_prayer
        end

        def assemble_midday_prayer
          [
            build_opening,
            build_invitation,
            build_psalms_title,
            build_psalms,
            build_readings,
            build_prayer,
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
          rubric = fetch_liturgical_text("midday_rubric_opening")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Preparation sentence
          preparation = fetch_liturgical_text("midday_preparation")
          if preparation
            lines << line_item(preparation.content, type: "leader")
            lines << line_item("", type: "spacer")
          end

          return nil if lines.empty?

          {
            name: "Acolhida",
            slug: "opening",
            lines: lines
          }
        end

        # 2. INVITATION
        def build_invitation
          lines = []

          # Rubric for invitation
          rubric = fetch_liturgical_text("midday_rubric_invitation")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Use Lent-specific invitation (without Alleluia) during Lent
          slug = is_lent? ? "midday_invitation_lent" : "midday_invitation"
          invitation = fetch_liturgical_text(slug)
          if invitation
            lines << line_item(invitation.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          return nil if lines.empty?

          {
            name: "Invitatório",
            slug: "invitation",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Psalms
        # ============================================================================

        # 3. PSALMS TITLE
        def build_psalms_title
          lines = []

          # Rubric before psalms
          rubric = fetch_liturgical_text("midday_rubric_psalm")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          return nil if lines.empty?

          {
            name: "Salmo",
            slug: "psalms_title",
            lines: lines
          }
        end

        # 4. PSALMS
        def build_psalms
          sections = []

          psalm_slugs = {
            1 => "lucerna_pedibus_meis",  # Psalm 119:105-112
            2 => "levavi_oculos",         # Psalm 121
            3 => "in_convertendo"         # Psalm 126
          }

          # Get selected psalms from preferences using resolve_preference
          selected_psalms = resolve_preference(
            :midday_inviting_canticle,
            [ 1, 2, 3 ]
          ) || [ 1, 2, 3 ]

          Array(selected_psalms).each do |psalm_num|
            psalm = fetch_liturgical_text(psalm_slugs[psalm_num])
            if psalm
              lines = []
              lines << line_item(psalm.content, type: "congregation")

              sections << {
                name: [ psalm.title, psalm.reference&.then { |ref| "(#{ref})" } ].compact.join(" ").presence || "Salmo",
                slug: psalm_slugs[psalm_num],
                lines: lines
              }
            end
          end

          sections
        end

        # ============================================================================
        # SECTION: Readings and Prayers
        # ============================================================================

        # 5. READINGS
        def build_readings
          lines = []

          # Rubric before readings
          rubric = fetch_liturgical_text("midday_rubric_before_readings")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Show all three readings sequentially
          (1..3).each do |reading_num|
            reading = fetch_liturgical_text("midday_reading_#{reading_num}")
            if reading
              lines << line_item(reading.content, type: "leader")
              lines << line_item("", type: "spacer")
            end
          end

          return nil if lines.empty?

          {
            name: "Leituras",
            slug: "readings",
            lines: lines
          }
        end

        # 6. LORD'S PRAYER
        def build_prayer
          lines = []

          # Rubric before prayers
          rubric = fetch_liturgical_text("midday_rubric_before_prayers")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Our Father
          our_father = fetch_liturgical_text("midday_our_father")
          if our_father
            lines << line_item(our_father.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          # Rubric after Our Father
          rubric_after = fetch_liturgical_text("rubric_after_our_father")
          if rubric_after
            lines << line_item(rubric_after.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          # Midday prayer
          prayer = fetch_liturgical_text("midday_prayer")
          if prayer
            lines << line_item(prayer.content, type: "responsive")
            lines << line_item("", type: "spacer")
          end

          # Rubric after prayer (mentions spontaneous prayers)
          rubric = fetch_liturgical_text("midday_rubric_after_prayer")
          if rubric
            lines << line_item(rubric.content, type: "rubric")
            lines << line_item("", type: "spacer")
          end

          return nil if lines.empty?

          {
            name: "Orações",
            slug: "prayer",
            lines: lines
          }
        end

        # ============================================================================
        # SECTION: Dismissal
        # ============================================================================

        # 8. DISMISSAL
        def build_dismissal
          lines = []

          # Use Lent-specific dismissal (without Alleluia) during Lent
          slug = is_lent? ? "midday_dismissal_lent" : "midday_dismissal"
          dismissal = fetch_liturgical_text(slug)
          if dismissal
            lines << line_item(dismissal.content, type: "responsive")
          end

          return nil if lines.empty?

          {
            name: "Despedida",
            slug: "dismissal",
            lines: lines
          }
        end
      end
    end
  end
end
