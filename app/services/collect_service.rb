# Serviço para buscar coletas (orações) litúrgicas para uma data específica
class CollectService
  attr_reader :date, :calendar

  def initialize(date)
    @date = date
    @calendar = LiturgicalCalendar.new(date.year)
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

  # 1. Buscar por celebração fixa (santo, festa, etc)
  def find_by_celebration
    celebration = Celebration.fixed.for_date(date.month, date.day).first
    return [] unless celebration

    Collect.for_celebration(celebration.id).in_language("pt-BR")
  end

  # 2. Buscar por domingo (Proper ou nome do domingo)
  def find_by_sunday
    return [] unless date.sunday?

    # Tentar por Proper primeiro (domingos do Tempo Comum)
    proper_num = calendar.proper_number(date)
    if proper_num
      collects = Collect.for_sunday("proper_#{proper_num}").in_language("pt-BR")
      return collects if collects.any?
    end

    # Se não encontrou por Proper, tentar pelo nome do domingo
    sunday_ref = SundayReferenceMapper.map(date, calendar)
    return [] unless sunday_ref

    Collect.for_sunday(sunday_ref).in_language("pt-BR")
  end

  # 3. Buscar pela quadra litúrgica
  def find_by_season
    season_name = calendar.season_for_date(date)
    season = LiturgicalSeason.find_by(name: season_name)
    return [] unless season

    Collect.for_season(season.id).in_language("pt-BR")
  end

  # Formata a resposta: retorna hash se única, array se múltiplas
  def format_response(collects)
    return nil if collects.nil? || collects.empty?

    if collects.count == 1
      { text: collects.first.text, preface: collects.first.preface }
    else
      collects.map { |c| { text: c.text, preface: c.preface } }
    end
  end
end
