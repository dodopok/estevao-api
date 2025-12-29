# frozen_string_literal: true

module DailyOffice
  module Builders
    # LOC 1987 specific builder
    # Routes to office-specific builders (Morning, Evening)
    class Loc1987Builder
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
          Loc1987::Morning.new(date: date, office_type: office_type, preferences: preferences)
        when :evening
          Loc1987::Evening.new(date: date, office_type: office_type, preferences: preferences)
        when :midday
          raise ArgumentError, "LOC 1987 does not support Midday office"
        when :compline
          raise ArgumentError, "LOC 1987 does not support Compline office"
        else
          raise ArgumentError, "Unknown office type: #{office_type}"
        end
      end
    end
  end
end
