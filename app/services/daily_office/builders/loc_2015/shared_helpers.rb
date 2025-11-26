# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2015
      module SharedHelpers
        private

        def fetch_liturgical_text(slug)
          return nil unless prayer_book

          LiturgicalText.find_by(
            slug: slug,
            prayer_book_id: prayer_book.id
          )
        end

        def line_item(text, type: "text")
          { text: text, type: type }
        end

        def is_lent?
          lent_season?(day_info[:liturgical_season])
        end

        def season_specific_antiphon
          season = day_info[:liturgical_season]
          season_slug = season_to_antiphon_slug(season, feast_day: day_info[:feast_day])
          return nil unless season_slug

          "morning_before_invocation_#{season_slug}"
        end
      end
    end
  end
end
