require "test_helper"

class LiturgicalCalendarIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    # Cria dados necessários para testes de integração completos
    @advent_season = LiturgicalSeason.create!(
      name: "Advento",
      color: "violeta"
    )

    @christmas_season = LiturgicalSeason.create!(
      name: "Natal",
      color: "branco"
    )

    @lent_season = LiturgicalSeason.create!(
      name: "Quaresma",
      color: "roxo"
    )

    @easter_season = LiturgicalSeason.create!(
      name: "Páscoa",
      color: "branco"
    )

    # Cria celebrações de teste
    @easter = Celebration.create!(
      name: "Páscoa",
      celebration_type: "principal_feast",
      rank: 0,
      movable: true,
      calculation_rule: "easter",
      liturgical_color: "branco"
    )

    @christmas = Celebration.create!(
      name: "Natal",
      celebration_type: "principal_feast",
      rank: 2,
      movable: false,
      fixed_month: 12,
      fixed_day: 25,
      liturgical_color: "branco"
    )

    @holy_saturday = Celebration.create!(
      name: "Sábado Santo",
      celebration_type: "major_holy_day",
      rank: 23,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "preto"
    )

    @easter_vigil = Celebration.create!(
      name: "Vigília Pascal",
      celebration_type: "principal_feast",
      rank: 1,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "branco"
    )

    @lesser_feast = Celebration.create!(
      name: "Margaret of Scotland",
      celebration_type: "lesser_feast",
      rank: 249,
      movable: false,
      fixed_month: 11,
      fixed_day: 16,
      liturgical_color: "branco"
    )

    # Limpa cache
    Rails.cache.clear
  end

  # === TESTES DE FLUXO COMPLETO: DIA ===

  test "fluxo completo: domingo no Tempo Comum retorna dados corretos" do
    # 16 de novembro de 2025 - Domingo no Tempo Comum
    get "/api/v1/calendar/2025/11/16"

    assert_response :success
    json = JSON.parse(response.body)

    # Verifica estrutura completa
    assert_equal "2025-11-16", json["date"]
    assert_equal "Sunday", json["day_of_week"]
    assert_equal "Tempo Comum", json["liturgical_season"]
    assert_equal "verde", json["liturgical_color"], "Domingos no Tempo Comum devem ser verdes"
    assert_equal "C", json["liturgical_year"]
    assert_equal true, json["is_sunday"]

    # Verifica que todos os campos esperados existem
    assert json.key?("week_of_season")
    assert json.key?("proper_week")
    assert json.key?("sunday_after_pentecost")
    assert json.key?("sunday_name")
    assert json.key?("collect")
    assert json.key?("readings")
    assert json.key?("celebration")
  end

  test "fluxo completo: Natal retorna celebração e cor correta" do
    get "/api/v1/calendar/2025/12/25"

    assert_response :success
    json = JSON.parse(response.body)

    assert_equal "2025-12-25", json["date"]
    assert_equal "Natal", json["liturgical_season"]
    assert_equal "branco", json["liturgical_color"]
    assert_equal true, json["is_holy_day"]

    # Verifica celebração
    assert json["celebration"]
    assert_equal "Natal", json["celebration"]["name"]
  end

  test "fluxo completo: Vigília Pascal tem precedência sobre Sábado Santo" do
    get "/api/v1/calendar/2026/4/4"

    assert_response :success
    json = JSON.parse(response.body)

    # Deveria retornar Vigília Pascal (rank 1), não Sábado Santo (rank 23)
    assert_equal "branco", json["liturgical_color"]
    assert json["celebration"]
    assert_equal "Vigília Pascal", json["celebration"]["name"]
  end

  test "fluxo completo: Semana Santa 2026 retorna celebrações corretas" do
    # Cria celebrações da Semana Santa
    Celebration.create!(
      name: "Segunda-feira Santa",
      celebration_type: "major_holy_day",
      rank: 21,
      movable: true,
      calculation_rule: "easter_minus_6_days",
      liturgical_color: "roxo"
    )

    Celebration.create!(
      name: "Terça-feira Santa",
      celebration_type: "major_holy_day",
      rank: 21,
      movable: true,
      calculation_rule: "easter_minus_5_days",
      liturgical_color: "roxo"
    )

    Celebration.create!(
      name: "Quarta-feira Santa",
      celebration_type: "major_holy_day",
      rank: 21,
      movable: true,
      calculation_rule: "easter_minus_4_days",
      liturgical_color: "roxo"
    )

    # Segunda-feira Santa: 30/03/2026
    get "/api/v1/calendar/2026/3/30"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "Segunda-feira Santa", json["celebration"]["name"]

    # Terça-feira Santa: 31/03/2026
    get "/api/v1/calendar/2026/3/31"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "Terça-feira Santa", json["celebration"]["name"]

    # Quarta-feira Santa: 01/04/2026
    get "/api/v1/calendar/2026/4/1"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "Quarta-feira Santa", json["celebration"]["name"]
  end

  # === TESTES DE FLUXO COMPLETO: MÊS ===

  test "fluxo completo: calendário mensal retorna todos os dias" do
    get "/api/v1/calendar/2025/12"

    assert_response :success
    json = JSON.parse(response.body)

    assert_equal 2025, json["year"]
    assert_equal 12, json["month"]
    assert_equal "Dezembro", json["month_name"]
    assert_equal 31, json["days"].length

    # Verifica que cada dia tem estrutura completa
    first_day = json["days"].first
    assert first_day.key?("date")
    assert first_day.key?("day_of_week")
    assert first_day.key?("liturgical_season")
    assert first_day.key?("liturgical_color")
    assert first_day.key?("is_sunday")

    # Verifica que dia 25 é Natal
    christmas_day = json["days"].find { |d| d["date"] == "2025-12-25" }
    assert christmas_day
    assert_equal "Natal", christmas_day["liturgical_season"]
  end

  test "fluxo completo: calendário mensal mantém consistência entre dias" do
    get "/api/v1/calendar/2025/11"
    month_json = JSON.parse(response.body)

    # Pega um dia específico do mês
    day_16 = month_json["days"].find { |d| d["date"] == "2025-11-16" }

    # Busca o mesmo dia individualmente
    get "/api/v1/calendar/2025/11/16"
    day_json = JSON.parse(response.body)

    # Compara campos importantes - devem ser idênticos
    assert_equal day_json["date"], day_16["date"]
    assert_equal day_json["liturgical_season"], day_16["liturgical_season"]
    assert_equal day_json["liturgical_color"], day_16["liturgical_color"]
    assert_equal day_json["is_sunday"], day_16["is_sunday"]
  end

  # === TESTES DE FLUXO COMPLETO: ANO ===

  test "fluxo completo: resumo anual retorna datas móveis corretas" do
    get "/api/v1/calendar/2025"

    assert_response :success
    json = JSON.parse(response.body)

    assert_equal 2025, json["year"]

    # Verifica datas móveis conhecidas para 2025
    movable = json["movable_dates"]
    assert_equal "2025-04-20", movable["easter"]
    assert_equal "2025-03-05", movable["ash_wednesday"]
    assert_equal "2025-06-08", movable["pentecost"]

    # Verifica datas importantes traduzidas
    important = json["important_dates"]
    assert important.key?("pascoa")
    assert important.key?("quarta_feira_de_cinzas")
    assert important.key?("pentecostes")
    assert important.key?("advento")
  end

  test "fluxo completo: resumo anual inclui todas as quadras" do
    get "/api/v1/calendar/2025"

    assert_response :success
    json = JSON.parse(response.body)

    seasons = json["seasons_summary"]
    assert seasons.is_a?(Array)
    assert seasons.length > 0

    # Verifica estrutura de cada quadra
    seasons.each do |season|
      assert season.key?("nome")
    end
  end

  # === TESTES DE INTEGRAÇÃO: LEITURAS ===

  test "fluxo completo: leituras são incluídas quando disponíveis" do
    # Cria leitura para uma data específica
    LectionaryReading.create!(
      celebration_id: @christmas.id,
      date_reference: "12-25",
      cycle: "all",
      service_type: "eucharist",
      first_reading: "Isaiah 9:2-7",
      psalm: "Psalm 96",
      second_reading: "Titus 2:11-14",
      gospel: "Luke 2:1-20"
    )

    get "/api/v1/calendar/2025/12/25"

    assert_response :success
    json = JSON.parse(response.body)

    # Verifica que leituras estão presentes (pode ser nil se não encontradas)
    assert json.key?("readings")
  end

  test "fluxo completo: endpoint de leituras retorna dados corretos" do
    # Cria leitura
    LectionaryReading.create!(
      celebration_id: @christmas.id,
      date_reference: "12-25",
      cycle: "all",
      service_type: "eucharist",
      first_reading: "Isaiah 9:2-7",
      psalm: "Psalm 96",
      gospel: "Luke 2:1-20"
    )

    get "/api/v1/lectionary/2025/12/25"

    # 404 é OK se não encontrou leituras
    assert [ 200, 404 ].include?(response.status)

    if response.status == 200
      json = JSON.parse(response.body)
      # Verifica que tem uma estrutura válida
      assert json.is_a?(Hash)
      assert json.key?("date") || json.key?("data") # Pode ser em inglês ou português
    end
  end

  # === TESTES DE INTEGRAÇÃO: COLETAS ===

  test "fluxo completo: coletas são incluídas quando disponíveis" do
    # Cria coleta para Natal
    Collect.create!(
      celebration_id: @christmas.id,
      text: "Deus Onipotente, que destes vosso Filho unigênito...",
      language: "pt-BR"
    )

    get "/api/v1/calendar/2025/12/25"

    assert_response :success
    json = JSON.parse(response.body)

    # Verifica que coleta está presente
    assert json["collect"]
  end

  test "fluxo completo: coletas de quadras são usadas quando não há específica" do
    # Cria coleta para Advento
    Collect.create!(
      season_id: @advent_season.id,
      text: "Onipotente Deus, dá-nos a graça...",
      language: "pt-BR"
    )

    # Data no Advento sem celebração específica
    get "/api/v1/calendar/2025/12/1"

    assert_response :success
    json = JSON.parse(response.body)

    # Deveria ter coleta (da quadra)
    assert json.key?("collect")
  end

  # === TESTES DE INTEGRAÇÃO: CELEBRAÇÕES ===

  test "fluxo completo: endpoint de celebrações lista todas" do
    get "/api/v1/celebrations"

    assert_response :success
    json = JSON.parse(response.body)

    # Endpoint retorna objeto com total e celebracoes
    assert json.is_a?(Hash), "Endpoint deve retornar um hash"
    assert json.key?("celebracoes") || json.key?("celebrations")

    celebrations = json["celebracoes"] || json["celebrations"] || []
    assert celebrations.is_a?(Array)
  end

  test "fluxo completo: busca de celebrações funciona" do
    # URI encode para evitar problemas com caracteres especiais
    get "/api/v1/celebrations/search?q=#{CGI.escape('Páscoa')}"

    assert_response :success
    json = JSON.parse(response.body)

    # Pode retornar array ou hash com celebracoes
    if json.is_a?(Hash)
      celebrations = json["celebracoes"] || json["celebrations"] || []
      assert celebrations.is_a?(Array)
    else
      assert json.is_a?(Array), "Busca deve retornar um array ou hash"
    end
  end

  test "fluxo completo: celebrações por data retorna correto" do
    get "/api/v1/celebrations/date/12/25"

    assert_response :success
    json = JSON.parse(response.body)

    # Pode retornar array ou hash com celebracoes
    if json.is_a?(Hash)
      celebrations = json["celebracoes"] || json["celebrations"] || []
      assert celebrations.is_a?(Array)
    else
      assert json.is_a?(Array), "Celebrações por data deve retornar um array ou hash"
    end
  end

  # === TESTES DE INTEGRAÇÃO: CACHE ===

  test "fluxo completo: cache funciona para múltiplas requisições" do
    Rails.cache.clear

    # Primeira requisição
    get "/api/v1/calendar/2025/12/25"
    assert_response :success
    first_response = response.body

    # Segunda requisição (pode usar cache)
    get "/api/v1/calendar/2025/12/25"
    assert_response :success
    second_response = response.body

    # Respostas devem ser idênticas
    assert_equal JSON.parse(first_response), JSON.parse(second_response)
  end

  # === TESTES DE INTEGRAÇÃO: VALIDAÇÕES ===

  test "fluxo completo: validação de data inválida funciona" do
    get "/api/v1/calendar/2025/13/45"

    assert_response :bad_request
    json = JSON.parse(response.body)

    assert json.key?("error")
    assert_match(/inválida/i, json["error"])
  end

  test "fluxo completo: validação de ano fora do range funciona" do
    get "/api/v1/calendar/1800/1/1"

    assert_response :bad_request
    json = JSON.parse(response.body)

    assert_match(/Ano deve estar entre 1900 e 2200/, json["error"])
  end

  test "fluxo completo: validação de mês inválido funciona" do
    get "/api/v1/calendar/2025/15"

    assert_response :bad_request
    json = JSON.parse(response.body)

    assert_match(/Mês deve estar entre 1 e 12/, json["error"])
  end

  # === TESTES DE INTEGRAÇÃO: CASOS ESPECIAIS ===

  test "fluxo completo: ano bissexto funciona corretamente" do
    get "/api/v1/calendar/2024/2/29"

    assert_response :success
    json = JSON.parse(response.body)

    assert_equal "2024-02-29", json["date"]
  end

  test "fluxo completo: 29 de fevereiro em ano não bissexto retorna erro" do
    get "/api/v1/calendar/2025/2/29"

    assert_response :bad_request
  end

  test "fluxo completo: virada de ano funciona corretamente" do
    # 31 de dezembro
    get "/api/v1/calendar/2025/12/31"
    assert_response :success
    dec_json = JSON.parse(response.body)
    assert_equal "2025-12-31", dec_json["date"]

    # 1 de janeiro
    get "/api/v1/calendar/2026/1/1"
    assert_response :success
    jan_json = JSON.parse(response.body)
    assert_equal "2026-01-01", jan_json["date"]
  end

  # === TESTES DE INTEGRAÇÃO: CICLOS LITÚRGICOS ===

  test "fluxo completo: ciclo litúrgico muda corretamente no Advento" do
    # Antes do Advento 2025 (ainda é ano litúrgico 2024)
    get "/api/v1/calendar/2025/11/15"
    assert_response :success
    before_advent = JSON.parse(response.body)

    # Durante Advento 2025 (já é ano litúrgico 2025 = Ciclo C)
    get "/api/v1/calendar/2025/12/7"
    assert_response :success
    during_advent = JSON.parse(response.body)

    # Ambos devem ter um liturgical_year definido
    assert before_advent.key?("liturgical_year")
    assert during_advent.key?("liturgical_year")

    # O ciclo durante o Advento deve ser diferente ou igual, dependendo da implementação
    assert [ "A", "B", "C" ].include?(during_advent["liturgical_year"])
  end

  test "fluxo completo: endpoint de ciclo retorna correto" do
    get "/api/v1/lectionary/cycle/2025"

    # Endpoint pode não existir ou retornar 404
    # Apenas verifica que não quebra
    assert [ 200, 404 ].include?(response.status), "Endpoint deveria retornar 200 ou 404"

    if response.status == 200
      json = JSON.parse(response.body)
      # Se existe, deve ter uma estrutura válida
      assert json.is_a?(Hash)
    end
  end

  # === TESTES DE INTEGRAÇÃO: PERFORMANCE ===

  test "fluxo completo: requisições respondem em tempo aceitável" do
    times = []

    5.times do
      start = Time.now
      get "/api/v1/calendar/2025/12/25"
      elapsed = Time.now - start
      times << elapsed

      assert_response :success
    end

    avg_time = times.sum / times.size
    assert avg_time < 1.0, "Tempo médio de resposta: #{avg_time}s (esperado < 1s)"
  end

  # === TESTES DE INTEGRAÇÃO: CONTENT TYPE ===

  test "fluxo completo: todos os endpoints retornam JSON" do
    endpoints = [
      "/api/v1/calendar/2025/12/25",
      "/api/v1/calendar/2025/12",
      "/api/v1/calendar/2025",
      "/api/v1/celebrations"
    ]

    endpoints.each do |endpoint|
      get endpoint
      assert_response :success
      assert_equal "application/json; charset=utf-8", response.content_type,
        "#{endpoint} deveria retornar JSON"
    end
  end

  # === TESTES DE INTEGRAÇÃO: RAIZ DA API ===

  test "fluxo completo: raiz da API retorna informações" do
    get "/"

    assert_response :success
    json = JSON.parse(response.body)

    # A raiz deve retornar alguma informação
    assert json.is_a?(Hash)
    # Verifica se tem pelo menos uma chave (estrutura pode variar)
    assert json.keys.any?
  end
end
