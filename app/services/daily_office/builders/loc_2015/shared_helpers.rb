# frozen_string_literal: true

module DailyOffice
  module Builders
    module Loc2015
      module SharedHelpers
        private

        # Generates a random number within the given range using an optional seed.
        # When a seed is provided via preferences[:seed], the randomization is deterministic.
        # This allows sharing the same office configuration via QR code or link.
        #
        # @param range [Range] The range of numbers to select from (e.g., 1..7)
        # @param key [Symbol] A unique identifier for this randomization point
        # @return [Integer] A random number within the range
        def seeded_random(range, key:)
          if preferences[:seed]
            # Use seed + key hash to ensure different randomization points
            # produce different but deterministic results
            Random.new(preferences[:seed] + key.hash).rand(range)
          else
            # No seed provided, use standard random behavior
            rand(range)
          end
        end

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
