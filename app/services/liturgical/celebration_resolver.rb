# frozen_string_literal: true

module Liturgical
  # Serviço para resolver transferências de festas conforme as regras litúrgicas
  class Liturgical::CelebrationResolver
    include PrayerBookAware

    attr_reader :year, :easter_calc

    # Maps calculation_rule to the corresponding key in all_movable_dates
    # This is the canonical source for calculation rule mappings
    CALCULATION_RULE_TO_MOVABLE_DATE = {
      "easter" => :easter,
      "easter_minus_46_days" => :ash_wednesday,
      "easter_minus_6_days" => :holy_monday,
      "easter_minus_5_days" => :holy_tuesday,
      "easter_minus_4_days" => :holy_wednesday,
      "easter_minus_3_days" => :maundy_thursday,
      "easter_minus_2_days" => :good_friday,
      "easter_minus_1_day" => :holy_saturday,
      "easter_minus_1_days" => :holy_saturday, # Alternative spelling
      "easter_plus_39_days" => :ascension,
      "easter_plus_49_days" => :pentecost,
      "easter_plus_56_days" => :trinity_sunday,
      "first_sunday_after_pentecost" => :trinity_sunday,
      "first_sunday_after_epiphany" => :baptism_of_the_lord,
      "sunday_before_advent" => :christ_the_king
    }.freeze

    # Maps calculation rules to their possible date_reference names
    # Used for finding readings in the lectionary
    CALCULATION_RULE_TO_DATE_REFERENCES = {
      "easter_minus_46_days" => %w[ash_wednesday],
      "easter_minus_6_days" => %w[holy_monday],
      "easter_minus_5_days" => %w[holy_tuesday],
      "easter_minus_4_days" => %w[holy_wednesday],
      "easter_minus_3_days" => %w[maundy_thursday holy_thursday],
      "easter_minus_2_days" => %w[good_friday],
      "easter_minus_1_days" => %w[holy_saturday holy_saturday_vigil],
      "easter_minus_1_day" => %w[holy_saturday holy_saturday_vigil],
      "easter" => %w[easter_sunday easter_day],
      "easter_plus_39_days" => %w[ascension ascension_day],
      "easter_plus_49_days" => %w[pentecost whitsunday],
      "easter_plus_56_days" => %w[trinity_sunday],
      "first_sunday_after_pentecost" => %w[trinity_sunday]
    }.freeze

    def initialize(year, prayer_book_code: "loc_2015", easter_calc: nil)
      @year = year
      @prayer_book_code = prayer_book_code
      @easter_calc = easter_calc || Liturgical::EasterCalculator.new(year)
      @season_determinator = Liturgical::SeasonDeterminator.new(year, easter_calc: @easter_calc)
      @transfer_rules = Liturgical::TransferRules.new(year, easter_calc: @easter_calc)
    end

    # Resolve qual celebração deve ser observada numa data específica,
    # aplicando regras de transferência e hierarquia
    def resolve_for_date(date)
      # 1. Coleta todas as celebrações que "querem" estar nesta data
      candidates = collect_candidates(date)

      # 2. Se não há candidatos, retorna nil
      return nil if candidates.empty?

      # 3. Se há apenas um candidato, retorna ele
      return candidates.first if candidates.length == 1

      # 4. Se há múltiplos candidatos, resolve por hierarquia
      resolve_by_hierarchy(candidates, date)
    end

    # Retorna a data onde uma celebração deve ser observada,
    # considerando possíveis transferências
    def actual_date_for_celebration(celebration)
      # Se é móvel, calcula a data
      if celebration.movable?
        return calculate_movable_date(celebration)
      end

      # Se é fixa e não pode ser transferida, retorna a data fixa
      unless celebration.can_be_transferred?
        return Date.new(year, celebration.fixed_month, celebration.fixed_day)
      end

      # Verifica se precisa transferir
      original_date = Date.new(year, celebration.fixed_month, celebration.fixed_day)

      # Aplica regras de transferência
      transfer_if_needed(celebration, original_date)
    end

    private

    def collect_candidates(date)
      candidates = []

      # Candidatos fixos (filtrados por prayer_book)
      fixed_celebrations = Celebration.for_prayer_book_id(prayer_book_id)
                                      .fixed
                                      .for_date(date.month, date.day)
      candidates.concat(fixed_celebrations.to_a)

      # Candidatos móveis que caem nesta data (filtrados por prayer_book)
      # Use memoized movable_celebrations to avoid repeated queries
      movable_celebrations_for_prayer_book.each do |cel|
        if calculate_movable_date(cel) == date
          candidates << cel
        end
      end

      # Candidatos transferidos para esta data (filtrados por prayer_book)
      # Use memoized transferable_celebrations to avoid repeated queries
      transferable_celebrations_for_prayer_book.each do |cel|
        next if cel.movable? # já tratado acima

        transferred_date = actual_date_for_celebration(cel)
        if transferred_date == date && transferred_date != Date.new(year, cel.fixed_month, cel.fixed_day)
          candidates << cel
        end
      end

      candidates
    end

    # Memoize movable celebrations to avoid repeated queries
    def movable_celebrations_for_prayer_book
      @movable_celebrations_for_prayer_book ||= Celebration.movable.for_prayer_book_id(prayer_book_id).to_a
    end

    # Memoize transferable celebrations to avoid repeated queries
    # Only select fixed celebrations since movable ones are handled separately
    def transferable_celebrations_for_prayer_book
      @transferable_celebrations_for_prayer_book ||= Celebration.for_prayer_book_id(prayer_book_id)
                                                                .where(can_be_transferred: true, movable: false)
                                                                .to_a
    end

    def resolve_by_hierarchy(celebrations, date)
      # Ordena por rank (menor = maior precedência)
      sorted = celebrations.sort_by(&:rank)

      # Festa Principal tem maior precedência
      principal_feast = sorted.find { |c| c.principal_feast? }
      return principal_feast if principal_feast

      # Depois Dia Santo Principal
      major_holy_day = sorted.find { |c| c.major_holy_day? }
      return major_holy_day if major_holy_day

      # Domingos em quadras principais (Advento, Natal, Quaresma, Páscoa) têm precedência sobre festas menores
      # MAS: Festas Principais e Dias Santos Principais já foram tratados acima
      if date.sunday? && in_major_season?(date)
        # Retorna a festa menor para que apareça em 'celebration',
        # mas LiturgicalCalendar usará a cor da quadra (não da celebração)
        return sorted.first
      end

      # Caso contrário, retorna o de menor rank
      sorted.first
    end

    def calculate_movable_date(celebration)
      return nil unless celebration.movable?

      movable_key = CALCULATION_RULE_TO_MOVABLE_DATE[celebration.calculation_rule]
      return nil unless movable_key

      easter_calc.all_movable_dates[movable_key]
    end

    # Delegate transfer logic to Liturgical::TransferRules
    def transfer_if_needed(celebration, original_date)
      @transfer_rules.transfer_if_needed(celebration, original_date)
    end

    # Verifica se uma data está em período protegido (não pode ter festivais menores)
    # Delegado ao Liturgical::SeasonDeterminator
    def in_protected_period?(date)
      @season_determinator.in_protected_period?(date)
    end

    # Verifica se uma data está em uma quadra litúrgica principal
    # onde os domingos têm precedência sobre festivais menores
    # Delegado ao Liturgical::SeasonDeterminator
    def in_major_season?(date)
      @season_determinator.in_major_season?(date)
    end
  end
end
