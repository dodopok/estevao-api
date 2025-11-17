# Helper para mapear nomes de domingos em português para referências do banco de dados
# Exemplo: "1º Domingo do Advento" -> "1st_sunday_of_advent"
class SundayReferenceMapper
  # Mapa de domingos especiais (português -> inglês)
  SPECIAL_SUNDAYS = {
    "Cristo Rei do Universo" => "christ_the_king",
    "Domingo da Páscoa" => "easter_sunday",
    "Pentecostes" => "pentecost",
    "Santíssima Trindade" => "trinity_sunday",
    "Domingo de Ramos" => "palm_sunday",
    "Batismo de nosso Senhor Jesus Cristo" => "baptism_of_the_lord"
  }.freeze

  # Tradução de quadras litúrgicas (português -> inglês)
  SEASON_TRANSLATIONS = {
    "Advento" => "advent",
    "Natal" => "christmas",
    "Epifania" => "epiphany",
    "Quaresma" => "lent",
    "Páscoa" => "easter",
    "Tempo Comum" => "ordinary_time"
  }.freeze

  class << self
    # Mapeia o nome do domingo em português para a referência do banco
    def map(date, calendar)
      sunday_name = calendar.sunday_name(date)
      return nil unless sunday_name

      # Verificar se é um domingo especial
      return SPECIAL_SUNDAYS[sunday_name] if SPECIAL_SUNDAYS.key?(sunday_name)

      # Converter domingos numerados
      parse_numbered_sunday(sunday_name)
    end

    private

    # Converte domingos numerados para formato de referência
    # "1º Domingo do Advento" -> "1st_sunday_of_advent"
    # "4º Domingo na Quaresma" -> "4th_sunday_in_lent"
    def parse_numbered_sunday(sunday_name)
      match = sunday_name.match(/(\d+)º Domingo (do|no|da|na) (.+)/)
      return sunday_name.parameterize(separator: "_") unless match

      number = match[1].to_i
      preposition = match[2]
      season = match[3]

      ordinal = to_ordinal(number)
      prep = translate_preposition(preposition)
      translated_season = translate_season(season)

      "#{ordinal}_sunday_#{prep}_#{translated_season}"
    end

    # Converte número para ordinal em inglês
    def to_ordinal(number)
      case number
      when 1 then "1st"
      when 2 then "2nd"
      when 3 then "3rd"
      else "#{number}th"
      end
    end

    # Traduz preposição de português para inglês
    def translate_preposition(preposition)
      (preposition == "no" || preposition == "na") ? "in" : "of"
    end

    # Traduz nome da quadra para inglês
    def translate_season(season)
      SEASON_TRANSLATIONS[season] || season.parameterize(separator: "_")
    end
  end
end
