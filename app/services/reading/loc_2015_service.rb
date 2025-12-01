# Serviço especializado para buscar leituras do LOC 2015 (IEAB)
#
# O lecionário da IEAB segue uma lógica diferente para leituras diárias:
# - Qui/Sex/Sab: Leituras de PREPARAÇÃO para o domingo SEGUINTE
# - Seg/Ter/Qua: Leituras de REFLEXÃO sobre o domingo ANTERIOR
#
# Esta classe sobrescreve apenas os métodos necessários do ReadingService
# para implementar essa lógica específica.
#
class Reading::Loc2015Service < ReadingService
  # Dias de preparação (antes do domingo)
  PREPARATION_DAYS = [ 4, 5, 6 ].freeze # Thursday, Friday, Saturday

  # Dias de reflexão (depois do domingo)
  REFLECTION_DAYS = [ 1, 2, 3 ].freeze # Monday, Tuesday, Wednesday

  def initialize(date, calendar: nil, translation: "nvi")
    super(date, prayer_book_code: "loc_2015", calendar: calendar, translation: translation)
  end

  private

  # Sobrescreve para usar a lógica específica do IEAB
  def build_weekly_date_references
    refs = []
    weekday = weekday_name(date)

    # 1. Tentar por data fixa (ex: "december_22" para 22 de dezembro)
    month_name = Date::MONTHNAMES[date.month].downcase
    refs << "#{month_name}_#{date.day}"

    # 2. Buscar domingo de referência baseado na lógica IEAB
    reference_sunday = find_ieab_reference_sunday

    # 3. Tentar por Proper (Tempo Comum)
    proper_num = calendar.proper_number(reference_sunday)
    if proper_num
      refs << "proper_#{proper_num}_#{weekday}"
    end

    # 4. Tentar por nome do domingo de referência
    sunday_ref = map_sunday_reference(reference_sunday)
    if sunday_ref
      refs << "#{sunday_ref}_#{weekday}"
    end

    # 5. Tentar referências especiais para semanas importantes
    special_week_refs = build_special_week_references(weekday)
    refs.concat(special_week_refs)

    refs
  end

  # Encontra o domingo de referência baseado na lógica IEAB
  # - Qui/Sex/Sab: usa o PRÓXIMO domingo (preparação)
  # - Seg/Ter/Qua: usa o domingo ANTERIOR (reflexão)
  def find_ieab_reference_sunday
    if preparation_day?
      find_next_sunday_date
    else
      find_most_recent_sunday_date
    end
  end

  # Verifica se é um dia de preparação (Qui/Sex/Sab)
  def preparation_day?
    PREPARATION_DAYS.include?(date.wday)
  end

  # Verifica se é um dia de reflexão (Seg/Ter/Qua)
  def reflection_day?
    REFLECTION_DAYS.include?(date.wday)
  end

  # Encontra a data do próximo domingo
  def find_next_sunday_date
    days_until_sunday = (7 - date.wday) % 7
    days_until_sunday = 7 if days_until_sunday == 0 # Se for domingo, pegar o próximo
    date + days_until_sunday
  end

  # Mapeia a data do domingo para sua referência
  def map_sunday_reference(sunday_date)
    # Usar o SundayReferenceMapper com o calendário do ano do domingo
    sunday_calendar = LiturgicalCalendar.new(sunday_date.year)
    SundayReferenceMapper.map(sunday_date, sunday_calendar)
  end

  # Sobrescreve para usar calendário correto baseado no domingo de referência
  def build_special_week_references(weekday)
    refs = []
    reference_sunday = find_ieab_reference_sunday
    reference_calendar = LiturgicalCalendar.new(reference_sunday.year)
    season = reference_calendar.season_for_date(reference_sunday)

    case season
    when "Advento"
      week = reference_calendar.week_number(reference_sunday)
      refs << "#{week.ordinalize}_sunday_of_advent_#{weekday}" if week
    when "Natal"
      refs << "week_of_christmas_#{weekday}"
      refs << "first_sunday_after_christmas_#{weekday}"
      if reference_sunday.month == 1
        refs << "baptism_of_christ_#{weekday}"
        refs << "week_of_epiphany_#{weekday}"
      end
    when "Epifania"
      week = reference_calendar.week_number(reference_sunday)
      refs << "ordinary_time_#{week + 1}_#{weekday}" if week && week >= 1
      refs << "ordinary_time_#{week}_#{weekday}" if week && week >= 1
      refs << "week_of_epiphany_#{weekday}"
      refs << "baptism_of_christ_#{weekday}"
      refs << "last_sunday_after_epiphany_#{weekday}"
    when "Quaresma"
      week = reference_calendar.week_number(reference_sunday)
      refs << "#{week.ordinalize}_sunday_of_lent_#{weekday}" if week
      refs << "holy_week_#{weekday}"
    when "Páscoa"
      week = reference_calendar.week_number(reference_sunday)
      refs << "#{week.ordinalize}_sunday_of_easter_#{weekday}" if week
      refs << "week_of_pentecost_#{weekday}"
      refs << "trinity_sunday_#{weekday}"
    when "Tempo Comum"
      # Verificar semanas especiais após Pentecostes
      easter_calc = Liturgical::EasterCalculator.new(reference_sunday.year)
      pentecost = easter_calc.pentecost
      trinity = pentecost + 7

      if reference_sunday > pentecost && reference_sunday <= trinity
        refs << "week_of_pentecost_#{weekday}"
        refs << "trinity_sunday_#{weekday}"
      end

      # Cristo Rei (último domingo do Tempo Comum)
      if christ_the_king_sunday?(reference_sunday)
        refs << "christ_the_king_#{weekday}"
      end
    end

    refs
  end

  # Verifica se o domingo é Cristo Rei (último domingo antes do Advento)
  def christ_the_king_sunday?(sunday_date)
    # Cristo Rei é o domingo entre 20-26 de novembro
    sunday_date.month == 11 && sunday_date.day >= 20 && sunday_date.day <= 26
  end
end
