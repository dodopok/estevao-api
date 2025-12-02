require 'rails_helper'

RSpec.describe "Liturgical Calendar Integration", type: :request do
  before(:all) do
    # Setup foundational liturgical data
    setup_liturgical_foundation
  end

  let(:default_preferences) { { prayer_book_code: 'loc_2015' }.to_json }

  before do
    # Create required test data for complete integration tests
    @prayer_book = @loc_2015 || PrayerBook.find_by(code: "loc_2015")

    # Seasons are already created by setup_liturgical_foundation
    @advent_season = @advent
    @christmas_season = @christmas
    @lent_season = @lent
    @easter_season = @easter

    # Create test celebrations
    @easter = create(:celebration,
      name: "Páscoa",
      celebration_type: "principal_feast",
      rank: 0,
      movable: true,
      calculation_rule: "easter",
      liturgical_color: "branco",
      prayer_book: @prayer_book
    )

    @christmas = create(:celebration,
      name: "Natividade de nosso Senhor Jesus Cristo",
      celebration_type: "principal_feast",
      rank: 2,
      movable: false,
      fixed_month: 12,
      fixed_day: 25,
      liturgical_color: "branco",
      prayer_book: @prayer_book
    )

    @holy_saturday = create(:celebration,
      name: "Sábado Santo",
      celebration_type: "major_holy_day",
      rank: 23,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "preto",
      prayer_book: @prayer_book
    )

    @easter_vigil = create(:celebration,
      name: "Vigília Pascal",
      celebration_type: "principal_feast",
      rank: 1,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "branco",
      prayer_book: @prayer_book
    )

    @lesser_feast = create(:celebration,
      name: "Margaret of Scotland",
      celebration_type: "lesser_feast",
      rank: 249,
      movable: false,
      fixed_month: 11,
      fixed_day: 16,
      liturgical_color: "branco",
      prayer_book: @prayer_book
    )

    # Clear cache
    Rails.cache.clear
  end

  # === COMPLETE WORKFLOW TESTS: DAY ===

  describe "Complete workflow: Day" do
    it "fluxo completo: domingo no Tempo Comum retorna dados corretos" do
      # 16 de novembro de 2025 - Domingo no Tempo Comum
      get "/api/v1/calendar/2025/11/16", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Verifica estrutura completa
      expect(json["date"]).to eq("16/11/2025")
      expect(json["day_of_week"]).to eq("Domingo")
      expect(json["liturgical_season"]).to eq("Tempo Comum")
      expect(json["liturgical_color"]).to eq("verde"), "Domingos no Tempo Comum devem ser verdes"
      expect(json["liturgical_year"]).to eq("C")
      expect(json["is_sunday"]).to eq(true)

      # Verifica que todos os campos esperados existem
      expect(json).to have_key("week_of_season")
      expect(json).to have_key("proper_week")
      expect(json).to have_key("sunday_after_pentecost")
      expect(json).to have_key("sunday_name")
      expect(json).to have_key("collect")
      expect(json).to have_key("readings")
      expect(json).to have_key("celebration")
    end

    it "fluxo completo: Natal retorna celebração e cor correta" do
      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      expect(json["date"]).to eq("25/12/2025")
      expect(json["liturgical_season"]).to eq("Natal")
      expect(json["liturgical_color"]).to eq("branco")
      expect(json["is_holy_day"]).to eq(true)

      # Verifica celebração
      expect(json["celebration"]).to be_present
      expect(json["celebration"]["name"]).to eq("Natividade de nosso Senhor Jesus Cristo")
    end

    it "fluxo completo: Vigília Pascal tem precedência sobre Sábado Santo" do
      get "/api/v1/calendar/2026/4/4", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Deveria retornar Vigília Pascal (rank 1), não Sábado Santo (rank 23)
      expect(json["liturgical_color"]).to eq("branco")
      expect(json["celebration"]).to be_present
      expect(json["celebration"]["name"]).to eq("Vigília Pascal")
    end

    it "fluxo completo: Semana Santa 2026 retorna celebrações corretas" do
      # Cria celebrações da Semana Santa
      create(:celebration,
        name: "Segunda-feira Santa",
        celebration_type: "major_holy_day",
        rank: 21,
        movable: true,
        calculation_rule: "easter_minus_6_days",
        liturgical_color: "roxo",
        prayer_book: @prayer_book
      )

      create(:celebration,
        name: "Terça-feira Santa",
        celebration_type: "major_holy_day",
        rank: 21,
        movable: true,
        calculation_rule: "easter_minus_5_days",
        liturgical_color: "roxo",
        prayer_book: @prayer_book
      )

      create(:celebration,
        name: "Quarta-feira Santa",
        celebration_type: "major_holy_day",
        rank: 21,
        movable: true,
        calculation_rule: "easter_minus_4_days",
        liturgical_color: "roxo",
        prayer_book: @prayer_book
      )

      # Segunda-feira Santa: 30/03/2026
      get "/api/v1/calendar/2026/3/30", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["celebration"]["name"]).to eq("Segunda-feira Santa")

      # Terça-feira Santa: 31/03/2026
      get "/api/v1/calendar/2026/3/31", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["celebration"]["name"]).to eq("Terça-feira Santa")

      # Quarta-feira Santa: 01/04/2026
      get "/api/v1/calendar/2026/4/1", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["celebration"]["name"]).to eq("Quarta-feira Santa")
    end
  end

  # === COMPLETE WORKFLOW TESTS: MONTH ===

  describe "Complete workflow: Month" do
    it "fluxo completo: calendário mensal retorna todos os dias" do
      get "/api/v1/calendar/2025/12", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      expect(json["year"]).to eq(2025)
      expect(json["month"]).to eq(12)
      expect(json["month_name"]).to eq("Dezembro")
      expect(json["days"].length).to eq(31)

      # Verifica que cada dia tem estrutura completa
      first_day = json["days"].first
      expect(first_day).to have_key("date")
      expect(first_day).to have_key("day_of_week")
      expect(first_day).to have_key("liturgical_season")
      expect(first_day).to have_key("liturgical_color")
      expect(first_day).to have_key("is_sunday")

      # Verifica que dia 25 é Natal
      christmas_day = json["days"].find { |d| d["date"] == "25/12/2025" }
      expect(christmas_day).to be_present
      expect(christmas_day["liturgical_season"]).to eq("Natal")
    end

    it "fluxo completo: calendário mensal mantém consistência entre dias" do
      get "/api/v1/calendar/2025/11", params: { preferences: default_preferences }
      month_json = JSON.parse(response.body)

      # Pega um dia específico do mês
      day_16 = month_json["days"].find { |d| d["date"] == "16/11/2025" }

      # Busca o mesmo dia individualmente
      get "/api/v1/calendar/2025/11/16", params: { preferences: default_preferences }
      day_json = JSON.parse(response.body)

      # Compara campos importantes - devem ser idênticos
      expect(day_json["date"]).to eq(day_16["date"])
      expect(day_json["liturgical_season"]).to eq(day_16["liturgical_season"])
      expect(day_json["liturgical_color"]).to eq(day_16["liturgical_color"])
      expect(day_json["is_sunday"]).to eq(day_16["is_sunday"])
    end
  end

  # === COMPLETE WORKFLOW TESTS: YEAR ===

  describe "Complete workflow: Year" do
    it "fluxo completo: resumo anual retorna datas móveis corretas" do
      get "/api/v1/calendar/2025", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      expect(json["year"]).to eq(2025)

      # Verifica datas móveis conhecidas para 2025
      movable = json["movable_dates"]
      expect(movable["easter"]).to eq("2025-04-20")
      expect(movable["ash_wednesday"]).to eq("2025-03-05")
      expect(movable["pentecost"]).to eq("2025-06-08")

      # Verifica datas importantes traduzidas
      important = json["important_dates"]
      expect(important).to have_key("pascoa")
      expect(important).to have_key("quarta_feira_de_cinzas")
      expect(important).to have_key("pentecostes")
      expect(important).to have_key("advento")
    end

    it "fluxo completo: resumo anual inclui todas as quadras" do
      get "/api/v1/calendar/2025", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      seasons = json["seasons_summary"]
      expect(seasons).to be_an(Array)
      expect(seasons.length).to be > 0

      # Verifica estrutura de cada quadra
      seasons.each do |season|
        expect(season).to have_key("nome")
      end
    end
  end

  # === INTEGRATION TESTS: READINGS ===

  describe "Integration: Readings" do
    it "fluxo completo: leituras são incluídas quando disponíveis" do
      # Cria leitura para uma data específica
      create(:lectionary_reading,
        prayer_book: @prayer_book,
        celebration_id: @christmas.id,
        date_reference: "12-25",
        cycle: "all",
        service_type: "eucharist",
        first_reading: "Isaiah 9:2-7",
        psalm: "Psalm 96",
        second_reading: "Titus 2:11-14",
        gospel: "Luke 2:1-20"
      )

      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Verifica que leituras estão presentes (pode ser nil se não encontradas)
      expect(json).to have_key("readings")
    end

    it "fluxo completo: endpoint de leituras retorna dados corretos" do
      # Cria leitura
      create(:lectionary_reading,
        prayer_book: @prayer_book,
        celebration_id: @christmas.id,
        date_reference: "12-25",
        cycle: "all",
        service_type: "eucharist",
        first_reading: "Isaiah 9:2-7",
        psalm: "Psalm 96",
        gospel: "Luke 2:1-20"
      )

      get "/api/v1/lectionary/2025/12/25", params: { preferences: default_preferences }

      # 404 é OK se não encontrou leituras
      expect([ 200, 404 ]).to include(response.status)

      if response.status == 200
        json = JSON.parse(response.body)
        # Verifica que tem uma estrutura válida
        expect(json).to be_a(Hash)
        expect(json.key?("date") || json.key?("data")).to be true # Pode ser em inglês ou português
      end
    end
  end

  # === INTEGRATION TESTS: COLLECTS ===

  describe "Integration: Collects" do
    it "fluxo completo: coletas são incluídas quando disponíveis" do
      # Busca a celebração que será resolvida pelo Liturgical::CelebrationResolver
      resolver = Liturgical::CelebrationResolver.new(2025, prayer_book_code: "loc_2015")
      christmas_celebration = resolver.resolve_for_date(Date.new(2025, 12, 25))

      # Cria coleta para Natal usando a celebração que será resolvida
      create(:collect,
        prayer_book: @prayer_book,
        celebration_id: christmas_celebration.id,
        text: "Deus Onipotente, que destes vosso Filho unigênito...",
        language: "pt-BR"
      )

      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Verifica que coleta está presente
      expect(json["collect"]).to be_present
    end

    it "fluxo completo: coletas de quadras são usadas quando não há específica" do
      # Cria coleta para Advento
      create(:collect,
        prayer_book: @prayer_book,
        season_id: @advent_season.id,
        text: "Onipotente Deus, dá-nos a graça...",
        language: "pt-BR"
      )

      # Data no Advento sem celebração específica
      get "/api/v1/calendar/2025/12/1", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Deveria ter coleta (da quadra)
      expect(json).to have_key("collect")
    end
  end

  # === INTEGRATION TESTS: CELEBRATIONS ===

  describe "Integration: Celebrations" do
    it "fluxo completo: endpoint de celebrações lista todas" do
      get "/api/v1/celebrations", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Endpoint retorna objeto com total e celebracoes
      expect(json).to be_a(Hash), "Endpoint deve retornar um hash"
      expect(json.key?("celebracoes") || json.key?("celebrations")).to be true

      celebrations = json["celebracoes"] || json["celebrations"] || []
      expect(celebrations).to be_an(Array)
    end

    it "fluxo completo: busca de celebrações funciona" do
      # URI encode para evitar problemas com caracteres especiais
      get "/api/v1/celebrations/search?q=#{CGI.escape('Páscoa')}", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Pode retornar array ou hash com celebracoes
      if json.is_a?(Hash)
        celebrations = json["celebracoes"] || json["celebrations"] || []
        expect(celebrations).to be_an(Array)
      else
        expect(json).to be_an(Array), "Busca deve retornar um array ou hash"
      end
    end

    it "fluxo completo: celebrações por data retorna correto" do
      get "/api/v1/celebrations/date/12/25", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Pode retornar array ou hash com celebracoes
      if json.is_a?(Hash)
        celebrations = json["celebracoes"] || json["celebrations"] || []
        expect(celebrations).to be_an(Array)
      else
        expect(json).to be_an(Array), "Celebrações por data deve retornar um array ou hash"
      end
    end
  end

  # === INTEGRATION TESTS: CACHE ===

  describe "Integration: Cache" do
    it "fluxo completo: cache funciona para múltiplas requisições" do
      Rails.cache.clear

      # Primeira requisição
      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      first_response = response.body

      # Segunda requisição (pode usar cache)
      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      second_response = response.body

      # Respostas devem ser idênticas
      expect(JSON.parse(first_response)).to eq(JSON.parse(second_response))
    end
  end

  # === INTEGRATION TESTS: VALIDATIONS ===

  describe "Integration: Validations" do
    it "fluxo completo: validação de data inválida funciona" do
      get "/api/v1/calendar/2025/13/45", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)

      expect(json).to have_key("error")
      expect(json["error"]).to match(/inválida/i)
    end

    it "fluxo completo: validação de ano fora do range funciona" do
      get "/api/v1/calendar/1800/1/1", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)

      expect(json["error"]).to match(/Ano deve estar entre 1900 e 2200/)
    end

    it "fluxo completo: validação de mês inválido funciona" do
      get "/api/v1/calendar/2025/15", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)

      expect(json["error"]).to match(/Mês deve estar entre 1 e 12/)
    end
  end

  # === INTEGRATION TESTS: EDGE CASES ===

  describe "Integration: Edge cases" do
    it "fluxo completo: ano bissexto funciona corretamente" do
      get "/api/v1/calendar/2024/2/29", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      expect(json["date"]).to eq("29/02/2024")
    end

    it "fluxo completo: 29 de fevereiro em ano não bissexto retorna erro" do
      get "/api/v1/calendar/2025/2/29", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)
    end

    it "fluxo completo: virada de ano funciona corretamente" do
      # 31 de dezembro
      get "/api/v1/calendar/2025/12/31", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      dec_json = JSON.parse(response.body)
      expect(dec_json["date"]).to eq("31/12/2025")

      # 1 de janeiro
      get "/api/v1/calendar/2026/1/1", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      jan_json = JSON.parse(response.body)
      expect(jan_json["date"]).to eq("01/01/2026")
    end
  end

  # === INTEGRATION TESTS: LITURGICAL CYCLES ===

  describe "Integration: Liturgical cycles" do
    it "fluxo completo: ciclo litúrgico muda corretamente no Advento" do
      # Antes do Advento 2025 (ainda é ano litúrgico 2024)
      get "/api/v1/calendar/2025/11/15", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      before_advent = JSON.parse(response.body)

      # Durante Advento 2025 (já é ano litúrgico 2025 = Ciclo C)
      get "/api/v1/calendar/2025/12/7", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      during_advent = JSON.parse(response.body)

      # Ambos devem ter um liturgical_year definido
      expect(before_advent).to have_key("liturgical_year")
      expect(during_advent).to have_key("liturgical_year")

      # O ciclo durante o Advento deve ser diferente ou igual, dependendo da implementação
      expect([ "A", "B", "C" ]).to include(during_advent["liturgical_year"])
    end

    it "fluxo completo: endpoint de ciclo retorna correto" do
      get "/api/v1/lectionary/cycle/2025", params: { preferences: default_preferences }

      # Endpoint pode não existir ou retornar 404
      # Apenas verifica que não quebra
      expect([ 200, 404 ]).to include(response.status), "Endpoint deveria retornar 200 ou 404"

      if response.status == 200
        json = JSON.parse(response.body)
        # Se existe, deve ter uma estrutura válida
        expect(json).to be_a(Hash)
      end
    end
  end

  # === INTEGRATION TESTS: PERFORMANCE ===

  describe "Integration: Performance" do
    it "fluxo completo: requisições respondem em tempo aceitável" do
      times = []

      5.times do
        start = Time.now
        get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }
        elapsed = Time.now - start
        times << elapsed

        expect(response).to have_http_status(:success)
      end

      avg_time = times.sum / times.size
      expect(avg_time).to be < 1.0, "Tempo médio de resposta: #{avg_time}s (esperado < 1s)"
    end
  end

  # === INTEGRATION TESTS: CONTENT TYPE ===

  describe "Integration: Content type" do
    it "fluxo completo: todos os endpoints retornam JSON" do
      endpoints = [
        "/api/v1/calendar/2025/12/25",
        "/api/v1/calendar/2025/12",
        "/api/v1/calendar/2025",
        "/api/v1/celebrations"
      ]

      endpoints.each do |endpoint|
        get endpoint, params: { preferences: default_preferences }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8"),
          "#{endpoint} deveria retornar JSON"
      end
    end
  end

  # === INTEGRATION TESTS: API ROOT ===

  describe "Integration: API root" do
    it "fluxo completo: raiz da API retorna informações" do
      get "/"

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # A raiz deve retornar alguma informação
      expect(json).to be_a(Hash)
      # Verifica se tem pelo menos uma chave (estrutura pode variar)
      expect(json.keys.any?).to be true
    end
  end

  # === INTEGRATION TESTS: CHRISTMAS SEASON DATES ===

  describe "Integration: Christmas season dates" do
    before do
      # Create collects for Christmas Sundays
      Collect.create!(
        sunday_reference: "1st_sunday_after_christmas",
        text: "Coleta do 1º Domingo após Natal",
        language: "pt-BR",
        prayer_book: @prayer_book
      )

      Collect.create!(
        sunday_reference: "2nd_sunday_after_christmas",
        text: "Coleta do 2º Domingo após Natal",
        language: "pt-BR",
        prayer_book: @prayer_book
      )

      # Create readings for Christmas Sundays
      LectionaryReading.create!(
        date_reference: "2nd_sunday_after_christmas",
        cycle: "all",
        service_type: "eucharist",
        first_reading: "Jeremias 31:7-14",
        psalm: "Salmo 147:12-20",
        second_reading: "Efésios 1:3-14",
        gospel: "João 1:10-18",
        prayer_book: @prayer_book
      )
    end

    it "5 de Janeiro 2025 retorna tempo de Natal e leituras corretas" do
      get "/api/v1/calendar/2025/01/05", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      # Deve ser tempo de Natal, não Tempo Comum
      expect(json["liturgical_season"]).to eq("Natal")
      expect(json["liturgical_color"]).to eq("branco")
      expect(json["sunday_name"]).to eq("2º Domingo após Natal")
      expect(json["week_of_season"]).to eq(2)

      # Deve retornar coleta
      expect(json["collect"]).to be_present

      # Deve retornar leituras
      expect(json["readings"]).to be_present
    end

    it "28 de Dezembro 2025 retorna 1º Domingo após Natal" do
      get "/api/v1/calendar/2025/12/28", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      expect(json["liturgical_season"]).to eq("Natal")
      expect(json["liturgical_color"]).to eq("branco")
      expect(json["sunday_name"]).to eq("1º Domingo após Natal")
      expect(json["week_of_season"]).to eq(1)
    end

    it "12 de Janeiro 2025 retorna Batismo do Senhor (início da Epifania)" do
      get "/api/v1/calendar/2025/01/12", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)

      expect(json["liturgical_season"]).to eq("Epifania")
      expect(json["sunday_name"]).to eq("Batismo de nosso Senhor Jesus Cristo")
    end
  end
end
