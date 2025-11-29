# Serviço para buscar leituras do lecionário para uma data específica
class ReadingService
  attr_reader :date, :calendar, :cycle, :prayer_book_code

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
                # Domingos: leituras eucarísticas
                find_by_celebration ||
                find_by_proper ||
                find_by_sunday ||
                find_by_fixed_date
    else
                # Dias de semana: leituras semanais (weekly) primeiro, depois outras
                find_weekly_reading ||
                find_by_celebration ||
                find_by_fixed_date
    end

    format_response(reading)
  end

  private

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
      refs << "week_of_epiphany_#{weekday}"
      refs << "baptism_of_christ_#{weekday}"
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
      # Já tratado pelo proper_number acima
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
