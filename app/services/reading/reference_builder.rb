# frozen_string_literal: true

module Reading
  # Service responsible for building date references for lectionary lookups
  # Generates reference strings used to find readings in the database
  class ReferenceBuilder
    WEEKDAY_NAMES = %w[sunday monday tuesday wednesday thursday friday saturday].freeze

    # Maps fixed dates to their special references
    SPECIAL_DATE_REFERENCES = {
      [ 12, 25 ] => %w[christmas_day christmas],
      [ 12, 24 ] => %w[christmas_eve],
      [ 1, 1 ] => %w[holy_name],
      [ 1, 6 ] => %w[epiphany],
      [ 3, 25 ] => %w[annunciation],
      [ 11, 1 ] => %w[all_saints],
      [ 8, 6 ] => %w[transfiguration],
      [ 2, 2 ] => %w[presentation_of_the_lord presentation]
    }.freeze

    def initialize(date, calendar:)
      @date = date
      @calendar = calendar
    end

    # Build references for a fixed date (e.g., "december_24", "christmas_eve")
    def fixed_date_references
      refs = []

      # Standard format: "month_day"
      refs << month_day_reference

      # Special references for important dates
      special_refs = SPECIAL_DATE_REFERENCES[[ date.month, date.day ]]
      refs.concat(special_refs) if special_refs

      refs
    end

    # Build references for a celebration
    def celebration_references(celebration)
      refs = []

      # From calculation_rule - use canonical mapping from CelebrationResolver
      if celebration.calculation_rule.present?
        rule_refs = Liturgical::CelebrationResolver::CALCULATION_RULE_TO_DATE_REFERENCES[celebration.calculation_rule]
        refs.concat(rule_refs) if rule_refs
      end

      # From fixed date
      if celebration.fixed_month && celebration.fixed_day
        refs << month_day_reference_for(celebration.fixed_month, celebration.fixed_day)

        special_refs = SPECIAL_DATE_REFERENCES[[ celebration.fixed_month, celebration.fixed_day ]]
        refs.concat(special_refs) if special_refs
      end

      refs
    end

    # Build references for weekly readings (weekday readings)
    def weekly_references
      refs = []
      weekday = weekday_name

      # 1. Fixed date reference (e.g., "december_22")
      refs << month_day_reference

      # 2. Proper reference (Ordinary Time)
      most_recent_sunday = find_most_recent_sunday
      proper_num = calendar.proper_number(most_recent_sunday)
      refs << "proper_#{proper_num}_#{weekday}" if proper_num

      # 3. Sunday reference (e.g., "first_sunday_of_advent_monday")
      sunday_ref = SundayReferenceMapper.map(most_recent_sunday, calendar)
      refs << "#{sunday_ref}_#{weekday}" if sunday_ref

      # 4. Special week references
      refs.concat(special_week_references(weekday))

      refs
    end

    private

    attr_reader :date, :calendar

    def month_day_reference
      month_name = Date::MONTHNAMES[date.month].downcase
      "#{month_name}_#{date.day}"
    end

    def month_day_reference_for(month, day)
      month_name = Date::MONTHNAMES[month]&.downcase
      "#{month_name}_#{day}" if month_name
    end

    def weekday_name
      WEEKDAY_NAMES[date.wday]
    end

    def find_most_recent_sunday
      days_since_sunday = date.wday == 0 ? 0 : date.wday
      date - days_since_sunday
    end

    def special_week_references(weekday)
      refs = []
      season = calendar.season_for_date(date)

      case season
      when "Advento"
        advent_week_references(weekday, refs)
      when "Natal"
        christmas_week_references(weekday, refs)
      when "Epifania"
        epiphany_week_references(weekday, refs)
      when "Quaresma"
        lent_week_references(weekday, refs)
      when "Páscoa"
        easter_week_references(weekday, refs)
      when "Tempo Comum"
        ordinary_time_week_references(weekday, refs)
      end

      refs
    end

    def advent_week_references(weekday, refs)
      week = calendar.week_number(date)
      refs << "#{week.ordinalize}_sunday_of_advent_#{weekday}" if week
    end

    def christmas_week_references(weekday, refs)
      refs << "week_of_christmas_#{weekday}"
      refs << "first_sunday_after_christmas_#{weekday}"

      if date.month == 1
        refs << "baptism_of_christ_#{weekday}"
        refs << "week_of_epiphany_#{weekday}"
      end
    end

    def epiphany_week_references(weekday, refs)
      week = calendar.week_number(date)
      if week && week >= 1
        refs << "ordinary_time_#{week + 1}_#{weekday}"
        refs << "ordinary_time_#{week}_#{weekday}"
      end
      refs << "week_of_epiphany_#{weekday}"
      refs << "baptism_of_christ_#{weekday}"
      refs << "last_sunday_after_epiphany_#{weekday}"
    end

    def lent_week_references(weekday, refs)
      week = calendar.week_number(date)
      refs << "#{week.ordinalize}_sunday_of_lent_#{weekday}" if week
      refs << "holy_week_#{weekday}"
      refs << "holy_#{weekday}"
    end

    def easter_week_references(weekday, refs)
      week = calendar.week_number(date)
      refs << "#{week.ordinalize}_sunday_of_easter_#{weekday}" if week
      refs << "week_of_pentecost_#{weekday}"
      refs << "trinity_sunday_#{weekday}"
    end

    def ordinary_time_week_references(weekday, refs)
      easter_calc = EasterCalculator.new(date.year)
      pentecost = easter_calc.pentecost
      trinity = pentecost + 7

      if date > pentecost && date < trinity
        refs << "week_of_pentecost_#{weekday}"
        refs << "trinity_sunday_#{weekday}"
      end
    end
  end
end
