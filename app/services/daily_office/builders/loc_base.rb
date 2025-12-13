# frozen_string_literal: true

module DailyOffice
  module Builders
    # Base class for all LOC-specific builders
    # Provides common functionality for all prayer books
    class LocBase < BaseBuilder
      include SharedHelpers
      include Concerns::SeasonMapper
      include Concerns::ReadingFormatter

      attr_reader :psalm_builder, :reading_builder, :prayer_builder

      def initialize(date:, office_type:, preferences: {})
        super
        initialize_component_builders
      end

      def call
        structure = super

        {
          date: date.strftime("%Y-%m-%d"),
          office_type: office_type.to_s,
          season: day_info[:liturgical_season],
          color: day_info[:liturgical_color],
          celebration: day_info[:celebration],
          saint: day_info[:saint],
          modules: structure,
          metadata: {
            prayer_book_code: preferences[:prayer_book_code],
            prayer_book_name: prayer_book&.name,
            bible_version: preferences[:bible_version],
            language: preferences[:language],
            seed: preferences[:seed]
          }
        }
      end

      private

      def initialize_component_builders
        @psalm_builder = Components::PsalmBuilder.new(
          date: @date,
          preferences: @preferences
        )
        @reading_builder = Components::ReadingBuilder.new(
          date: @date,
          preferences: @preferences,
          readings: @readings
        )
        @prayer_builder = Components::PrayerBuilder.new(
          date: @date,
          preferences: @preferences,
          day_info: @day_info
        )
      end
    end
  end
end
