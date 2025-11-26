# frozen_string_literal: true

module DailyOffice
  module Builders
    class Loc2015Builder < BaseBuilder
      include Concerns::SeasonMapper
      include Concerns::ReadingFormatter
      include Loc2015::SharedHelpers
      include Loc2015::MorningPrayer
      include Loc2015::EveningPrayer
      include Loc2015::MiddayPrayer
      include Loc2015::Compline

      # LOC 2015 (IEAB) specific implementation
      # Implements all methods using LOC 2015 specific liturgical texts

      def initialize(date:, office_type:, preferences: {})
        super
        # Initialize component builders with LOC 2015 context
        @psalm_builder = Components::PsalmBuilder.new(
          date: @date,
          preferences: @preferences
        )
        @canticle_builder = Components::CanticleBuilder.new(
          date: @date,
          preferences: @preferences,
          day_info: @day_info
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
