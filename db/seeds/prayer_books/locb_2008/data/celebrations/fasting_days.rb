# ================================================================================
# DIAS DE JEJUM - LOCB 2008
# Quarta-feira de Cinzas e Sexta-feira da Paixão
# ================================================================================

Rails.logger.info "🙏 Criando Dias de Jejum - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

fasting_days = [
  {
    name: "Quarta-feira de Cinzas",
    latin_name: "Feria Quarta Cinerum",
    celebration_type: :major_holy_day,
    rank: 40,
    movable: true,
    calculation_rule: "easter_minus_46_days",
    liturgical_color: "roxo",
    can_be_transferred: false,
    description: "Início da Quaresma - dia de jejum",
    post_slug: "celebration-ash-wednesday"
  },
  {
    name: "Sexta-feira da Paixão",
    latin_name: "Feria Sexta in Passione Domini",
    celebration_type: :major_holy_day,
    rank: 41,
    movable: true,
    calculation_rule: "easter_minus_2_days",
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Paixão e Morte de nosso Senhor - dia de jejum",
    post_slug: "celebration-good-friday"
  }
]

fasting_days.each do |day|
  Celebration.create!(day.merge(prayer_book_id: prayer_book&.id))
  Rails.logger.info "  ✓ #{day[:name]}"
end

# ================================================================================
# DIAS DE DEVOÇÕES ESPECIAIS - LOCB 2008
# Quarta-feira de Cinzas e os dias da Quaresma e da Semana Santa
# (exceto domingos e Festa da Anunciação).
# Sexta-feira da Paixão e todas as outras sextas-feiras do ano,
# em lembrança da crucificação do Senhor, exceto nas sextas-feiras
# das Quadras do Natal e da Páscoa, e em quaisquer outras festas
# de nosso Senhor que ocorram numa sexta-feira.
# ================================================================================

# TODO: Implementar regras de devoções especiais como metadados ou configuração

# ================================================================================
# TÊMPORAS - LOCB 2008
# Tradicionalmente observadas nas quartas, sextas e sábados após:
# - Primeiro domingo na Quaresma
# - Pentecostes
# - Dia da Santa Cruz (14 de setembro)
# - 13 de dezembro
# ================================================================================

# TODO: Implementar Têmporas

# ================================================================================
# DIAS DE ROGAÇÕES - LOCB 2008
# Tradicionalmente observados na segunda, terça e quarta-feira
# antes do Dia da Ascensão
# ================================================================================

# TODO: Implementar Dias de Rogações
