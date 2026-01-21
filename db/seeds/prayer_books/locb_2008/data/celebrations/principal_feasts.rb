# ================================================================================
# FESTAS PRINCIPAIS - LOCB 2008
# As festas principais observadas nesta Igreja são:
# Páscoa, Ascensão, Pentecostes, Domingo da Trindade, Todos os Santos, Natal, Epifania
# Tais festas têm precedência sobre qualquer outro dia ou observância.
# O Dia de Todos os Santos pode ser observado no domingo seguinte.
# ================================================================================

Rails.logger.info "⭐ Criando Festas Principais - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

principal_feasts = [
  {
    name: "Páscoa",
    latin_name: "Pascha",
    celebration_type: :principal_feast,
    rank: 0,
    movable: true,
    calculation_rule: "easter",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "A Ressurreição de nosso Senhor Jesus Cristo",
    person_type: "event",
    gender: "neutral",
    post_slug: "celebration-easter"
  },
  {
    name: "Ascensão de nosso Senhor Jesus Cristo",
    latin_name: "Ascensio Domini",
    celebration_type: :principal_feast,
    rank: 1,
    movable: true,
    calculation_rule: "easter_plus_39_days",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Quinta-feira, 40 dias após a Páscoa",
    person_type: "event",
    gender: "neutral",
    post_slug: "celebration-ascension"
  },
  {
    name: "Pentecostes",
    latin_name: "Pentecostes",
    celebration_type: :principal_feast,
    rank: 2,
    movable: true,
    calculation_rule: "easter_plus_49_days",
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Domingo, 50 dias após a Páscoa - Descida do Espírito Santo",
    person_type: "event",
    gender: "neutral",
    post_slug: "celebration-pentecost"
  },
  {
    name: "Domingo da Trindade",
    latin_name: "Sanctissimae Trinitatis",
    celebration_type: :principal_feast,
    rank: 3,
    movable: true,
    calculation_rule: "easter_plus_56_days",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Primeiro domingo após Pentecostes",
    person_type: "event",
    gender: "neutral",
    post_slug: "celebration-trinity"
  },
  {
    name: "Todos os Santos",
    latin_name: "Omnium Sanctorum",
    celebration_type: :principal_feast,
    rank: 4,
    fixed_month: 11,
    fixed_day: 1,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: true,
    transfer_rules: {
      conditions: [ "can_transfer_to_following_sunday" ],
      transfer_to: "first_sunday_after_november_1"
    },
    description: "Pode ser observado no domingo seguinte",
    person_type: "event",
    gender: "neutral",
    post_slug: "celebration-all-saints"
  },
  {
    name: "Natividade de nosso Senhor Jesus Cristo",
    latin_name: "Nativitas Domini",
    celebration_type: :principal_feast,
    rank: 5,
    fixed_month: 12,
    fixed_day: 25,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Natal - Nascimento de Jesus Cristo",
    person_type: "event",
    gender: "neutral",
    post_slug: "celebration-christmas"
  },
  {
    name: "Epifania de nosso Senhor Jesus Cristo",
    latin_name: "Epiphania Domini",
    celebration_type: :principal_feast,
    rank: 6,
    fixed_month: 1,
    fixed_day: 6,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Manifestação de Cristo aos gentios",
    person_type: "event",
    gender: "neutral",
    post_slug: "celebration-epiphany"
  }
]

principal_feasts.each do |feast|
  Celebration.create!(feast.merge(prayer_book_id: prayer_book&.id))
  Rails.logger.info "  ✓ #{feast[:name]}"
end
