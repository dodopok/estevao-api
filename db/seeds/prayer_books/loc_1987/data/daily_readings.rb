#!/usr/bin/env ruby
# encoding: UTF-8

# ================================================================================
# WEEKLY READINGS IMPORTER - LOC 1987 IEAB
# ================================================================================
#
# Purpose:
#   Import daily office readings from CSV file into lectionary_readings table
#
# CSV Structure (expected):
#   ciclo,semana,dia,salmo_manha,salmo_noite,antigo_testamento,novo_testamento,evangelho
#
# Mapping Logic:
#   1. Cycle: "Ímpar" -> "I", "Par" -> "II"
#   2. Week names (Portuguese) -> date_reference base (English)
#   3. Day names (Portuguese) -> weekday suffix (English)
#   4. Psalms:
#      - salmo_manha -> psalm (main)
#      - salmo_noite -> psalm_alternative (optional)
#   5. Readings:
#      - antigo_testamento -> first_reading
#      - novo_testamento -> second_reading
#      - evangelho -> gospel
#   6. Alternative Readings (not in CSV but column created):
#      - Currently CSV does not have separate columns for alternatives,
#        but script is prepared to handle them if they are added or parsed.
#
# Usage:
#   rails runner db/seeds/prayer_books/loc_1987/data/daily_readings.rb
#
# ================================================================================

require 'csv'

