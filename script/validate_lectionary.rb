#!/usr/bin/env ruby
# encoding: UTF-8

# ================================================================================
# LECTIONARY VALIDATION SCRIPT
# ================================================================================
#
# Purpose:
#   Validate that all dates in a year have proper liturgical data
#   (readings, collects, season, color) for a specific prayer book.
#
# Usage:
#   rails runner script/validate_lectionary.rb [year] [prayer_book_code]
#
# Examples:
#   rails runner script/validate_lectionary.rb 2025 loc_2015
#   rails runner script/validate_lectionary.rb 2026
#   rails runner script/validate_lectionary.rb
#
# Output:
#   - Summary of validation results
#   - List of dates with missing data
#   - Statistics by season
#
# ================================================================================

class LectionaryValidator
  attr_reader :year, :prayer_book_code, :results

  def initialize(year, prayer_book_code = "loc_2015")
    @year = year
    @prayer_book_code = prayer_book_code
    @results = {
      total_days: 0,
      sundays: { total: 0, with_readings: 0, with_collect: 0, missing_readings: [], missing_collect: [] },
      weekdays: { total: 0, with_readings: 0, with_collect: 0, missing_readings: [], missing_collect: [] },
      seasons: {},
      errors: []
    }
  end

  def validate
    puts "=" * 80
    puts "VALIDAÇÃO DO LECIONÁRIO - #{prayer_book_code.upcase}"
    puts "Ano: #{year}"
    puts "=" * 80
    puts

    start_date = Date.new(year, 1, 1)
    end_date = Date.new(year, 12, 31)

    (start_date..end_date).each do |date|
      validate_date(date)
    end

    print_results
  end

  private

  def validate_date(date)
    @results[:total_days] += 1

    begin
      calendar = LiturgicalCalendar.new(date.year)
      reading_service = ReadingService.new(date, prayer_book_code: prayer_book_code)
      collect_service = CollectService.new(date, prayer_book_code: prayer_book_code)

      season = calendar.season_for_date(date)
      color = calendar.color_for_date(date)
      readings = reading_service.find_readings
      collect = collect_service.find_collects

      # Track by season
      @results[:seasons][season] ||= { total: 0, with_readings: 0, with_collect: 0 }
      @results[:seasons][season][:total] += 1

      if date.sunday?
        validate_sunday(date, season, color, readings, collect)
      else
        validate_weekday(date, season, color, readings, collect)
      end

    rescue => e
      @results[:errors] << { date: date, error: e.message }
    end

    # Progress indicator
    print "." if @results[:total_days] % 30 == 0
  end

  def validate_sunday(date, season, color, readings, collect)
    @results[:sundays][:total] += 1

    if readings.present?
      @results[:sundays][:with_readings] += 1
      @results[:seasons][season][:with_readings] += 1
    else
      @results[:sundays][:missing_readings] << format_date_info(date, season)
    end

    if collect.present?
      @results[:sundays][:with_collect] += 1
      @results[:seasons][season][:with_collect] += 1
    else
      @results[:sundays][:missing_collect] << format_date_info(date, season)
    end
  end

  def validate_weekday(date, season, color, readings, collect)
    @results[:weekdays][:total] += 1

    if readings.present?
      @results[:weekdays][:with_readings] += 1
      @results[:seasons][season][:with_readings] += 1
    else
      @results[:weekdays][:missing_readings] << format_date_info(date, season)
    end

    if collect.present?
      @results[:weekdays][:with_collect] += 1
      @results[:seasons][season][:with_collect] += 1
    else
      @results[:weekdays][:missing_collect] << format_date_info(date, season)
    end
  end

  def format_date_info(date, season)
    day_name = %w[Dom Seg Ter Qua Qui Sex Sáb][date.wday]
    "#{date.strftime('%d/%m/%Y')} (#{day_name}) - #{season}"
  end

  def print_results
    puts
    puts
    puts "=" * 80
    puts "RESULTADOS DA VALIDAÇÃO"
    puts "=" * 80
    puts

    # General stats
    puts "📊 ESTATÍSTICAS GERAIS"
    puts "-" * 40
    puts "Total de dias validados: #{@results[:total_days]}"
    puts

    # Sundays
    puts "🔴 DOMINGOS"
    puts "-" * 40
    sunday_readings_pct = (@results[:sundays][:with_readings].to_f / @results[:sundays][:total] * 100).round(1)
    sunday_collect_pct = (@results[:sundays][:with_collect].to_f / @results[:sundays][:total] * 100).round(1)
    puts "Total: #{@results[:sundays][:total]}"
    puts "Com leituras: #{@results[:sundays][:with_readings]} (#{sunday_readings_pct}%)"
    puts "Com coleta: #{@results[:sundays][:with_collect]} (#{sunday_collect_pct}%)"

    if @results[:sundays][:missing_readings].any?
      puts
      puts "⚠️  Domingos SEM leituras (#{@results[:sundays][:missing_readings].size}):"
      @results[:sundays][:missing_readings].first(10).each { |d| puts "   - #{d}" }
      puts "   ... e mais #{@results[:sundays][:missing_readings].size - 10}" if @results[:sundays][:missing_readings].size > 10
    end

    if @results[:sundays][:missing_collect].any?
      puts
      puts "⚠️  Domingos SEM coleta (#{@results[:sundays][:missing_collect].size}):"
      @results[:sundays][:missing_collect].first(10).each { |d| puts "   - #{d}" }
      puts "   ... e mais #{@results[:sundays][:missing_collect].size - 10}" if @results[:sundays][:missing_collect].size > 10
    end
    puts

    # Weekdays
    puts "🔵 DIAS DE SEMANA"
    puts "-" * 40
    weekday_readings_pct = (@results[:weekdays][:with_readings].to_f / @results[:weekdays][:total] * 100).round(1)
    weekday_collect_pct = (@results[:weekdays][:with_collect].to_f / @results[:weekdays][:total] * 100).round(1)
    puts "Total: #{@results[:weekdays][:total]}"
    puts "Com leituras: #{@results[:weekdays][:with_readings]} (#{weekday_readings_pct}%)"
    puts "Com coleta: #{@results[:weekdays][:with_collect]} (#{weekday_collect_pct}%)"

    if @results[:weekdays][:missing_readings].any?
      puts
      puts "⚠️  Dias de semana SEM leituras (#{@results[:weekdays][:missing_readings].size}):"
      @results[:weekdays][:missing_readings].first(15).each { |d| puts "   - #{d}" }
      puts "   ... e mais #{@results[:weekdays][:missing_readings].size - 15}" if @results[:weekdays][:missing_readings].size > 15
    end
    puts

    # By season
    puts "📅 POR QUADRA LITÚRGICA"
    puts "-" * 40
    @results[:seasons].each do |season, stats|
      readings_pct = (stats[:with_readings].to_f / stats[:total] * 100).round(1)
      puts "#{season}: #{stats[:total]} dias, #{stats[:with_readings]} com leituras (#{readings_pct}%)"
    end
    puts

    # Errors
    if @results[:errors].any?
      puts "❌ ERROS (#{@results[:errors].size}):"
      puts "-" * 40
      @results[:errors].first(10).each do |err|
        puts "   #{err[:date]}: #{err[:error]}"
      end
      puts "   ... e mais #{@results[:errors].size - 10}" if @results[:errors].size > 10
      puts
    end

    # Final verdict
    puts "=" * 80
    total_missing = @results[:sundays][:missing_readings].size + @results[:weekdays][:missing_readings].size
    if total_missing == 0 && @results[:errors].empty?
      puts "✅ VALIDAÇÃO COMPLETA - Todos os dias têm leituras!"
    elsif @results[:sundays][:missing_readings].empty?
      puts "⚠️  VALIDAÇÃO PARCIAL - Todos os domingos OK, #{@results[:weekdays][:missing_readings].size} dias de semana sem leituras"
    else
      puts "❌ VALIDAÇÃO FALHOU - #{@results[:sundays][:missing_readings].size} domingos e #{@results[:weekdays][:missing_readings].size} dias de semana sem leituras"
    end
    puts "=" * 80
  end
end

# ================================================================================
# MAIN
# ================================================================================

year = (ARGV[0] || Date.today.year).to_i
prayer_book_code = ARGV[1] || "loc_2015"

validator = LectionaryValidator.new(year, prayer_book_code)
validator.validate
