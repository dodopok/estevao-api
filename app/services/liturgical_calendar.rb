# Serviço principal para gerar o calendário litúrgico de um ano
class LiturgicalCalendar
  attr_reader :year, :easter_calc

  def initialize(year)
    @year = year
    @easter_calc = EasterCalculator.new(year)
  end

  # Retorna as informações litúrgicas completas de um dia específico
  def day_info(date)
    {
      date: date.to_s,
      day_of_week: day_name_pt(date),
      liturgical_season: season_for_date(date),
      color: color_for_date(date),
      celebration: celebration_for_date(date),
      is_sunday: date.sunday?,
      is_holy_day: holy_day?(date),
      week_of_season: week_number(date),
      sunday_name: sunday_name(date)
    }
  end

  # Retorna a quadra litúrgica para uma data
  def season_for_date(date)
    movable = easter_calc.all_movable_dates

    case date
    when movable[:first_sunday_of_advent]..Date.new(year, 12, 24)
      "Advento"
    when Date.new(year, 12, 25)..epiphany_season_end
      "Natal"
    when epiphany_season_start..movable[:ash_wednesday] - 1.day
      "Epifania"
    when movable[:ash_wednesday]..movable[:holy_saturday]
      "Quaresma"
    when movable[:easter]..movable[:pentecost]
      "Páscoa"
    else
      "Tempo Comum"
    end
  end

  # Determina a cor litúrgica para uma data
  def color_for_date(date)
    celebration = celebration_for_date(date)

    # Se há uma celebração com cor específica, usa essa cor
    return celebration[:color] if celebration && celebration[:color]

    # Caso contrário, usa a cor da quadra
    season = season_for_date(date)
    movable = easter_calc.all_movable_dates

    case season
    when "Advento"
      date == movable[:first_sunday_of_advent] + 14.days ? "rosa" : "violeta"
    when "Natal", "Páscoa"
      "branco"
    when "Quaresma"
      if date >= movable[:palm_sunday] && date <= movable[:good_friday]
        date == movable[:good_friday] ? "vermelho" : "vermelho"
      elsif date == movable[:ash_wednesday] + 21.days # 4º Domingo na Quaresma
        "rosa"
      else
        "roxo"
      end
    when "Tempo Comum"
      "verde"
    when "Epifania"
      "verde"
    else
      "verde"
    end
  end

  # Retorna a celebração principal do dia
  def celebration_for_date(date)
    # Usa o CelebrationResolver para aplicar regras de transferência e hierarquia
    resolver = CelebrationResolver.new(year)
    celebration = resolver.resolve_for_date(date)

    return nil unless celebration

    {
      id: celebration.id,
      name: celebration.name,
      type: celebration.celebration_type,
      rank: celebration.rank,
      color: celebration.liturgical_color,
      description: celebration.description,
      transferred: transferred?(celebration, date)
    }
  end

  # Determina se o dia é um dia santo
  def holy_day?(date)
    celebration = celebration_for_date(date)
    celebration && (celebration[:type] == "principal_feast" || celebration[:type] == "major_holy_day")
  end

  # Nome do domingo ou dia especial
  def sunday_name(date)
    return nil unless date.sunday?

    season = season_for_date(date)
    movable = easter_calc.all_movable_dates

    case date
    when movable[:easter]
      "Domingo da Páscoa"
    when movable[:pentecost]
      "Pentecostes"
    when movable[:trinity_sunday]
      "Santíssima Trindade"
    when movable[:palm_sunday]
      "Domingo de Ramos"
    when movable[:christ_the_king]
      "Cristo Rei do Universo"
    when movable[:first_sunday_of_advent]
      "1º Domingo do Advento"
    when movable[:baptism_of_the_lord]
      "Batismo de nosso Senhor Jesus Cristo"
    else
      week = week_number(date)
      "#{week}º Domingo #{season == 'Tempo Comum' ? 'no' : 'do'} #{season}"
    end
  end

  # Número da semana na quadra
  def week_number(date)
    season = season_for_date(date)
    movable = easter_calc.all_movable_dates

    case season
    when "Advento"
      ((date - movable[:first_sunday_of_advent]).to_i / 7) + 1
    when "Quaresma"
      ((date - movable[:first_sunday_in_lent]).to_i / 7) + 1
    when "Páscoa"
      ((date - movable[:easter]).to_i / 7) + 1
    else
      nil
    end
  end

  # Retorna todas as festas e dias santos do mês
  def month_calendar(month)
    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month

    (start_date..end_date).map do |date|
      day_info(date)
    end
  end

  # Retorna o calendário completo do ano
  def year_calendar
    (1..12).map do |month|
      {
        month: month,
        month_name: I18n.t("date.month_names")[month],
        days: month_calendar(month)
      }
    end
  end

  private

  # Celebração móvel para uma data específica
  def movable_celebration_for_date(date)
    movable = easter_calc.all_movable_dates

    movable_celebrations = {
      movable[:easter] => Celebration.find_by(name: "Páscoa"),
      movable[:ash_wednesday] => Celebration.find_by(name: "Quarta-Feira de Cinzas"),
      movable[:good_friday] => Celebration.find_by(name: "Sexta-Feira da Paixão"),
      movable[:maundy_thursday] => Celebration.find_by(name: "Quinta-Feira Santa"),
      movable[:ascension] => Celebration.find_by(name: "Ascensão de nosso Senhor Jesus Cristo"),
      movable[:pentecost] => Celebration.find_by(name: "Pentecostes"),
      movable[:trinity_sunday] => Celebration.find_by(name: "Santíssima Trindade"),
      movable[:baptism_of_the_lord] => Celebration.find_by(name: "Batismo de nosso Senhor Jesus Cristo"),
      movable[:christ_the_king] => Celebration.find_by(name: "Cristo Rei do Universo")
    }

    movable_celebrations[date]
  end

  # Fim da quadra da Epifania
  def epiphany_season_end
    easter_calc.ash_wednesday - 1.day
  end

  # Início da quadra da Epifania
  def epiphany_season_start
    Date.new(year, 1, 7) # Dia depois da Epifania
  end

  # Nome do dia da semana em português
  def day_name_pt(date)
    names = %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado]
    names[date.wday]
  end

  # Verifica se uma celebração foi transferida para esta data
  def transferred?(celebration, date)
    return false if celebration.movable?

    original_date = Date.new(year, celebration.fixed_month, celebration.fixed_day)
    original_date != date
  end
end
