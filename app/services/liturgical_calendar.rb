# Serviço principal para gerar o calendário litúrgico de um ano
class LiturgicalCalendar
  attr_reader :year, :easter_calc, :prayer_book_code

  def initialize(year, prayer_book_code: "loc_2015")
    @year = year
    @prayer_book_code = prayer_book_code
    @easter_calc = EasterCalculator.new(year)
  end

  # Retorna as informações litúrgicas completas de um dia específico
  def day_info(date)
    {
      date: date.strftime("%d/%m/%Y"),
      sunday_name: sunday_name(date),
      day_of_week: day_name_br(date),
      liturgical_season: season_for_date(date),
      color: color_for_date(date),
      celebration: celebration_for_date(date),
      is_sunday: date.sunday?,
      is_holy_day: holy_day?(date),
      week_of_season: week_number(date),
      proper_week: proper_number(date),
      sunday_after_pentecost: sunday_after_pentecost(date),
      liturgical_year: liturgical_year_cycle(date),
      saint: saint_for_date(date)
    }
  end

  # Retorna a quadra litúrgica para uma data
  def season_for_date(date)
    movable = easter_calc.all_movable_dates
    baptism = movable[:baptism_of_the_lord]

    # Verificar primeiro se estamos no início de Janeiro (Natal do ano anterior)
    # Ex: 5 de Janeiro 2025 pertence ao Natal que começou em 25 Dez 2024
    # O Batismo do Senhor marca o fim do Natal e início da Epifania
    if date.month == 1 && date < baptism
      return "Natal"
    end

    # Advento: do 1º Domingo do Advento até 24 de dezembro
    if date >= movable[:first_sunday_of_advent] && date <= Date.new(year, 12, 24)
      return "Advento"
    end

    # Natal: 25 de dezembro até véspera do Batismo do Senhor do próximo ano
    christmas_start = Date.new(year, 12, 25)
    if date >= christmas_start
      return "Natal"
    end

    # Epifania: do Batismo do Senhor até véspera da Quarta de Cinzas
    if date >= baptism && date < movable[:ash_wednesday]
      return "Epifania"
    end

    # Quaresma: Quarta de Cinzas até Sábado Santo
    if date >= movable[:ash_wednesday] && date <= movable[:holy_saturday]
      return "Quaresma"
    end

    # Páscoa: Domingo de Páscoa até Pentecostes
    if date >= movable[:easter] && date <= movable[:pentecost]
      return "Páscoa"
    end

    # Caso contrário: Tempo Comum
    "Tempo Comum"
  end

  # Determina a cor litúrgica para uma data
  def color_for_date(date)
    celebration = celebration_for_date(date)

    # Se há uma FESTA PRINCIPAL ou DIA SANTO PRINCIPAL, usa SEMPRE a cor da celebração
    # (sobrescreve tudo, incluindo domingos e quadras litúrgicas)
    if celebration && celebration[:color]
      if celebration[:type] == "principal_feast" || celebration[:type] == "major_holy_day"
        return celebration[:color]
      end
    end

    # Para festivais e festas menores: mantém a cor da quadra litúrgica
    # A celebração aparece em 'celebration', mas não altera a cor litúrgica principal

    # Usa a cor da quadra
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
      elsif date == movable[:first_sunday_in_lent] + 21.days # 4º Domingo na Quaresma
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
    resolver = CelebrationResolver.new(year, prayer_book_code: prayer_book_code)
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

      # Tratamento especial para o tempo de Natal
      if season == "Natal"
        return "#{week}º Domingo após Natal"
      end

      preposition = case season
      when "Tempo Comum" then "no"
      when "Quaresma" then "na"
      when "Epifania" then "da"
      else "do"
      end
      "#{week}º Domingo #{preposition} #{season}"
    end
  end

  # Número da semana na quadra
  def week_number(date)
    season = season_for_date(date)
    movable = easter_calc.all_movable_dates

    case season
    when "Advento"
      ((date - movable[:first_sunday_of_advent]).to_i / 7) + 1
    when "Natal"
      # Contar domingos após o Natal
      # 25-31 de dezembro = semana 1
      # 1-6 de janeiro (antes do Batismo) = semana 2
      christmas = date.month == 12 ? Date.new(year, 12, 25) : Date.new(year - 1, 12, 25)
      ((date - christmas).to_i / 7) + 1
    when "Epifania"
      # Count weeks from Baptism of the Lord
      start_date = movable[:baptism_of_the_lord]
      ((date - start_date).to_i / 7) + 1
    when "Quaresma"
      ((date - movable[:first_sunday_in_lent]).to_i / 7) + 1
    when "Páscoa"
      ((date - movable[:easter]).to_i / 7) + 1
    when "Tempo Comum"
      # Ordinary Time has two parts: before Lent and after Pentecost
      if date < movable[:ash_wednesday]
        # Before Lent - count from Baptism of the Lord
        baptism = movable[:baptism_of_the_lord]
        # Find the Sunday on or after baptism
        first_sunday = baptism.sunday? ? baptism : baptism + (7 - baptism.wday).days
        ((date - first_sunday).to_i / 7) + 1
      else
        # After Pentecost
        trinity = movable[:trinity_sunday]
        # First Sunday in Ordinary Time after Pentecost is the Sunday after Trinity
        first_sunday_after_pentecost = trinity + 7.days
        ((date - first_sunday_after_pentecost).to_i / 7) + 1
      end
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

  # Calcula qual domingo após Pentecostes (retorna nil se não estiver no tempo após Pentecostes)
  def sunday_after_pentecost(date)
    return nil unless date.sunday?

    season = season_for_date(date)
    return nil unless season == "Tempo Comum"

    movable = easter_calc.all_movable_dates

    # Only count if we're after Pentecost
    return nil if date < movable[:pentecost]

    # Count Sundays after Pentecost
    # Trinity Sunday is the first Sunday after Pentecost
    trinity = movable[:trinity_sunday]

    # First Sunday in Ordinary Time after Trinity is the first Sunday after Pentecost in Ordinary Time
    first_sunday_after_pentecost = trinity + 7.days

    # Calculate which Sunday after Pentecost
    weeks_after = ((date - movable[:pentecost]).to_i / 7)
    weeks_after if weeks_after >= 0
  end

  # Retorna informações sobre o santo do dia
  def saint_for_date(date)
    celebration = celebration_for_date(date)

    return nil unless celebration

    # Check if the celebration is a saint's day (lesser feast or commemoration typically)
    if celebration[:type] == "lesser_feast" || celebration[:type] == "commemoration" ||
       celebration[:name]&.match?(/São|Santa|Santo|Bem-aventurado/i)
      {
        name: celebration[:name],
        type: celebration[:type],
        color: celebration[:color]
      }
    end
  end

  # Calcula o número do proper (contagem contínua no Tempo Comum)
  # O sistema RCL usa contagem REVERSA a partir de Cristo Rei
  # Proper 29 = domingo mais próximo de 23 de novembro
  # Proper 28 = domingo mais próximo de 16 de novembro, etc.
  def proper_number(date)
    season = season_for_date(date)
    return nil unless season == "Tempo Comum"
    return nil unless date.sunday?

    movable = easter_calc.all_movable_dates

    if date < movable[:ash_wednesday]
      # Before Lent - use forward counting from Baptism of the Lord
      baptism = movable[:baptism_of_the_lord]
      # Find the first Sunday on or after baptism
      first_sunday = baptism.sunday? ? baptism : baptism + (7 - baptism.wday).days

      # Calculate which proper (Propers before Lent are numbered 1-9)
      weeks = ((date - first_sunday).to_i / 7) + 1
      weeks if date >= first_sunday
    else
      # After Pentecost - use REVERSE counting from Christ the King
      # The RCL assigns Propers based on proximity to fixed dates
      # Proper 29 is closest to November 23, Proper 28 to November 16, etc.

      # Map of Proper numbers to their target dates (month, day)
      # Working backwards from Proper 29 (Nov 23) in increments of 7 days
      proper_dates = {
        29 => [ 11, 23 ], # Christ the King
        28 => [ 11, 16 ],
        27 => [ 11, 9 ],
        26 => [ 11, 2 ],
        25 => [ 10, 26 ],
        24 => [ 10, 19 ],
        23 => [ 10, 12 ],
        22 => [ 10, 5 ],
        21 => [ 9, 28 ],
        20 => [ 9, 21 ],
        19 => [ 9, 14 ],
        18 => [ 9, 7 ],
        17 => [ 8, 31 ],
        16 => [ 8, 24 ],
        15 => [ 8, 17 ],
        14 => [ 8, 10 ],
        13 => [ 8, 3 ],
        12 => [ 7, 27 ],
        11 => [ 7, 20 ],
        10 => [ 7, 13 ],
        9 => [ 7, 6 ],
        8 => [ 6, 29 ],
        7 => [ 6, 22 ],
        6 => [ 6, 15 ],
        5 => [ 6, 8 ],
        4 => [ 6, 1 ]
      }

      # Find the Proper by finding the closest Sunday to each reference date
      closest_proper = nil
      min_distance = Float::INFINITY

      proper_dates.each do |proper_num, (month, day)|
        reference_date = Date.new(year, month, day)
        # Find the Sunday closest to this reference date
        closest_sunday = reference_date

        # Adjust to find nearest Sunday
        days_from_sunday = reference_date.wday
        if days_from_sunday <= 3
          # If Mon-Wed, use previous Sunday
          closest_sunday = reference_date - days_from_sunday.days
        elsif days_from_sunday > 3
          # If Thu-Sat, use next Sunday
          closest_sunday = reference_date + (7 - days_from_sunday).days
        end
        # If it's already Sunday (wday == 0), it stays the same

        # Check if this is our date
        if date == closest_sunday
          return proper_num
        end
      end

      nil
    end
  end

  # Retorna o ciclo do ano litúrgico (A, B ou C)
  def liturgical_year_cycle(date)
    # The liturgical year starts on the First Sunday of Advent
    # For example:
    # - Liturgical year 2025 runs from 1st Sunday of Advent 2024 to Christ the King 2025
    # - Liturgical year 2026 runs from 1st Sunday of Advent 2025 to Christ the King 2026

    # Check if we're in the current liturgical year or the next one
    # We need to check Advent from the current calendar year and previous year
    current_year_advent = easter_calc.all_movable_dates[:first_sunday_of_advent]

    # If the date is on or after this year's Advent, we're in the next liturgical year
    if date >= current_year_advent
      liturgical_year_number = year + 1
    else
      # Otherwise, we're in the current liturgical year (which started last year's Advent)
      liturgical_year_number = year
    end

    LectionaryReading.cycle_for_year(liturgical_year_number)
  end

  # Translation helpers
  def translate_season(season_pt)
    translations = {
      "Advento" => "Advent",
      "Natal" => "Christmas",
      "Epifania" => "Epiphany",
      "Quaresma" => "Lent",
      "Páscoa" => "Easter",
      "Tempo Comum" => "Ordinary Time"
    }
    translations[season_pt] || season_pt
  end

  def translate_color(color_pt)
    translations = {
      "branco" => "white",
      "vermelho" => "red",
      "roxo" => "purple",
      "violeta" => "violet",
      "rosa" => "rose",
      "verde" => "green",
      "preto" => "black"
    }
    translations[color_pt] || color_pt
  end

  def day_name_en(date)
    names = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    names[date.wday]
  end

  def day_name_br(date)
    names = %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado]
    names[date.wday]
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

  # Verifica se uma data está em uma quadra litúrgica principal
  # onde os domingos têm precedência sobre festivais menores
  def in_major_season?(date)
    season = season_for_date(date)
    [ "Advento", "Natal", "Quaresma", "Páscoa" ].include?(season)
  end
end
