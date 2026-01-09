# ================================================================================
# LEITURAS - DIAS SANTOS - LOC 1987
# ================================================================================

Rails.logger.info "📖 Carregando leituras dos Dias Santos (LOC 1987)..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

holy_days = [
  {
    date_reference: "andrew", # 30/11
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30:11-14",
    psalm: "19 ou 19:1-6",
    second_reading: "Romanos 10:8b-18",
    gospel: "Mateus 4:18-22"
  },
  {
    date_reference: "thomas_apostle", # 21/12
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Habacuque 2:1-4",
    psalm: "126",
    second_reading: "Hebreus 10:35—11:1",
    gospel: "João 20:24-29"
  },
  {
    date_reference: "stephen", # 26/12
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 26:1-9,12-15",
    psalm: "31 ou 31:1-5",
    second_reading: "Atos 6:8—7:2a,51c-60",
    gospel: "Mateus 23:34-39"
  },
  {
    date_reference: "john_evangelist", # 27/12
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êxodo 33:18-23",
    psalm: "92 ou 92:1-4,11-14",
    second_reading: "I João 1:1-9",
    gospel: "João 21:19b-24"
  },
  {
    date_reference: "holy_innocents", # 28/12
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 31:15-17",
    psalm: "124",
    second_reading: "Apocalipse 21:1-7",
    gospel: "Mateus 2:13-18"
  },
  {
    date_reference: "confession_of_peter", # 18/1
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 4:8-13",
    psalm: "23",
    second_reading: "I Pedro 5:1-4",
    gospel: "Mateus 16:13-19"
  },
  {
    date_reference: "conversion_of_paul", # 25/1
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 26:9-21",
    psalm: "67",
    second_reading: "Gálatas 1:11 -24",
    gospel: "Mateus 10:16-22"
  },
  {
    date_reference: "presentation", # 2/2
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Malaquias 3:1-4",
    psalm: "84 ou 84:1-6",
    second_reading: "Hebreus 2:14-18",
    gospel: "Lucas 2:22-40"
  },
  {
    date_reference: "matthias", # 24/2
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 1:15-26",
    psalm: "15",
    second_reading: "Filipenses 3:13-21",
    gospel: "João 15:1,6-16"
  },
  {
    date_reference: "joseph", # 19/3
    cycle: "all",
    service_type: "eucharist",
    first_reading: "II Samuel 7:4,8-16",
    psalm: "89:1-29 ou 89:1-4,26-29",
    second_reading: "Romanos 4:13-18",
    gospel: "Lucas 2:41-52"
  },
  {
    date_reference: "annunciation", # 25/3
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaias 7:10-14",
    psalm: "40:1-11 ou 40:5-10",
    second_reading: "Hebreus 10:5-10",
    gospel: "Lucas 1:26-38"
  },
  {
    date_reference: "mark", # 25/4
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaias 52:7-10",
    psalm: "2 ou 2:7-10",
    second_reading: "Efésios 4:7-8,11-16",
    gospel: "Marcos 1:1-15 ou Marcos 16:15-20"
  },
  {
    date_reference: "philip_and_james", # 1/5
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaias 30:18-21",
    psalm: "119:33-40",
    second_reading: "II Coríntios 4:1-6",
    gospel: "João 14:6-14"
  },
  {
    date_reference: "visitation", # 31/5
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Sofonias 3:14-18a",
    psalm: "113",
    second_reading: "Colossenses 3:12-17",
    gospel: "Lucas 1:39-49"
  },
  {
    date_reference: "barnabas", # 11/6
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaias 42:5-12",
    psalm: "112",
    second_reading: "Atos 11:19-30,13:1-3",
    gospel: "Mateus 10:7-16"
  },
  {
    date_reference: "nativity_of_john_the_baptist", # 24/6
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaias 40:1-11",
    psalm: "85 ou 85:7-13",
    second_reading: "Atos 13:14b-26",
    gospel: "Lucas 1:57-80"
  },
  {
    date_reference: "peter_and_paul", # 29/6
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Ezequiel 34:11-16",
    psalm: "87",
    second_reading: "II Timóteo 4:1-8",
    gospel: "João 21:15-19"
  },
  {
    date_reference: "mary_magdalene", # 22/7
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Judite 9:1,11-14",
    psalm: "42:1-7",
    second_reading: "II Coríntios 5:14-18",
    gospel: "João 20:11-18"
  },
  {
    date_reference: "james_apostle", # 25/7
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 45:1-5",
    psalm: "7:1-10",
    second_reading: "Atos 11:27—12:3",
    gospel: "Mateus 20:20-28"
  },
  {
    date_reference: "transfiguration", # 6/8
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êxodo 34:29-35",
    psalm: "99 ou 99:5-9",
    second_reading: "II Pedro 1:13-21",
    gospel: "Lucas 9:28-36"
  },
  {
    date_reference: "blessed_virgin_mary", # 15/8
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaias 61:10-11",
    psalm: "34 ou 34:1-9",
    second_reading: "Gálatas 4:4-7",
    gospel: "Lucas 1:46-55"
  },
  {
    date_reference: "bartholomew", # 24/8
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 18:15-18",
    psalm: "91 ou 91:1-4",
    second_reading: "I Coríntios 4:9-15",
    gospel: "Lucas 22:24-30"
  },
  {
    date_reference: "independence_day_brazil", # 7/9
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 10:17-21",
    psalm: "145 ou 145:1-9",
    second_reading: "Hebreus 11:8-16",
    gospel: "Mateus 5:43-48"
  },
  {
    date_reference: "holy_cross", # 14/9
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaias 45:21-25",
    psalm: "98 ou 98:1-4",
    second_reading: "Filipenses 2:5-11 ou Gálatas 6:14-18",
    gospel: "João 12:3 1-36a"
  },
  {
    date_reference: "matthew", # 21/9
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Provérbios 3:1-6",
    psalm: "119:33-40",
    second_reading: "II Timóteo 3:14-17",
    gospel: "Mateus 9:9-13"
  },
  {
    date_reference: "michael_and_all_angels", # 29/9
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Gênesis 28:10-17",
    psalm: "103 ou 103:19-22",
    second_reading: "Apocalipse 12:7-12",
    gospel: "João 1:47-51"
  },
  {
    date_reference: "luke", # 18/10
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Eclesiástico 38:1-4,6-10,12-14",
    psalm: "147 ou 147:1-7",
    second_reading: "II Timóteo 4:5-13",
    gospel: "Lucas 4:14-21"
  },
  {
    date_reference: "james_of_jerusalem", # 23/10 (São Tiago de Jerusalém)
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 15:12-22a",
    psalm: "1",
    second_reading: "I Coríntios 15:1-11",
    gospel: "Mateus 13:54-58"
  },
  {
    date_reference: "simon_and_jude", # 28/10
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 32:1-4",
    psalm: "119:89-96",
    second_reading: "Efésios 2:13-22",
    gospel: "João 15:17-27"
  },
  {
    date_reference: "all_saints", # 1/11
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Eclesiástico 44:1-10,13-14",
    psalm: "149",
    second_reading: "Apocalipse 7:2-4,9-17",
    gospel: "Mateus 5:1-12"
  },
  {
    date_reference: "all_saints_alt", # 1/11 Option 2
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Eclesiástico 2:(1-6)7-11",
    psalm: "149 ou 149",
    second_reading: "Efésios 1 :(11-14)15-23",
    gospel: "Lucas 6:20-26(27-36)"
  },
  {
    date_reference: "thanksgiving", # Dia de Ação de Graças
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 8:1-3,6-10 (17-20)",
    psalm: "65 ou 65:9-14",
    second_reading: "Tiago 1:17-18,21-27",
    gospel: "Mateus 6:25-33"
  }
]

