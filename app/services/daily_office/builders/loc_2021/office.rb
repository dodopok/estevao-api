# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2021
      class Office < Base
        def assemble_office
          if preferences[:office_type] == "alternative"
            assemble_alternative_office
          else
            assemble_traditional_office
          end
        end

        private

        def assemble_traditional_office
          [
            build_welcome,
            build_confession,
            build_absolution,
            build_thanksgiving,
            build_lessons,
            {
              name: "SERMÃO",
              slug: "sermon",
              lines: []
            },
            build_creed,
            build_lords_prayer,
            build_blessing
          ].flatten.compact
        end

        def assemble_alternative_office
          m_grace = fetch_liturgical_text("grace_m")
          r_grace = fetch_liturgical_text("grace_r")

          [
            build_alt_welcome,
            build_alt_confession,
            build_lords_prayer,
            build_lessons,
            build_creed,
            build_collect_of_the_day,
            build_other_prayers,
            {
              name: "A GRAÇA",
              slug: "grace",
              lines: [
                line_item(m_grace&.content, type: "leader", slug: m_grace&.slug),
                line_item(r_grace&.content, type: "congregation", slug: r_grace&.slug)
              ].compact
            }
          ].flatten.compact
        end
      end
    end
  end
end
