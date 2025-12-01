# frozen_string_literal: true

module Liturgical
  # Service responsible for translating liturgical terms between languages
  # Supports Portuguese (pt-BR) and English (en) translations
  class Translator
    SEASONS = {
      "Advento" => "Advent",
      "Natal" => "Christmas",
      "Epifania" => "Epiphany",
      "Quaresma" => "Lent",
      "Páscoa" => "Easter",
      "Tempo Comum" => "Ordinary Time"
    }.freeze

    COLORS = {
      "branco" => "white",
      "vermelho" => "red",
      "roxo" => "purple",
      "violeta" => "violet",
      "rosa" => "rose",
      "verde" => "green",
      "preto" => "black"
    }.freeze

    DAY_NAMES_EN = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze
    DAY_NAMES_PT = %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado].freeze

    class << self
      def season(season_pt)
        SEASONS[season_pt] || season_pt
      end

      def color(color_pt)
        COLORS[color_pt] || color_pt
      end

      def day_name_en(date)
        DAY_NAMES_EN[date.wday]
      end

      def day_name_pt(date)
        DAY_NAMES_PT[date.wday]
      end

      # Aliases for backward compatibility
      alias_method :translate_season, :season
      alias_method :translate_color, :color
      alias_method :day_name_br, :day_name_pt
    end
  end
end
