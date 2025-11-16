# Seeds para o Calendário Litúrgico Anglicano
# Este arquivo popula o banco de dados com as celebrações e quadras básicas

puts "🌱 Iniciando seeds do Calendário Litúrgico Anglicano..."

# Limpa dados existentes
puts "Limpando dados existentes..."
LectionaryReading.destroy_all
Collect.destroy_all
Celebration.destroy_all
LiturgicalColor.destroy_all
LiturgicalSeason.destroy_all

# === CORES LITÚRGICAS ===
puts "\n📊 Criando cores litúrgicas..."
colors = [
  { name: "branco", hex_code: "#FFFFFF", usage_description: "Natal, Páscoa, Festas do Senhor, Santos não-mártires, Funerais" },
  { name: "vermelho", hex_code: "#DC143C", usage_description: "Semana Santa (exceto Quinta-feira Santa), Pentecostes, Mártires, Confirmações e Ordenações" },
  { name: "roxo", hex_code: "#800080", usage_description: "Quaresma (desde Quarta-feira de Cinzas até véspera de Domingo de Ramos)" },
  { name: "violeta", hex_code: "#8B00FF", usage_description: "Advento (preferencial)" },
  { name: "azul_escuro", hex_code: "#00008B", usage_description: "Advento (alternativo)" },
  { name: "rosa", hex_code: "#FFB6C1", usage_description: "3º Domingo do Advento e 4º Domingo na Quaresma" },
  { name: "verde", hex_code: "#228B22", usage_description: "Tempo Comum" },
  { name: "preto", hex_code: "#000000", usage_description: "Sexta-feira da Paixão (opcional), Funerais (opcional)" },
  { name: "pano_cru", hex_code: "#F5DEB3", usage_description: "Quaresma (alternativo ao roxo)" }
]

colors.each do |color_data|
  LiturgicalColor.create!(color_data)
  puts "  ✓ #{color_data[:name]}"
end

# === QUADRAS LITÚRGICAS ===
puts "\n📅 Criando quadras litúrgicas..."
seasons = [
  { name: "Advento", color: "violeta", description: "Tempo de preparação para o Natal" },
  { name: "Natal", color: "branco", description: "Celebração da Natividade do Senhor" },
  { name: "Epifania", color: "verde", description: "Manifestação de Cristo ao mundo" },
  { name: "Quaresma", color: "roxo", description: "Tempo de penitência e preparação para a Páscoa" },
  { name: "Páscoa", color: "branco", description: "Celebração da Ressurreição do Senhor" },
  { name: "Tempo Comum", color: "verde", description: "Tempo de crescimento espiritual" }
]

seasons.each do |season_data|
  LiturgicalSeason.create!(season_data)
  puts "  ✓ #{season_data[:name]}"
end

# === FESTAS PRINCIPAIS ===
puts "\n⭐ Criando Festas Principais..."

principal_feasts = [
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
      conditions: ["if_falls_on_sunday", "if_between_palm_sunday_and_second_easter"],
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

# === DIAS SANTOS PRINCIPAIS ===
puts "\n✝️  Criando Dias Santos Principais..."

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
  }
]

major_holy_days.each do |holy_day|
  Celebration.create!(holy_day)
  puts "  ✓ #{holy_day[:name]}"
end

# === FESTIVAIS (Apóstolos e Evangelistas) ===
puts "\n🎉 Criando Festivais..."

