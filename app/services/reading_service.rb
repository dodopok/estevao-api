# Serviço para buscar leituras do lecionário para uma data específica
class ReadingService
  attr_reader :date, :calendar, :cycle, :prayer_book_code

  # Factory method que retorna o serviço apropriado baseado no prayer_book_code
  def self.for(date, prayer_book_code: "loc_2015")
    case prayer_book_code
    when "loc_2015"
      IeabReadingService.new(date)
    else
      new(date, prayer_book_code: prayer_book_code)
    end
  end

  def initialize(date, prayer_book_code: "loc_2015")
    @date = date
    @calendar = LiturgicalCalendar.new(date.year)
    @cycle = determine_cycle
    @prayer_book_code = prayer_book_code
  end

  def prayer_book
    @prayer_book ||= PrayerBook.find_by_code(@prayer_book_code)
  end

  def prayer_book_id
    prayer_book&.id
  end

  # Retorna as leituras para o dia
  def find_readings
    reading = if date.sunday?
                # Domingos: verificar hierarquia litúrgica
                find_sunday_readings
    else
                # Dias de semana: verificar festas principais primeiro
                find_weekday_readings
    end

    format_response(reading)
  end

  private

  # Busca leituras para dias de semana
  def find_weekday_readings
    celebration = calendar.celebration_for_date(date)

    # Festas principais e dias santos maiores têm precedência sobre leituras semanais
    if celebration && (celebration[:type] == "principal_feast" || celebration[:type] == "major_holy_day")
      reading = find_by_resolved_celebration(celebration)
      return reading if reading
    end

    # Dias da Semana Santa e outras celebrações móveis importantes
    # (mesmo que sejam lesser_feast, têm leituras próprias)
    if celebration && is_moveable_feast_with_readings?(celebration)
      reading = find_by_resolved_celebration(celebration)
      return reading if reading
    end

    # Leituras semanais, depois celebrações menores, depois data fixa
    find_weekly_reading ||
    find_by_celebration ||
    find_by_fixed_date
  end

  # Verifica se a celebração é uma festa móvel que tem leituras próprias
  def is_moveable_feast_with_readings?(celebration)
    return false unless celebration
    return false unless celebration[:id]

    cel = Celebration.find_by(id: celebration[:id])
    return false unless cel&.calculation_rule.present?

    # Dias da Semana Santa e outras festas móveis com leituras próprias
    moveable_rules_with_readings = %w[
      easter_minus_6_days
      easter_minus_5_days
      easter_minus_4_days
      easter_minus_3_days
      easter_minus_2_days
      easter_minus_1_days
    ]

    moveable_rules_with_readings.include?(cel.calculation_rule)
  end

  # Busca leituras para domingos respeitando hierarquia litúrgica
  def find_sunday_readings
    celebration = calendar.celebration_for_date(date)

    # Festas principais e dias santos maiores sempre têm precedência
    if celebration && (celebration[:type] == "principal_feast" || celebration[:type] == "major_holy_day")
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

  # Busca leituras pela celebração resolvida (considera transferências e festas móveis)
  def find_by_resolved_celebration(celebration_info)
    return nil unless celebration_info

    celebration = Celebration.find_by(id: celebration_info[:id])
    return nil unless celebration

    # Tentar por celebration_id
    reading = LectionaryReading.where(celebration_id: celebration.id, cycle: [ "all", cycle ])
                               .for_prayer_book_id(prayer_book_id)
                               .service_type_eucharist
                               .first
    return reading if reading

    # Tentar pelo nome parameterizado
    celebration_ref = celebration.name.parameterize(separator: "_")
    reading = LectionaryReading.for_date_reference(celebration_ref)
                               .where(cycle: [ cycle, "all" ])
                               .for_prayer_book_id(prayer_book_id)
                               .service_type_eucharist
                               .first
    return reading if reading

    # Tentar por calculation_rule (ex: "all_saints", "easter_plus_49_days")
    if celebration.calculation_rule.present?
      reading = LectionaryReading.for_date_reference(celebration.calculation_rule)
                                 .where(cycle: [ cycle, "all" ])
                                 .for_prayer_book_id(prayer_book_id)
                                 .service_type_eucharist
                                 .first
      return reading if reading
    end

    # Tentar por date_references conhecidos para festas principais fixas
    special_refs = build_celebration_date_references(celebration)
    special_refs.each do |ref|
      reading = LectionaryReading.for_date_reference(ref)
                                 .where(cycle: [ cycle, "all" ])
                                 .for_prayer_book_id(prayer_book_id)
                                 .service_type_eucharist
                                 .first
      return reading if reading
    end

    nil
  end

  # Constrói referências possíveis para uma celebração
  def build_celebration_date_references(celebration)
    refs = []

    # Festas móveis: mapear calculation_rule para date_reference
    if celebration.calculation_rule.present?
      case celebration.calculation_rule
      when "easter_minus_6_days"
        refs << "holy_monday"
      when "easter_minus_5_days"
        refs << "holy_tuesday"
      when "easter_minus_4_days"
        refs << "holy_wednesday"
      when "easter_minus_3_days"
        refs << "maundy_thursday"
        refs << "holy_thursday"
      when "easter_minus_2_days"
        refs << "good_friday"
      when "easter_minus_1_days"
        refs << "holy_saturday"
        refs << "holy_saturday_vigil"
      when "easter"
        refs << "easter_sunday"
        refs << "easter_day"
      when "easter_plus_39_days"
        refs << "ascension"
        refs << "ascension_day"
      when "easter_plus_49_days"
        refs << "pentecost"
        refs << "whitsunday"
      when "easter_plus_56_days"
        refs << "trinity_sunday"
      end
    end

    # Festas fixas: tentar por data
    if celebration.fixed_month && celebration.fixed_day
      # Formato "month_day"
      month_name = Date::MONTHNAMES[celebration.fixed_month]&.downcase
      refs << "#{month_name}_#{celebration.fixed_day}" if month_name

      # Referências especiais conhecidas
      case [ celebration.fixed_month, celebration.fixed_day ]
      when [ 12, 25 ]
        refs << "christmas_day"
        refs << "christmas"
      when [ 12, 24 ]
        refs << "christmas_eve"
      when [ 1, 1 ]
        refs << "holy_name"
      when [ 1, 6 ]
        refs << "epiphany"
      when [ 3, 25 ]
        refs << "annunciation"
      when [ 11, 1 ]
        refs << "all_saints"
      when [ 8, 6 ]
        refs << "transfiguration"
      when [ 2, 2 ]
        refs << "presentation_of_the_lord"
        refs << "presentation"
      end
    end

    refs
  end

  # Verifica se o domingo está em uma quadra principal
  # onde o domingo tem precedência sobre festivais menores
  def sunday_in_major_season?
    return false unless date.sunday?

    season = calendar.season_for_date(date)
    %w[Advento Quaresma Páscoa].include?(season)
  end

  # Determina o ciclo litúrgico (A, B, C para leituras semanais e domingos)
  def determine_cycle
    # Para leituras semanais (weekly), usar o mesmo ciclo A/B/C dos domingos
    # Isso é baseado no ano litúrgico, não no ano civil
    calendar.liturgical_year_cycle(date)
  end

  # 1. Buscar por celebração fixa (festa de santo, etc)
  def find_by_celebration
    celebration = Celebration.fixed.for_date(date.month, date.day).first
    return nil unless celebration

    # Tentar por celebration_id
    reading = LectionaryReading.where(celebration_id: celebration.id, cycle: [ "all", cycle ])
                               .for_prayer_book_id(prayer_book_id)
                               .service_type_eucharist
                               .first

    # Se não encontrou, tentar pelo nome parameterizado
    if reading.nil?
      celebration_ref = celebration.name.parameterize(separator: "_")
      reading = LectionaryReading.for_date_reference(celebration_ref)
                                 .where(cycle: [ cycle, "all" ])
                                 .for_prayer_book_id(prayer_book_id)
                                 .service_type_eucharist
                                 .first
    end

    reading
  end

  # 2. Buscar por Proper (domingos do Tempo Comum)
  def find_by_proper
    return nil unless date.sunday?

    proper_num = calendar.proper_number(date)
    return nil unless proper_num

    LectionaryReading.for_date_reference("proper_#{proper_num}")
                     .where(cycle: [ cycle, "all" ])
                     .for_prayer_book_id(prayer_book_id)
                     .service_type_eucharist
                     .first
  end

  # 3. Buscar pelo nome do domingo
  def find_by_sunday
    return nil unless date.sunday?

    sunday_ref = SundayReferenceMapper.map(date, calendar)
    return nil unless sunday_ref

    LectionaryReading.for_date_reference(sunday_ref)
                     .where(cycle: [ cycle, "all" ])
                     .for_prayer_book_id(prayer_book_id)
                     .service_type_eucharist
                     .first
  end

  # 4. Buscar por data fixa específica (ex: "december_24", "christmas_day")
  def find_by_fixed_date
    possible_refs = build_fixed_date_references

    possible_refs.each do |ref|
      reading = LectionaryReading.for_date_reference(ref)
                                 .where(cycle: [ cycle, "all" ])
                                 .for_prayer_book_id(prayer_book_id)
                                 .service_type_eucharist
                                 .first
      return reading if reading
    end

    nil
  end

  # 5. Buscar leituras semanais (weekly) para dias de semana
  def find_weekly_reading
    return nil if date.sunday? # Leituras semanais são apenas para dias de semana

    # Construir date_reference baseado na semana litúrgica
    week_refs = build_weekly_date_references

    week_refs.each do |ref|
      reading = LectionaryReading.for_date_reference(ref)
                                 .where(cycle: [ cycle, "A", "B", "C" ]) # Busca no ciclo específico
                                 .for_prayer_book_id(prayer_book_id)
                                 .weekly
                                 .first
      return reading if reading
    end

    nil
  end

  # Constrói lista de possíveis referências para leituras semanais
  def build_weekly_date_references
    refs = []
    weekday = weekday_name(date)

    # 1. Tentar por data fixa (ex: "december_22" para 22 de dezembro)
    month_name = Date::MONTHNAMES[date.month].downcase
    refs << "#{month_name}_#{date.day}"

    # 2. Tentar por Proper (Tempo Comum) - baseado no domingo mais recente
    most_recent_sunday = find_most_recent_sunday_date
    proper_num = calendar.proper_number(most_recent_sunday)
    if proper_num
      refs << "proper_#{proper_num}_#{weekday}"
    end

    # 3. Tentar por nome do domingo mais recente
    sunday_ref = find_most_recent_sunday_reference
    if sunday_ref
      refs << "#{sunday_ref}_#{weekday}"
    end

    # 4. Tentar referências especiais para semanas importantes
    special_week_refs = build_special_week_references(weekday)
    refs.concat(special_week_refs)

    refs
  end

  # Encontra a data do domingo mais recente
  def find_most_recent_sunday_date
    days_since_sunday = date.wday == 0 ? 0 : date.wday
    date - days_since_sunday
  end

  # Encontra a referência do domingo mais recente
  def find_most_recent_sunday_reference
    most_recent_sunday = find_most_recent_sunday_date

    # Obter referência do domingo usando SundayReferenceMapper
    SundayReferenceMapper.map(most_recent_sunday, calendar)
  end

  # Constrói referências para semanas especiais
  def build_special_week_references(weekday)
    refs = []
    season = calendar.season_for_date(date)

    case season
    when "Advento"
      # Semanas do Advento
      week = calendar.week_number(date)
      refs << "#{week.ordinalize}_sunday_of_advent_#{weekday}" if week
    when "Natal"
      refs << "week_of_christmas_#{weekday}"
      refs << "first_sunday_after_christmas_#{weekday}"
      # Para dias próximos ao Batismo do Senhor (início de Janeiro)
      if date.month == 1
        refs << "baptism_of_christ_#{weekday}"
        refs << "week_of_epiphany_#{weekday}"
      end
    when "Epifania"
      week = calendar.week_number(date)
      # O CSV usa "Tempo Comum X" para semanas da Epifania
      # O week number na Epifania começa em 1 (Batismo), então Tempo Comum 2 = week 2
      # Adicionar +1 porque o Batismo é week 1 mas não tem Tempo Comum 1
      refs << "ordinary_time_#{week + 1}_#{weekday}" if week && week >= 1
      refs << "ordinary_time_#{week}_#{weekday}" if week && week >= 1
      refs << "week_of_epiphany_#{weekday}"
      refs << "baptism_of_christ_#{weekday}"
      refs << "last_sunday_after_epiphany_#{weekday}"
    when "Quaresma"
      week = calendar.week_number(date)
      refs << "#{week.ordinalize}_sunday_of_lent_#{weekday}" if week
      refs << "holy_week_#{weekday}"
    when "Páscoa"
      week = calendar.week_number(date)
      refs << "#{week.ordinalize}_sunday_of_easter_#{weekday}" if week
      refs << "week_of_pentecost_#{weekday}"
      refs << "trinity_sunday_#{weekday}"
    when "Tempo Comum"
      # Verificar se estamos na semana entre Pentecostes e Trindade
      easter_calc = EasterCalculator.new(date.year)
      pentecost = easter_calc.pentecost
      trinity = pentecost + 7  # Trindade = domingo após Pentecostes

      if date > pentecost && date < trinity
        refs << "week_of_pentecost_#{weekday}"
        refs << "trinity_sunday_#{weekday}"
      end
    end

    refs
  end

  # Retorna o nome do dia da semana em inglês (lowercase)
  def weekday_name(date)
    %w[sunday monday tuesday wednesday thursday friday saturday][date.wday]
  end

  # Constrói lista de possíveis referências para datas fixas
  def build_fixed_date_references
    refs = []

    # Formato padrão: "month_day"
    month_name = Date::MONTHNAMES[date.month].downcase
    refs << "#{month_name}_#{date.day}"

    # Referências especiais para datas importantes
    special_dates = {
      [ 12, 25 ] => "christmas_day",
      [ 12, 24 ] => "christmas_eve",
      [ 1, 1 ] => "holy_name",
      [ 1, 6 ] => "epiphany"
    }

    special_ref = special_dates[[ date.month, date.day ]]
    refs << special_ref if special_ref

    refs
  end

  # Formata a resposta para retornar apenas os campos necessários
  # Enriquece cada leitura com componentes parseados (book_name, chapter, verse)
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

    # Se não conseguiu parsear, retorna apenas a referência
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
