#!/usr/bin/env ruby
# encoding: UTF-8

# ================================================================================
# DAILY READINGS IMPORTER - LOCB 2008
# ================================================================================
#
# Purpose:
#   Import daily office readings from CSV file into lectionary_readings table
#   for LOCB 2008 prayer book (biannual cycle: odd/even years)
#
# CSV Structure:
#   ciclo,semana,dia,salmo_manha,salmo_noite,antigo_testamento,novo_testamento,evangelho
#   Ímpar,Primeira Semana do Advento,Seg,"Salmo 1, 2, 3","Salmo 4, 7",Isaías 1:10-20,1 Tessalonicenses 1:1-10,Lucas 20:1-8
#
# Mapping Logic:
#   1. Cycle: Ímpar → "odd", Par → "even"
#   2. Week names (Portuguese) → date_reference base (English)
#   3. Day names (Portuguese) → weekday suffix (English)
#   4. Fixed dates (DD Mon) → month_day format
#   5. Psalms: salmo_manha / salmo_noite joined with " / "
#   6. novo_testamento → second_reading, evangelho → gospel
#
# Usage:
#   rails runner script/import_locb_2008_daily_readings.rb
#
# ================================================================================

require 'csv'

class Locb2008DailyReadingsImporter
  # ============================================================================
  # WEEK NAME MAPPING (Portuguese → English date_reference)
  # ============================================================================
  WEEK_NAME_MAPPING = {
    # Advent Season
    "Primeira Semana do Advento" => "1st_sunday_of_advent",
    "Segunda Semana do Advento" => "2nd_sunday_of_advent",
    "Terceira Semana do Advento" => "3rd_sunday_of_advent",
    "Quarta Semana do Advento" => "4th_sunday_of_advent",

    # Christmas Season
    "Dia de Natal" => "christmas_day",
    "Primeira Semana do Natal" => "1st_sunday_after_christmas",
    "Segunda Semana do Natal" => "2nd_sunday_after_christmas",
    "Primeiro Domingo depois do Natal" => "1st_sunday_after_christmas",
    "Santo Nome de Jesus" => "holy_name",

    # Epiphany Season
    "Tempo da Epifania" => "week_of_epiphany",
    "Primeira Semana da Epifania" => "1st_sunday_after_epiphany",
    "Segunda Semana da Epifania" => "2nd_sunday_after_epiphany",
    "Terceira Semana da Epifania" => "3rd_sunday_after_epiphany",
    "Quarta Semana da Epifania" => "4th_sunday_after_epiphany",
    "Quinta Semana da Epifania" => "5th_sunday_after_epiphany",
    "Sexta Semana da Epifania" => "6th_sunday_after_epiphany",
    "Sétima Semana da Epifania" => "7th_sunday_after_epiphany",
    "Oitava Semana da Epifania" => "8th_sunday_after_epiphany",
    "Última Semana da Epifania" => "last_sunday_after_epiphany",

    # Lent Season
    "Primeira Semana da Quaresma" => "1st_sunday_of_lent",
    "Segunda Semana da Quaresma" => "2nd_sunday_of_lent",
    "Terceira Semana da Quaresma" => "3rd_sunday_of_lent",
    "Quarta Semana da Quaresma" => "4th_sunday_of_lent",
    "Quinta Semana da Quaresma" => "5th_sunday_of_lent",

    # Holy Week
    "Semana Santa" => "holy_week",

    # Easter Season
    "Primeira Semana da Páscoa" => "easter_sunday",
    "Segunda Semana da Páscoa" => "2nd_sunday_of_easter",
    "Terceira Semana da Páscoa" => "3rd_sunday_of_easter",
    "Quarta Semana da Páscoa" => "4th_sunday_of_easter",
    "Quinta Semana da Páscoa" => "5th_sunday_of_easter",
    "Sexta Semana da Páscoa" => "6th_sunday_of_easter",
    "Sétima Semana da Páscoa" => "7th_sunday_of_easter",
    "Ascensão do Senhor" => "ascension",

    # Pentecost Season
    "Semana de Pentecostes" => "pentecost",
    "Semana da Trindade" => "trinity_sunday",

    # Ordinary Time - Propers
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
  # CYCLE MAPPING (Portuguese → English)
  # ============================================================================
  CYCLE_MAPPING = {
    "Ímpar" => "odd",
    "Impar" => "odd",
    "Par" => "even"
  }.freeze

  # Default CSV path
  DEFAULT_CSV_PATH = 'db/seeds/prayer_books/locb_2008/data/daily_readings.csv'.freeze

  # ============================================================================
  # INITIALIZATION
  # ============================================================================
  def initialize(csv_path = nil, prayer_book = nil)
    @csv_path = csv_path || DEFAULT_CSV_PATH
    @prayer_book = prayer_book || PrayerBook.find_by!(code: 'locb_2008')
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
    puts "IMPORTING LOCB 2008 DAILY READINGS FROM: #{@csv_path}"
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
    cycle = extract_cycle(row['ciclo'])
    week_name = row['semana']
    day_str = row['dia']

    # Build date_reference
    date_reference = build_date_reference(week_name, day_str)

    # Map readings
    salmo_manha = row['salmo_manha']
    salmo_noite = row['salmo_noite']
    psalm = build_psalm(salmo_manha, salmo_noite)

    first_reading = row['antigo_testamento']
    second_reading = row['novo_testamento']
    gospel = row['evangelho']

    # Create/update record
    create_or_update_reading({
      prayer_book_id: @prayer_book.id,
      cycle: cycle,
      service_type: 'weekly',
      date_reference: date_reference,
      reading_type: nil, # LOCB 2008 doesn't have complementary/semicontinuous
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
  def extract_cycle(ciclo_str)
    CYCLE_MAPPING[ciclo_str] || ciclo_str&.downcase
  end

  # ============================================================================
  # PSALM CONSTRUCTION
  # ============================================================================
  def build_psalm(salmo_manha, salmo_noite)
    parts = [ salmo_manha, salmo_noite ].compact.reject(&:empty?)
    parts.join(' / ')
  end

  # ============================================================================
  # DATE REFERENCE CONSTRUCTION
  # ============================================================================
  def build_date_reference(week_name, day_str)
    # 1. Check if it's a fixed date (e.g., "22 Dez", "2 Jan", "24 Dez")
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
      date_reference: data[:date_reference]
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

  puts "Starting LOCB 2008 Daily Readings Import..."
  importer = Locb2008DailyReadingsImporter.new(csv_path)
  importer.import
  puts "\n✓ Import completed successfully!"
end
