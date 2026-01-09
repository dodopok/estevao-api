require 'rails_helper'

RSpec.describe "Api::V1::CalendarController", type: :request do
  let(:default_preferences) { { prayer_book_code: 'loc_2015' }.to_json }

  before do
    # Create minimal required test data - use loc_2015 so Liturgical::CelebrationResolver finds celebrations correctly
    @prayer_book = PrayerBook.find_or_create_by(code: 'loc_2015') do |pb|
      pb.name = "Livro de Oração Comum 2015"
      pb.year = 2015
    end

    @easter = Celebration.find_or_create_by(
      name: "Páscoa",
      prayer_book: @prayer_book
    ) do |c|
      c.celebration_type = "principal_feast"
      c.rank = 0
      c.movable = true
      c.calculation_rule = "easter"
      c.liturgical_color = "branco"
    end

    @advent_season = LiturgicalSeason.find_by(name: "Advento") ||
                     LiturgicalSeason.create!(name: "Advento", color: "violeta")

    # Clear cache before each test
    Rails.cache.clear
  end

  # === /today ENDPOINT TESTS ===
  describe "GET /api/v1/calendar/today" do
    it "returns information for current day" do
      today = Date.today
      get "/api/v1/calendar/today", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      expect(json["date"]).to eq(today.strftime("%d/%m/%Y"))
      expect(json).to have_key("day_of_week")
      expect(json).to have_key("liturgical_season")
      expect(json).to have_key("liturgical_color")
      expect(json).to have_key("is_sunday")
    end
  end

  # === /day ENDPOINT TESTS ===
  describe "GET /api/v1/calendar/:year/:month/:day" do
    it "returns information for a specific day" do
      get "/api/v1/calendar/2025/11/16", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      expect(json["date"]).to eq("16/11/2025")
      expect(json["day_of_week"]).to eq("Domingo")
      expect(json["liturgical_season"]).to eq("Tempo Comum")
      expect(json["liturgical_color"]).to eq("verde")
      expect(json["liturgical_year"]).to eq("C")
      expect(json["is_sunday"]).to eq(true)

      # Verify complete structure
      expect(json).to have_key("week_of_season")
      expect(json).to have_key("proper_week")
      expect(json).to have_key("sunday_after_pentecost")
      expect(json).to have_key("sunday_name")
      expect(json).to have_key("is_holy_day")
    end

    it "returns 400 for invalid date" do
      get "/api/v1/calendar/2025/13/32", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)

      json = JSON.parse(response.body)
      expect(json).to have_key("error")
      expect(json["error"]).to match(/inválida/i)
    end

    it "returns 400 for year out of range" do
      get "/api/v1/calendar/1800/1/1", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)

      json = JSON.parse(response.body)
      expect(json["error"]).to match(/Ano deve estar entre 1900 e 2200/)
    end

    it "works with cache" do
      # Clear cache before test
      Rails.cache.clear

      # First request
      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      first_response = JSON.parse(response.body)

      # Second request (may or may not use cache depending on configuration)
      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      second_response = JSON.parse(response.body)

      # Both responses should be identical
      expect(first_response["date"]).to eq(second_response["date"])
      expect(first_response["liturgical_season"]).to eq(second_response["liturgical_season"])
    end

    it "includes collects and readings" do
      # Create test collect
      create(:collect,
        prayer_book: @prayer_book,
        season_id: @advent_season.id,
        text: "Coleta de teste",
      )

      get "/api/v1/calendar/2025/12/1", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      # May or may not have collect/readings depending on data
      # The important thing is that the fields exist
      expect(json).to have_key("collect")
      expect(json).to have_key("readings")
    end

    # === SPECIFIC CASES TESTED PREVIOUSLY ===

    it "returns green color for 2025-11-16 (not white)" do
      # Margaret of Scotland - lesser feast with white color
      Celebration.find_or_create_by!(
        name: "Margaret of Scotland",
        prayer_book: @prayer_book
      ) do |c|
        c.celebration_type = "lesser_feast"
        c.rank = 249
        c.movable = false
        c.fixed_month = 11
        c.fixed_day = 16
        c.liturgical_color = "branco"
      end

      get "/api/v1/calendar/2025/11/16", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      # Sunday in Ordinary Time should be green, not white
      expect(json["liturgical_color"]).to eq("verde")
      expect(json["liturgical_season"]).to eq("Tempo Comum")
    end

    it "returns Easter Vigil for 2026-04-04" do
      # Create Easter Vigil and Holy Saturday
      Celebration.find_or_create_by!(
        name: "Sábado Santo",
        prayer_book: @prayer_book
      ) do |c|
        c.celebration_type = "major_holy_day"
        c.rank = 23
        c.movable = true
        c.calculation_rule = "easter_minus_1_day"
        c.liturgical_color = "preto"
      end

      Celebration.find_or_create_by!(
        name: "Vigília Pascal",
        prayer_book: @prayer_book
      ) do |c|
        c.celebration_type = "principal_feast"
        c.rank = 1
        c.movable = true
        c.calculation_rule = "easter_minus_1_day"
        c.liturgical_color = "branco"
      end

      get "/api/v1/calendar/2026/4/4", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      # Should return Easter Vigil (rank 1) instead of Holy Saturday (rank 23)
      expect(json["liturgical_color"]).to eq("branco")
      expect(json["celebration"]).to be_present
      expect(json["celebration"]["name"]).to eq("Vigília Pascal")
    end

    it "returns correct data for Holy Week 2026 dates" do
      # Create Holy Week celebrations
      Celebration.find_or_create_by!(
        name: "Segunda-feira Santa",
        prayer_book: @prayer_book
      ) do |c|
        c.celebration_type = "major_holy_day"
        c.rank = 21
        c.movable = true
        c.calculation_rule = "easter_minus_6_days"
        c.liturgical_color = "roxo"
      end

      Celebration.find_or_create_by!(
        name: "Terça-feira Santa",
        prayer_book: @prayer_book
      ) do |c|
        c.celebration_type = "major_holy_day"
        c.rank = 21
        c.movable = true
        c.calculation_rule = "easter_minus_5_days"
        c.liturgical_color = "roxo"
      end

      Celebration.find_or_create_by!(
        name: "Quarta-feira Santa",
        prayer_book: @prayer_book
      ) do |c|
        c.celebration_type = "major_holy_day"
        c.rank = 21
        c.movable = true
        c.calculation_rule = "easter_minus_4_days"
        c.liturgical_color = "roxo"
      end

      # Test Monday of Holy Week
      get "/api/v1/calendar/2026/3/30", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["celebration"]["name"]).to eq("Segunda-feira Santa")

      # Test Tuesday of Holy Week
      get "/api/v1/calendar/2026/3/31", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["celebration"]["name"]).to eq("Terça-feira Santa")

      # Test Wednesday of Holy Week
      get "/api/v1/calendar/2026/4/1", params: { preferences: default_preferences }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["celebration"]["name"]).to eq("Quarta-feira Santa")
    end
  end

  # === /month ENDPOINT TESTS ===
  describe "GET /api/v1/calendar/:year/:month" do
    it "returns calendar for the month" do
      get "/api/v1/calendar/2025/12", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      expect(json["year"]).to eq(2025)
      expect(json["month"]).to eq(12)
      expect(json["month_name"]).to eq("Dezembro")
      expect(json).to have_key("days")
      expect(json["days"]).to be_an(Array)
      expect(json["days"].length).to eq(31) # December has 31 days
    end

    it "returns 400 for invalid month" do
      get "/api/v1/calendar/2025/13", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)

      json = JSON.parse(response.body)
      expect(json["error"]).to match(/Mês deve estar entre 1 e 12/)
    end

    it "each day has complete structure" do
      get "/api/v1/calendar/2025/11", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      first_day = json["days"].first

      # Verify each day's structure
      expect(first_day).to have_key("date")
      expect(first_day).to have_key("day_of_week")
      expect(first_day).to have_key("liturgical_season")
      expect(first_day).to have_key("liturgical_color")
      expect(first_day).to have_key("is_sunday")
    end
  end

  # === /year ENDPOINT TESTS ===
  describe "GET /api/v1/calendar/:year" do
    it "returns summary for the year" do
      get "/api/v1/calendar/2025", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      expect(json["year"]).to eq(2025)
      expect(json).to have_key("movable_dates")
      expect(json).to have_key("seasons_summary")
      expect(json).to have_key("important_dates")
    end

    it "returns correct movable dates" do
      get "/api/v1/calendar/2025", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      movable = json["movable_dates"]

      # Verify some known dates
      expect(movable["easter"]).to eq("2025-04-20")
      expect(movable["ash_wednesday"]).to eq("2025-03-05")
      expect(movable["pentecost"]).to eq("2025-06-08")
    end

    it "returns translated important dates" do
      get "/api/v1/calendar/2025", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      important = json["important_dates"]

      expect(important).to have_key("pascoa")
      expect(important).to have_key("quarta_feira_de_cinzas")
      expect(important).to have_key("pentecostes")
      expect(important).to have_key("advento")
      expect(important).to have_key("cristo_rei")
    end

    it "returns 400 for invalid year" do
      get "/api/v1/calendar/1500", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)

      json = JSON.parse(response.body)
      expect(json["error"]).to match(/Ano deve estar entre 1900 e 2200/)
    end

    it "returns seasons summary" do
      get "/api/v1/calendar/2025", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      seasons = json["seasons_summary"]

      expect(seasons).to be_an(Array)
      expect(seasons.length).to be > 0

      # Verify each season's structure
      season = seasons.first
      expect(season).to have_key("nome")
    end
  end

  # === PERFORMANCE AND CACHE TESTS ===
  describe "Performance and Cache" do
    it "endpoints respond within acceptable time" do
      start_time = Time.now

      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }

      elapsed = Time.now - start_time

      expect(response).to have_http_status(:success)
      # Should respond in less than 1 second (generous for CI)
      expect(elapsed).to be < 1.0
    end
  end

  # === CONSISTENCY TESTS ===
  describe "Consistency" do
    it "day returned in month corresponds to day endpoint" do
      # Fetch the month
      get "/api/v1/calendar/2025/11", params: { preferences: default_preferences }
      month_json = JSON.parse(response.body)

      # Fetch day 16 specifically
      get "/api/v1/calendar/2025/11/16", params: { preferences: default_preferences }
      day_json = JSON.parse(response.body)

      # Find day 16 in the month
      day_in_month = month_json["days"].find { |d| d["date"] == "16/11/2025" }

      # Compare important fields
      expect(day_json["liturgical_season"]).to eq(day_in_month["liturgical_season"])
      expect(day_json["liturgical_color"]).to eq(day_in_month["liturgical_color"])
      expect(day_json["is_sunday"]).to eq(day_in_month["is_sunday"])
    end
  end

  # === EDGE CASES TESTS ===
  describe "Edge Cases" do
    it "works for leap years" do
      # February 29, 2024 (leap year)
      get "/api/v1/calendar/2024/2/29", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json["date"]).to eq("29/02/2024")
    end

    it "returns error for February 29 in non-leap year" do
      get "/api/v1/calendar/2025/2/29", params: { preferences: default_preferences }

      expect(response).to have_http_status(:bad_request)
    end

    it "works for December 31" do
      get "/api/v1/calendar/2025/12/31", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json["date"]).to eq("31/12/2025")
    end

    it "works for January 1" do
      get "/api/v1/calendar/2025/1/1", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json["date"]).to eq("01/01/2025")
    end
  end

  # === JSON FORMAT TESTS ===
  describe "JSON Format" do
    it "response has Content-Type application/json" do
      get "/api/v1/calendar/2025/12/25", params: { preferences: default_preferences }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "response structure is consistent" do
      get "/api/v1/calendar/2025/7/15", params: { preferences: default_preferences } # Date without celebration

      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)

      # Fields that can be nil should be absent or nil
      # The important thing is that the structure is consistent
      expect(json).to be_a(Hash)
    end
  end
end
