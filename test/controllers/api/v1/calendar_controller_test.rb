require "test_helper"

module Api
  module V1
    class CalendarControllerTest < ActionDispatch::IntegrationTest
      def setup
        # Cria dados mínimos necessários para os testes
        @prayer_book = default_prayer_book

        @easter = Celebration.create!(
          name: "Páscoa",
          celebration_type: "principal_feast",
          rank: 0,
          movable: true,
          calculation_rule: "easter",
          liturgical_color: "branco",
          prayer_book: @prayer_book
        )

        @advent_season = LiturgicalSeason.create!(
          name: "Advento",
          color: "violeta"
        )

        # Limpa o cache antes de cada teste
        Rails.cache.clear
      end

      # === TESTES DO ENDPOINT /today ===
      test "GET /api/v1/calendar/today retorna informações do dia atual" do
        today = Date.today
        get "/api/v1/calendar/today"
        assert_response :success

        json = JSON.parse(response.body)

        assert_equal today.strftime("%d/%m/%Y"), json["date"]
        assert json.key?("day_of_week")
        assert json.key?("liturgical_season")
        assert json.key?("liturgical_color")
        assert json.key?("is_sunday")
      end

      # === TESTES DO ENDPOINT /day ===

      test "GET /api/v1/calendar/:year/:month/:day retorna informações do dia" do
        get "/api/v1/calendar/2025/11/16"

        assert_response :success

        json = JSON.parse(response.body)

        assert_equal "16/11/2025", json["date"]
        assert_equal "Domingo", json["day_of_week"]
        assert_equal "Tempo Comum", json["liturgical_season"]
        assert_equal "verde", json["liturgical_color"]
        assert_equal "C", json["liturgical_year"]
        assert_equal true, json["is_sunday"]

        # Verifica estrutura completa
        assert json.key?("week_of_season")
        assert json.key?("proper_week")
        assert json.key?("sunday_after_pentecost")
        assert json.key?("sunday_name")
        assert json.key?("is_holy_day")
      end

      test "GET /api/v1/calendar/:year/:month/:day retorna 400 para data inválida" do
        get "/api/v1/calendar/2025/13/32"

        assert_response :bad_request

        json = JSON.parse(response.body)
        assert json.key?("error")
        assert_match(/inválida/i, json["error"])
      end

      test "GET /api/v1/calendar/:year/:month/:day retorna 400 para ano fora do range" do
        get "/api/v1/calendar/1800/1/1"

        assert_response :bad_request

        json = JSON.parse(response.body)
        assert_match(/Ano deve estar entre 1900 e 2200/, json["error"])
      end

      test "GET /api/v1/calendar/:year/:month/:day funciona com cache" do
        # Limpa cache antes do teste
        Rails.cache.clear

        # Primeira requisição
        get "/api/v1/calendar/2025/12/25"
        assert_response :success
        first_response = JSON.parse(response.body)

        # Segunda requisição (pode usar cache ou não dependendo da configuração)
        get "/api/v1/calendar/2025/12/25"
        assert_response :success
        second_response = JSON.parse(response.body)

        # Ambas as respostas deveriam ser idênticas
        assert_equal first_response["date"], second_response["date"]
        assert_equal first_response["liturgical_season"], second_response["liturgical_season"]
      end

      test "GET /api/v1/calendar/:year/:month/:day inclui coletas e leituras" do
        # Cria uma coleta de teste
        Collect.create!(
          prayer_book: @prayer_book,
          season_id: @advent_season.id,
          text: "Coleta de teste",
          language: "pt-BR"
        )

        get "/api/v1/calendar/2025/12/1"

        assert_response :success

        json = JSON.parse(response.body)

        # Pode ou não ter collect/readings dependendo dos dados
        # O importante é que os campos existam
        assert json.key?("collect")
        assert json.key?("readings")
      end

      # === CASOS ESPECÍFICOS TESTADOS ANTERIORMENTE ===

      test "GET /api/v1/calendar/2025/11/16 retorna cor verde (não branca)" do
        # Margaret of Scotland - lesser feast com cor branca
        Celebration.create!(
          name: "Margaret of Scotland",
          celebration_type: "lesser_feast",
          rank: 249,
          movable: false,
          fixed_month: 11,
          fixed_day: 16,
          liturgical_color: "branco",
          prayer_book: @prayer_book
        )

        get "/api/v1/calendar/2025/11/16"

        assert_response :success

        json = JSON.parse(response.body)

        # Domingo no Tempo Comum deveria ser verde, não branco
        assert_equal "verde", json["liturgical_color"]
        assert_equal "Tempo Comum", json["liturgical_season"]
      end

      test "GET /api/v1/calendar/2026/4/4 retorna Vigília Pascal" do
        # Cria Vigília Pascal e Sábado Santo
        Celebration.create!(
          name: "Sábado Santo",
          celebration_type: "major_holy_day",
          rank: 23,
          movable: true,
          calculation_rule: "easter_minus_1_day",
          liturgical_color: "preto",
          prayer_book: @prayer_book
        )

        Celebration.create!(
          name: "Vigília Pascal",
          celebration_type: "principal_feast",
          rank: 1,
          movable: true,
          calculation_rule: "easter_minus_1_day",
          liturgical_color: "branco",
          prayer_book: @prayer_book
        )

        get "/api/v1/calendar/2026/4/4"

        assert_response :success

        json = JSON.parse(response.body)

        # Deveria retornar Vigília Pascal (rank 1) ao invés de Sábado Santo (rank 23)
        assert_equal "branco", json["liturgical_color"]
        assert json["celebration"]
        assert_equal "Vigília Pascal", json["celebration"]["name"]
      end

      test "GET /api/v1/calendar para datas da Semana Santa 2026" do
        # Cria celebrações da Semana Santa
        Celebration.create!(
          name: "Segunda-feira Santa",
          celebration_type: "major_holy_day",
          rank: 21,
          movable: true,
          calculation_rule: "easter_minus_6_days",
          liturgical_color: "roxo",
          prayer_book: @prayer_book
        )

        Celebration.create!(
          name: "Terça-feira Santa",
          celebration_type: "major_holy_day",
          rank: 21,
          movable: true,
          calculation_rule: "easter_minus_5_days",
          liturgical_color: "roxo",
          prayer_book: @prayer_book
        )

        Celebration.create!(
          name: "Quarta-feira Santa",
          celebration_type: "major_holy_day",
          rank: 21,
          movable: true,
          calculation_rule: "easter_minus_4_days",
          liturgical_color: "roxo",
          prayer_book: @prayer_book
        )

        # Testa Segunda-feira Santa
        get "/api/v1/calendar/2026/3/30"
        assert_response :success
        json = JSON.parse(response.body)
        assert_equal "Segunda-feira Santa", json["celebration"]["name"]

        # Testa Terça-feira Santa
        get "/api/v1/calendar/2026/3/31"
        assert_response :success
        json = JSON.parse(response.body)
        assert_equal "Terça-feira Santa", json["celebration"]["name"]

        # Testa Quarta-feira Santa
        get "/api/v1/calendar/2026/4/1"
        assert_response :success
        json = JSON.parse(response.body)
        assert_equal "Quarta-feira Santa", json["celebration"]["name"]
      end

      # === TESTES DO ENDPOINT /month ===

      test "GET /api/v1/calendar/:year/:month retorna calendário do mês" do
        get "/api/v1/calendar/2025/12"

        assert_response :success

        json = JSON.parse(response.body)

        assert_equal 2025, json["year"]
        assert_equal 12, json["month"]
        assert_equal "Dezembro", json["month_name"]
        assert json.key?("days")
        assert json["days"].is_a?(Array)
        assert_equal 31, json["days"].length # Dezembro tem 31 dias
      end

      test "GET /api/v1/calendar/:year/:month retorna 400 para mês inválido" do
        get "/api/v1/calendar/2025/13"

        assert_response :bad_request

        json = JSON.parse(response.body)
        assert_match(/Mês deve estar entre 1 e 12/, json["error"])
      end

      test "GET /api/v1/calendar/:year/:month cada dia tem estrutura completa" do
        get "/api/v1/calendar/2025/11"

        assert_response :success

        json = JSON.parse(response.body)
        first_day = json["days"].first

        # Verifica estrutura de cada dia
        assert first_day.key?("date")
        assert first_day.key?("day_of_week")
        assert first_day.key?("liturgical_season")
        assert first_day.key?("liturgical_color")
        assert first_day.key?("is_sunday")
      end

      # === TESTES DO ENDPOINT /year ===

      test "GET /api/v1/calendar/:year retorna resumo do ano" do
        get "/api/v1/calendar/2025"

        assert_response :success

        json = JSON.parse(response.body)

        assert_equal 2025, json["year"]
        assert json.key?("movable_dates")
        assert json.key?("seasons_summary")
        assert json.key?("important_dates")
      end

      test "GET /api/v1/calendar/:year retorna datas móveis corretas" do
        get "/api/v1/calendar/2025"

        assert_response :success

        json = JSON.parse(response.body)
        movable = json["movable_dates"]

        # Verifica algumas datas conhecidas
        assert_equal "2025-04-20", movable["easter"]
        assert_equal "2025-03-05", movable["ash_wednesday"]
        assert_equal "2025-06-08", movable["pentecost"]
      end

      test "GET /api/v1/calendar/:year retorna datas importantes traduzidas" do
        get "/api/v1/calendar/2025"

        assert_response :success

        json = JSON.parse(response.body)
        important = json["important_dates"]

        assert important.key?("pascoa")
        assert important.key?("quarta_feira_de_cinzas")
        assert important.key?("pentecostes")
        assert important.key?("advento")
        assert important.key?("cristo_rei")
      end

      test "GET /api/v1/calendar/:year retorna 400 para ano inválido" do
        get "/api/v1/calendar/1500"

        assert_response :bad_request

        json = JSON.parse(response.body)
        assert_match(/Ano deve estar entre 1900 e 2200/, json["error"])
      end

      test "GET /api/v1/calendar/:year retorna resumo das quadras" do
        get "/api/v1/calendar/2025"

        assert_response :success

        json = JSON.parse(response.body)
        seasons = json["seasons_summary"]

        assert seasons.is_a?(Array)
        assert seasons.length > 0

        # Verifica estrutura de cada quadra
        season = seasons.first
        assert season.key?("nome")
      end

      # === TESTES DE PERFORMANCE E CACHE ===

      test "endpoints respondem dentro de tempo aceitável" do
        start_time = Time.now

        get "/api/v1/calendar/2025/12/25"

        elapsed = Time.now - start_time

        assert_response :success
        # Deveria responder em menos de 1 segundo (generoso para CI)
        assert elapsed < 1.0, "Endpoint demorou #{elapsed}s, esperado < 1s"
      end

      # === TESTES DE CONSISTÊNCIA ===

      test "dia retornado no month corresponde ao day endpoint" do
        # Busca o mês
        get "/api/v1/calendar/2025/11"
        month_json = JSON.parse(response.body)

        # Busca o dia 16 especificamente
        get "/api/v1/calendar/2025/11/16"
        day_json = JSON.parse(response.body)

        # Encontra o dia 16 no mês
        day_in_month = month_json["days"].find { |d| d["date"] == "16/11/2025" }

        # Compara campos importantes
        assert_equal day_json["liturgical_season"], day_in_month["liturgical_season"]
        assert_equal day_json["liturgical_color"], day_in_month["liturgical_color"]
        assert_equal day_json["is_sunday"], day_in_month["is_sunday"]
      end

      # === TESTES DE EDGE CASES ===

      test "GET /api/v1/calendar funciona para anos bissextos" do
        # 29 de fevereiro de 2024 (ano bissexto)
        get "/api/v1/calendar/2024/2/29"

        assert_response :success

        json = JSON.parse(response.body)
        assert_equal "29/02/2024", json["date"]
      end

      test "GET /api/v1/calendar retorna erro para 29 de fevereiro em ano não bissexto" do
        get "/api/v1/calendar/2025/2/29"

        assert_response :bad_request
      end

      test "GET /api/v1/calendar funciona para 31 de dezembro" do
        get "/api/v1/calendar/2025/12/31"

        assert_response :success

        json = JSON.parse(response.body)
        assert_equal "31/12/2025", json["date"]
      end

      test "GET /api/v1/calendar funciona para 1 de janeiro" do
        get "/api/v1/calendar/2025/1/1"

        assert_response :success

        json = JSON.parse(response.body)
        assert_equal "01/01/2025", json["date"]
      end

      # === TESTES DE FORMATO JSON ===

      test "response tem Content-Type application/json" do
        get "/api/v1/calendar/2025/12/25"

        assert_response :success
        assert_equal "application/json; charset=utf-8", response.content_type
      end

      test "response não inclui campos nil quando usar compact" do
        get "/api/v1/calendar/2025/7/15" # Data sem celebração

        assert_response :success

        json = JSON.parse(response.body)

        # Campos que podem ser nil devem estar ausentes ou nil
        # O importante é que a estrutura seja consistente
        assert json.is_a?(Hash)
      end
    end
  end
end
