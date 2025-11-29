#!/usr/bin/env ruby
# encoding: UTF-8

# ================================================================================
# WEEKLY READINGS IMPORTER - LOC 2015 IEAB
# ================================================================================
#
# Purpose:
#   Import daily office readings from CSV file into lectionary_readings table
#
# CSV Structure (v2):
#   ano,semana,dia,tipo,salmo,antigo_testamento,novo_testamento
#   Ano A,Primeiro Domingo do Advento,Qui,,Salmo 122,...
#   Ano C,Próprio 21,Qui,Complementar,Salmo 146,...
#
# Mapping Logic:
#   1. Week names (Portuguese) → date_reference base (English)
#   2. Day names (Portuguese) → weekday suffix (English)
#   3. Fixed dates (DD Mon) → month_day format
#   4. Reading type from 'tipo' column: Complementar or Semicontínua
#   5. Gospel detection: Mateus/Marcos/Lucas/João → gospel field
#      All other NT books → second_reading field
#
# Usage:
#   rails runner script/import_weekly_readings.rb
#
# ================================================================================

require 'csv'

class WeeklyReadingsImporter
  # ============================================================================
  # WEEK NAME MAPPING (Portuguese → English date_reference)
  # ============================================================================
  WEEK_NAME_MAPPING = {
    # Advent Season (multiple naming conventions)
    "Primeiro Domingo do Advento" => "1st_sunday_of_advent",
    "Segundo Domingo do Advento" => "2nd_sunday_of_advent",
    "Terceiro Domingo do Advento" => "3rd_sunday_of_advent",
    "Quarto Domingo do Advento" => "4th_sunday_of_advent",
    "Advento 1" => "1st_sunday_of_advent",
    "Advento 2" => "2nd_sunday_of_advent",
    "Advento 3" => "3rd_sunday_of_advent",
    "Advento 4" => "4th_sunday_of_advent",

    # Christmas Season
    "Natividade de nosso Senhor Jesus Cristo" => "week_of_christmas",
    "Natal" => "week_of_christmas",
    "Primeiro Domingo após o Natal" => "first_sunday_after_christmas",

    # Epiphany Season
    "Epifania de nosso Senhor Jesus Cristo" => "week_of_epiphany",
    "Epifania" => "week_of_epiphany",
    "Batismo de nosso Senhor Jesus Cristo" => "baptism_of_christ",
    "Batismo" => "baptism_of_christ",
    "Último Domingo depois da Epifania" => "last_sunday_after_epiphany",
    "Último Epifania" => "last_sunday_after_epiphany",

    # Ordinary Time after Epiphany (multiple naming conventions)
    "Segundo Domingo depois da Epifania" => "2nd_sunday_after_epiphany",
    "Terceiro Domingo depois da Epifania" => "3rd_sunday_after_epiphany",
    "Quarto Domingo depois da Epifania" => "4th_sunday_after_epiphany",
    "Quinto Domingo depois da Epifania" => "5th_sunday_after_epiphany",
    "Sexto Domingo depois da Epifania" => "6th_sunday_after_epiphany",
    "Sétimo Domingo depois da Epifania" => "7th_sunday_after_epiphany",
    "Oitavo Domingo depois da Epifania" => "8th_sunday_after_epiphany",
    "Nono Domingo depois da Epifania" => "9th_sunday_after_epiphany",
    "Epifania 2" => "2nd_sunday_after_epiphany",
    "Epifania 3" => "3rd_sunday_after_epiphany",
    "Epifania 4" => "4th_sunday_after_epiphany",
    "Epifania 5" => "5th_sunday_after_epiphany",
    "Epifania 6" => "6th_sunday_after_epiphany",
    "Epifania 7" => "7th_sunday_after_epiphany",
    "Epifania 8" => "8th_sunday_after_epiphany",
    "Epifania 9" => "9th_sunday_after_epiphany",

    # Lent Season (multiple naming conventions)
    "Quarta-feira de Cinzas" => "ash_wednesday",
    "Primeiro Domingo da Quaresma" => "1st_sunday_of_lent",
    "Segundo Domingo da Quaresma" => "2nd_sunday_of_lent",
    "Terceiro Domingo da Quaresma" => "3rd_sunday_of_lent",
    "Quarto Domingo da Quaresma" => "4th_sunday_of_lent",
    "Quinto Domingo da Quaresma" => "5th_sunday_of_lent",
    "Quaresma 1" => "1st_sunday_of_lent",
    "Quaresma 2" => "2nd_sunday_of_lent",
    "Quaresma 3" => "3rd_sunday_of_lent",
    "Quaresma 4" => "4th_sunday_of_lent",
    "Quaresma 5" => "5th_sunday_of_lent",

    # Holy Week
    "Domingo de Ramos" => "palm_sunday",
    "Ramos" => "palm_sunday",
    "Semana Santa" => "holy_week",

    # Easter Season (multiple naming conventions)
    "Domingo de Páscoa" => "easter_sunday",
    "Páscoa 1" => "easter_sunday",
    "Segundo Domingo da Páscoa" => "2nd_sunday_of_easter",
    "Terceiro Domingo da Páscoa" => "3rd_sunday_of_easter",
    "Quarto Domingo da Páscoa" => "4th_sunday_of_easter",
    "Quinto Domingo da Páscoa" => "5th_sunday_of_easter",
    "Sexto Domingo da Páscoa" => "6th_sunday_of_easter",
    "Sétimo Domingo da Páscoa" => "7th_sunday_of_easter",
    "Páscoa 2" => "2nd_sunday_of_easter",
    "Páscoa 3" => "3rd_sunday_of_easter",
    "Páscoa 4" => "4th_sunday_of_easter",
    "Páscoa 5" => "5th_sunday_of_easter",
    "Páscoa 6" => "6th_sunday_of_easter",
    "Páscoa 7" => "7th_sunday_of_easter",
    "Ascensão de nosso Senhor Jesus Cristo" => "ascension",

    # Pentecost
    "Dia de Pentecostes" => "pentecost",
    "Pentecostes" => "pentecost",
    "Santíssima Trindade" => "trinity_sunday",
    "Trindade" => "trinity_sunday",

    # Ordinary Time (after Pentecost) - Propers
    "Próprio 1" => "proper_1",
    "Próprio 2" => "proper_2",
    "Próprio 3" => "proper_3",
    "Próprio 4" => "proper_4",
    "Próprio 5" => "proper_5",
    "Próprio 6" => "proper_6",
    "Próprio 7" => "proper_7",
    "Próprio 8" => "proper_8",
    "Próprio 9" => "proper_9",
    "Próprio 10" => "proper_10",
    "Próprio 11" => "proper_11",
    "Próprio 12" => "proper_12",
    "Próprio 13" => "proper_13",
    "Próprio 14" => "proper_14",
    "Próprio 15" => "proper_15",
    "Próprio 16" => "proper_16",
    "Próprio 17" => "proper_17",
    "Próprio 18" => "proper_18",
    "Próprio 19" => "proper_19",
    "Próprio 20" => "proper_20",
    "Próprio 21" => "proper_21",
    "Próprio 22" => "proper_22",
    "Próprio 23" => "proper_23",
    "Próprio 24" => "proper_24",
    "Próprio 25" => "proper_25",
    "Próprio 26" => "proper_26",
    "Próprio 27" => "proper_27",
    "Próprio 28" => "proper_28",
    "Próprio 29" => "christ_the_king"
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
    "Fev" => "february",
    "Mar" => "march",
    "Abr" => "april",
    "Mai" => "may",
    "Jun" => "june",
    "Jul" => "july",
    "Ago" => "august",
    "Set" => "september",
    "Out" => "october",
    "Nov" => "november",
    "Dez" => "december"
  }.freeze

  # ============================================================================
  # GOSPEL BOOKS (Portuguese)
  # ============================================================================
  GOSPEL_BOOKS = %w[Mateus Marcos Lucas João].freeze

  # Default CSV path
  DEFAULT_CSV_PATH = 'script/ieab_weekly_v2.csv'.freeze

  # ============================================================================
  # INITIALIZATION
  # ============================================================================
  def initialize(csv_path = nil)
    @csv_path = csv_path || DEFAULT_CSV_PATH
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
    tipo = row['tipo']

    # Build date_reference
    date_reference = build_date_reference(week_name, day_str)

    # Determine reading_type from 'tipo' column
    reading_type = extract_reading_type(tipo)

    # Map readings (note: column names use snake_case in v2)
    psalm = row['salmo']
    first_reading = row['antigo_testamento']
    novo_testamento = row['novo_testamento']

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

  def extract_reading_type(tipo_str)
    return 'complementary' if tipo_str&.downcase&.include?('complementar')
    return 'semicontinuous' if tipo_str&.downcase&.include?('semicont')
    # Default to nil/standard if no type specified (for seasons without two types)
    nil
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
    if day_str.match?(/^\d+\s+(Jan|Fev|Mar|Abr|Mai|Jun|Jul|Ago|Set|Out|Nov|Dez)$/)
      parts = day_str.split
      day = parts[0].to_i
      month = MONTH_MAPPING[parts[1]]
      return "#{month}_#{day}"
    end

    # 2. Extract base weekday
    weekday = WEEKDAY_MAPPING[day_str]

    if weekday.nil?
      raise "Unknown weekday: #{day_str}"
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
  csv_path = ARGV[0] # Optional: override default path

  if csv_path && !File.exist?(csv_path)
    puts "Error: File not found: #{csv_path}"
    exit 1
  end

  puts "Starting Weekly Readings Import..."
  importer = WeeklyReadingsImporter.new(csv_path)
  importer.import
  puts "\n✓ Import completed successfully!"
end
