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

  # Mapa de domingos após Natal (usam "after" em vez de "of")
  CHRISTMAS_SUNDAYS = {
    "1º Domingo após Natal" => "1st_sunday_after_christmas",
    "2º Domingo após Natal" => "2nd_sunday_after_christmas"
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

  # Mapa de apelidos para referências do banco (nome base -> lista de possíveis referências)
  REFERENCE_ALIASES = {
    "pentecost" => %w[pentecost_day pentecost whitsunday],
    "easter_sunday" => %w[easter_sunday easter_day easter],
    "trinity_sunday" => %w[trinity_sunday trinity],
    "baptism_of_the_lord" => %w[baptism_of_the_lord baptism_of_christ 1st_sunday_after_epiphany],
    "christ_the_king" => %w[christ_the_king sunday_before_advent],
    "7th_sunday_of_easter" => %w[7th_sunday_of_easter sunday_after_ascension]
  }.freeze

  class << self
    # Mapeia o nome do domingo em português para a referência do banco
    def map(date, calendar)
      sunday_name = calendar.sunday_name(date)
      return nil unless sunday_name

      # Verificar se é um domingo especial
      return SPECIAL_SUNDAYS[sunday_name] if SPECIAL_SUNDAYS.key?(sunday_name)

      # Verificar se é um domingo após Natal
      return CHRISTMAS_SUNDAYS[sunday_name] if CHRISTMAS_SUNDAYS.key?(sunday_name)

      # Verificar se é o último domingo após Epifania (Transfiguração)
      if is_last_sunday_after_epiphany?(date, calendar)
        return "last_sunday_after_epiphany"
      end

      # Converter domingos numerados
      parse_numbered_sunday(sunday_name)
    end

    # Retorna todas as referências possíveis para um domingo (incluindo apelidos)
    def map_with_aliases(date, calendar)
      primary_ref = map(date, calendar)
      return [] unless primary_ref

      aliases = REFERENCE_ALIASES[primary_ref]
      aliases ? aliases : [ primary_ref ]
    end

    # Verifica se a data é o último domingo após Epifania
    def is_last_sunday_after_epiphany?(date, calendar)
      return false unless date.sunday?
      return false unless calendar.season_for_date(date) == "Epifania"

      # O último domingo da Epifania é o domingo antes da Quarta-feira de Cinzas
      easter_calc = calendar.easter_calc
      date == easter_calc.last_sunday_after_epiphany
    end

    private

    # Converte domingos numerados para formato de referência
    # "1º Domingo do Advento" -> "1st_sunday_of_advent"
    # "4º Domingo na Quaresma" -> "4th_sunday_in_lent"
    # "1º Domingo após Natal" -> "1st_sunday_after_christmas"
    def parse_numbered_sunday(sunday_name)
      # Primeiro, verificar domingos "após" (ex: "1º Domingo após Natal")
      match_after = sunday_name.match(/(\d+)º Domingo após (.+)/)
      if match_after
        number = match_after[1].to_i
        season = match_after[2]
        ordinal = to_ordinal(number)
        translated_season = translate_season(season)
        return "#{ordinal}_sunday_after_#{translated_season}"
      end

      match = sunday_name.match(/(\d+)º Domingo (do|no|da|na) (.+)/)
      return sunday_name.parameterize(separator: "_") unless match

      number = match[1].to_i
      preposition = match[2]
      season = match[3]

      ordinal = to_ordinal(number)
      translated_season = translate_season(season)

      # Epifania usa "after" em vez de "of" (ex: 2nd_sunday_after_epiphany)
      if season == "Epifania"
        return "#{ordinal}_sunday_after_#{translated_season}"
      end

      prep = translate_preposition(preposition)
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
