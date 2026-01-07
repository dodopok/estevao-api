# frozen_string_literal: true

module DailyOffice
  module Builders
    # LOC 2021 (IAB) specific builder
    # Routes to the single office builder for both Morning and Evening
    class Loc2021Builder
      def self.call(date:, office_type:, preferences: {})
        new(date: date, office_type: office_type, preferences: preferences).call
      end

      def initialize(date:, office_type:, preferences: {})
        @date = date
        @office_type = office_type.to_sym
        @preferences = preferences
      end

      def call
        Loc2021::Office.new(date: @date, office_type: @office_type, preferences: @preferences).call
      end
    end
  end
end