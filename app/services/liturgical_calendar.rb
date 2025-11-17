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
      day_of_week: day_name_en(date),
      liturgical_season: translate_season(season_for_date(date)),
      color: translate_color(color_for_date(date)),
      celebration: celebration_for_date(date),
      is_sunday: date.sunday?,
      is_holy_day: holy_day?(date),
      week_of_season: week_number(date),
      proper_week: proper_number(date),
      sunday_name: translate_sunday_name(sunday_name(date)),
      sunday_after_pentecost: sunday_after_pentecost(date),
      liturgical_year: liturgical_year_cycle(date),
      saint: saint_for_date(date)
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
    # MAS: Se é domingo, SEMPRE usa cor da quadra (domingos têm precedência)
    if celebration && celebration[:color] && !date.sunday?
      return celebration[:color]
    end

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
      preposition = case season
                    when 'Tempo Comum' then 'no'
                    when 'Quaresma' then 'na'
                    when 'Epifania' then 'da'
                    else 'do'
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
    when "Epifania"
      # Count weeks from the Monday after Epiphany season starts
      start_date = epiphany_season_start
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
        29 => [11, 23], # Christ the King
        28 => [11, 16],
        27 => [11, 9],
        26 => [11, 2],
        25 => [10, 26],
        24 => [10, 19],
        23 => [10, 12],
        22 => [10, 5],
        21 => [9, 28],
        20 => [9, 21],
        19 => [9, 14],
        18 => [9, 7],
        17 => [8, 31],
        16 => [8, 24],
        15 => [8, 17],
        14 => [8, 10],
        13 => [8, 3],
        12 => [7, 27],
        11 => [7, 20],
        10 => [7, 13],
        9 => [7, 6],
        8 => [6, 29],
        7 => [6, 22],
        6 => [6, 15],
        5 => [6, 8],
        4 => [6, 1]
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

  def translate_sunday_name(name_pt)
    return nil if name_pt.nil?

    # Direct translations for special Sundays
    special_sundays = {
      "Domingo da Páscoa" => "Easter Sunday",
      "Pentecostes" => "Pentecost",
      "Santíssima Trindade" => "Trinity Sunday",
      "Domingo de Ramos" => "Palm Sunday",
      "Cristo Rei do Universo" => "Christ the King",
      "Batismo de nosso Senhor Jesus Cristo" => "Baptism of the Lord"
    }

    return special_sundays[name_pt] if special_sundays[name_pt]

    # Pattern-based translations for numbered Sundays
    # "1º Domingo do Advento" -> "1st Sunday of Advent"
    # "25º Domingo no Tempo Comum" -> "25th Sunday in Ordinary Time"

    if name_pt =~ /(\d+)º Domingo (do|no|da) (.+)/
      number = $1.to_i
      preposition = $2
      season = $3

      ordinal = case number
      when 1 then "1st"
      when 2 then "2nd"
      when 3 then "3rd"
      else "#{number}th"
      end

      prep = preposition == "no" ? "in" : "of"
      translated_season = translate_season(season)

      "#{ordinal} Sunday #{prep} #{translated_season}"
    else
      name_pt
    end
  end

  def day_name_en(date)
    names = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
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
    ["Advento", "Natal", "Quaresma", "Páscoa"].include?(season)
  end
end
