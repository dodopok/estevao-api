# frozen_string_literal: true

# Service to fetch lectionary readings for a specific date
#
# This service determines the appropriate readings based on:
# - The liturgical calendar and current season
# - The Sunday/weekday cycle (A/B/C for Sundays, Even/Odd for weekdays)
# - Celebration precedence (Principal feasts, Holy Days, etc.)
# - Prayer Book specific reading patterns
#
# CACHING: Uses v4 cache strategy with prayer_book.updated_at versioning
# - Readings are cached per date/prayer_book/translation with 1-day TTL
# - Readings data is deterministic for a given date, so cache is very effective
#
# @example Fetch readings for a specific date
#   service = ReadingService.for(Date.new(2024, 12, 25), prayer_book_code: 'loc_2015')
#   readings = service.find_readings
#   # => { first_reading: {...}, psalm: {...}, gospel: {...}, ... }
#
# @example Check the current lectionary cycle
#   service.cycle # => "A" (for Sundays) or "even" (for weekdays)
#
class ReadingService
  include PrayerBookAware

  # Movable feast calculation rules that have their own readings
  MOVABLE_RULES_WITH_READINGS = %w[
    easter_minus_46_days
    easter_minus_6_days
    easter_minus_5_days
    easter_minus_4_days
    easter_minus_3_days
    easter_minus_2_days
    easter_minus_1_days
  ].freeze

  # Seasons where Sunday takes precedence over minor festivals
  MAJOR_SEASONS = %w[Advento Quaresma Páscoa].freeze

  attr_reader :date, :calendar, :cycle, :translation, :reading_type

  # Factory method que retorna o serviço apropriado baseado no prayer_book_code
  # Uses caching for readings lookup
  def self.for(date, prayer_book_code: "loc_2015", calendar: nil, translation: "nvi", reading_type: nil)
    case prayer_book_code
    when "loc_2015"
      Reading::Loc2015Service.new(date, calendar: calendar, translation: translation, reading_type: reading_type)
    else
      new(date, prayer_book_code: prayer_book_code, calendar: calendar, translation: translation, reading_type: reading_type)
    end
  end

  def initialize(date, prayer_book_code: "loc_2015", calendar: nil, translation: "nvi", reading_type: nil)
    @date = date
    @calendar = calendar || LiturgicalCalendar.new(date.year)
    @cycle = determine_cycle
    @prayer_book_code = prayer_book_code
    @translation = translation
    @reading_type = reading_type
  end

  # Retorna as leituras para o dia (cached)
  def find_readings
    cache_key = build_readings_cache_key

    Rails.cache.fetch(cache_key, expires_in: 1.day) do
      record_cache_miss
      find_readings_uncached
    end
  end

  private

  # Build cache key for readings
  def build_readings_cache_key
    pb = PrayerBook.find_by_code(prayer_book_code)
    pb_version = pb&.updated_at&.to_i || 0

    "v4/readings/#{date}/#{prayer_book_code}/#{translation}/#{reading_type || 'default'}/pb_#{pb_version}"
  end

  # Find readings without cache (internal use)
  def find_readings_uncached
    reading = date.sunday? ? find_sunday_readings : find_weekday_readings
    format_response(reading)
  end

  # Record cache miss for Datadog metrics
  def record_cache_miss
    return unless defined?(Datadog) && Datadog.respond_to?(:statsd)

    Datadog.statsd.increment(
      "cache.miss",
      tags: [
        "cache_category:readings",
        "prayer_book:#{prayer_book_code}",
        "is_sunday:#{date.sunday?}"
      ]
    )
  rescue StandardError
    # Don't let metrics failures affect the app
  end

  def query
    @query ||= Reading::Query.new(prayer_book_id: prayer_book_id, cycle: cycle, date: date, reading_type: reading_type)
  end

  def reference_builder
    @reference_builder ||= Reading::ReferenceBuilder.new(date, calendar: calendar)
  end

  # Busca leituras para dias de semana
  def find_weekday_readings
    celebration = calendar.celebration_for_date(date)

    # Festas principais e dias santos maiores têm precedência
    if principal_celebration?(celebration)
      reading = find_by_resolved_celebration(celebration)
      return reading if reading
    end

    # Dias da Semana Santa e outras celebrações móveis importantes
    if movable_feast_with_readings?(celebration)
      reading = find_by_resolved_celebration(celebration)
      return reading if reading
    end

    # Leituras semanais, depois celebrações menores, depois data fixa
    find_weekly_reading ||
      find_by_celebration ||
      find_by_fixed_date
  end

  # Busca leituras para domingos respeitando hierarquia litúrgica
  def find_sunday_readings
    celebration = calendar.celebration_for_date(date)

    # Festas principais e dias santos maiores sempre têm precedência
    if principal_celebration?(celebration)
      reading = find_by_resolved_celebration(celebration)
      return reading if reading
    end

    # Domingos em quadras principais têm precedência sobre festivais menores
    if sunday_in_major_season?
      reading = find_by_proper || find_by_sunday
      return reading if reading
    end

    # Para outros domingos, festivais podem ter precedência
    find_by_celebration ||
      find_by_proper ||
      find_by_sunday ||
      find_by_fixed_date
  end

  def principal_celebration?(celebration)
    return false unless celebration

    %w[principal_feast major_holy_day].include?(celebration[:type])
  end

  def movable_feast_with_readings?(celebration)
    return false unless celebration&.dig(:id)

    cel = Celebration.find_by(id: celebration[:id])
    return false unless cel&.calculation_rule.present?

    MOVABLE_RULES_WITH_READINGS.include?(cel.calculation_rule)
  end

  def sunday_in_major_season?
    return false unless date.sunday?

    MAJOR_SEASONS.include?(calendar.season_for_date(date))
  end

  # Busca leituras pela celebração resolvida
  def find_by_resolved_celebration(celebration_info)
    return nil unless celebration_info

    celebration = Celebration.find_by(id: celebration_info[:id])
    return nil unless celebration

    # Tentar por celebration_id
    reading = query.find_by_celebration_id(celebration.id)
    return reading if reading

    # Tentar pelo nome parameterizado
    celebration_ref = celebration.name.parameterize(separator: "_")
    reading = query.find_by_reference(celebration_ref)
    return reading if reading

    # Tentar por calculation_rule
    if celebration.calculation_rule.present?
      reading = query.find_by_reference(celebration.calculation_rule)
      return reading if reading
    end

    # Tentar por referências especiais da celebração
    special_refs = reference_builder.celebration_references(celebration)
    query.find_by_references(special_refs)
  end

  # Determina o ciclo litúrgico (A, B, C)
  def determine_cycle
    calendar.liturgical_year_cycle(date)
  end

  # 1. Buscar por celebração fixa
  def find_by_celebration
    celebration = Celebration.fixed
                            .for_prayer_book_id(prayer_book_id)
                            .for_date(date.month, date.day)
                            .first
    return nil unless celebration

    reading = query.find_by_celebration_id(celebration.id)
    return reading if reading

    celebration_ref = celebration.name.parameterize(separator: "_")
    query.find_by_reference(celebration_ref)
  end

  # 2. Buscar por Proper (domingos do Tempo Comum)
  def find_by_proper
    return nil unless date.sunday?

    proper_num = calendar.proper_number(date)
    return nil unless proper_num

    query.find_by_reference("proper_#{proper_num}")
  end

  # 3. Buscar pelo nome do domingo
  def find_by_sunday
    return nil unless date.sunday?

    sunday_ref = SundayReferenceMapper.map(date, calendar)
    query.find_by_reference(sunday_ref)
  end

  # 4. Buscar por data fixa específica
  def find_by_fixed_date
    refs = reference_builder.fixed_date_references
    query.find_by_references(refs)
  end

  # 5. Buscar leituras semanais para dias de semana
  def find_weekly_reading
    return nil if date.sunday?

    refs = reference_builder.weekly_references
    query.find_weekly_by_references(refs)
  end

  # Formata a resposta
  def format_response(reading)
    return nil unless reading

    {
      first_reading: enrich_reading(reading.first_reading),
      psalm: enrich_reading(reading.psalm),
      second_reading: enrich_reading(reading.second_reading),
      gospel: enrich_reading(reading.gospel),
      notes: reading.notes
    }.compact
  end

  # Enriquece uma referência de leitura com componentes parseados e texto bíblico
  def enrich_reading(reference)
    return nil if reference.blank?

    # Normalize reference for single-chapter books (e.g., "Judas 17-25" -> "Judas 1.17-25")
    bible_service = BibleTextService.new(translation: @translation)
    normalized_reference = bible_service.send(:normalize_reference, reference)

    parsed = BibleText.parse_reference(normalized_reference)
    return { reference: reference, translation: @translation } unless parsed

    result = {
      reference: reference,
      translation: @translation,
      book_name: parsed[:book],
      chapter: parsed[:chapter],
      verse_start: parsed[:verse_start],
      verse_end: parsed[:verse_end]
    }

    # Buscar o conteúdo do texto bíblico (já normaliza internamente)
    content = fetch_bible_content(reference)
    result[:content] = content if content

    result
  end

  # Busca o conteúdo do texto bíblico
  def fetch_bible_content(reference)
    bible_service = BibleTextService.new(translation: translation)
    result = bible_service.fetch_passage_structured(reference)

    # Log if content fetch fails
    if result.nil?
      Rails.logger.warn "[ReadingService] Failed to fetch Bible content for: #{reference} (#{translation})"
    end

    result
  end
end
