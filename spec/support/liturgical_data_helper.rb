# frozen_string_literal: true

module LiturgicalDataHelper
  # Cria os dados litúrgicos básicos necessários para a maioria dos testes
  # Isso inclui: cores litúrgicas, quadras litúrgicas, e prayer book padrão
  def setup_liturgical_foundation
    # Cores litúrgicas
    @white = LiturgicalColor.find_or_create_by!(name: "branco") do |color|
      color.hex_code = "#FFFFFF"
    end

    @red = LiturgicalColor.find_or_create_by!(name: "vermelho") do |color|
      color.hex_code = "#DC143C"
    end

    @purple = LiturgicalColor.find_or_create_by!(name: "roxo") do |color|
      color.hex_code = "#800080"
    end

    @violet = LiturgicalColor.find_or_create_by!(name: "violeta") do |color|
      color.hex_code = "#8B00FF"
    end

    @green = LiturgicalColor.find_or_create_by!(name: "verde") do |color|
      color.hex_code = "#228B22"
    end

    @rose = LiturgicalColor.find_or_create_by!(name: "rosa") do |color|
      color.hex_code = "#FFB6C1"
    end

    @black = LiturgicalColor.find_or_create_by!(name: "preto") do |color|
      color.hex_code = "#000000"
    end

    @blue = LiturgicalColor.find_or_create_by!(name: "azul_escuro") do |color|
      color.hex_code = "#00008B"
    end

    @off_white = LiturgicalColor.find_or_create_by!(name: "pano_cru") do |color|
      color.hex_code = "#F5F5DC"
    end

    # Quadras litúrgicas
    @advent = LiturgicalSeason.find_by(name: "Advento") ||
              LiturgicalSeason.create!(name: "Advento", color: "violeta")

    @christmas = LiturgicalSeason.find_by(name: "Natal") ||
                 LiturgicalSeason.create!(name: "Natal", color: "branco")

    @epiphany = LiturgicalSeason.find_by(name: "Epifania") ||
                LiturgicalSeason.create!(name: "Epifania", color: "verde")

    @lent = LiturgicalSeason.find_by(name: "Quaresma") ||
            LiturgicalSeason.create!(name: "Quaresma", color: "roxo")

    @easter = LiturgicalSeason.find_by(name: "Páscoa") ||
              LiturgicalSeason.create!(name: "Páscoa", color: "branco")

    @ordinary_time = LiturgicalSeason.find_by(name: "Tempo Comum") ||
                     LiturgicalSeason.create!(name: "Tempo Comum", color: "verde")

    # Prayer Books
    @loc_2015 = PrayerBook.find_or_create_by!(code: "loc_2015") do |pb|
      pb.name = "Livro de Oração Comum - IEAB - 2015"
      pb.year = 2015
      pb.is_recommended = true
      pb.features = {
        "lectionary" => {
          "reading_types" => [ "semicontinuous", "complementary" ],
          "default_reading_type" => "semicontinuous",
          "supports_vigil" => false
        },
        "daily_office" => {
          "supports_family_rite" => true
        },
        "psalter" => {}
      }
    end

    @loc_2019 = PrayerBook.find_or_create_by!(code: "loc_2019") do |pb|
      pb.name = "Livro de Oração Comum - IEAB - 2019"
      pb.year = 2019
      pb.is_recommended = false
      pb.features = {
        "lectionary" => {
          "reading_types" => [ "semicontinuous", "complementary" ],
          "default_reading_type" => "semicontinuous",
          "supports_vigil" => false
        },
        "daily_office" => {
          "supports_family_rite" => true
        },
        "psalter" => {}
      }
    end

    # Prayer book that doesn't support family rite (for testing)
    @loc_1987 = PrayerBook.find_or_create_by!(code: "loc_1987") do |pb|
      pb.name = "Livro de Oração Comum - 1987"
      pb.year = 1987
      pb.is_recommended = false
      pb.features = {
        "lectionary" => {
          "reading_types" => [ "semicontinuous" ],
          "default_reading_type" => "semicontinuous",
          "supports_vigil" => false
        },
        "daily_office" => {
          "supports_family_rite" => false
        },
        "psalter" => {}
      }
    end
  end

  # Cria celebrações básicas necessárias para testes
  def setup_basic_celebrations(prayer_book = nil)
    pb = prayer_book || @loc_2015 || PrayerBook.find_by(code: "loc_2015")

    @easter_celebration = Celebration.find_or_create_by!(
      name: "Páscoa",
      prayer_book: pb
    ) do |c|
      c.celebration_type = "principal_feast"
      c.rank = 0
      c.movable = true
      c.calculation_rule = "easter"
      c.liturgical_color = "branco"
    end

    @christmas_celebration = Celebration.find_or_create_by!(
      name: "Natividade de nosso Senhor Jesus Cristo",
      prayer_book: pb
    ) do |c|
      c.celebration_type = "principal_feast"
      c.rank = 1
      c.movable = false
      c.fixed_month = 12
      c.fixed_day = 25
      c.liturgical_color = "branco"
    end

    @ash_wednesday = Celebration.find_or_create_by!(
      name: "Quarta-Feira de Cinzas",
      prayer_book: pb
    ) do |c|
      c.celebration_type = "major_holy_day"
      c.rank = 22
      c.movable = true
      c.calculation_rule = "easter_minus_46_days"
      c.liturgical_color = "roxo"
    end
  end

  # Cria textos litúrgicos básicos para o Ofício Diário
  # Carrega os seeds reais para garantir que todos os textos necessários existam
  def setup_liturgical_texts(prayer_book = nil)
    pb = prayer_book || @loc_2015 || PrayerBook.find_by(code: "loc_2015")
    return unless pb

    # Se já existem textos litúrgicos suficientes, pula o carregamento
    return if LiturgicalText.where(prayer_book: pb).count > 100

    # Carrega os seeds reais dos textos litúrgicos
    seed_path = Rails.root.join("db/seeds/prayer_books/loc_2015/data/liturgical_texts.rb")
    if File.exist?(seed_path)
      load seed_path
    end
  end

  # Cria salmos básicos para testes
  # Carrega os seeds reais para garantir que todos os salmos e ciclos existam
  def setup_basic_psalms(prayer_book = nil)
    pb = prayer_book || @loc_2015 || PrayerBook.find_by(code: "loc_2015")
    return unless pb

    # Se já existem salmos suficientes, pula o carregamento
    return if Psalm.where(prayer_book: pb).count >= 150

    # Carrega os seeds reais dos salmos
    psalms_path = Rails.root.join("db/seeds/prayer_books/loc_2015/data/psalms.rb")
    if File.exist?(psalms_path)
      load psalms_path
    end

    # Carrega os ciclos de salmos
    cycles_path = Rails.root.join("db/seeds/prayer_books/loc_2015/data/psalm_cycles.rb")
    if File.exist?(cycles_path)
      load cycles_path
    end
  end

  # Setup completo para testes de integração
  def setup_full_liturgical_data
    setup_liturgical_foundation
    setup_basic_celebrations
    setup_liturgical_texts
    setup_basic_psalms
  end
end

# Incluir automaticamente em todos os testes de request
RSpec.configure do |config|
  config.include LiturgicalDataHelper, type: :request
  config.include LiturgicalDataHelper, type: :service
end
