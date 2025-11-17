# Serviço para calcular a data da Páscoa e outras datas móveis
# Usa o algoritmo de Computus (algoritmo de Gauss)
class EasterCalculator
  attr_reader :year

  def initialize(year)
    @year = year
  end

  # Calcula a data da Páscoa usando o algoritmo de Computus
  # A Páscoa é sempre o primeiro domingo depois da lua cheia
  # que cai no dia 21 de março ou depois
  def easter_date
    @easter_date ||= calculate_easter
  end

  # Quarta-feira de Cinzas (46 dias antes da Páscoa)
  def ash_wednesday
    easter_date - 46.days
  end

  # Primeiro Domingo na Quaresma (6 domingos antes da Páscoa)
  def first_sunday_in_lent
    easter_date - 42.days
  end

  # Domingo de Ramos (domingo antes da Páscoa)
  def palm_sunday
    easter_date - 7.days
  end

  # Segunda-feira Santa
  def holy_monday
    easter_date - 6.days
  end

  # Terça-feira Santa
  def holy_tuesday
    easter_date - 5.days
  end

  # Quarta-feira Santa
  def holy_wednesday
    easter_date - 4.days
  end

  # Quinta-feira Santa (quinta-feira antes da Páscoa)
  def maundy_thursday
    easter_date - 3.days
  end

  # Sexta-feira da Paixão (sexta-feira antes da Páscoa)
  def good_friday
    easter_date - 2.days
  end

  # Sábado Santo
  def holy_saturday
    easter_date - 1.day
  end

  # Segundo Domingo da Páscoa
  def second_sunday_of_easter
    easter_date + 7.days
  end

  # Ascensão (40 dias após a Páscoa, quinta-feira)
  def ascension
    easter_date + 39.days
  end

  # Pentecostes (50 dias após a Páscoa)
  def pentecost
    easter_date + 49.days
  end

  # Santíssima Trindade (primeiro domingo depois de Pentecostes)
  def trinity_sunday
    pentecost + 7.days
  end

  # Dias de Rogações (quarta, sexta e sábado antes da Ascensão)
  def rogation_days
    [
      ascension - 3.days,  # Segunda-feira
      ascension - 1.day,   # Quarta-feira
      ascension - 2.days   # Sexta-feira (correção: deve ser antes)
    ].sort
  end

  # Corpus Christi (quinta-feira após Trindade)
  def corpus_christi
    trinity_sunday + 4.days
  end

  # Primeiro Domingo do Advento (4 domingos antes do Natal)
  def first_sunday_of_advent
    christmas = Date.new(year, 12, 25)
    # Encontra o domingo mais próximo antes do Natal
    days_until_sunday = christmas.wday == 0 ? 7 : christmas.wday
    nearest_sunday = christmas - days_until_sunday.days

    # Volta 3 domingos (total de 4 domingos do Advento)
    nearest_sunday - 21.days
  end

  # Cristo Rei (domingo anterior ao Advento)
  def christ_the_king
    first_sunday_of_advent - 7.days
  end

  # Epifania (6 de janeiro)
  def epiphany
    Date.new(year, 1, 6)
  end

  # Batismo do Senhor (primeiro domingo depois da Epifania)
  def baptism_of_the_lord
    epi = epiphany
    # Se Epifania cair num domingo, Batismo é no domingo seguinte
    if epi.sunday?
      epi + 7.days
    else
      # Próximo domingo após Epifania
      days_until_sunday = 7 - epi.wday
      epi + days_until_sunday.days
    end
  end

  # Último Domingo depois da Epifania (domingo antes da Quarta-feira de Cinzas)
  def last_sunday_after_epiphany
    ash_wednesday - (ash_wednesday.wday == 0 ? 7 : ash_wednesday.wday).days
  end

  # Transfiguração (6 de agosto)
  def transfiguration
    Date.new(year, 8, 6)
  end

  # Retorna um hash com todas as datas móveis importantes
  def all_movable_dates
    {
      easter: easter_date,
      ash_wednesday: ash_wednesday,
      first_sunday_in_lent: first_sunday_in_lent,
      palm_sunday: palm_sunday,
      holy_monday: holy_monday,
      holy_tuesday: holy_tuesday,
      holy_wednesday: holy_wednesday,
      maundy_thursday: maundy_thursday,
      good_friday: good_friday,
      holy_saturday: holy_saturday,
      second_sunday_of_easter: second_sunday_of_easter,
      ascension: ascension,
      pentecost: pentecost,
      trinity_sunday: trinity_sunday,
      corpus_christi: corpus_christi,
      first_sunday_of_advent: first_sunday_of_advent,
      christ_the_king: christ_the_king,
      baptism_of_the_lord: baptism_of_the_lord,
      last_sunday_after_epiphany: last_sunday_after_epiphany
    }
  end

  private

  # Algoritmo de Computus (método de Gauss)
  # para calcular a data da Páscoa
  def calculate_easter
    # Cálculos intermediários
    a = year % 19
    b = year / 100
    c = year % 100
    d = b / 4
    e = b % 4
    f = (b + 8) / 25
    g = (b - f + 1) / 3
    h = (19 * a + b - d - g + 15) % 30
    i = c / 4
    k = c % 4
    l = (32 + 2 * e + 2 * i - h - k) % 7
    m = (a + 11 * h + 22 * l) / 451

    # Mês e dia da Páscoa
    month = (h + l - 7 * m + 114) / 31
    day = ((h + l - 7 * m + 114) % 31) + 1

    Date.new(year, month, day)
  end
end
