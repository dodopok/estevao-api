# frozen_string_literal: true

# Serviço para buscar leituras do lecionário para uma data específica
class ReadingService
  include PrayerBookAware

  # Movable feast calculation rules that have their own readings
  MOVABLE_RULES_WITH_READINGS = %w[
    easter_minus_6_days
    easter_minus_5_days
    easter_minus_4_days
    easter_minus_3_days
    easter_minus_2_days
    easter_minus_1_days
  ].freeze

  # Seasons where Sunday takes precedence over minor festivals
  MAJOR_SEASONS = %w[Advento Quaresma Páscoa].freeze

  attr_reader :date, :calendar, :cycle

  # Factory method que retorna o serviço apropriado baseado no prayer_book_code
  def self.for(date, prayer_book_code: "loc_2015", calendar: nil)
    case prayer_book_code
    when "loc_2015"
      Reading::Loc2015Service.new(date, calendar: calendar)
    else
      new(date, prayer_book_code: prayer_book_code, calendar: calendar)
    end
  end

  def initialize(date, prayer_book_code: "loc_2015", calendar: nil)
    @date = date
    @calendar = calendar || LiturgicalCalendar.new(date.year)
    @cycle = determine_cycle
    @prayer_book_code = prayer_book_code
  end

  # Retorna as leituras para o dia
  def find_readings
    reading = date.sunday? ? find_sunday_readings : find_weekday_readings
    format_response(reading)
  end

  private

  def query
    @query ||= Reading::Query.new(prayer_book_id: prayer_book_id, cycle: cycle)
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
    celebration = Celebration.fixed.for_date(date.month, date.day).first
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

  # Enriquece uma referência de leitura com componentes parseados
  def enrich_reading(reference)
    return nil if reference.blank?

    parsed = BibleText.parse_reference(reference)
    return { reference: reference } unless parsed

    {
      reference: reference,
      book_name: parsed[:book],
      chapter: parsed[:chapter],
      verse_start: parsed[:verse_start],
      verse_end: parsed[:verse_end]
    }
  end
end
