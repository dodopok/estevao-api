# ================================================================================
# FESTAS PRINCIPAIS (13 celebrações - Rank 0-12)
# ================================================================================

puts "⭐ Criando Festas Principais..."

principal_feasts = [
  {
    name: "Vigilia de Natal",
    latin_name: "Vigilia de Natali",
    celebration_type: :principal_feast,
    rank: 1,
    fixed_month: 12,
    fixed_day: 24,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Vigilia de Natal - Nascimento de Jesus Cristo"
  },
  {
    name: "Natividade de nosso Senhor Jesus Cristo",
    latin_name: "Nativitas Domini",
    celebration_type: :principal_feast,
    rank: 1,
    fixed_month: 12,
    fixed_day: 25,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Natal - Nascimento de Jesus Cristo"
  },
  {
    name: "Santo Nome e Circuncisão de nosso Senhor Jesus Cristo",
    celebration_type: :principal_feast,
    rank: 2,
    fixed_month: 1,
    fixed_day: 1,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Primeiro dia do ano civil"
  },
  {
    name: "Epifania de nosso Senhor Jesus Cristo",
    latin_name: "Epiphania Domini",
    celebration_type: :principal_feast,
    rank: 3,
    fixed_month: 1,
    fixed_day: 6,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Manifestação de Cristo aos gentios"
  },
  {
    name: "Batismo de nosso Senhor Jesus Cristo",
    celebration_type: :principal_feast,
    rank: 4,
    movable: true,
    calculation_rule: "first_sunday_after_epiphany",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Primeiro domingo depois da Epifania"
  },
  {
    name: "Apresentação de nosso Senhor Jesus Cristo no Templo",
    latin_name: "Praesentatio Domini",
    celebration_type: :principal_feast,
    rank: 5,
    fixed_month: 2,
    fixed_day: 2,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Candelária - 40 dias após o Natal"
  },
  {
    name: "Anunciação de nosso Senhor Jesus Cristo à Bem-Aventurada Virgem Maria",
    latin_name: "Annuntiatio Domini",
    celebration_type: :principal_feast,
    rank: 6,
    fixed_month: 3,
    fixed_day: 25,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: true,
    transfer_rules: {
      conditions: [ "if_falls_on_sunday", "if_between_palm_sunday_and_second_easter" ],
      transfer_to: "monday_after_second_easter_sunday"
    },
    description: "Anunciação do Anjo Gabriel a Maria"
  },
  {
    name: "Páscoa",
    latin_name: "Pascha",
    celebration_type: :principal_feast,
    rank: 0,  # Rank 0 = maior de todas
    movable: true,
    calculation_rule: "easter",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Ressurreição de nosso Senhor Jesus Cristo"
  },
  {
    name: "Ascensão de nosso Senhor Jesus Cristo",
    latin_name: "Ascensio Domini",
    celebration_type: :principal_feast,
    rank: 7,
    movable: true,
    calculation_rule: "easter_plus_39_days",
    liturgical_color: "branco",
    can_be_transferred: true,
    transfer_rules: {
      can_transfer_to: "sunday_after"
    },
    description: "40 dias após a Páscoa"
  },
  {
    name: "Pentecostes",
    celebration_type: :principal_feast,
    rank: 8,
    movable: true,
    calculation_rule: "easter_plus_49_days",
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "50 dias após a Páscoa - Descida do Espírito Santo"
  },
  {
    name: "Santíssima Trindade",
    latin_name: "Sanctissima Trinitas",
    celebration_type: :principal_feast,
    rank: 9,
    movable: true,
    calculation_rule: "first_sunday_after_pentecost",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Primeiro domingo depois de Pentecostes"
  },
  {
    name: "Transfiguração de nosso Senhor Jesus Cristo",
    latin_name: "Transfiguratio Domini",
    celebration_type: :principal_feast,
    rank: 10,
    fixed_month: 8,
    fixed_day: 6,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false
  },
  {
    name: "Todos os Santos e Santas",
    latin_name: "Omnium Sanctorum",
    celebration_type: :principal_feast,
    rank: 11,
    fixed_month: 11,
    fixed_day: 1,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: true,
    transfer_rules: {
      can_transfer_to: "nearest_sunday"
    }
  },
  {
    name: "Cristo Rei do Universo",
    latin_name: "Christus Rex",
    celebration_type: :principal_feast,
    rank: 12,
    movable: true,
    calculation_rule: "sunday_before_advent",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Domingo anterior ao Advento"
  }
]

principal_feasts.each do |feast|
  Celebration.create!(feast)
  puts "  ✓ #{feast[:name]}"
end
