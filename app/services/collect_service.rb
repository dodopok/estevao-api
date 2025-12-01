# frozen_string_literal: true

# Serviço para buscar coletas (orações) litúrgicas para uma data específica
class CollectService
  include PrayerBookAware

  DEFAULT_LANGUAGE = "pt-BR"

  attr_reader :date, :calendar

  def initialize(date, prayer_book_code: "loc_2015", calendar: nil, language: DEFAULT_LANGUAGE)
    @date = date
    @calendar = calendar || LiturgicalCalendar.new(date.year)
    @prayer_book_code = prayer_book_code
    @language = language
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

  attr_reader :language

  # Memoized Liturgical::CelebrationResolver for the date's year
  def resolver
    @resolver ||= Liturgical::CelebrationResolver.new(date.year, prayer_book_code: prayer_book_code)
  end

  # Memoized Liturgical::CelebrationResolver for a specific year
  def resolver_for_year(year)
    @resolvers ||= {}
    @resolvers[year] ||= Liturgical::CelebrationResolver.new(year, prayer_book_code: prayer_book_code)
  end

  # Common query for collects by celebration
  def collects_for_celebration(celebration)
    return [] unless celebration

    Collect.for_celebration(celebration.id)
           .for_prayer_book_id(prayer_book_id)
           .in_language(language)
  end

  # Common query for collects by sunday reference
  def collects_for_sunday(sunday_ref)
    return [] unless sunday_ref

    Collect.for_sunday(sunday_ref)
           .for_prayer_book_id(prayer_book_id)
           .in_language(language)
  end

  # 1. Buscar por celebração (usa Liturgical::CelebrationResolver para prioridades)
  def find_by_celebration
    celebration = resolver.resolve_for_date(date)
    collects_for_celebration(celebration)
  end

  # 2. Buscar por domingo (Proper ou nome do domingo)
  def find_by_sunday
    return [] unless date.sunday?

    # Tentar por Proper primeiro (domingos do Tempo Comum)
    collects = find_by_proper(calendar.proper_number(date))
    return collects if collects.any?

    # Se não encontrou por Proper, tentar pelo nome do domingo
    collects_for_sunday(SundayReferenceMapper.map(date, calendar))
  end

  # 3. Buscar pela coleta do último domingo
  def find_by_season
    last_sunday = find_last_sunday
    return [] unless last_sunday

    # Usar o calendário do ano do domingo, não da data atual
    # Isso é importante para virada de ano (ex: 02/01/2025 -> último domingo 29/12/2024)
    sunday_calendar = calendar_for_date(last_sunday)

    # Primeiro, verificar se o domingo anterior tem uma celebração com coleta
    # (Páscoa, Pentecostes, Trindade usam celebration_id em vez de sunday_reference)
    collects = find_collect_for_sunday_celebration(last_sunday)
    return collects if collects.any?

    # Tentar buscar a coleta desse domingo por Proper
    collects = find_by_proper(sunday_calendar.proper_number(last_sunday))
    return collects if collects.any?

    # Se não encontrou por Proper, tentar pelo nome do domingo
    collects_for_sunday(SundayReferenceMapper.map(last_sunday, sunday_calendar))
  end

  # Buscar coleta por número de Proper
  def find_by_proper(proper_num)
    return [] unless proper_num

    collects_for_sunday("proper_#{proper_num}")
  end

  # Busca coleta por celebração do domingo (Páscoa, Pentecostes, Trindade, etc.)
  def find_collect_for_sunday_celebration(sunday_date)
    year_resolver = resolver_for_year(sunday_date.year)
    celebration = year_resolver.resolve_for_date(sunday_date)
    collects_for_celebration(celebration)
  end

  # Retorna o calendário apropriado para uma data
  def calendar_for_date(target_date)
    target_date.year == date.year ? calendar : LiturgicalCalendar.new(target_date.year)
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

    collects.map { |c| { text: c.text, preface: c.preface } }
  end
end
