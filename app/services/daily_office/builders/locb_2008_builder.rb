# frozen_string_literal: true

module DailyOffice
  module Builders
    # LOCB 2008 (Livro de Oração Comum Brasileiro) specific builder
    # Routes to office-specific builders (Morning Rite One, Morning Rite Two, etc.)
    class Locb2008Builder
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
        # Determine rite from preferences (default to rite_one)
        rite = preferences[:morning_prayer_rite] || "1"

        case rite.to_s
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
        # Determine rite from preferences (default to rite_one)
        rite = preferences[:evening_prayer_rite] || "1"

        case rite.to_s
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
        # Determine rite from preferences (default to rite_one)
        rite = preferences[:compline_prayer_rite] || "1"

        case rite.to_s
        when "1"
          Locb2008::ComplineRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        when "2"
          Locb2008::ComplineRiteTwo.new(date: date, office_type: office_type, preferences: preferences)
        else
          Locb2008::ComplineRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        end
      end
    end
  end
end
