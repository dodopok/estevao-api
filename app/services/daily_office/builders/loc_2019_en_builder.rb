# frozen_string_literal: true

module DailyOffice
  module Builders
    # LOC 2019 English (ACNA) specific builder
    # Routes to office-specific builders (Morning, Evening, Midday, Compline)
    class Loc2019EnBuilder
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
          Loc2019En::Morning.new(date: date, office_type: office_type, preferences: preferences)
        when :midday
          Loc2019En::Midday.new(date: date, office_type: office_type, preferences: preferences)
        when :evening
          Loc2019En::Evening.new(date: date, office_type: office_type, preferences: preferences)
        when :compline
          Loc2019En::Compline.new(date: date, office_type: office_type, preferences: preferences)
        else
          # Fallback to base builder for unimplemented offices
          BaseBuilder.new(date: date, office_type: office_type, preferences: preferences)
        end
      end
    end
  end
end
