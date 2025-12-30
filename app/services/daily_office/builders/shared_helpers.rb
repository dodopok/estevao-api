# frozen_string_literal: true

module DailyOffice
  module Builders
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

        # Use cached texts from LiturgicalText model for better performance
        LiturgicalText.texts_cache_for(prayer_book.code)[slug]
      end

      def line_item(text, type: "text", slug: nil)
        item = { text: text, type: type }
        item[:slug] = slug if slug.present?
        item
      end

      def build_collect_lines(collects)
        lines = []
        if collects.is_a?(Array)
          collects.each do |collect|
            lines << line_item(collect[:title], type: "heading") if collect[:title]
            lines << line_item(collect[:text], slug: collect[:slug])
            lines << line_item(collect[:preface], type: "citation") if collect[:preface]
            lines << line_item("", type: "spacer")
          end
        elsif collects.present?
          text = collects.is_a?(Hash) ? collects[:text] : collects
          lines << line_item(text)
          lines << line_item("", type: "spacer")
        end
        lines
      end

      def is_lent?
        lent_season?(day_info[:liturgical_season])
      end

      # Gets the default value for a preference from its PreferenceDefinition
      def preference_default(pref_key)
        return nil unless prayer_book

        # Use memoized preference definitions cache for better performance
        pref_def = preference_definitions_cache[pref_key.to_s]
        pref_def&.default_value
      end

      # Lazy-load all preference definitions for this prayer book into a hash indexed by key
      def preference_definitions_cache
        @preference_definitions_cache ||= prayer_book
          .preference_definitions
          .index_by(&:key)
      end

      # Resolves a preference value to handle "random", "all", specific values, or nil.
      #
      # This helper standardizes preference handling across builders, supporting:
      # - Numeric ranges (e.g., 1..7) for numbered liturgical texts
      # - Slug arrays (e.g., %w[venite jubilate]) for named texts
      # - Special values "random" and "all"
      # - When preference is nil/empty, uses PreferenceDefinition default_value or seeded_random
      #
      # @param pref_key [Symbol] The preference key to look up in preferences hash
      # @param options [Range, Array] Available options (Range for numeric, Array for slugs)
      #
      # @return [Integer, String, Array] Resolved value(s) based on preference type
      #   - Returns Integer when options is Range and pref_value is numeric or "random"
      #   - Returns String when options is Array and pref_value is specific slug or "random"
      #   - Returns Array when pref_value is "all" (options.to_a for Range, options for Array)
      #   - Uses PreferenceDefinition default_value for nil/empty values, or seeded_random as fallback
      #
      # @example Numeric range with specific value
      #   resolve_preference(:morning_opening_sentence, 1..7)
      #   # => 3 (if preferences[:morning_opening_sentence] == "3")
      #
      # @example Numeric range with "random"
      #   resolve_preference(:morning_opening_sentence, 1..7)
      #   # => 4 (deterministic based on seed if preferences[:morning_opening_sentence] == "random")
      #
      # @example Numeric range with "all"
      #   resolve_preference(:morning_opening_sentence, 1..7)
      #   # => [1, 2, 3, 4, 5, 6, 7] (if preferences[:morning_opening_sentence] == "all")
      #
      # @example Slug array with specific value
      #   resolve_preference(:invitatory_canticle, %w[venite jubilate])
      #   # => "venite" (if preferences[:invitatory_canticle] == "venite")
      #
      # @example Slug array with "random"
      #   resolve_preference(:invitatory_canticle, %w[venite jubilate])
      #   # => "jubilate" (deterministic based on seed if preferences[:invitatory_canticle] == "random")
      #
      # @example Slug array with "all"
      #   resolve_preference(:invitatory_canticle, %w[venite jubilate])
      #   # => ["venite", "jubilate"] (if preferences[:invitatory_canticle] == "all")
      #
      # @example Nil preference (uses PreferenceDefinition default or seeded random)
      #   resolve_preference(:morning_opening_sentence, 1..7)
      #   # => 5 (PreferenceDefinition default_value or deterministic random if preferences[:morning_opening_sentence] is nil)
      #
      def resolve_preference(pref_key, options)
        pref_value = preferences[pref_key]

        # If preference is nil/empty, use PreferenceDefinition default or return nil
        if pref_value.nil? || pref_value.to_s.strip.empty?
          # Get default from PreferenceDefinition
          default_value = preference_default(pref_key)
          # If no default exists, return nil
          return nil if default_value.nil? || default_value.to_s.strip.empty?
          pref_value = default_value
        end

        # Handle "random" - use seeded_random for deterministic selection
        if pref_value.to_s == "random"
          if options.is_a?(Range)
            return seeded_random(options, key: pref_key)
          else
            # For arrays, use seeded_random with index range and return the element
            return options.first if options.empty?
            return options[seeded_random(0...options.length, key: pref_key)]
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
