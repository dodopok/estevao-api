require "test_helper"

class CelebrationResolverTest < ActiveSupport::TestCase
  def setup
    # Cria celebrações de teste necessárias
    @easter = Celebration.create!(
      name: "Páscoa",
      celebration_type: "principal_feast",
      rank: 0,
      movable: true,
      calculation_rule: "easter",
      liturgical_color: "branco",
      can_be_transferred: false
    )

    @holy_saturday = Celebration.create!(
      name: "Sábado Santo",
      celebration_type: "major_holy_day",
      rank: 23,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "preto",
      can_be_transferred: false
    )

    @easter_vigil = Celebration.create!(
      name: "Vigília Pascal",
      celebration_type: "principal_feast",
      rank: 1,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "branco",
      can_be_transferred: false
    )

    @good_friday = Celebration.create!(
      name: "Sexta-Feira da Paixão",
      celebration_type: "major_holy_day",
      rank: 22,
      movable: true,
      calculation_rule: "easter_minus_2_days",
      liturgical_color: "vermelho",
      can_be_transferred: false
    )

    @annunciation = Celebration.create!(
      name: "Anunciação de nosso Senhor Jesus Cristo à Bem-Aventurada Virgem Maria",
      celebration_type: "principal_feast",
      rank: 10,
      movable: false,
      fixed_month: 3,
      fixed_day: 25,
      liturgical_color: "branco",
      can_be_transferred: true
    )

    @saint_joseph = Celebration.create!(
      name: "José de Nazaré",
      celebration_type: "festival",
      rank: 30,
      movable: false,
      fixed_month: 3,
      fixed_day: 19,
      liturgical_color: "branco",
      can_be_transferred: true
    )

    @all_saints = Celebration.create!(
      name: "Todos os Santos e Santas",
      celebration_type: "principal_feast",
      rank: 11,
      movable: false,
      fixed_month: 11,
      fixed_day: 1,
      liturgical_color: "branco",
      can_be_transferred: true
    )

    @lesser_feast = Celebration.create!(
      name: "Santo Teste",
      celebration_type: "lesser_feast",
      rank: 250,
      movable: false,
      fixed_month: 5,
      fixed_day: 15,
      liturgical_color: "branco",
      can_be_transferred: false
    )
  end

  # Testes de cálculo de datas móveis
  test "calcula data da Páscoa corretamente" do
    resolver = CelebrationResolver.new(2026)
    date = resolver.send(:calculate_movable_date, @easter)

    assert_equal Date.new(2026, 4, 5), date
  end

  test "calcula data do Sábado Santo corretamente" do
    resolver = CelebrationResolver.new(2026)
    date = resolver.send(:calculate_movable_date, @holy_saturday)

    assert_equal Date.new(2026, 4, 4), date
  end

  test "calcula data da Sexta-feira da Paixão corretamente" do
    resolver = CelebrationResolver.new(2026)
    date = resolver.send(:calculate_movable_date, @good_friday)

    assert_equal Date.new(2026, 4, 3), date
  end

  test "retorna nil para celebration_rule desconhecida" do
    celebration = Celebration.new(
      name: "Teste",
      movable: true,
      calculation_rule: "unknown_rule"
    )

    resolver = CelebrationResolver.new(2025)
    date = resolver.send(:calculate_movable_date, celebration)

    assert_nil date
  end

  # Testes de hierarquia
  test "resolve por hierarquia quando há múltiplas celebrações" do
    resolver = CelebrationResolver.new(2026)

    # Sábado Santo e Vigília Pascal caem no mesmo dia
    date = Date.new(2026, 4, 4)
    result = resolver.resolve_for_date(date)

    # Vigília Pascal tem rank 1, Sábado Santo tem rank 23
    # Menor rank = maior precedência
    assert_equal @easter_vigil.id, result.id,
      "Vigília Pascal deveria ter precedência sobre Sábado Santo"
  end

  test "retorna nil quando não há celebrações" do
    resolver = CelebrationResolver.new(2025)
    # Data sem celebrações
    date = Date.new(2025, 5, 20)

    result = resolver.resolve_for_date(date)
    assert_nil result
  end

  test "retorna única celebração quando há apenas uma" do
    resolver = CelebrationResolver.new(2025)
    date = Date.new(2025, 5, 15) # Data do @lesser_feast

    result = resolver.resolve_for_date(date)
    assert_equal @lesser_feast.id, result.id
  end

  # Testes de transferência
  test "Anunciação não é transferida quando não há conflito" do
    # 2025: 25 de março é terça-feira, não há conflito
    resolver = CelebrationResolver.new(2025)
    date = resolver.actual_date_for_celebration(@annunciation)

    assert_equal Date.new(2025, 3, 25), date,
      "Anunciação não deveria ser transferida quando não há conflito"
  end

  test "Anunciação é transferida quando cai num domingo" do
    # Encontra um ano onde 25 de março cai num domingo
    # 2029: 25 de março é domingo
    resolver = CelebrationResolver.new(2029)
    original_date = Date.new(2029, 3, 25)

    assert original_date.sunday?, "25/03/2029 deveria ser domingo"

    transferred_date = resolver.actual_date_for_celebration(@annunciation)

    # Deveria ser transferida para segunda-feira
    assert_equal Date.new(2029, 3, 26), transferred_date,
      "Anunciação deveria ser transferida para segunda quando cai em domingo"
  end

  test "Todos os Santos pode ser transferido para domingo mais próximo" do
    # 2025: 1 de novembro é sábado
    resolver = CelebrationResolver.new(2025)
    transferred_date = resolver.actual_date_for_celebration(@all_saints)

    # Deveria ser transferida para domingo entre 30/10 e 5/11
    assert transferred_date.sunday?,
      "Todos os Santos deveria ser transferido para um domingo"
    assert transferred_date >= Date.new(2025, 10, 30)
    assert transferred_date <= Date.new(2025, 11, 5)
  end

  test "Todos os Santos permanece em 1 de novembro se já for domingo" do
    # 2026: 1 de novembro é domingo
    resolver = CelebrationResolver.new(2026)
    date = resolver.actual_date_for_celebration(@all_saints)

    assert_equal Date.new(2026, 11, 1), date,
      "Todos os Santos não deveria ser transferido se já cair em domingo"
  end

  # Testes de celebrações fixas
  test "celebrações fixas que não podem ser transferidas mantêm data original" do
    resolver = CelebrationResolver.new(2025)
    date = resolver.actual_date_for_celebration(@lesser_feast)

    assert_equal Date.new(2025, 5, 15), date
  end

  # Testes de período protegido
  test "identifica corretamente período protegido da Semana Santa" do
    resolver = CelebrationResolver.new(2026)

    # Domingo de Ramos até Segundo Domingo da Páscoa
    palm_sunday = Date.new(2026, 3, 29)
    holy_saturday = Date.new(2026, 4, 4)
    easter = Date.new(2026, 4, 5)

    assert resolver.send(:in_protected_period?, palm_sunday)
    assert resolver.send(:in_protected_period?, holy_saturday)
    assert resolver.send(:in_protected_period?, easter)

    # Fora do período protegido
    before_palm = Date.new(2026, 3, 28)
    refute resolver.send(:in_protected_period?, before_palm)
  end

  # Testes de quadras principais
  test "identifica Advento como quadra principal" do
    resolver = CelebrationResolver.new(2025)
    # Primeiro domingo do Advento 2025
    date = Date.new(2025, 11, 30)

    assert resolver.send(:in_major_season?, date)
  end

  test "identifica Quaresma como quadra principal" do
    resolver = CelebrationResolver.new(2025)
    # Durante a Quaresma
    date = Date.new(2025, 3, 15)

    assert resolver.send(:in_major_season?, date)
  end

  test "identifica Páscoa como quadra principal" do
    resolver = CelebrationResolver.new(2025)
    # Durante a Páscoa
    date = Date.new(2025, 4, 27)

    assert resolver.send(:in_major_season?, date)
  end

  test "identifica Natal como quadra principal" do
    resolver = CelebrationResolver.new(2025)
    # 25 de dezembro - Natal
    date = Date.new(2025, 12, 25)

    # O método in_major_season? depende do LiturgicalCalendar
    # que precisa verificar se a data está na quadra do Natal
    # Vamos apenas verificar se o método funciona
    result = resolver.send(:in_major_season?, date)

    # Natal é uma quadra principal, então deveria retornar true
    assert result, "Natal (#{date}) deveria ser identificado como quadra principal"
  end

  test "Tempo Comum não é quadra principal" do
    resolver = CelebrationResolver.new(2025)
    # Tempo Comum
    date = Date.new(2025, 6, 15)

    refute resolver.send(:in_major_season?, date)
  end

  # Teste de coleta de candidatos
  test "coleta celebrações fixas corretamente" do
    resolver = CelebrationResolver.new(2025)
    date = Date.new(2025, 3, 19) # São José

    candidates = resolver.send(:collect_candidates, date)

    assert candidates.any? { |c| c.id == @saint_joseph.id },
      "Deveria incluir São José"
  end

  test "coleta celebrações móveis corretamente" do
    resolver = CelebrationResolver.new(2026)
    date = Date.new(2026, 4, 5) # Páscoa 2026

    candidates = resolver.send(:collect_candidates, date)

    assert candidates.any? { |c| c.id == @easter.id },
      "Deveria incluir Páscoa"
  end

  # Teste de casos específicos mencionados pelo usuário
  test "2026-04-04 retorna Vigília Pascal (não Sábado Santo)" do
    resolver = CelebrationResolver.new(2026)
    date = Date.new(2026, 4, 4)

    result = resolver.resolve_for_date(date)

    assert_equal @easter_vigil.id, result.id,
      "2026-04-04 deveria retornar Vigília Pascal por ter maior precedência"
  end

  test "domingos em quadras principais têm precedência sobre festivais" do
    # Cria um festival que cai num domingo da Quaresma
    festival = Celebration.create!(
      name: "Festival Teste",
      celebration_type: "festival",
      rank: 35,
      movable: false,
      fixed_month: 3,
      fixed_day: 16, # Ajustar para ser domingo em 2025
      liturgical_color: "branco",
      can_be_transferred: true
    )

    resolver = CelebrationResolver.new(2025)
    # Encontra um domingo na Quaresma
    date = Date.new(2025, 3, 16)

    # Se for domingo na quadra principal, o resolve_by_hierarchy deve retornar nil
    # (para que LiturgicalCalendar use o domingo ao invés da festa)
    if date.sunday? && resolver.send(:in_major_season?, date)
      candidates = [ festival ]
      result = resolver.send(:resolve_by_hierarchy, candidates, date)

      assert_nil result,
        "Domingos em quadras principais deveriam ter precedência sobre festivais"
    end
  end
end
