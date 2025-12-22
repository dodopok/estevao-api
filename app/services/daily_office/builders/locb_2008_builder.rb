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
        else
          Locb2008::MorningRiteOne.new(date: date, office_type: office_type, preferences: preferences)
        end
      end

      def evening_builder
        # TODO: Implement evening prayer builders
        raise NotImplementedError, "LOCB 2008 Evening Prayer not yet implemented"
      end

      def midday_builder
        # TODO: Implement midday prayer builders
        raise NotImplementedError, "LOCB 2008 Midday Prayer not yet implemented"
      end

      def compline_builder
        # TODO: Implement compline builders
        raise NotImplementedError, "LOCB 2008 Compline not yet implemented"
      end
    end
  end
end
