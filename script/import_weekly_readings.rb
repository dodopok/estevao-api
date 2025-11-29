#!/usr/bin/env ruby
# encoding: UTF-8
# ================================================================================
# WEEKLY READINGS IMPORTER - LOC 2015 IEAB
# ================================================================================
#
# Purpose:
#   Import daily office readings from CSV file into lectionary_readings table
#
# CSV Structure:
#   ano,semana,dia,salmo,antigo testamento,novo testamento
#   Ano A,Semana próxima ao Primeiro Domingo do Advento,Qui,Salmo 122,...
#
# Mapping Logic:
#   1. Week names (Portuguese) → date_reference base (English)
#   2. Day names (Portuguese) → weekday suffix (English)
#   3. Fixed dates (DD Mon) → month_day format
#   4. Reading type from day modifiers: (Complementar) or (Semicontínua)
#   5. Gospel detection: Mateus/Marcos/Lucas/João → gospel field
#      All other NT books → second_reading field
#
# Usage:
#   rails runner script/import_weekly_readings.rb script/ieab_weekly.csv
#
# ================================================================================

require 'csv'

class WeeklyReadingsImporter
  # ============================================================================
  # WEEK NAME MAPPING (Portuguese → English date_reference)
  # ============================================================================
  WEEK_NAME_MAPPING = {
    # Advent Season
    "Semana próxima ao Primeiro Domingo do Advento" => "1st_sunday_of_advent",
    "Semana próxima ao Segundo Domingo do Advento" => "2nd_sunday_of_advent",
    "Semana próxima ao Terceiro Domingo do Advento" => "3rd_sunday_of_advent",
    "Semana próxima ao Quarto Domingo do Advento" => "4th_sunday_of_advent",

    # Christmas Season
    "Semana próxima à Natividade" => "week_of_christmas",
    "Primeiro Domingo após o Natal" => "first_sunday_after_christmas",

    # Epiphany Season
    "Semana próxima à Epifania" => "week_of_epiphany",
    "Tempo Comum 1 (Batismo de Cristo)" => "baptism_of_christ",
    "Último Domingo depois da Epifania" => "last_sunday_after_epiphany",

    # Ordinary Time (before Lent)
    "Tempo Comum 2" => "ordinary_time_2",
    "Tempo Comum 3" => "ordinary_time_3",
    "Tempo Comum 4" => "ordinary_time_4",
    "Tempo Comum 5" => "ordinary_time_5",
    "Tempo Comum 6 / Próprio 1" => "proper_1",
    "Tempo Comum 7 / Próprio 2" => "proper_2",
    "Tempo Comum 8 / Próprio 3" => "proper_3",
    "Tempo Comum 9 / Próprio 4" => "proper_4",

    # Lent Season
    "Semana próxima ao Primeiro Domingo da Quaresma" => "1st_sunday_of_lent",
    "Semana próxima ao Segundo Domingo da Quaresma" => "2nd_sunday_of_lent",
    "Semana próxima ao Terceiro Domingo da Quaresma" => "3rd_sunday_of_lent",
    "Semana próxima ao Quarto Domingo da Quaresma" => "4th_sunday_of_lent",
    "Semana próxima ao Quinto Domingo da Quaresma" => "5th_sunday_of_lent",

    # Holy Week
    "Semana Santa / Domingo de Ramos" => "holy_week",

    # Easter Season
    "Semana próxima ao Segundo Domingo da Páscoa" => "2nd_sunday_of_easter",
    "Semana próxima ao Terceiro Domingo da Páscoa" => "3rd_sunday_of_easter",
    "Semana próxima ao Quarto Domingo da Páscoa" => "4th_sunday_of_easter",
    "Semana próxima ao Quinto Domingo da Páscoa" => "5th_sunday_of_easter",
    "Semana próxima ao Sexto Domingo da Páscoa" => "6th_sunday_of_easter",
    "Semana próxima ao Sétimo Domingo da Páscoa" => "7th_sunday_of_easter",

    # Pentecost
    "Semana próxima a Pentecostes" => "week_of_pentecost",
    "Semana Próxima à Santíssima Trindade" => "trinity_sunday",

    # Ordinary Time (after Pentecost) - Propers
    "Próprio 3 / Tempo Comum 8" => "proper_3",
    "Próprio 4 / Tempo Comum 9" => "proper_4",
    "Próprio 5 / Tempo Comum 10" => "proper_5",
    "Próprio 6 / Tempo Comum 11" => "proper_6",
    "Próprio 7 / Tempo Comum 12" => "proper_7",
    "Próprio 8 / Tempo Comum 13" => "proper_8",
    "Próprio 9 / Tempo Comum 14" => "proper_9",
    "Próprio 10 / Tempo Comum 15" => "proper_10",
    "Próprio 11 / Tempo Comum 16" => "proper_11",
    "Próprio 12 / Tempo Comum 17" => "proper_12",
    "Próprio 13 / Tempo Comum 18" => "proper_13",
    "Próprio 14 / Tempo Comum 19" => "proper_14",
    "Próprio 15 / Tempo Comum 20" => "proper_15",
    "Próprio 16 / Tempo Comum 21" => "proper_16",
    "Próprio 17 / Tempo Comum 22" => "proper_17",
    "Próprio 18 / Tempo Comum 23" => "proper_18",
    "Próprio 19 / Tempo Comum 24" => "proper_19",
    "Próprio 20 / Tempo Comum 25" => "proper_20",
    "Próprio 21 / Tempo Comum 26" => "proper_21",
    "Próprio 22 / Tempo Comum 27" => "proper_22",
    "Próprio 23 / Tempo Comum 28" => "proper_23",
    "Próprio 24 / Tempo Comum 29" => "proper_24",
    "Próprio 25 / Tempo Comum 30" => "proper_25",
    "Próprio 26 / Tempo Comum 31" => "proper_26",
    "Próprio 27 / Tempo Comum 32" => "proper_27",
    "Próprio 28 / Tempo Comum 33" => "proper_28",
    "Próprio 29 / Tempo Comum 34 (Cristo Rei)" => "christ_the_king"
  }.freeze

  # ============================================================================
  # WEEKDAY MAPPING (Portuguese → English)
  # ============================================================================
  WEEKDAY_MAPPING = {
    "Seg" => "monday",
    "Ter" => "tuesday",
    "Qua" => "wednesday",
    "Qui" => "thursday",
    "Sex" => "friday",
    "Sab" => "saturday"
  }.freeze

  # ============================================================================
  # MONTH MAPPING (Portuguese → English)
  # ============================================================================
  MONTH_MAPPING = {
    "Jan" => "january",
    "Dez" => "december"
  }.freeze

  # ============================================================================
  # GOSPEL BOOKS (Portuguese)
  # ============================================================================
  GOSPEL_BOOKS = %w[Mateus Marcos Lucas João].freeze

  # ============================================================================
  # INITIALIZATION
  # ============================================================================
  def initialize(csv_path)
    @csv_path = csv_path
    @prayer_book = PrayerBook.find_by!(code: 'loc_2015')
    @stats = {
      created: 0,
      updated: 0,
      skipped: 0,
      errors: []
    }
  end

  # ============================================================================
  # IMPORT MAIN METHOD
  # ============================================================================
  def import
    puts "\n" + "="*80
    puts "IMPORTING WEEKLY READINGS FROM: #{@csv_path}"
    puts "="*80
    puts ""

    row_count = 0
    CSV.foreach(@csv_path, headers: true, encoding: 'UTF-8') do |row|
      row_count += 1
      process_row(row, row_count)
      print '.' if row_count % 50 == 0
    end

    report_stats
  end

  private

  # ============================================================================
  # ROW PROCESSING
  # ============================================================================
  def process_row(row, row_number)
    # Extract CSV fields
    cycle = extract_cycle(row['ano'])
    week_name = row['semana']
    day_str = row['dia']

    # Build date_reference
    date_reference = build_date_reference(week_name, day_str)

    # Determine reading_type
    reading_type = extract_reading_type(day_str)

    # Map readings
    psalm = row['salmo']
    first_reading = row['antigo testamento']
    novo_testamento = row['novo testamento']

    # Detect gospel vs second_reading
    if gospel_book?(novo_testamento)
      gospel = novo_testamento
      second_reading = nil
    else
      gospel = nil
      second_reading = novo_testamento
    end

    # Create/update record
    create_or_update_reading({
      prayer_book_id: @prayer_book.id,
      cycle: cycle,
      service_type: 'weekly',
      date_reference: date_reference,
      reading_type: reading_type,
      first_reading: first_reading,
      psalm: psalm,
      second_reading: second_reading,
      gospel: gospel
    })

  rescue => e
    @stats[:errors] << "Row #{row_number}: #{e.message}"
    @stats[:skipped] += 1
  end

  # ============================================================================
  # EXTRACTION METHODS
  # ============================================================================
  def extract_cycle(ano_str)
    # "Ano A" → "A"
    ano_str.gsub('Ano ', '')
  end

  def extract_reading_type(day_str)
    return 'complementary' if day_str.include?('(Complementar)')
    'semicontinuous'
  end

  # ============================================================================
  # GOSPEL DETECTION
  # ============================================================================
  def gospel_book?(text)
    return false if text.nil? || text.strip.empty?

    # Exclude Roman numerals at start (I, II, III)
    # This prevents "I João" from being identified as "João" (Gospel)
    return false if text.strip.match?(/^(I|II|III)\s/)

    # Check if text starts with any gospel book name
    GOSPEL_BOOKS.any? { |book| text.strip.start_with?(book) }
  end

  # ============================================================================
  # DATE REFERENCE CONSTRUCTION
  # ============================================================================
  def build_date_reference(week_name, day_str)
    # 1. Check if it's a fixed date (e.g., "22 Dez", "2 Jan")
    if day_str.match?(/^\d+\s+(Jan|Dez)$/)
      parts = day_str.split
      day = parts[0].to_i
      month = MONTH_MAPPING[parts[1]]
      return "#{month}_#{day}"
    end

    # 2. Extract base weekday (remove modifiers like "(Complementar)")
    clean_day = day_str.gsub(/\s*\([^)]+\)/, '').strip
    weekday = WEEKDAY_MAPPING[clean_day]

    if weekday.nil?
      raise "Unknown weekday: #{clean_day} (original: #{day_str})"
    end

    # 3. Map week name to base reference
    week_base = WEEK_NAME_MAPPING[week_name]

    if week_base.nil?
      raise "Unknown week name: #{week_name}"
    end

    # 4. Construct full reference
    "#{week_base}_#{weekday}"
  end

  # ============================================================================
  # DATABASE OPERATIONS
  # ============================================================================
  def create_or_update_reading(data)
    existing = LectionaryReading.find_by(
      prayer_book_id: data[:prayer_book_id],
      cycle: data[:cycle],
      service_type: data[:service_type],
      date_reference: data[:date_reference],
      reading_type: data[:reading_type]
    )

    if existing
      existing.update!(data)
      @stats[:updated] += 1
    else
      LectionaryReading.create!(data)
      @stats[:created] += 1
    end
  end

  # ============================================================================
  # STATISTICS REPORTING
  # ============================================================================
  def report_stats
    puts "\n\n" + "="*80
    puts "IMPORT COMPLETED"
    puts "="*80
    puts "✅ Created: #{@stats[:created]}"
    puts "🔄 Updated: #{@stats[:updated]}"
    puts "⏭️  Skipped: #{@stats[:skipped]}"
    puts "📊 Total processed: #{@stats[:created] + @stats[:updated] + @stats[:skipped]}"

    if @stats[:errors].any?
      puts "\n❌ ERRORS (#{@stats[:errors].count}):"
      @stats[:errors].first(10).each { |err| puts "   #{err}" }
      if @stats[:errors].count > 10
        puts "   ... and #{@stats[:errors].count - 10} more errors"
      end
    end

    puts "="*80
  end
end

# ================================================================================
# SCRIPT EXECUTION
# ================================================================================
if __FILE__ == $0
  if ARGV.empty?
    puts "Usage: rails runner script/import_weekly_readings.rb <path_to_csv>"
    puts "Example: rails runner script/import_weekly_readings.rb script/ieab_weekly.csv"
    exit 1
  end

  csv_path = ARGV[0]

  unless File.exist?(csv_path)
    puts "Error: File not found: #{csv_path}"
    exit 1
  end

  puts "Starting Weekly Readings Import..."
  importer = WeeklyReadingsImporter.new(csv_path)
  importer.import
  puts "\n✓ Import completed successfully!"
end
