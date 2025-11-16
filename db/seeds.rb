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

# === FESTAS MENORES (Lesser Feasts) ===
puts "\n🕊️  Criando Festas Menores..."

lesser_feasts = [
  { name: "Santo Agostinho de Cantuária", celebration_type: :lesser_feast, rank: 100, fixed_month: 5, fixed_day: 26, liturgical_color: "branco", description: "Bispo, 605" },
  { name: "Santo Ambrósio de Milão", celebration_type: :lesser_feast, rank: 101, fixed_month: 12, fixed_day: 7, liturgical_color: "branco", description: "Bispo e Doutor, 397" },
  { name: "Santa Mônica", celebration_type: :lesser_feast, rank: 102, fixed_month: 8, fixed_day: 27, liturgical_color: "branco", description: "Mãe de Agostinho, 387" },
  { name: "Santo Agostinho de Hipona", celebration_type: :lesser_feast, rank: 103, fixed_month: 8, fixed_day: 28, liturgical_color: "branco", description: "Bispo e Doutor, 430" },
  { name: "São Jerônimo", celebration_type: :lesser_feast, rank: 104, fixed_month: 9, fixed_day: 30, liturgical_color: "branco", description: "Sacerdote e Doutor, 420" },
  { name: "São Francisco de Assis", celebration_type: :lesser_feast, rank: 105, fixed_month: 10, fixed_day: 4, liturgical_color: "branco", description: "Frade e Fundador, 1226" },
  { name: "Santa Teresa de Ávila", celebration_type: :lesser_feast, rank: 106, fixed_month: 10, fixed_day: 15, liturgical_color: "branco", description: "Mística e Doutora, 1582" },
  { name: "São Nicolau de Mira", celebration_type: :lesser_feast, rank: 107, fixed_month: 12, fixed_day: 6, liturgical_color: "branco", description: "Bispo, c. 342" },
  { name: "Santa Lúcia", celebration_type: :lesser_feast, rank: 108, fixed_month: 12, fixed_day: 13, liturgical_color: "vermelho", description: "Mártir, 304" },
  { name: "São Gregório Magno", celebration_type: :lesser_feast, rank: 109, fixed_month: 3, fixed_day: 12, liturgical_color: "branco", description: "Bispo e Doutor, 604" },
  { name: "São Patrício", celebration_type: :lesser_feast, rank: 110, fixed_month: 3, fixed_day: 17, liturgical_color: "branco", description: "Bispo e Missionário, c. 461" },
  { name: "São Jorge", celebration_type: :lesser_feast, rank: 111, fixed_month: 4, fixed_day: 23, liturgical_color: "vermelho", description: "Mártir, c. 303" },
  { name: "São Bento de Núrsia", celebration_type: :lesser_feast, rank: 112, fixed_month: 7, fixed_day: 11, liturgical_color: "branco", description: "Abade e Fundador, c. 550" },
  { name: "Santa Maria Madalena de Pazzi", celebration_type: :lesser_feast, rank: 113, fixed_month: 5, fixed_day: 25, liturgical_color: "branco", description: "Mística, 1607" },
  { name: "São Tomás de Aquino", celebration_type: :lesser_feast, rank: 114, fixed_month: 1, fixed_day: 28, liturgical_color: "branco", description: "Sacerdote e Doutor, 1274" },
  { name: "Santa Escolástica", celebration_type: :lesser_feast, rank: 115, fixed_month: 2, fixed_day: 10, liturgical_color: "branco", description: "Monja, c. 543" },
  { name: "São Valentim", celebration_type: :lesser_feast, rank: 116, fixed_month: 2, fixed_day: 14, liturgical_color: "vermelho", description: "Mártir, c. 269" },
  { name: "São Inácio de Antioquia", celebration_type: :lesser_feast, rank: 117, fixed_month: 10, fixed_day: 17, liturgical_color: "vermelho", description: "Bispo e Mártir, c. 107" },
  { name: "São Martinho de Tours", celebration_type: :lesser_feast, rank: 118, fixed_month: 11, fixed_day: 11, liturgical_color: "branco", description: "Bispo, 397" },
  { name: "Santa Catarina de Alexandria", celebration_type: :lesser_feast, rank: 119, fixed_month: 11, fixed_day: 25, liturgical_color: "vermelho", description: "Mártir, c. 305" }
]

