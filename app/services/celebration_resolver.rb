# Serviço para resolver transferências de festas conforme as regras litúrgicas
class CelebrationResolver
  attr_reader :year, :easter_calc, :prayer_book_code, :prayer_book

  def initialize(year, prayer_book_code: "loc_2015")
    @year = year
    @prayer_book_code = prayer_book_code
    @easter_calc = EasterCalculator.new(year)
  end

  def prayer_book
    @prayer_book ||= PrayerBook.find_by_code(prayer_book_code)
  end

  def prayer_book_id
    prayer_book&.id
  end

  # Resolve qual celebração deve ser observada numa data específica,
  # aplicando regras de transferência e hierarquia
  def resolve_for_date(date)
    # 1. Coleta todas as celebrações que "querem" estar nesta data
    candidates = collect_candidates(date)

    # 2. Se não há candidatos, retorna nil
    return nil if candidates.empty?

    # 3. Se há apenas um candidato, retorna ele
    return candidates.first if candidates.length == 1

    # 4. Se há múltiplos candidatos, resolve por hierarquia
    resolve_by_hierarchy(candidates, date)
  end

  # Retorna a data onde uma celebração deve ser observada,
  # considerando possíveis transferências
  def actual_date_for_celebration(celebration)
    # Se é móvel, calcula a data
    if celebration.movable?
      return calculate_movable_date(celebration)
    end

    # Se é fixa e não pode ser transferida, retorna a data fixa
    unless celebration.can_be_transferred?
      return Date.new(year, celebration.fixed_month, celebration.fixed_day)
    end

    # Verifica se precisa transferir
    original_date = Date.new(year, celebration.fixed_month, celebration.fixed_day)

    # Aplica regras de transferência
    transfer_if_needed(celebration, original_date)
  end

  private

  def collect_candidates(date)
    candidates = []

    # Candidatos fixos (filtrados por prayer_book)
    fixed_celebrations = Celebration.for_prayer_book_id(prayer_book_id)
                                    .fixed
                                    .for_date(date.month, date.day)
    candidates.concat(fixed_celebrations.to_a)

    # Candidatos móveis que caem nesta data (filtrados por prayer_book)
    Celebration.movable.for_prayer_book_id(prayer_book_id).each do |cel|
      if calculate_movable_date(cel) == date
        candidates << cel
      end
    end

    # Candidatos transferidos para esta data (filtrados por prayer_book)
    Celebration.for_prayer_book_id(prayer_book_id).where(can_be_transferred: true).each do |cel|
      next if cel.movable? # já tratado acima

      transferred_date = actual_date_for_celebration(cel)
      if transferred_date == date && transferred_date != Date.new(year, cel.fixed_month, cel.fixed_day)
        candidates << cel
      end
    end

    candidates
  end

  def resolve_by_hierarchy(celebrations, date)
    # Ordena por rank (menor = maior precedência)
    sorted = celebrations.sort_by(&:rank)

    # Festa Principal ou Dia Santo Principal sempre tem precedência (mesmo em domingos)
    principal = sorted.find { |c| c.principal_feast? || c.major_holy_day? }
    return principal if principal

    # Domingos em quadras principais (Advento, Natal, Quaresma, Páscoa) têm precedência sobre festas menores
    # MAS: Festas Principais e Dias Santos Principais já foram tratados acima
    if date.sunday? && in_major_season?(date)
      # Retorna a festa menor para que apareça em 'celebration',
      # mas LiturgicalCalendar usará a cor da quadra (não da celebração)
      return sorted.first
    end

    # Caso contrário, retorna o de menor rank
    sorted.first
  end

  def calculate_movable_date(celebration)
    return nil unless celebration.movable?

    movable_dates = easter_calc.all_movable_dates

    case celebration.calculation_rule
    when "easter"
      movable_dates[:easter]
    when "easter_minus_46_days"
      movable_dates[:ash_wednesday]
    when "easter_minus_6_days"
      movable_dates[:holy_monday]
    when "easter_minus_5_days"
      movable_dates[:holy_tuesday]
    when "easter_minus_4_days"
      movable_dates[:holy_wednesday]
    when "easter_minus_3_days"
      movable_dates[:maundy_thursday]
    when "easter_minus_2_days"
      movable_dates[:good_friday]
    when "easter_minus_1_day"
      movable_dates[:holy_saturday]
    when "easter_plus_39_days"
      movable_dates[:ascension]
    when "easter_plus_49_days"
      movable_dates[:pentecost]
    when "first_sunday_after_pentecost"
      movable_dates[:trinity_sunday]
    when "first_sunday_after_epiphany"
      movable_dates[:baptism_of_the_lord]
    when "sunday_before_advent"
      movable_dates[:christ_the_king]
    else
      nil
    end
  end

  def transfer_if_needed(celebration, original_date)
    # Regras específicas de transferência baseadas nas normas

    # ANUNCIAÇÃO (25 de março)
    if celebration.name =~ /Anunciação/
      return transfer_annunciation(original_date)
    end

    # JOSÉ DE NAZARÉ e MARCOS, EVANGELISTA
    # Se caem entre Domingo de Ramos e Segundo Domingo da Páscoa
    if [ "José de Nazaré", "Marcos, Evangelista" ].include?(celebration.name)
      return transfer_if_holy_week(original_date)
    end

    # FESTIVAIS que caem em domingo (exceto período protegido)
    if celebration.festival? && original_date.sunday?
      return transfer_festival_on_sunday(celebration, original_date)
    end

    # ASCENSÃO pode ser transferida para domingo seguinte (pastoral)
    if celebration.name =~ /Ascensão/
      # Por padrão, quinta-feira, mas pode ser transferida
      # Retorna a data original (quinta-feira)
      return original_date
    end

    # Todos os Santos pode ser transferido para domingo mais próximo
    if celebration.name =~ /Todos os Santos/
      return transfer_all_saints(original_date)
    end

    # Se não há regra específica, mantém a data original
    original_date
  end

  def transfer_annunciation(original_date)
    # 25 de março
    movable = easter_calc.all_movable_dates
    palm_sunday = movable[:palm_sunday]
    second_easter = movable[:second_sunday_of_easter]

    # Se cai num domingo, transfere para segunda-feira
    if original_date.sunday?
      return original_date + 1.day
    end

    # Se cai entre Domingo de Ramos (inclusive) e Segundo Domingo da Páscoa (inclusive)
    if original_date >= palm_sunday && original_date <= second_easter
      # Transfere para segunda-feira após Segundo Domingo da Páscoa
      return second_easter + 1.day
    end

    original_date
  end

  def transfer_if_holy_week(original_date)
    movable = easter_calc.all_movable_dates
    palm_sunday = movable[:palm_sunday]
    second_easter = movable[:second_sunday_of_easter]

    # Se cai entre Domingo de Ramos e Segundo Domingo da Páscoa
    if original_date >= palm_sunday && original_date <= second_easter
      # Transfere para segunda-feira após Segundo Domingo da Páscoa
      # Se Anunciação já foi transferida para lá, usa terça-feira
      monday_after = second_easter + 1.day

      # Verifica se Anunciação está ocupando segunda-feira
      annunciation = Celebration.find_by(name: "Anunciação de nosso Senhor Jesus Cristo à Bem-Aventurada Virgem Maria")
      if annunciation
        annunciation_date = Date.new(year, 3, 25)
        if transfer_annunciation(annunciation_date) == monday_after
          return second_easter + 2.days # Terça-feira
        end
      end

      return monday_after
    end

    original_date
  end

  def transfer_festival_on_sunday(celebration, original_date)
    # Festivais geralmente não são celebrados em domingos específicos
    # Exceções: domingos entre Cristo Rei e Batismo do Senhor,
    # e entre Último Domingo após Epifania e Santíssima Trindade

    movable = easter_calc.all_movable_dates
    christ_the_king = movable[:christ_the_king]
    baptism = movable[:baptism_of_the_lord]
    last_epiphany = movable[:last_sunday_after_epiphany]
    trinity = movable[:trinity_sunday]

    # Período protegido onde festivais não podem ser celebrados em domingo
    protected_period = (
      (original_date >= christ_the_king && original_date <= baptism) ||
      (original_date >= last_epiphany && original_date <= trinity)
    )

    if protected_period
      # Transfere para próxima segunda-feira
      return original_date + 1.day
    end

    # Fora do período protegido, pode usar coleta/leituras do festival no domingo
    # mas geralmente transfere para segunda
    original_date + 1.day
  end

  def transfer_all_saints(original_date)
    # 1º de novembro
    # Pode ser celebrado no domingo entre 30 de outubro e 5 de novembro

    # Se cai num domingo, mantém
    return original_date if original_date.sunday?

    # Procura o domingo mais próximo no intervalo permitido
    start_range = Date.new(year, 10, 30)
    end_range = Date.new(year, 11, 5)

    (start_range..end_range).each do |date|
      if date.sunday?
        return date
      end
    end

    # Se não encontrou domingo no intervalo, mantém 1º de novembro
    original_date
  end

  # Verifica se uma data está em período protegido (não pode ter festivais menores)
  def in_protected_period?(date)
    movable = easter_calc.all_movable_dates
    palm_sunday = movable[:palm_sunday]
    second_easter = movable[:second_sunday_of_easter]

    # Semana Santa até Segundo Domingo da Páscoa
    (date >= palm_sunday && date <= second_easter)
  end

  # Verifica se uma data está em uma quadra litúrgica principal
  # onde os domingos têm precedência sobre festivais menores
  def in_major_season?(date)
    movable = easter_calc.all_movable_dates

    # Advento (do 1º Domingo do Advento até 24 de dezembro)
    if date >= movable[:first_sunday_of_advent] && date <= Date.new(year, 12, 24)
      return true
    end

    # Natal (25 de dezembro até 6 de janeiro do próximo ano - Epifania)
    # Durante o Natal, domingos têm precedência
    christmas_start = Date.new(year, 12, 25)
    epiphany = Date.new(year + 1, 1, 6)
    if date >= christmas_start && date <= epiphany
      return true
    end

    # Quaresma (Quarta-feira de Cinzas até Sábado Santo)
    if date >= movable[:ash_wednesday] && date <= movable[:holy_saturday]
      return true
    end

    # Páscoa (Domingo de Páscoa até Pentecostes)
    if date >= movable[:easter] && date <= movable[:pentecost]
      return true
    end

    false
  end
end
