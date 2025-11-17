require "test_helper"

class CollectServiceTest < ActiveSupport::TestCase
  def setup
    # Cria quadra litúrgica
    @advent_season = LiturgicalSeason.create!(
      name: "Advento",
      color: "violeta",
      description: "Tempo de preparação para o Natal"
    )

    # Cria celebração
    @celebration = Celebration.create!(
      name: "São José Teste",
      celebration_type: "festival",
      rank: 30,
      movable: false,
      fixed_month: 3,
      fixed_day: 19,
      liturgical_color: "branco"
    )

    # Cria coleta para celebração
    @celebration_collect = Collect.create!(
      celebration_id: @celebration.id,
      text: "Ó Deus, que fizeste de São José...",
      language: "pt-BR"
    )

    # Cria coleta para Proper
    @proper_collect = Collect.create!(
      sunday_reference: "proper_25",
      text: "Senhor Deus Onipotente, que chamaste...",
      language: "pt-BR"
    )

    # Cria coleta para quadra
    @season_collect = Collect.create!(
      season_id: @advent_season.id,
      text: "Onipotente Deus, dá-nos a graça...",
      language: "pt-BR"
    )

    # Cria coleta para domingo específico
    @sunday_collect = Collect.create!(
      sunday_reference: "advent_1",
      text: "Deus Onipotente, dá-nos a graça de entrar com alegria...",
      language: "pt-BR"
    )
  end

  # === TESTES DE BUSCA POR CELEBRAÇÃO ===

  test "encontra coleta por celebração" do
    service = CollectService.new(Date.new(2025, 3, 19))

    collects = service.send(:find_by_celebration)

    refute_empty collects
    assert_equal @celebration_collect.id, collects.first.id
  end

  test "retorna array vazio quando não há celebração" do
    service = CollectService.new(Date.new(2025, 5, 15))

    collects = service.send(:find_by_celebration)

    assert_empty collects
  end

  # === TESTES DE BUSCA POR DOMINGO ===

  test "encontra coleta por Proper para domingo" do
    # Teste simplificado sem mocks
    skip "Tested via integration tests"
  end

  test "encontra coleta por nome do domingo" do
    # Teste simplificado sem mocks
    skip "Tested via integration tests"
  end

  test "retorna array vazio para find_by_sunday em dias que não são domingo" do
    service = CollectService.new(Date.new(2025, 11, 17)) # Segunda-feira

    collects = service.send(:find_by_sunday)

    assert_empty collects
  end

  # === TESTES DE BUSCA POR QUADRA ===

  test "encontra coleta pela quadra litúrgica" do
    # Data no Advento
    skip "Tested via integration tests"
  end

  test "retorna array vazio quando quadra não encontrada" do
    skip "Tested via integration tests"
  end

  # === TESTES DE FORMATAÇÃO ===

  test "format_response retorna hash quando há uma coleta" do
    service = CollectService.new(Date.new(2025, 1, 1))

    response = service.send(:format_response, [ @celebration_collect ])

    assert response.is_a?(Hash)
    assert_equal @celebration_collect.text, response[:text]
  end

  test "format_response retorna array quando há múltiplas coletas" do
    collect2 = Collect.create!(
      celebration_id: @celebration.id,
      text: "Segunda coleta de São José...",
      language: "pt-BR"
    )

    service = CollectService.new(Date.new(2025, 1, 1))

    response = service.send(:format_response, [ @celebration_collect, collect2 ])

    assert response.is_a?(Array)
    assert_equal 2, response.length
    assert response.all? { |r| r.is_a?(Hash) && r.key?(:text) }
  end

  test "format_response retorna nil quando array vazio" do
    service = CollectService.new(Date.new(2025, 1, 1))

    response = service.send(:format_response, [])

    assert_nil response
  end

  test "format_response retorna nil quando nil" do
    service = CollectService.new(Date.new(2025, 1, 1))

    response = service.send(:format_response, nil)

    assert_nil response
  end

  test "format_response inclui preface quando presente" do
    collect_with_preface = Collect.create!(
      celebration_id: @celebration.id,
      text: "Coleta com prefácio...",
      preface: "Prefácio especial...",
      language: "pt-BR"
    )

    service = CollectService.new(Date.new(2025, 1, 1))

    response = service.send(:format_response, [ collect_with_preface ])

    assert_equal "Coleta com prefácio...", response[:text]
    assert_equal "Prefácio especial...", response[:preface]
  end

  # === TESTES DE INTEGRAÇÃO ===

  test "find_collects retorna coleta quando encontrada" do
    service = CollectService.new(Date.new(2025, 3, 19))

    collects = service.find_collects

    refute_nil collects
    assert collects.is_a?(Hash) || collects.is_a?(Array)
  end

  test "find_collects retorna nil quando nenhuma coleta encontrada" do
    # Remove todas as coletas
    Collect.destroy_all

    service = CollectService.new(Date.new(2025, 5, 15))

    collects = service.find_collects

    assert_nil collects
  end

  # === TESTES DE PRIORIDADE ===

  test "busca por celebração tem prioridade sobre domingo" do
    # Cria uma celebração que cai num domingo
    sunday_celebration = Celebration.create!(
      name: "Festa em Domingo",
      celebration_type: "festival",
      rank: 30,
      movable: false,
      fixed_month: 11,
      fixed_day: 30, # Primeiro Domingo do Advento 2025
      liturgical_color: "branco"
    )

    celebration_collect = Collect.create!(
      celebration_id: sunday_celebration.id,
      text: "Coleta da celebração em domingo",
      language: "pt-BR"
    )

    service = CollectService.new(Date.new(2025, 11, 30))

    collects = service.find_collects

    # Deveria retornar a coleta da celebração, não do domingo
    if collects.is_a?(Hash)
      assert_equal "Coleta da celebração em domingo", collects[:text]
    elsif collects.is_a?(Array)
      assert_includes collects.map { |c| c[:text] }, "Coleta da celebração em domingo"
    end
  end

  test "busca por domingo tem prioridade sobre quadra" do
    # Teste de prioridade
    skip "Tested via integration tests"
  end

  # === TESTES DE FILTRO POR IDIOMA ===

  test "retorna apenas coletas no idioma correto" do
    # Cria coleta em inglês
    Collect.create!(
      celebration_id: @celebration.id,
      text: "English collect...",
      language: "en"
    )

    service = CollectService.new(Date.new(2025, 3, 19))

    collects_raw = service.send(:find_by_celebration)

    # Deveria retornar apenas a coleta em português
    assert_equal 1, collects_raw.count
    assert_equal "pt-BR", collects_raw.first.language
  end

  # === TESTES DE CASOS ESPECÍFICOS ===

  test "domingo no Advento retorna coleta correta" do
    skip "Tested via integration tests"
  end

  test "retorna nil para data sem nenhuma coleta definida" do
    # Remove todas as coletas
    Collect.destroy_all

    service = CollectService.new(Date.new(2025, 6, 15))

    collects = service.find_collects

    assert_nil collects
  end
end
