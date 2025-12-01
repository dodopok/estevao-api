# ================================================================================
# DIAS SANTOS PRINCIPAIS (4 celebrações - Rank 20-23)
# ================================================================================

Rails.logger.info "✝️  Criando Dias Santos Principais..."

prayer_book = PrayerBook.find_by_code('loc_2015')

major_holy_days = [
  {
    name: "Quarta-Feira de Cinzas",
    latin_name: "Feria Quarta Cinerum",
    celebration_type: :major_holy_day,
    rank: 20,
    movable: true,
    calculation_rule: "easter_minus_46_days",
    liturgical_color: "roxo",
    can_be_transferred: false,
    description: "Início da Quaresma - dia de jejum"
  },
  {
    name: "Quinta-Feira Santa",
    latin_name: "Feria Quinta in Cena Domini",
    celebration_type: :major_holy_day,
    rank: 21,
    movable: true,
    calculation_rule: "easter_minus_3_days",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Instituição da Eucaristia"
  },
  {
    name: "Sexta-Feira da Paixão",
    latin_name: "Feria Sexta in Passione Domini",
    celebration_type: :major_holy_day,
    rank: 22,
    movable: true,
    calculation_rule: "easter_minus_2_days",
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Paixão e Morte de nosso Senhor - dia de jejum"
  },
  {
    name: "Sábado Santo",
    latin_name: "Feria Sabbati Sancti",
    celebration_type: :major_holy_day,
    rank: 23,
    movable: true,
    calculation_rule: "easter_minus_1_day",
    liturgical_color: "black",
    can_be_transferred: false,
    description: "Dia de silêncio e espera pela Ressurreição"
  }
]

major_holy_days.each do |holy_day|
  Celebration.create!(holy_day.merge(prayer_book_id: prayer_book&.id))
  Rails.logger.info "  ✓ #{holy_day[:name]}"
end