class Loc1987ReadingsImporter
  # ============================================================================
  # WEEK NAME MAPPING (Portuguese -> English date_reference)
  # ============================================================================
  WEEK_NAME_MAPPING = {
    # Advent Season
    "Primeira Semana do Advento" => "1st_sunday_of_advent",
    "Segunda Semana do Advento" => "2nd_sunday_of_advent",
    "Terceira Semana do Advento" => "3rd_sunday_of_advent",
    "Quarta Semana do Advento" => "4th_sunday_of_advent",

    # Christmas Season
    "Natal" => "week_of_christmas",
    "Primeira Semana do Natal" => "week_of_christmas", # Assuming standard week
    "Primeiro Domingo depois do Natal" => "first_sunday_after_christmas", # If used as week
    "Semana do Natal" => "week_of_christmas",
    "Santo Nome de Jesus" => "holy_name",
    "Segunda Semana do Natal" => "2nd_sunday_after_christmas", # Rare but possible

    # Epiphany Season
    "Dia da Epifania" => "epiphany", # Fixed date usually
    "Epifania" => "week_of_epiphany",
    "Tempo da Epifania" => "week_of_epiphany", # The week after Epiphany
    "Semana da Epifania" => "week_of_epiphany",
    "Primeira Semana da Epifania" => "week_of_epiphany",
    "Primeira Semana depois da Epifania" => "1st_sunday_after_epiphany", # Usually Baptism
    "Segunda Semana depois da Epifania" => "2nd_sunday_after_epiphany",
    "Segunda Semana da Epifania" => "2nd_sunday_after_epiphany",
    "Terceira Semana depois da Epifania" => "3rd_sunday_after_epiphany",
    "Terceira Semana da Epifania" => "3rd_sunday_after_epiphany",
    "Quarta Semana depois da Epifania" => "4th_sunday_after_epiphany",
    "Quarta Semana da Epifania" => "4th_sunday_after_epiphany",
    "Quinta Semana depois da Epifania" => "5th_sunday_after_epiphany",
    "Quinta Semana da Epifania" => "5th_sunday_after_epiphany",
    "Sexta Semana depois da Epifania" => "6th_sunday_after_epiphany",
    "Sexta Semana da Epifania" => "6th_sunday_after_epiphany",
    "Sétima Semana depois da Epifania" => "7th_sunday_after_epiphany",
    "Sétima Semana da Epifania" => "7th_sunday_after_epiphany",
    "Oitava Semana depois da Epifania" => "8th_sunday_after_epiphany",
    "Oitava Semana da Epifania" => "8th_sunday_after_epiphany",
    "Última Semana da Epifania" => "last_sunday_after_epiphany",

    # Lent Season
    "Quarta-feira de Cinzas" => "ash_wednesday",
    "Semana das Cinzas" => "ash_wednesday", # For days following
    "Primeira Semana da Quaresma" => "1st_sunday_of_lent",
    "Segunda Semana da Quaresma" => "2nd_sunday_of_lent",
    "Terceira Semana da Quaresma" => "3rd_sunday_of_lent",
    "Quarta Semana da Quaresma" => "4th_sunday_of_lent",
    "Quinta Semana da Quaresma" => "5th_sunday_of_lent",
    "Semana Santa" => "holy_week",

    # Easter Season
    "Dia da Páscoa" => "easter_sunday",
    "Semana da Páscoa" => "easter_sunday", # Easter Week
    "Primeira Semana da Páscoa" => "easter_sunday",
    "Segunda Semana da Páscoa" => "2nd_sunday_of_easter",
    "Terceira Semana da Páscoa" => "3rd_sunday_of_easter",
    "Quarta Semana da Páscoa" => "4th_sunday_of_easter",
    "Quinta Semana da Páscoa" => "5th_sunday_of_easter",
    "Sexta Semana da Páscoa" => "6th_sunday_of_easter",
    "Véspera da Ascensão" => "ascension", # TODO: handle vigil/eve
    "Dia da Ascensão" => "ascension",
    "Semana da Ascensão" => "ascension", # Or 7th Sunday
    "Sétima Semana da Páscoa" => "7th_sunday_of_easter",

    # Pentecost
    "Véspera de Pentecostes" => "pentecost",
    "Dia de Pentecostes" => "pentecost",
    "Semana de Pentecostes" => "week_of_pentecost",

    "Véspera do Domingo da Trindade" => "trinity_sunday",
    "Domingo da Trindade" => "trinity_sunday",
    "Semana da Trindade" => "trinity_sunday",

    # Season after Pentecost (Proper / Semanas depois de Pentecostes)
    # LOC 1987 usually uses "Semana X depois de Pentecostes"
    # Need to map to proper_X if following RCL or numbered weeks if not.
    # Assuming LOC 1987 follows a numbered system directly:
    "Primeira Semana depois de Pentecostes" => "proper_1", # Or Trinity? Check logic
    "Próprio 1" => "proper_1",
    "Segunda Semana depois de Pentecostes" => "proper_2",
    "Próprio 2" => "proper_2",
    "Terceira Semana depois de Pentecostes" => "proper_3",
    "Próprio 3" => "proper_3",
    "Quarta Semana depois de Pentecostes" => "proper_4",
    "Próprio 4" => "proper_4",
    "Quinta Semana depois de Pentecostes" => "proper_5",
    "Próprio 5" => "proper_5",
    "Sexta Semana depois de Pentecostes" => "proper_6",
    "Próprio 6" => "proper_6",
    "Sétima Semana depois de Pentecostes" => "proper_7",
    "Próprio 7" => "proper_7",
    "Oitava Semana depois de Pentecostes" => "proper_8",
    "Próprio 8" => "proper_8",
    "Nona Semana depois de Pentecostes" => "proper_9",
    "Próprio 9" => "proper_9",
    "Décima Semana depois de Pentecostes" => "proper_10",
    "Próprio 10" => "proper_10",
    "Décima Primeira Semana depois de Pentecostes" => "proper_11",
    "Próprio 11" => "proper_11",
    "Décima Segunda Semana depois de Pentecostes" => "proper_12",
    "Próprio 12" => "proper_12",
    "Décima Terceira Semana depois de Pentecostes" => "proper_13",
    "Próprio 13" => "proper_13",
    "Décima Quarta Semana depois de Pentecostes" => "proper_14",
    "Próprio 14" => "proper_14",
    "Décima Quinta Semana depois de Pentecostes" => "proper_15",
    "Próprio 15" => "proper_15",
    "Décima Sexta Semana depois de Pentecostes" => "proper_16",
    "Próprio 16" => "proper_16",
    "Décima Sétima Semana depois de Pentecostes" => "proper_17",
    "Próprio 17" => "proper_17",
    "Décima Oitava Semana depois de Pentecostes" => "proper_18",
    "Próprio 18" => "proper_18",
    "Décima Nona Semana depois de Pentecostes" => "proper_19",
    "Próprio 19" => "proper_19",
    "Vigésima Semana depois de Pentecostes" => "proper_20",
    "Próprio 20" => "proper_20",
    "Vigésima Primeira Semana depois de Pentecostes" => "proper_21",
    "Próprio 21" => "proper_21",
    "Vigésima Segunda Semana depois de Pentecostes" => "proper_22",
    "Próprio 22" => "proper_22",
    "Vigésima Terceira Semana depois de Pentecostes" => "proper_23",
    "Próprio 23" => "proper_23",
    "Vigésima Quarta Semana depois de Pentecostes" => "proper_24",
    "Próprio 24" => "proper_24",
    "Vigésima Quinta Semana depois de Pentecostes" => "proper_25",
    "Próprio 25" => "proper_25",
    "Vigésima Sexta Semana depois de Pentecostes" => "proper_26",
    "Próprio 26" => "proper_26",
    "Vigésima Sétima Semana depois de Pentecostes" => "proper_27",
    "Próprio 27" => "proper_27",
    "Vigésima Oitava Semana depois de Pentecostes" => "proper_28",
    "Próprio 28" => "proper_28",
    "Vigésima Nona Semana depois de Pentecostes" => "proper_29",
    "Próprio 29" => "proper_29",
    "Última Semana depois de Pentecostes" => "christ_the_king" # Often proper_29 or 34 in other systems
  }.freeze

  # ============================================================================
  # WEEKDAY MAPPING (Portuguese -> English)
  # ============================================================================
  WEEKDAY_MAPPING = {
    "Seg" => "monday",
    "Ter" => "tuesday",
    "Qua" => "wednesday",
    "Qui" => "thursday",
    "Sex" => "friday",
    "Sab" => "saturday",
    "Dom" => "sunday"
  }.freeze

  # ============================================================================
  # MONTH MAPPING (Portuguese -> English)
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

  # Default CSV path
  DEFAULT_CSV_PATH = 'db/seeds/prayer_books/loc_1987/data/daily_readings.csv'.freeze

  # ============================================================================
  # INITIALIZATION
  # ============================================================================
  def initialize(csv_path = nil)
    @csv_path = csv_path || DEFAULT_CSV_PATH
    @prayer_book = PrayerBook.find_by!(code: 'loc_1987')
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
    Rails.logger.info "\n" + "="*80
    Rails.logger.info "IMPORTING LOC 1987 READINGS FROM: #{@csv_path}"
    Rails.logger.info "="*80
    Rails.logger.info ""

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
    # 1. Extract and map basic info
    cycle_raw = row['ciclo']
    cycle = map_cycle(cycle_raw)

    week_name = row['semana']
    day_str = row['dia']

    # 2. Build date_reference
    date_reference = build_date_reference(week_name, day_str)

    # If date_reference is nil, it means we couldn't map the week/day, so skip
    if date_reference.nil?
      Rails.logger.info "Skipping row #{row_number}: Unmapped week '#{week_name}' or day '#{day_str}'"
      @stats[:skipped] += 1
      # Optional: Log warning if needed, but keeping it clean for now
      return
    end

    # 3. Map readings
    # CSV cols: salmo_manha,salmo_noite,antigo_testamento,novo_testamento,evangelho

    psalm = row['salmo_manha']
    psalm_alt = row['salmo_noite']

    first_reading = row['antigo_testamento']
    second_reading = row['novo_testamento']
    gospel = row['evangelho']

    # 4. Create/Update record
    create_or_update_reading({
      prayer_book_id: @prayer_book.id,
      cycle: cycle,
      service_type: 'daily_office', # LOC 1987 is Daily Office (Daily Lectionary)
      date_reference: date_reference,
      reading_type: 'semicontinuous', # Default for Daily Office usually

      # Main Readings
      psalm: clean_text(psalm),
      first_reading: clean_text(first_reading),
      second_reading: clean_text(second_reading),
      gospel: clean_text(gospel),

      # Alternative/Evening Readings
      psalm_alternative: clean_text(psalm_alt),
      first_reading_alternative: nil, # CSV doesn't have it yet
      second_reading_alternative: nil, # CSV doesn't have it yet
      gospel_alternative: nil # CSV doesn't have it yet
    })

  rescue => e
    @stats[:errors] << "Row #{row_number}: #{e.message} | Row: #{row.to_h}"
    @stats[:skipped] += 1
  end

  # ============================================================================
  # HELPER METHODS
  # ============================================================================
  def map_cycle(cycle_raw)
    case cycle_raw&.downcase
    when 'ímpar', 'impar', '1' then 'odd'
    when 'par', '2' then 'even'
    when 'ambos' then 'all' # Or handle as applying to both
    end
  end

  def clean_text(text)
    return nil if text.nil? || text.strip.empty?
    text.strip
  end

  def build_date_reference(week_name, day_str)
    day_str = day_str.to_s.strip

    # 1. Check if it's a fixed date (e.g., "22 Dez", "2 Jan")
    if day_str.match?(/^\d+\s+(Jan|Fev|Mar|Abr|Mai|Jun|Jul|Ago|Set|Out|Nov|Dez)$/)
      parts = day_str.split
      day = parts[0].to_i
      month = MONTH_MAPPING[parts[1]]
      return "#{month}_#{day}"
    end

    # 2. Extract base weekday
    weekday = WEEKDAY_MAPPING[day_str]

    # 3. If weekday is nil, maybe it is a special day (like 'Dom' which is usually omitted in daily office but might appear)
    # or empty string?
    if weekday.nil?
      # If day_str is empty and we have a valid week_base (feast), return week_base
      week_base = WEEK_NAME_MAPPING[week_name]
      week_base ||= WEEK_NAME_MAPPING.find { |k, v| k.downcase == week_name.to_s.strip.downcase }&.last

      if day_str.empty? && week_base
        return week_base
      end

      # If day_str is empty, maybe the week_name itself implies the day?
      # e.g. "Dia de Natal"
      # But usually fixed dates are explicit.
      return nil
    end

    # 4. Map week name
    # We need to handle potential variations or trimming
    # Use exact match first, then case insensitive
    week_base = WEEK_NAME_MAPPING[week_name]
    week_base ||= WEEK_NAME_MAPPING.find { |k, v| k.downcase == week_name.to_s.strip.downcase }&.last

    if week_base.nil?
      # Try partial match or heuristics if strict match fails?
      # For now, return nil to skip unknown weeks
      # Rails.logger.warn "Unknown week: #{week_name}"
      return nil
    end

    "#{week_base}_#{weekday}"
  end

  # ============================================================================
  # DATABASE OPERATIONS
  # ============================================================================
  def create_or_update_reading(data)
    # Check if we should update or create
    # Note: For daily office, we might have multiple entries if we didn't handle cycle correctly
    # But here we include cycle in lookup.

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
    Rails.logger.info "\n\n" + "="*80
    Rails.logger.info "IMPORT COMPLETED"
    Rails.logger.info "="*80
    Rails.logger.info "✅ Created: #{@stats[:created]}"
    Rails.logger.info "🔄 Updated: #{@stats[:updated]}"
    Rails.logger.info "⏭️  Skipped: #{@stats[:skipped]}"
    Rails.logger.info "📊 Total processed: #{@stats[:created] + @stats[:updated] + @stats[:skipped]}"

    if @stats[:errors].any?
      Rails.logger.info "\n❌ ERRORS (#{@stats[:errors].count}):"
      @stats[:errors].first(10).each { |err| Rails.logger.info "   #{err}" }
    end
    Rails.logger.info "="*80
  end
end

# ================================================================================
# SCRIPT EXECUTION
# ================================================================================
if __FILE__ == $0
  csv_path = ARGV[0] # Optional: override default path

  # Ensure path exists
  unless csv_path
    csv_path = Loc1987ReadingsImporter::DEFAULT_CSV_PATH
  end

  if !File.exist?(csv_path)
    Rails.logger.info "Error: File not found: #{csv_path}"
    # try relative to rails root if not absolute
    csv_path = Rails.root.join(csv_path)
    if !File.exist?(csv_path)
      Rails.logger.info "Error: File really not found: #{csv_path}"
      exit 1
    end
  end

  Rails.logger.info "Starting LOC 1987 Readings Import..."
  importer = Loc1987ReadingsImporter.new(csv_path.to_s)
  importer.import
  Rails.logger.info "\n✓ Import completed successfully!"
end