festivals = [
  { name: "Confissão de Pedro, Apóstolo", celebration_type: :festival, rank: 30, fixed_month: 1, fixed_day: 18, liturgical_color: "branco" },
  { name: "Conversão de Paulo, Apóstolo", celebration_type: :festival, rank: 31, fixed_month: 1, fixed_day: 25, liturgical_color: "branco" },
  { name: "Matias, Apóstolo", celebration_type: :festival, rank: 32, fixed_month: 2, fixed_day: 24, liturgical_color: "vermelho" },
  { name: "José de Nazaré", celebration_type: :festival, rank: 33, fixed_month: 3, fixed_day: 19, liturgical_color: "branco", can_be_transferred: true },
  { name: "Marcos, Evangelista", celebration_type: :festival, rank: 34, fixed_month: 4, fixed_day: 25, liturgical_color: "vermelho", can_be_transferred: true },
  { name: "Filipe e Tiago Menor, Apóstolos", celebration_type: :festival, rank: 35, fixed_month: 5, fixed_day: 1, liturgical_color: "vermelho" },
  { name: "Visitação da Bem-Aventurada Virgem Maria", celebration_type: :festival, rank: 36, fixed_month: 5, fixed_day: 31, liturgical_color: "branco" },
  { name: "Barnabé, Apóstolo", celebration_type: :festival, rank: 37, fixed_month: 6, fixed_day: 11, liturgical_color: "vermelho" },
  { name: "Natividade de João Batista", celebration_type: :festival, rank: 38, fixed_month: 6, fixed_day: 24, liturgical_color: "branco" },
  { name: "Pedro e Paulo, Apóstolos", celebration_type: :festival, rank: 39, fixed_month: 6, fixed_day: 29, liturgical_color: "vermelho" },
  { name: "Maria Madalena, Apóstola", celebration_type: :festival, rank: 40, fixed_month: 7, fixed_day: 22, liturgical_color: "branco" },
  { name: "Tiago, Apóstolo", celebration_type: :festival, rank: 41, fixed_month: 7, fixed_day: 25, liturgical_color: "vermelho" },
  { name: "Bem-Aventurada Virgem Maria", celebration_type: :festival, rank: 42, fixed_month: 8, fixed_day: 15, liturgical_color: "branco" },
  { name: "Bartolomeu, Apóstolo", celebration_type: :festival, rank: 43, fixed_month: 8, fixed_day: 24, liturgical_color: "vermelho" },
  { name: "Santa Cruz", celebration_type: :festival, rank: 44, fixed_month: 9, fixed_day: 14, liturgical_color: "vermelho" },
  { name: "Mateus, Apóstolo e Evangelista", celebration_type: :festival, rank: 45, fixed_month: 9, fixed_day: 21, liturgical_color: "vermelho" },
  { name: "Arcanjo Miguel e Todos os Anjos", celebration_type: :festival, rank: 46, fixed_month: 9, fixed_day: 29, liturgical_color: "branco" },
  { name: "Lucas, Evangelista", celebration_type: :festival, rank: 47, fixed_month: 10, fixed_day: 18, liturgical_color: "vermelho" },
  { name: "Tiago de Jerusalém", celebration_type: :festival, rank: 48, fixed_month: 10, fixed_day: 23, liturgical_color: "vermelho" },
  { name: "Simão e Judas, Apóstolos", celebration_type: :festival, rank: 49, fixed_month: 10, fixed_day: 28, liturgical_color: "vermelho" },
  { name: "André, Apóstolo", celebration_type: :festival, rank: 50, fixed_month: 11, fixed_day: 30, liturgical_color: "vermelho" },
  { name: "Tomé, Apóstolo", celebration_type: :festival, rank: 51, fixed_month: 12, fixed_day: 21, liturgical_color: "vermelho" },
  { name: "Estêvão, Diácono e Protomártir", celebration_type: :festival, rank: 52, fixed_month: 12, fixed_day: 26, liturgical_color: "vermelho" },
  { name: "João, Apóstolo e Evangelista", celebration_type: :festival, rank: 53, fixed_month: 12, fixed_day: 27, liturgical_color: "branco" },
  { name: "Santos Inocentes", celebration_type: :festival, rank: 54, fixed_month: 12, fixed_day: 28, liturgical_color: "vermelho" }
]

festivals.each do |festival|
  Celebration.create!(festival.merge(movable: false, can_be_transferred: true))
  puts "  ✓ #{festival[:name]}"
end

puts "\n✅ Seeds criados com sucesso!"
puts "\nResumo:"
puts "  • #{LiturgicalColor.count} cores litúrgicas"
puts "  • #{LiturgicalSeason.count} quadras litúrgicas"
puts "  • #{Celebration.principal_feast.count} festas principais"
puts "  • #{Celebration.major_holy_day.count} dias santos principais"
puts "  • #{Celebration.festival.count} festivais"
puts "  • #{Celebration.count} celebrações no total"

puts "\n📝 Nota: Coletas e leituras devem ser adicionadas posteriormente pelo usuário."
puts "💡 Use migrations ou scripts personalizados para importar os dados de coletas e leituras."
