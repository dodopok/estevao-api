# frozen_string_literal: true

module DailyOffice
  module Builders
    class BaseBuilder
      attr_reader :date, :office_type, :preferences, :day_info, :readings
      attr_reader :psalm_builder, :reading_builder, :prayer_builder

      DEFAULT_PREFERENCES = {
        prayer_book_code: "loc_2015",
        bible_version: "nvi",
        family_rite: false
      }.freeze

      def initialize(date:, office_type:, preferences: {})
        @date = date.to_date
        @office_type = office_type.to_sym
        @preferences = DEFAULT_PREFERENCES.merge(preferences.symbolize_keys)

        # Generate seed if not provided (for sharing consistent office configurations)
        @preferences[:seed] ||= generate_seed

        # Load day info and readings
        @day_info = liturgical_calendar.day_info(@date)
        @readings = ReadingService.for(
          @date,
          prayer_book_code: @preferences[:prayer_book_code],
          translation: @preferences[:bible_version] || "nvi"
        ).find_readings || {}
        @collects = CollectService.new(@date, prayer_book_code: @preferences[:prayer_book_code]).find_collects || {}

        # Initialize component builders
        initialize_builders
      end

      def initialize_builders
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

      def prayer_book
        @prayer_book ||= PrayerBook.find_by(code: preferences[:prayer_book_code])
      end

      def call
        structure = case office_type
        when :morning then assemble_morning_prayer
        when :evening then assemble_evening_prayer
        when :midday then assemble_midday_prayer
        when :compline then assemble_compline
        else
                      raise "Unknown office type: #{office_type}"
        end

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

      def liturgical_calendar
        @liturgical_calendar ||= LiturgicalCalendar.new(
          date.year,
          prayer_book_code: preferences[:prayer_book_code]
        )
      end

      def prayer_book
        @prayer_book ||= PrayerBook.find_by(code: preferences[:prayer_book_code])
      end

      # Generates a deterministic seed based on date and office type
      # This allows the same day/office combination to have consistent randomization
      # when no specific seed is provided
      def generate_seed
        # Use date and office type to create a consistent seed for the same day/office
        # This ensures all users get the same randomization for a given day/office combination
        "#{date}_#{office_type}".hash
      end
    end
  end
end
