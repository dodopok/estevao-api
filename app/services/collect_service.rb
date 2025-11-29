# Serviço para buscar coletas (orações) litúrgicas para uma data específica
class CollectService
  attr_reader :date, :calendar, :prayer_book_code

  def initialize(date, prayer_book_code: "loc_2015")
    @date = date
    @calendar = LiturgicalCalendar.new(date.year)
    @prayer_book_code = prayer_book_code
  end

  def prayer_book
    @prayer_book ||= PrayerBook.find_by_code(@prayer_book_code)
  end

  def prayer_book_id
    prayer_book&.id
  end

  # Retorna a(s) coleta(s) para o dia
  # Pode retornar um hash (uma coleta) ou array (múltiplas opções)
  def find_collects
    collects = find_by_celebration
    collects = find_by_sunday if collects.blank?
    collects = find_by_season if collects.blank?

    format_response(collects)
  end

  private

  # 1. Buscar por celebração (usa CelebrationResolver para prioridades)
  def find_by_celebration
    resolver = CelebrationResolver.new(date.year, prayer_book_code: prayer_book_code)
    celebration = resolver.resolve_for_date(date)
    return [] unless celebration

    Collect.for_celebration(celebration.id)
           .for_prayer_book_id(prayer_book_id)
           .in_language("pt-BR")
  end

  # 2. Buscar por domingo (Proper ou nome do domingo)
  def find_by_sunday
    return [] unless date.sunday?

    # Tentar por Proper primeiro (domingos do Tempo Comum)
    proper_num = calendar.proper_number(date)
    if proper_num
      collects = Collect.for_sunday("proper_#{proper_num}")
                        .for_prayer_book_id(prayer_book_id)
                        .in_language("pt-BR")
      return collects if collects.any?
    end

    # Se não encontrou por Proper, tentar pelo nome do domingo
    sunday_ref = SundayReferenceMapper.map(date, calendar)
    return [] unless sunday_ref

    Collect.for_sunday(sunday_ref)
           .for_prayer_book_id(prayer_book_id)
           .in_language("pt-BR")
  end

  # 3. Buscar pela coleta do último domingo
  def find_by_season
    # Encontrar o domingo anterior
    last_sunday = find_last_sunday
    return [] unless last_sunday

    # Usar o calendário do ano do domingo, não da data atual
    # Isso é importante para virada de ano (ex: 02/01/2025 -> último domingo 29/12/2024)
    sunday_calendar = last_sunday.year == date.year ? calendar : LiturgicalCalendar.new(last_sunday.year)

    # Primeiro, verificar se o domingo anterior tem uma celebração com coleta
    # (Páscoa, Pentecostes, Trindade usam celebration_id em vez de sunday_reference)
    collects = find_collect_for_sunday_celebration(last_sunday, sunday_calendar)
    return collects if collects.any?

    # Tentar buscar a coleta desse domingo por Proper
    proper_num = sunday_calendar.proper_number(last_sunday)
    if proper_num
      collects = Collect.for_sunday("proper_#{proper_num}")
                        .for_prayer_book_id(prayer_book_id)
                        .in_language("pt-BR")
      return collects if collects.any?
    end

    # Se não encontrou por Proper, tentar pelo nome do domingo
    sunday_ref = SundayReferenceMapper.map(last_sunday, sunday_calendar)
    return [] unless sunday_ref

    Collect.for_sunday(sunday_ref)
           .for_prayer_book_id(prayer_book_id)
           .in_language("pt-BR")
  end

  # Busca coleta por celebração do domingo (Páscoa, Pentecostes, Trindade, etc.)
  def find_collect_for_sunday_celebration(sunday_date, sunday_calendar)
    resolver = CelebrationResolver.new(sunday_date.year, prayer_book_code: prayer_book_code)
    celebration = resolver.resolve_for_date(sunday_date)
    return [] unless celebration

    Collect.for_celebration(celebration.id)
           .for_prayer_book_id(prayer_book_id)
           .in_language("pt-BR")
  end

  # Encontra o domingo anterior à data atual
  def find_last_sunday
    days_since_sunday = date.wday # 0 = domingo, 1 = segunda, etc
    return nil if days_since_sunday == 0 # Se já é domingo, não busca

    date - days_since_sunday.days
  end

  # Formata a resposta: retorna hash se única, array se múltiplas
  def format_response(collects)
    return nil if collects.nil? || collects.empty?

    if collects.count == 1
      [ { text: collects.first.text, preface: collects.first.preface } ]
    else
      collects.map { |c| { text: c.text, preface: c.preface } }
    end
  end
end
