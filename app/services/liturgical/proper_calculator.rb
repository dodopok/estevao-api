# frozen_string_literal: true

module Liturgical
  # Calcula o número do Proper (contagem contínua no Tempo Comum)
  # O sistema RCL usa contagem REVERSA a partir de Cristo Rei
  # Proper 29 = domingo mais próximo de 23 de novembro
  # Proper 28 = domingo mais próximo de 16 de novembro, etc.
  class ProperCalculator
    # Map of Proper numbers to their target dates (month, day)
    # Working backwards from Proper 29 (Nov 23) in increments of 7 days
    # Propers 1-3 are only used in years when Easter falls early (before April 14)
    PROPER_TARGET_DATES = {
      29 => [ 11, 23 ], # Christ the King
      28 => [ 11, 16 ],
      27 => [ 11, 9 ],
      26 => [ 11, 2 ],
      25 => [ 10, 26 ],
      24 => [ 10, 19 ],
      23 => [ 10, 12 ],
      22 => [ 10, 5 ],
      21 => [ 9, 28 ],
      20 => [ 9, 21 ],
      19 => [ 9, 14 ],
      18 => [ 9, 7 ],
      17 => [ 8, 31 ],
      16 => [ 8, 24 ],
      15 => [ 8, 17 ],
      14 => [ 8, 10 ],
      13 => [ 8, 3 ],
      12 => [ 7, 27 ],
      11 => [ 7, 20 ],
      10 => [ 7, 13 ],
      9 => [ 7, 6 ],
      8 => [ 6, 29 ],
      7 => [ 6, 22 ],
      6 => [ 6, 15 ],
      5 => [ 6, 8 ],
      4 => [ 6, 1 ],
      3 => [ 5, 25 ],
      2 => [ 5, 18 ],
      1 => [ 5, 11 ]
    }.freeze

    attr_reader :year, :easter_calc

    def initialize(year, easter_calc: nil)
      @year = year
      @easter_calc = easter_calc || Liturgical::EasterCalculator.new(year)
    end

    # Calcula o número do proper para uma data específica
    # Retorna nil se não for Tempo Comum
    def calculate(date, season:)
      return nil unless season == "Tempo Comum"

      movable = easter_calc.all_movable_dates

      if date < movable[:ash_wednesday]
        calculate_before_lent(date, movable)
      else
        calculate_after_pentecost(date)
      end
    end

    private

    # Before Lent - use forward counting from Baptism of the Lord
    def calculate_before_lent(date, movable)
      baptism = movable[:baptism_of_the_lord]
      # Find the first Sunday on or after baptism
      first_sunday = baptism.sunday? ? baptism : baptism + (7 - baptism.wday).days

      # Calculate which proper (Propers before Lent are numbered 1-9)
      # For weekdays, we want the count based on the most recent Sunday
      target_date = date.sunday? ? date : date - date.wday.days
      weeks = ((target_date - first_sunday).to_i / 7) + 1
      weeks if target_date >= first_sunday
    end

    # After Pentecost - use REVERSE counting from Christ the King
    # The RCL assigns Propers based on proximity to fixed dates
    def calculate_after_pentecost(date)
      # Find the preceding Sunday (or today if it's Sunday)
      target_sunday = date.sunday? ? date : date - date.wday.days

      PROPER_TARGET_DATES.each_key do |proper_num|
        return proper_num if target_sunday == closest_sunday_for_proper(proper_num)
      end

      nil
    end

    # Find the Sunday closest to the reference date for a given proper number
    def closest_sunday_for_proper(proper_num)
      month, day = PROPER_TARGET_DATES[proper_num]
      reference_date = Date.new(year, month, day)

      days_from_sunday = reference_date.wday
      if days_from_sunday == 0
        # Already Sunday
        reference_date
      elsif days_from_sunday <= 3
        # If Mon-Wed, use previous Sunday
        reference_date - days_from_sunday.days
      else
        # If Thu-Sat, use next Sunday
        reference_date + (7 - days_from_sunday).days
      end
    end
  end
end
