# frozen_string_literal: true

module Liturgical
  # Service responsible for handling liturgical transfer rules
  # Transfers celebrations when they conflict with higher-ranking observances
  class TransferRules
    def initialize(year, easter_calc:)
      @year = year
      @easter_calc = easter_calc
    end

    # Determines if a celebration needs to be transferred and returns the actual date
    # @param celebration [Celebration] the celebration to check
    # @param original_date [Date] the original date of the celebration
    # @return [Date] the actual date (may be transferred)
    def transfer_if_needed(celebration, original_date)
      return transfer_annunciation(original_date) if annunciation?(celebration)
      return transfer_if_holy_week(original_date) if needs_holy_week_transfer?(celebration)
      return transfer_festival_on_sunday(original_date) if festival_on_sunday?(celebration, original_date)
      return transfer_all_saints(original_date) if all_saints?(celebration)

      original_date
    end

    private

    attr_reader :year, :easter_calc

    def movable_dates
      @movable_dates ||= easter_calc.all_movable_dates
    end

    # Celebration type checks
    def annunciation?(celebration)
      celebration.name =~ /Anunciação/
    end

    def needs_holy_week_transfer?(celebration)
      %w[José\ de\ Nazaré Marcos,\ Evangelista].any? { |name| celebration.name.include?(name.delete("\\")) }
    end

    def festival_on_sunday?(celebration, date)
      celebration.festival? && date.sunday?
    end

    def all_saints?(celebration)
      celebration.name =~ /Todos os Santos/
    end

    # Transfer logic for Annunciation (March 25)
    def transfer_annunciation(original_date)
      palm_sunday = movable_dates[:palm_sunday]
      second_easter = movable_dates[:second_sunday_of_easter]

      # If falls on Sunday, transfer to Monday
      return original_date + 1.day if original_date.sunday?

      # If falls between Palm Sunday and Second Sunday of Easter (inclusive)
      if in_protected_easter_period?(original_date, palm_sunday, second_easter)
        return second_easter + 1.day
      end

      original_date
    end

    # Transfer logic for celebrations during Holy Week
    def transfer_if_holy_week(original_date)
      palm_sunday = movable_dates[:palm_sunday]
      second_easter = movable_dates[:second_sunday_of_easter]

      return original_date unless in_protected_easter_period?(original_date, palm_sunday, second_easter)

      monday_after = second_easter + 1.day

      # Check if Annunciation is occupying Monday
      if annunciation_occupies_monday?(monday_after)
        second_easter + 2.days # Tuesday
      else
        monday_after
      end
    end

    # Transfer logic for festivals falling on Sunday
    def transfer_festival_on_sunday(original_date)
      # Outside protected period, transfer to Monday
      # Inside protected period, also transfer to Monday
      original_date + 1.day
    end

    # Transfer logic for All Saints (November 1)
    def transfer_all_saints(original_date)
      return original_date if original_date.sunday?

      # Look for the nearest Sunday in allowed range (Oct 30 - Nov 5)
      find_sunday_in_range(year, 10, 30, 11, 5) || original_date
    end

    # Helper methods
    def in_protected_easter_period?(date, palm_sunday, second_easter)
      date >= palm_sunday && date <= second_easter
    end

    def annunciation_occupies_monday?(monday_date)
      annunciation_original = Date.new(year, 3, 25)
      transfer_annunciation(annunciation_original) == monday_date
    end

    def find_sunday_in_range(year, start_month, start_day, end_month, end_day)
      start_range = Date.new(year, start_month, start_day)
      end_range = Date.new(year, end_month, end_day)

      (start_range..end_range).find(&:sunday?)
    end
  end
end
