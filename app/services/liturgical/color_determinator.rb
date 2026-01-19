# frozen_string_literal: true

module Liturgical
  # Service responsible for determining liturgical colors for dates
  # Colors are determined by the liturgical season and any special celebrations
  class ColorDeterminator
    # Color constants in Portuguese
    COLORS = {
      white: "branco",
      red: "vermelho",
      purple: "roxo",
      violet: "violeta",
      rose: "rosa",
      green: "verde",
      black: "preto"
    }.freeze

    # Seasons that use specific colors
    WHITE_SEASONS = %w[Natal Páscoa].freeze

    # Principal celebration types that override season color
    PRINCIPAL_CELEBRATION_TYPES = %w[principal_feast major_holy_day].freeze

    def initialize(season_determinator:, easter_calc:)
      @season_determinator = season_determinator
      @easter_calc = easter_calc
    end

    # Determines the liturgical color for a given date
    # @param date [Date] the date to determine color for
    # @param celebration [Hash, nil] optional celebration info with :color and :type
    # @return [String] the liturgical color in Portuguese
    def color_for(date, celebration: nil)
      # Priority rules for liturgical colors:
      # 1. Principal feasts and major holy days: always use celebration color
      # 2. Sundays: use season color (Sunday takes precedence over festivals and lesser feasts)
      # 3. Festivals on weekdays: use celebration color
      # 4. Lesser feasts on weekdays: use celebration color
      # 5. Commemorations on weekdays: use celebration color

      return celebration[:color] if principal_celebration?(celebration)
      return color_for_season(date) if date.sunday?
      return celebration[:color] if celebration&.dig(:color).present?

      color_for_season(date)
    end

    private

    attr_reader :season_determinator, :easter_calc

    # Only principal feasts and major holy days override Sundays
    def principal_celebration?(celebration)
      return false unless celebration&.dig(:color).present?

      PRINCIPAL_CELEBRATION_TYPES.include?(celebration[:type])
    end

    def color_for_season(date)
      season = season_determinator.season_for_date(date)
      movable = easter_calc.all_movable_dates

      case season
      when "Advento"
        advent_color(date, movable)
      when *WHITE_SEASONS
        COLORS[:white]
      when "Quaresma"
        lent_color(date, movable)
      when "Tempo Comum", "Epifania"
        COLORS[:green]
      else
        COLORS[:green]
      end
    end

    def advent_color(date, movable)
      # Third Sunday of Advent (Gaudete Sunday) is rose
      gaudete_sunday = movable[:first_sunday_of_advent] + 14.days
      date == gaudete_sunday ? COLORS[:rose] : COLORS[:violet]
    end

    def lent_color(date, movable)
      if holy_week_before_easter_vigil?(date, movable)
        COLORS[:red]
      elsif laetare_sunday?(date, movable)
        COLORS[:rose]
      else
        COLORS[:purple]
      end
    end

    def holy_week_before_easter_vigil?(date, movable)
      date >= movable[:palm_sunday] && date <= movable[:good_friday]
    end

    def laetare_sunday?(date, movable)
      # Fourth Sunday in Lent (Laetare Sunday)
      date == movable[:first_sunday_in_lent] + 21.days
    end
  end
end
