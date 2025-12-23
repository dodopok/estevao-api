# frozen_string_literal: true

module DailyOffice
  module Builders
    # LOCB 2008 (Livro de Oração Comum Brasileiro) specific builder
    # Routes to office-specific builders (Morning Rite One, Morning Rite Two, etc.)
    class Locb2008Builder
      MORNING_RITES = %w[1 2 3 4].freeze
      EVENING_RITES = %w[1 2 3 4].freeze
      COMPLINE_RITES = %w[1 2].freeze

      def self.call(date:, office_type:, preferences: {})
        new(date: date, office_type: office_type, preferences: preferences).call
      end

      def initialize(date:, office_type:, preferences: {})
        @date = date
        @office_type = office_type.to_sym
        @preferences = preferences
      end

      def call
        office_builder.call
      end

      private

      attr_reader :date, :office_type, :preferences

      def office_builder
        case office_type
        when :morning
          morning_builder
        when :evening
          evening_builder
        when :midday
          midday_builder
        when :compline
          compline_builder
        else
          raise ArgumentError, "Unknown office type: #{office_type}"
        end
      end

      def morning_builder
        rite = resolve_rite_preference(:morning_prayer_rite, MORNING_RITES)

        case rite
        when "1"
          Locb2008::MorningRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        when "2"
          Locb2008::MorningRiteTwo.new(date: date, office_type: office_type, preferences: preferences)
        when "3"
          Locb2008::MorningRiteThree.new(date: date, office_type: office_type, preferences: preferences)
        when "4"
          Locb2008::MorningRiteFour.new(date: date, office_type: office_type, preferences: preferences)
        else
          Locb2008::MorningRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        end
      end

      def evening_builder
        rite = resolve_rite_preference(:evening_prayer_rite, EVENING_RITES)

        case rite
        when "1"
          Locb2008::EveningRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        when "2"
          Locb2008::EveningRiteTwo.new(date: date, office_type: office_type, preferences: preferences)
        when "3"
          Locb2008::EveningRiteThree.new(date: date, office_type: office_type, preferences: preferences)
        when "4"
          Locb2008::EveningRiteFour.new(date: date, office_type: office_type, preferences: preferences)
        else
          Locb2008::EveningRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        end
      end

      def midday_builder
        Locb2008::Midday.new(date: date, office_type: office_type, preferences: preferences)
      end

      def compline_builder
        rite = resolve_rite_preference(:compline_prayer_rite, COMPLINE_RITES)

        case rite
        when "1"
          Locb2008::ComplineRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        when "2"
          Locb2008::ComplineRiteTwo.new(date: date, office_type: office_type, preferences: preferences)
        else
          Locb2008::ComplineRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        end
      end

      # Resolves the rite preference, handling "random" values with seeded randomization
      # @param pref_key [Symbol] The preference key (e.g., :morning_prayer_rite)
      # @param available_rites [Array<String>] Array of available rite options
      # @return [String] The resolved rite value
      def resolve_rite_preference(pref_key, available_rites)
        pref_value = preferences[pref_key]

        # Default to "1" if nil or empty
        return "1" if pref_value.nil? || pref_value.to_s.strip.empty?

        # Handle "random" - use seeded_random for deterministic selection
        if pref_value.to_s == "random"
          return available_rites[seeded_random(0...available_rites.length, key: pref_key)]
        end

        pref_value.to_s
      end

      # Generates a random number within the given range using an optional seed.
      # When a seed is provided via preferences[:seed], the randomization is deterministic.
      # @param range [Range] The range of numbers to select from
      # @param key [Symbol] A unique identifier for this randomization point
      # @return [Integer] A random number within the range
      def seeded_random(range, key:)
        if preferences[:seed]
          Random.new(preferences[:seed] + key.hash).rand(range)
        else
          rand(range)
        end
      end
    end
  end
end
