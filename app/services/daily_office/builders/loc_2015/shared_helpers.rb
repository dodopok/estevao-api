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

        # Resolves a preference value to handle "random", "all", specific values, or nil.
        #
        # This helper standardizes preference handling across LOC 2015 builders, supporting:
        # - Numeric ranges (e.g., 1..7) for numbered liturgical texts
        # - Slug arrays (e.g., %w[venite jubilate]) for named texts
        # - Special values "random" and "all"
        #
        # @param pref_value [String, Integer, nil] The preference value from user settings
        # @param options [Range, Array] Available options (Range for numeric, Array for slugs)
        # @param random_key [Symbol] Unique key for deterministic seeded randomization
        #
        # @return [Integer, String, Array, nil] Resolved value(s) based on preference type
        #   - Returns Integer when options is Range and pref_value is numeric or "random"
        #   - Returns String when options is Array and pref_value is specific slug or "random"
        #   - Returns Array when pref_value is "all" (options.to_a for Range, options for Array)
        #   - Returns nil for nil/empty/invalid values
        #
        # @example Numeric range with specific value
        #   resolve_preference("3", 1..7, :morning__opening_sentence)
        #   # => 3
        #
        # @example Numeric range with "random"
        #   resolve_preference("random", 1..7, :morning__opening_sentence)
        #   # => 4 (deterministic based on seed)
        #
        # @example Numeric range with "all"
        #   resolve_preference("all", 1..7, :morning__opening_sentence)
        #   # => [1, 2, 3, 4, 5, 6, 7]
        #
        # @example Slug array with specific value
        #   resolve_preference("venite", %w[venite jubilate], :morning__invitatory_canticle)
        #   # => "venite"
        #
        # @example Slug array with "random"
        #   resolve_preference("random", %w[venite jubilate], :morning__invitatory_canticle)
        #   # => "jubilate" (deterministic based on seed)
        #
        # @example Slug array with "all"
        #   resolve_preference("all", %w[venite jubilate], :morning__invitatory_canticle)
        #   # => ["venite", "jubilate"]
        #
        # @example Nil preference (builder handles default)
        #   resolve_preference(nil, 1..7, :morning__opening_sentence)
        #   # => nil
        #
        def resolve_preference(pref_value, options, random_key)
          return nil if pref_value.nil? || pref_value.to_s.strip.empty?

          # Handle "random" - use seeded_random for deterministic selection
          if pref_value.to_s == "random"
            if options.is_a?(Range)
              return seeded_random(options, key: random_key)
            else
              # For arrays, use seeded_random with index range and return the element
              return nil if options.empty?
              return options[seeded_random(0...options.length, key: random_key)]
            end
          end

          # Handle "all" - return all options as array
          if pref_value.to_s == "all"
            return options.is_a?(Range) ? options.to_a : options
          end

          # Handle specific value
          if options.is_a?(Range)
            # Convert string to integer for numeric ranges
            pref_value.to_s.to_i
          else
            # Return the slug value as-is for arrays
            pref_value.to_s
          end
        end
      end
    end
  end
end
