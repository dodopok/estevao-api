# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2015
      # Late Evening (Ao Anoitecer) - Specific for Family Rite
      class LateEvening < Base
        private

        def assemble_office
          assemble_late_evening
        end

        def assemble_late_evening
          [
            build_welcome,
            build_psalms,
            build_reading,
            build_lords_prayer,
            build_collect
          ].flatten.compact
        end

        def build_welcome
          text = fetch_liturgical_text("family_late_evening_opening")
          return nil unless text

          {
            name: "Ao Anoitecer",
            slug: "welcome",
            lines: [
              line_item(text.content, type: "leader", slug: text.slug)
            ]
          }
        end

        def build_psalms
          psalm = fetch_liturgical_text("family_late_evening_psalm_138")
          return nil unless psalm

          {
            name: "Confitebor Tibi (Salmo 138)",
            slug: "psalms",
            lines: [
              line_item(psalm.content, type: "congregation", slug: psalm.slug)
            ]
          }
        end

        def build_reading
          reading_num = resolve_preference(:family_late_evening_reading, 1..3) || 1
          text = fetch_liturgical_text("family_late_evening_reading_#{reading_num}")
          return nil unless text

          {
            name: "Leituras",
            slug: "reading",
            lines: [
              line_item(text.content, type: "leader", slug: text.slug),
              line_item("(#{text.reference})", type: "citation")
            ]
          }
        end

        def build_lords_prayer
          text = fetch_liturgical_text("our_father")
          return nil unless text

          {
            name: "Pai Nosso",
            slug: "lords_prayer",
            lines: [
              line_item(text.content, type: "congregation", slug: text.slug)
            ]
          }
        end

        def build_collect
          text = fetch_liturgical_text("family_late_evening_collect")
          return nil unless text

          {
            name: "Oração Conclusiva",
            slug: "collect",
            lines: [
              line_item(text.content, type: "leader", slug: text.slug)
            ]
          }
        end
      end
    end
  end
end
