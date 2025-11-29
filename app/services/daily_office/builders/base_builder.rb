# frozen_string_literal: true

module DailyOffice
  module Builders
    class BaseBuilder
      attr_reader :date, :office_type, :preferences, :day_info, :readings
      attr_reader :psalm_builder, :canticle_builder, :reading_builder, :prayer_builder

      def initialize(date:, office_type:, preferences: {})
        @date = date.to_date
        @office_type = office_type.to_sym
        @preferences = default_preferences.merge(preferences)

        # Generate seed if not provided (for sharing consistent office configurations)
        @preferences[:seed] ||= generate_seed

        # Load day info and readings
        @day_info = liturgical_calendar.day_info(@date)
        @readings = ReadingService.for(@date, prayer_book_code: @preferences[:prayer_book_code]).find_readings || {}
        @collects = CollectService.new(@date, prayer_book_code: @preferences[:prayer_book_code]).find_collects || {}

        # Initialize component builders
        initialize_builders
      end

      def initialize_builders
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

      # These methods can be overridden by subclasses for LOC-specific behavior
      def assemble_morning_prayer
        return assemble_morning_prayer_family if preferences[:family_rite]

        [
          prayer_builder.build_opening_sentence(:morning),
          prayer_builder.build_confession,
          prayer_builder.build_absolution,
          prayer_builder.build_invocation,
          canticle_builder.build_invitatory,
          psalm_builder.build_psalms(:morning),
          reading_builder.build_first_reading,
          canticle_builder.build_first_canticle,
          reading_builder.build_second_reading,
          canticle_builder.build_second_canticle,
          prayer_builder.build_creed,
          prayer_builder.build_kyrie,
          prayer_builder.build_lords_prayer,
          prayer_builder.build_morning_suffrages,
          prayer_builder.build_collects,
          prayer_builder.build_general_thanksgiving,
          prayer_builder.build_chrysostom_prayer,
          prayer_builder.build_dismissal
        ].compact
      end

      def assemble_morning_prayer_family
        [
          prayer_builder.build_opening_sentence(:morning),
          prayer_builder.build_invocation,
          psalm_builder.build_single_psalm(:morning),
          reading_builder.build_first_reading,
          prayer_builder.build_kyrie,
          prayer_builder.build_lords_prayer,
          prayer_builder.build_simple_collect,
          prayer_builder.build_dismissal
        ].compact
      end

      def assemble_evening_prayer
        return assemble_evening_prayer_family if preferences[:family_rite]

        [
          prayer_builder.build_opening_sentence(:evening),
          prayer_builder.build_confession,
          prayer_builder.build_absolution,
          prayer_builder.build_invocation,
          psalm_builder.build_psalms(:evening),
          reading_builder.build_first_reading,
          canticle_builder.build_magnificat,
          reading_builder.build_second_reading,
          canticle_builder.build_nunc_dimittis,
          prayer_builder.build_creed,
          prayer_builder.build_kyrie,
          prayer_builder.build_lords_prayer,
          prayer_builder.build_evening_suffrages,
          prayer_builder.build_collects,
          prayer_builder.build_general_thanksgiving,
          prayer_builder.build_chrysostom_prayer,
          prayer_builder.build_dismissal
        ].compact
      end

      def assemble_evening_prayer_family
        [
          prayer_builder.build_opening_sentence(:evening),
          prayer_builder.build_invocation,
          psalm_builder.build_single_psalm(:evening),
          reading_builder.build_first_reading,
          prayer_builder.build_kyrie,
          prayer_builder.build_lords_prayer,
          prayer_builder.build_simple_collect,
          prayer_builder.build_dismissal
        ].compact
      end

      def assemble_midday_prayer
        [
          prayer_builder.build_opening_sentence(:midday),
          psalm_builder.build_midday_psalms,
          reading_builder.build_short_reading,
          prayer_builder.build_kyrie,
          prayer_builder.build_lords_prayer,
          prayer_builder.build_midday_collect,
          prayer_builder.build_dismissal
        ].compact
      end

      def assemble_compline
        [
          prayer_builder.build_opening_sentence(:compline),
          prayer_builder.build_confession,
          prayer_builder.build_absolution,
          psalm_builder.build_compline_psalms,
          canticle_builder.build_compline_hymn,
          reading_builder.build_short_reading,
          canticle_builder.build_nunc_dimittis,
          prayer_builder.build_kyrie,
          prayer_builder.build_lords_prayer,
          prayer_builder.build_compline_prayers,
          prayer_builder.build_dismissal
        ].compact
      end

      private

      def default_preferences
        {
          prayer_book_code: "loc_2015",
          bible_version: "nvi",
          language: "pt-BR",
          confession_type: "long",
          lords_prayer_version: "traditional",
          creed_type: :apostles,
          family_rite: false
        }
      end

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
        # Use date and office type to create a unique but deterministic seed
        "#{date.to_time.to_i}_#{office_type}".hash
      end
    end
  end
end