lesser_feasts.each do |feast|
  Celebration.create!(feast.merge(movable: false, can_be_transferred: false))
  puts "  ✓ #{feast[:name]}"
end

# === LEITURAS DO LECIONÁRIO (Exemplos) ===
puts "\n📖 Criando leituras de exemplo..."

# Exemplo de leituras para alguns domingos
sample_readings = [
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 2:1-5",
    psalm: "Psalm 122",
    second_reading: "Romans 13:11-14",
    gospel: "Matthew 24:36-44"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 64:1-9",
    psalm: "Psalm 80:1-7, 17-19",
    second_reading: "1 Corinthians 1:3-9",
    gospel: "Mark 13:24-37"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 33:14-16",
    psalm: "Psalm 25:1-10",
    second_reading: "1 Thessalonians 3:9-13",
    gospel: "Luke 21:25-36"
  },
  {
    date_reference: "easter_sunday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 10:34-43",
    psalm: "Psalm 118:1-2, 14-24",
    second_reading: "Colossians 3:1-4",
    gospel: "John 20:1-18"
  },
  {
    date_reference: "pentecost",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 2:1-21",
    psalm: "Psalm 104:24-34, 35b",
    second_reading: "Romans 8:22-27",
    gospel: "John 15:26-27; 16:4b-15"
  }
]

sample_readings.each do |reading|
  LectionaryReading.create!(reading)
  puts "  ✓ #{reading[:date_reference]} (Cycle #{reading[:cycle]})"
end

puts "\n✅ Seeds criados com sucesso!"
puts "\nResumo:"
puts "  • #{LiturgicalColor.count} cores litúrgicas"
puts "  • #{LiturgicalSeason.count} quadras litúrgicas"
puts "  • #{Celebration.principal_feast.count} festas principais"
puts "  • #{Celebration.major_holy_day.count} dias santos principais"
puts "  • #{Celebration.festival.count} festivais"
puts "  • #{Celebration.count} celebrações no total"

puts "  • #{Celebration.lesser_feast.count} festas menores"
puts "  • #{LectionaryReading.count} leituras do lecionário"

# === CARREGAR SEEDS ADICIONAIS ===
puts "\n📚 Carregando seeds adicionais..."

# Leituras do Lecionário
if File.exist?(Rails.root.join('db/seeds/lectionary_readings.rb'))
  load Rails.root.join('db/seeds/lectionary_readings.rb')
else
  puts "⚠️  Arquivo de leituras não encontrado."
end

# Leituras Complementares
if File.exist?(Rails.root.join('db/seeds/complete_lectionary.rb'))
  load Rails.root.join('db/seeds/complete_lectionary.rb')
else
  puts "⚠️  Arquivo de leituras complementares não encontrado."
end

# Santos Adicionais
if File.exist?(Rails.root.join('db/seeds/more_saints.rb'))
  load Rails.root.join('db/seeds/more_saints.rb')
else
  puts "⚠️  Arquivo de santos adicionais não encontrado."
end

puts "\n📊 TOTAL FINAL:"
puts "  • #{LiturgicalColor.count} cores litúrgicas"
puts "  • #{LiturgicalSeason.count} quadras litúrgicas"
puts "  • #{Celebration.count} celebrações totais"
puts "    - #{Celebration.principal_feast.count} festas principais"
puts "    - #{Celebration.major_holy_day.count} dias santos principais"
puts "    - #{Celebration.festival.count} festivais"
puts "    - #{Celebration.lesser_feast.count} festas menores"
puts "  • #{LectionaryReading.count} leituras do lecionário"
puts "  • #{Collect.count} coletas"

puts "\n✅ Banco de dados populado com sucesso!"
puts "\n📝 Próximos passos:"
puts "  • Adicionar coletas (orações) para domingos e festas"
puts "  • Adicionar leituras de dias de semana (opcional)"
puts "  • Revisar e corrigir quaisquer dados conforme necessário"
