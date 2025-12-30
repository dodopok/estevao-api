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

    SUNDAY_NAMES = {
      "Domingo da Páscoa" => "Easter Sunday",
      "Pentecostes" => "Pentecost",
      "Santíssima Trindade" => "Trinity Sunday",
      "Domingo de Ramos" => "Palm Sunday",
      "Cristo Rei do Universo" => "Christ the King",
      "1º Domingo do Advento" => "1st Sunday of Advent",
      "2º Domingo do Advento" => "2nd Sunday of Advent",
      "3º Domingo do Advento" => "3rd Sunday of Advent",
      "4º Domingo do Advento" => "4th Sunday of Advent",
      "Batismo de nosso Senhor Jesus Cristo" => "Baptism of our Lord",
      "1º Domingo após Natal" => "1st Sunday after Christmas",
      "2º Domingo após Natal" => "2nd Sunday after Christmas"
    }.freeze

    class << self
      def season(season_pt)
        SEASONS[season_pt] || season_pt
      end

      def color(color_pt)
        COLORS[color_pt] || color_pt
      end

      def sunday_name(name_pt)
        return name_pt unless name_pt

        # Try exact match
        return SUNDAY_NAMES[name_pt] if SUNDAY_NAMES.key?(name_pt)

        # Try regex for numbered Sundays
        # "#{week}º Domingo #{preposition} #{season}"
        match = name_pt.match(/(\d+)º Domingo (do|no|da|na|após) (.+)/)
        if match
          number = match[1].to_i
          preposition = match[2]
          season_pt = match[3]
          
          ordinal = case number
                    when 1 then "1st"
                    when 2 then "2nd"
                    when 3 then "3rd"
                    else "#{number}th"
                    end
          
          prep = case preposition
                 when "no", "na" then "in"
                 when "após" then "after"
                 else "of"
                 end
          
          translated_season = SEASONS[season_pt] || season_pt
          "#{ordinal} Sunday #{prep} #{translated_season}"
        else
          name_pt
        end
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
      alias_method :translate_sunday_name, :sunday_name
      alias_method :day_name_br, :day_name_pt
    end
  end
end
