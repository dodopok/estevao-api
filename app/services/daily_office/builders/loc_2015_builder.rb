# frozen_string_literal: true

module DailyOffice
  module Builders
    # LOC 2015 (IEAB) specific builder
    # Routes to office-specific builders (Morning, Evening, Midday, Compline)
    class Loc2015Builder
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
          Loc2015::Morning.new(date: date, office_type: office_type, preferences: preferences)
        when :evening
          Loc2015::Evening.new(date: date, office_type: office_type, preferences: preferences)
        when :midday
          Loc2015::Midday.new(date: date, office_type: office_type, preferences: preferences)
        when :compline
          Loc2015::Compline.new(date: date, office_type: office_type, preferences: preferences)
        when :late_evening
          Loc2015::LateEvening.new(date: date, office_type: office_type, preferences: preferences)
        else
          raise ArgumentError, "Unknown office type: #{office_type}"
        end
      end
    end
  end
end
