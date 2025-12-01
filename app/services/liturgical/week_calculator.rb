# frozen_string_literal: true

module Liturgical
  # Service responsible for calculating week numbers within liturgical seasons
  class WeekCalculator
    def initialize(season_determinator:, easter_calc:)
      @season_determinator = season_determinator
      @easter_calc = easter_calc
    end

    # Calculates the week number within the current liturgical season
    # @param date [Date] the date to calculate week number for
    # @return [Integer, nil] the week number or nil if not applicable
    def week_number(date)
      season = season_determinator.season_for_date(date)
      movable = easter_calc.all_movable_dates

      case season
      when "Advento"
        weeks_since(date, movable[:first_sunday_of_advent])
      when "Natal"
        christmas_week_number(date)
      when "Epifania"
        weeks_since(date, movable[:baptism_of_the_lord])
      when "Quaresma"
        weeks_since(date, movable[:first_sunday_in_lent])
      when "Páscoa"
        weeks_since(date, movable[:easter])
      when "Tempo Comum"
        ordinary_time_week_number(date, movable)
      end
    end

    # Calculates which Sunday after Pentecost a date is
    # @param date [Date] the date to check
    # @return [Integer, nil] the Sunday number or nil if not applicable
    def sunday_after_pentecost(date)
      return nil unless date.sunday?

      season = season_determinator.season_for_date(date)
      return nil unless season == "Tempo Comum"

      movable = easter_calc.all_movable_dates
      return nil if date < movable[:pentecost]

      weeks_after = (date - movable[:pentecost]).to_i / 7
      weeks_after if weeks_after >= 0
    end

    private

    attr_reader :season_determinator, :easter_calc

    def weeks_since(date, start_date)
      ((date - start_date).to_i / 7) + 1
    end

    def christmas_week_number(date)
      # 25-31 de dezembro = semana 1
      # 1-6 de janeiro (antes do Batismo) = semana 2
      christmas = if date.month == 12
                    Date.new(date.year, 12, 25)
      else
                    Date.new(date.year - 1, 12, 25)
      end
      weeks_since(date, christmas)
    end

    def ordinary_time_week_number(date, movable)
      if date < movable[:ash_wednesday]
        ordinary_time_before_lent(date, movable)
      else
        ordinary_time_after_pentecost(date, movable)
      end
    end

    def ordinary_time_before_lent(date, movable)
      # Before Lent - count from Baptism of the Lord
      baptism = movable[:baptism_of_the_lord]
      # Find the Sunday on or after baptism
      first_sunday = baptism.sunday? ? baptism : baptism + (7 - baptism.wday).days
      weeks_since(date, first_sunday)
    end

    def ordinary_time_after_pentecost(date, movable)
      # After Pentecost
      trinity = movable[:trinity_sunday]
      # First Sunday in Ordinary Time after Pentecost is the Sunday after Trinity
      first_sunday_after_pentecost = trinity + 7.days
      weeks_since(date, first_sunday_after_pentecost)
    end
  end
end
