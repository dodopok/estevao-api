# frozen_string_literal: true

module DailyOffice
  module Builders
    # LOC 1662 specific builder
    class Loc1662Builder
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
          Loc1662::Morning.new(date: date, office_type: office_type, preferences: preferences)
        when :evening
          Loc1662::Evening.new(date: date, office_type: office_type, preferences: preferences)
        else
          raise ArgumentError, "Unknown office type for LOC 1662: #{office_type}"
        end
      end
    end
  end
end
