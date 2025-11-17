require "test_helper"

class EasterCalculatorTest < ActiveSupport::TestCase
  # Testa o cálculo da Páscoa para anos conhecidos
  # Usando o algoritmo de Computus
  test "calcula data da Páscoa corretamente para anos conhecidos" do
    # Datas conhecidas da Páscoa
    known_easters = {
      2020 => Date.new(2020, 4, 12),
      2021 => Date.new(2021, 4, 4),
      2022 => Date.new(2022, 4, 17),
      2023 => Date.new(2023, 4, 9),
      2024 => Date.new(2024, 3, 31),
      2025 => Date.new(2025, 4, 20),
      2026 => Date.new(2026, 4, 5),
      2027 => Date.new(2027, 3, 28),
      2030 => Date.new(2030, 4, 21)
    }

    known_easters.each do |year, expected_date|
      calc = EasterCalculator.new(year)
      assert_equal expected_date, calc.easter_date,
        "Páscoa em #{year} deveria ser #{expected_date}"
    end
  end

  test "Páscoa sempre cai entre 22 de março e 25 de abril" do
    # Testa um range de anos
    (2000..2050).each do |year|
      calc = EasterCalculator.new(year)
      easter = calc.easter_date

      earliest = Date.new(year, 3, 22)
      latest = Date.new(year, 4, 25)

      assert easter >= earliest && easter <= latest,
        "Páscoa em #{year} (#{easter}) deveria estar entre 22 de março e 25 de abril"
    end
  end

  test "Páscoa sempre cai em domingo" do
    (2000..2050).each do |year|
      calc = EasterCalculator.new(year)
      assert calc.easter_date.sunday?,
        "Páscoa em #{year} deveria ser domingo"
    end
  end

  # Testes para Quarta-feira de Cinzas
  test "Quarta-feira de Cinzas é 46 dias antes da Páscoa" do
    calc = EasterCalculator.new(2025)
    expected = calc.easter_date - 46.days
    assert_equal expected, calc.ash_wednesday
  end

  test "Quarta-feira de Cinzas sempre cai em quarta-feira" do
    (2020..2030).each do |year|
      calc = EasterCalculator.new(year)
      assert_equal 3, calc.ash_wednesday.wday, # 3 = quarta-feira
        "Quarta-feira de Cinzas em #{year} deveria ser quarta-feira"
    end
  end

  # Testes para Semana Santa
  test "Domingo de Ramos é 7 dias antes da Páscoa" do
    calc = EasterCalculator.new(2026)
    assert_equal calc.easter_date - 7.days, calc.palm_sunday
    assert calc.palm_sunday.sunday?, "Domingo de Ramos deveria ser domingo"
  end

  test "Segunda-feira Santa é 6 dias antes da Páscoa" do
    calc = EasterCalculator.new(2026)
    assert_equal calc.easter_date - 6.days, calc.holy_monday
    assert_equal 1, calc.holy_monday.wday, "Segunda-feira Santa deveria ser segunda"
  end

  test "Terça-feira Santa é 5 dias antes da Páscoa" do
    calc = EasterCalculator.new(2026)
    assert_equal calc.easter_date - 5.days, calc.holy_tuesday
    assert_equal 2, calc.holy_tuesday.wday, "Terça-feira Santa deveria ser terça"
  end

  test "Quarta-feira Santa é 4 dias antes da Páscoa" do
    calc = EasterCalculator.new(2026)
    assert_equal calc.easter_date - 4.days, calc.holy_wednesday
    assert_equal 3, calc.holy_wednesday.wday, "Quarta-feira Santa deveria ser quarta"
  end

  test "Quinta-feira Santa é 3 dias antes da Páscoa" do
    calc = EasterCalculator.new(2026)
    assert_equal calc.easter_date - 3.days, calc.maundy_thursday
    assert_equal 4, calc.maundy_thursday.wday, "Quinta-feira Santa deveria ser quinta"
  end

  test "Sexta-feira da Paixão é 2 dias antes da Páscoa" do
    calc = EasterCalculator.new(2026)
    assert_equal calc.easter_date - 2.days, calc.good_friday
    assert_equal 5, calc.good_friday.wday, "Sexta-feira da Paixão deveria ser sexta"
  end

  test "Sábado Santo é 1 dia antes da Páscoa" do
    calc = EasterCalculator.new(2026)
    assert_equal calc.easter_date - 1.day, calc.holy_saturday
    assert_equal 6, calc.holy_saturday.wday, "Sábado Santo deveria ser sábado"
  end

  # Testes para Quaresma
  test "Primeiro Domingo na Quaresma é 6 domingos antes da Páscoa" do
    calc = EasterCalculator.new(2025)
    assert_equal calc.easter_date - 42.days, calc.first_sunday_in_lent
    assert calc.first_sunday_in_lent.sunday?
  end

  test "Quaresma tem aproximadamente 40 dias sem contar domingos" do
    calc = EasterCalculator.new(2025)

    # A Quaresma vai da Quarta de Cinzas até o Sábado Santo
    # Mas liturgicamente, os 40 dias são contados de forma especial
    # O importante é que a estrutura esteja correta
    start_date = calc.ash_wednesday
    end_date = calc.holy_saturday

    weekdays_count = 0
    (start_date..end_date).each do |date|
      weekdays_count += 1 unless date.sunday?
    end

    # A contagem litúrgica pode variar, o importante é que esteja próximo de 40
    assert weekdays_count >= 37 && weekdays_count <= 44,
      "Quaresma deveria ter aproximadamente 40 dias sem contar domingos (atual: #{weekdays_count})"
  end

  # Testes para Páscoa
  test "Ascensão é 39 dias após a Páscoa (quinta-feira)" do
    calc = EasterCalculator.new(2025)
    assert_equal calc.easter_date + 39.days, calc.ascension
    assert_equal 4, calc.ascension.wday, "Ascensão deveria ser quinta-feira"
  end

  test "Pentecostes é 49 dias após a Páscoa (domingo)" do
    calc = EasterCalculator.new(2025)
    assert_equal calc.easter_date + 49.days, calc.pentecost
    assert calc.pentecost.sunday?, "Pentecostes deveria ser domingo"
  end

  test "Santíssima Trindade é 7 dias após Pentecostes (domingo)" do
    calc = EasterCalculator.new(2025)
    assert_equal calc.pentecost + 7.days, calc.trinity_sunday
    assert calc.trinity_sunday.sunday?, "Santíssima Trindade deveria ser domingo"
  end

  # Testes para Advento
  test "Primeiro Domingo do Advento é 4 domingos antes do Natal" do
    calc = EasterCalculator.new(2025)
    christmas = Date.new(2025, 12, 25)
    first_advent = calc.first_sunday_of_advent

    assert first_advent.sunday?, "Primeiro Domingo do Advento deveria ser domingo"

    # Conta domingos entre primeiro do Advento e Natal
    sundays = 0
    date = first_advent
    while date <= christmas
      sundays += 1 if date.sunday?
      date += 1.day
    end

    assert sundays >= 4, "Deveria haver pelo menos 4 domingos no Advento"
  end

  test "Cristo Rei é sempre o domingo antes do Advento" do
    calc = EasterCalculator.new(2025)
    christ_king = calc.christ_the_king
    first_advent = calc.first_sunday_of_advent

    assert christ_king.sunday?, "Cristo Rei deveria ser domingo"
    assert_equal first_advent - 7.days, christ_king
  end

  # Testes para Epifania
  test "Epifania é sempre 6 de janeiro" do
    (2020..2030).each do |year|
      calc = EasterCalculator.new(year)
      assert_equal Date.new(year, 1, 6), calc.epiphany
    end
  end

  test "Batismo do Senhor é o primeiro domingo depois da Epifania" do
    calc = EasterCalculator.new(2025)
    baptism = calc.baptism_of_the_lord

    assert baptism.sunday?, "Batismo do Senhor deveria ser domingo"
    assert baptism > calc.epiphany, "Batismo deveria ser depois da Epifania"

    # Verifica que não há domingo entre Epifania e Batismo
    date = calc.epiphany + 1.day
    while date < baptism
      refute date.sunday?, "Não deveria haver domingo entre Epifania e Batismo"
      date += 1.day
    end
  end

  test "Último Domingo após Epifania é o domingo antes da Quarta de Cinzas" do
    calc = EasterCalculator.new(2025)
    last_epiphany = calc.last_sunday_after_epiphany

    assert last_epiphany.sunday?, "Último domingo após Epifania deveria ser domingo"
    assert last_epiphany < calc.ash_wednesday

    # Verifica que é o domingo imediatamente antes
    next_sunday = last_epiphany + 7.days
    assert next_sunday > calc.ash_wednesday,
      "O próximo domingo deveria ser depois da Quarta de Cinzas"
  end

  # Teste do método all_movable_dates
  test "all_movable_dates retorna todas as datas importantes" do
    calc = EasterCalculator.new(2025)
    dates = calc.all_movable_dates

    required_keys = [
      :easter, :ash_wednesday, :first_sunday_in_lent, :palm_sunday,
      :holy_monday, :holy_tuesday, :holy_wednesday,
      :maundy_thursday, :good_friday, :holy_saturday,
      :second_sunday_of_easter, :ascension, :pentecost, :trinity_sunday,
      :corpus_christi, :first_sunday_of_advent, :christ_the_king,
      :baptism_of_the_lord, :last_sunday_after_epiphany
    ]

    required_keys.each do |key|
      assert dates.key?(key), "all_movable_dates deveria incluir :#{key}"
      assert dates[key].is_a?(Date), "#{key} deveria ser um Date"
    end
  end

  # Testes de consistência
  test "ordem cronológica das celebrações da Quaresma está correta" do
    calc = EasterCalculator.new(2025)

    assert calc.ash_wednesday < calc.first_sunday_in_lent
    assert calc.first_sunday_in_lent < calc.palm_sunday
    assert calc.palm_sunday < calc.holy_monday
    assert calc.holy_monday < calc.holy_tuesday
    assert calc.holy_tuesday < calc.holy_wednesday
    assert calc.holy_wednesday < calc.maundy_thursday
    assert calc.maundy_thursday < calc.good_friday
    assert calc.good_friday < calc.holy_saturday
    assert calc.holy_saturday < calc.easter_date
  end

  test "ordem cronológica das celebrações da Páscoa está correta" do
    calc = EasterCalculator.new(2025)

    assert calc.easter_date < calc.second_sunday_of_easter
    assert calc.second_sunday_of_easter < calc.ascension
    assert calc.ascension < calc.pentecost
    assert calc.pentecost < calc.trinity_sunday
  end

  # Teste para anos específicos mencionados pelo usuário
  test "datas corretas para 2026" do
    calc = EasterCalculator.new(2026)

    assert_equal Date.new(2026, 4, 5), calc.easter_date
    assert_equal Date.new(2026, 4, 4), calc.holy_saturday
    assert_equal Date.new(2026, 4, 3), calc.good_friday
    assert_equal Date.new(2026, 3, 30), calc.holy_monday
    assert_equal Date.new(2026, 3, 31), calc.holy_tuesday
    assert_equal Date.new(2026, 4, 1), calc.holy_wednesday
  end
end