# Map date_reference to celebration name in LOC 1987
CELEBRATION_NAME_MAP = {
  "andrew" => "Santo André, Apóstolo",
  "thomas_apostle" => "São Tomé, Apóstolo",
  "stephen" => "Santo Estevão, Diácono e Mártir",
  "john_evangelist" => "São João, Apóstolo e Evangelista",
  "holy_innocents" => "Santos Inocentes",
  "confession_of_peter" => "Confissão de São Pedro Apóstolo",
  "conversion_of_paul" => "Conversão de São Paulo Apóstolo",
  "presentation" => "Apresentação de Nosso Senhor Jesus Cristo no Templo",
  "matthias" => "São Matias, Apóstolo",
  "joseph" => "São José",
  "annunciation" => "Anunciação da Bem-Aventurada Virgem Maria",
  "mark" => "São Marcos, Evangelista",
  "philip_and_james" => "São Felipe e São Tiago, Apóstolos",
  "visitation" => "Visitação da Bem-Aventurada Virgem Maria",
  "barnabas" => "São Barnabé, Apóstolo",
  "nativity_of_john_the_baptist" => "Natividade de São João Batista",
  "peter_and_paul" => "São Pedro e São Paulo, Apóstolos",
  "mary_magdalene" => "Santa Maria Madalena",
  "james_apostle" => "São Tiago, Apóstolo",
  "transfiguration" => "Transfiguração de Nosso Senhor Jesus Cristo",
  "blessed_virgin_mary" => "Bem-Aventurada Virgem Maria, Mãe de Nosso Senhor Jesus Cristo",
  "bartholomew" => "São Bartolomeu, Apóstolo",
  "independence_day_brazil" => "Dia da Pátria",
  "holy_cross" => "Dia da Santa Cruz",
  "matthew" => "São Mateus, Apóstolo e Evangelista",
  "michael_and_all_angels" => "São Miguel e Todos os Anjos",
  "luke" => "São Lucas, Evangelista",
  "james_of_jerusalem" => "São Tiago de Jerusalém, Irmão de Nosso Senhor Jesus Cristo, Mártir",
  "simon_and_jude" => "São Simão e São Judas, Apóstolos",
  "all_saints" => "Dia de Todos os Santos",
  "all_saints_alt" => "Dia de Todos os Santos",
  "thanksgiving" => "Dia Nacional de Ação de Graças"
}.freeze

# Create records if not present
count = 0
skipped = 0
holy_days.each do |r|
  r[:prayer_book_id] = prayer_book.id

  # Find and link celebration
  cel_name = CELEBRATION_NAME_MAP[r[:date_reference]]
  celebration = Celebration.find_by(name: cel_name, prayer_book_id: prayer_book.id) if cel_name
  r[:celebration_id] = celebration&.id

  existing = LectionaryReading.find_by(
    date_reference: r[:date_reference],
    cycle: r[:cycle],
    service_type: r[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    existing.update!(r)
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras de Dias Santos (LOC 1987) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
