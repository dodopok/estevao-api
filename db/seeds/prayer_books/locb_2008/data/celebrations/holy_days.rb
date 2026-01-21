# ================================================================================
# DIAS SANTOS - LOCB 2008
# Os seguintes dias santos são regularmente observados durante o ano.
# A não ser que estejam ordenados de outra forma nas regras precedentes
# a respeito dos domingos, têm precedência sobre todos os outros dias
# de comemoração ou de observância.
# ================================================================================

Rails.logger.info "✝️  Criando Dias Santos - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

# ================================================================================
# OUTRAS FESTAS DE NOSSO SENHOR
# Estas festas têm precedência sobre o domingo:
# O Santo Nome, Apresentação de Cristo no Templo, Transfiguração de Cristo
# ================================================================================

other_feasts_of_our_lord = [
  {
    name: "Santo Nome de Jesus",
    celebration_type: :major_holy_day,
    rank: 20,
    fixed_month: 1,
    fixed_day: 1,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Oitava do Natal",
    post_slug: "celebration-holy-name-circumcision"
  },
  {
    name: "Apresentação de Cristo no Templo",
    latin_name: "Praesentatio Domini",
    celebration_type: :major_holy_day,
    rank: 21,
    fixed_month: 2,
    fixed_day: 2,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Candelária - 40 dias após o Natal",
    post_slug: "celebration-presentation"
  },
  {
    name: "Anunciação de Nosso Senhor",
    latin_name: "Annuntiatio Domini",
    celebration_type: :major_holy_day,
    rank: 22,
    fixed_month: 3,
    fixed_day: 25,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: true,
    transfer_rules: {
      conditions: [ "if_falls_in_holy_week_or_easter_week" ],
      transfer_to: "monday_after_second_easter_sunday"
    },
    description: "Anunciação do Anjo Gabriel a Maria",
    post_slug: "celebration-annunciation"
  },
  {
    name: "Visitação da Bem-Aventurada Virgem Maria",
    latin_name: "Visitatio Mariae",
    celebration_type: :major_holy_day,
    rank: 23,
    fixed_month: 5,
    fixed_day: 31,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Visita de Maria a Isabel",
    post_slug: "celebration-visitation"
  },
  {
    name: "São João Batista",
    latin_name: "Nativitas Sancti Ioannis Baptistae",
    celebration_type: :major_holy_day,
    rank: 24,
    fixed_month: 6,
    fixed_day: 24,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Natividade de João Batista",
    post_slug: "celebration-nativity-of-john-the-baptist"
  },
  {
    name: "Transfiguração de nosso Senhor Jesus Cristo",
    latin_name: "Transfiguratio Domini",
    celebration_type: :major_holy_day,
    rank: 25,
    fixed_month: 8,
    fixed_day: 6,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Transfiguração de Cristo no Monte Tabor",
    post_slug: "celebration-transfiguration"
  },
  {
    name: "Dia da Santa Cruz",
    latin_name: "Exaltatio Sanctae Crucis",
    celebration_type: :major_holy_day,
    rank: 26,
    fixed_month: 9,
    fixed_day: 14,
    movable: false,
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Exaltação da Santa Cruz",
    post_slug: "celebration-holy-cross"
  }
]

other_feasts_of_our_lord.each do |feast|
  Celebration.create!(feast.merge(prayer_book_id: prayer_book&.id))
  Rails.logger.info "  ✓ #{feast[:name]}"
end

# ================================================================================
# OUTRAS FESTAS PRINCIPAIS DO CALENDÁRIO MAIOR
# ================================================================================

major_calendar_feasts = [
  # Apóstolos
  {
    name: "Os Apóstolos",
    celebration_type: :festival,
    rank: 30,
    movable: false,
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Celebração coletiva dos Apóstolos",
    post_slug: "celebration-apostles"
  },
  # Evangelistas
  {
    name: "Os Evangelistas",
    celebration_type: :festival,
    rank: 31,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Mateus, Marcos, Lucas e João",
    post_slug: "celebration-evangelists"
  },
  # Santos específicos do Calendário Maior
  {
    name: "Santo Estevão",
    latin_name: "Sancti Stephani",
    celebration_type: :festival,
    rank: 32,
    fixed_month: 12,
    fixed_day: 26,
    movable: false,
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Diácono e mártir",
    post_slug: "celebration-stephen"
  },
  {
    name: "Santos Inocentes",
    latin_name: "Sanctorum Innocentium",
    celebration_type: :festival,
    rank: 33,
    fixed_month: 12,
    fixed_day: 28,
    movable: false,
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Os Santos Inocentes, mártires",
    post_slug: "celebration-holy-innocents"
  },
  {
    name: "São José, esposo de Maria, mãe de nosso Senhor Jesus Cristo",
    celebration_type: :festival,
    rank: 34,
    fixed_month: 3,
    fixed_day: 19,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Esposo de Maria",
    post_slug: "celebration-joseph-of-nazareth"
  },
  {
    name: "São Tiago de Jerusalém",
    celebration_type: :festival,
    rank: 35,
    fixed_month: 10,
    fixed_day: 23,
    movable: false,
    liturgical_color: "vermelho",
    can_be_transferred: false,
    description: "Irmão de nosso Senhor Jesus Cristo, mártir, 62",
    post_slug: "celebration-james-of-jerusalem"
  },
  {
    name: "Bem-aventurada Virgem Maria",
    latin_name: "Beatae Mariae Virginis",
    celebration_type: :festival,
    rank: 36,
    fixed_month: 8,
    fixed_day: 15,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Assunção de Maria",
    post_slug: "celebration-assumption-of-mary"
  },
  {
    name: "Maria, virgem mãe de nosso Senhor Jesus Cristo",
    celebration_type: :festival,
    rank: 36,
    fixed_month: 9,
    fixed_day: 8,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Natividade de Maria",
    post_slug: "celebration-nativity-of-mary"
  },
  {
    name: "São Miguel e Todos os Anjos",
    latin_name: "Sancti Michaelis et Omnium Angelorum",
    celebration_type: :festival,
    rank: 37,
    fixed_month: 9,
    fixed_day: 29,
    movable: false,
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Miguel e todos os Anjos",
    post_slug: "celebration-archangel-michael-and-all-angels"
  },
  {
    name: "Dia Nacional de Ação de Graças",
    celebration_type: :festival,
    rank: 38,
    movable: true,
    calculation_rule: "fourth_thursday_of_november",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Ação de Graças Nacional",
    post_slug: "celebration-thanksgiving"
  }
]

major_calendar_feasts.each do |feast|
  Celebration.create!(feast.merge(prayer_book_id: prayer_book&.id))
  Rails.logger.info "  ✓ #{feast[:name]}"
end
