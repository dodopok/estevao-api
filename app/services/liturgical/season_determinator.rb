# frozen_string_literal: true

module Liturgical
  # Determina a quadra (season) litúrgica e verifica períodos principais
  # Centraliza lógica duplicada de LiturgicalCalendar e Liturgical::CelebrationResolver
  class SeasonDeterminator
    MAJOR_SEASONS = %w[Advento Natal Quaresma Páscoa].freeze

    attr_reader :year, :easter_calc

    def initialize(year, easter_calc: nil)
      @year = year
      @easter_calc = easter_calc || Liturgical::EasterCalculator.new(year)
    end

    # Retorna a quadra litúrgica para uma data
    def season_for_date(date)
      movable = easter_calc.all_movable_dates
      baptism = movable[:baptism_of_the_lord]

      # Verificar primeiro se estamos no início de Janeiro (Natal do ano anterior)
      # Ex: 5 de Janeiro 2025 pertence ao Natal que começou em 25 Dez 2024
      # O Batismo do Senhor marca o fim do Natal e início da Epifania
      return "Natal" if date.month == 1 && date < baptism

      # Advento: do 1º Domingo do Advento até 24 de dezembro
      return "Advento" if date >= movable[:first_sunday_of_advent] && date <= Date.new(year, 12, 24)

      # Natal: 25 de dezembro até véspera do Batismo do Senhor do próximo ano
      return "Natal" if date >= Date.new(year, 12, 25)

      # Epifania: do Batismo do Senhor até véspera da Quarta de Cinzas
      return "Epifania" if date >= baptism && date < movable[:ash_wednesday]

      # Quaresma: Quarta de Cinzas até Sábado Santo
      return "Quaresma" if date >= movable[:ash_wednesday] && date <= movable[:holy_saturday]

      # Páscoa: Domingo de Páscoa até Pentecostes
      return "Páscoa" if date >= movable[:easter] && date <= movable[:pentecost]

      # Caso contrário: Tempo Comum
      "Tempo Comum"
    end

    # Verifica se uma data está em uma quadra litúrgica principal
    # onde os domingos têm precedência sobre festivais menores
    def in_major_season?(date)
      MAJOR_SEASONS.include?(season_for_date(date))
    end

    # Verifica se uma data está em período protegido (não pode ter festivais menores)
    # Semana Santa até Segundo Domingo da Páscoa
    def in_protected_period?(date)
      movable = easter_calc.all_movable_dates
      palm_sunday = movable[:palm_sunday]
      second_easter = movable[:second_sunday_of_easter]

      date >= palm_sunday && date <= second_easter
    end
  end
end
