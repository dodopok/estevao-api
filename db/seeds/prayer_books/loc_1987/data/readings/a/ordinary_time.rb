# ================================================================================
# LEITURAS - TEMPO COMUM / PRÓPRIOS - LOC 1987 - ANO A
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Comum (Próprios) - LOC 1987 - Ano A..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

ordinary_readings = [
  {
    date_reference: "proper_1",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Eclesiástico 15:11-20",
    psalm: "119:1-16",
    second_reading: "I Coríntios 3:1-9",
    gospel: "Mateus 5:21-24,27-30,33-37"
  },
  {
    date_reference: "proper_2",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Levítico 15:11-20",
    psalm: "71 ou 71:16-24",
    second_reading: "I Coríntios 3:10-11,16-23",
    gospel: "Mateus 5:38-48"
  },
  {
    date_reference: "proper_3",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 49:8-18",
    psalm: "62 ou 62:6-14",
    second_reading: "I Coríntios 4:1-5(6-7)8-13",
    gospel: "Mateus 6:24-34"
  },
  {
    date_reference: "proper_4",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronômio 11:18-21,28-28",
    psalm: "31 ou 31:1-5,19-24",
    second_reading: "Romanos 3:21-25a,28",
    gospel: "Mateus 7:21-27"
  },
  {
    date_reference: "proper_5",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Oséias 5:15-6:6",
    psalm: "50 ou 50:7-15",
    second_reading: "Romanos 4:13-18",
    gospel: "Mateus 9:9-13"
  },
  {
    date_reference: "proper_6",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 19:2-8a",
    psalm: "100",
    second_reading: "Romanos 5:6-11",
    gospel: "Mateus 9:35-10:8(9-15)"
  },
  {
    date_reference: "proper_7",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jeremias 20:7-13",
    psalm: "69:1-18 ou 69:7-10,16-18",
    second_reading: "Romanos 5:15b-19",
    gospel: "Mateus 10:(16-23)24-33"
  },
  {
    date_reference: "proper_8",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 2:10-17",
    psalm: "89:1-18 ou 89:1-18",
    second_reading: "Romanos 6:3-11",
    gospel: "Mateus 10:34-42"
  },
  {
    date_reference: "proper_9",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Zacarias 9:9-12",
    psalm: "145 ou 145:8-14",
    second_reading: "Romanos 7:21-8:6",
    gospel: "Mateus 11:25-30"
  }
]

# create
count = 0
skipped = 0
ordinary_readings.each do |r|
  r[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(date_reference: r[:date_reference], cycle: r[:cycle], service_type: r[:service_type], prayer_book_id: prayer_book.id)
  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Tempo Comum (próprios iniciais) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0

# ------------------------------------------------------------------------------
# Próprios adicionais (10 → 29)
# ------------------------------------------------------------------------------

additional = [
  {
    date_reference: "proper_10",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 55:1-5,10-13",
    psalm: "65 ou 65:9-14",
    second_reading: "Romanos 8:9-17",
    gospel: "Mateus 13:1-9,18-23"
  },
  {
    date_reference: "proper_11",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Sabedoria 12:13,16-19",
    psalm: "86 ou 86:11-17",
    second_reading: "Romanos 8:18-25",
    gospel: "Mateus 13:24-30,36-43"
  },
  {
    date_reference: "proper_12",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "I Reis 3:5-12",
    psalm: "119:121-136 ou 119:129-136",
    second_reading: "Romanos 8:26-34",
    gospel: "Mateus 13:31-33,44-49a"
  },
  {
    date_reference: "proper_13",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Neemias 9:16-20",
    psalm: "78:1-29 ou 78:14-20,23-25",
    second_reading: "Romanos 8:35-39",
    gospel: "Mateus 14:13-21"
  },
  {
    date_reference: "proper_14",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jonas 2:1-9",
    psalm: "29",
    second_reading: "Romanos 9:1-5",
    gospel: "Mateus 14:22-33"
  },
  {
    date_reference: "proper_15",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 56:1-2(5-6)6-7",
    psalm: "67",
    second_reading: "Romanos 11:13-15,29-32",
    gospel: "Mateus 15:21-28"
  },
  {
    date_reference: "proper_16",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 51:1-6",
    psalm: "138",
    second_reading: "Romanos 11:33-36",
    gospel: "Mateus 16:13-20"
  },
  {
    date_reference: "proper_17",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jeremias 15:15-21",
    psalm: "26 ou 16:1-8",
    second_reading: "Romanos 12:1-8",
    gospel: "Mateus 16:21-27"
  },
  {
    date_reference: "proper_18",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 33:1-6(7-11)",
    psalm: "119:33-48 ou 119:33-40",
    second_reading: "Romanos 12:9-21",
    gospel: "Mateus 18:15-20"
  },
  {
    date_reference: "proper_19",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Eclesiástico 27:30-28:7",
    psalm: "103 ou 103:8-13",
    second_reading: "Romanos 14:5-12",
    gospel: "Mateus 18:21-35"
  },
  {
    date_reference: "proper_20",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jonas 3:10-4:11",
    psalm: "145 ou 145:1-8",
    second_reading: "Filipenses 1:21-27",
    gospel: "Mateus 20:1-16"
  },
  {
    date_reference: "proper_21",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 18:1-4,25-32",
    psalm: "25:1-14 ou 25:3-9",
    second_reading: "Filipenses 2:1-13",
    gospel: "Mateus 21:28-32"
  },
  {
    date_reference: "proper_22",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 5:1-7",
    psalm: "80 ou 80:7-14",
    second_reading: "Filipenses 3:14-21",
    gospel: "Mateus 21:33-43"
  },
  {
    date_reference: "proper_23",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 25:1-9",
    psalm: "23",
    second_reading: "Filipenses 4:4-13",
    gospel: "Mateus 22:1-14"
  },
  {
    date_reference: "proper_24",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 45:1-7",
    psalm: "96 ou 96:1-9",
    second_reading: "I Tessalonicenses 1:1-10",
    gospel: "Mateus 22:15-22"
  },
  {
    date_reference: "proper_25",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 22:21-27",
    psalm: "1",
    second_reading: "I Tessalonicenses 2:1-8",
    gospel: "Mateus 22:34-46"
  },
  {
    date_reference: "proper_26",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Miquéias 3:5-12",
    psalm: "43",
    second_reading: "I Tessalonicenses 2:9-13,17-20",
    gospel: "Mateus 23:1-12"
  },
  {
    date_reference: "proper_27",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Amós",
    psalm: "70",
    second_reading: "I Tessalonicenses 4:13-18",
    gospel: "Mateus 25:1-13"
  },
  {
    date_reference: "proper_28",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Sofonias 1:7,12-18",
    psalm: "90 ou 90:1-8,12",
    second_reading: "I Tessalonicenses 5:1-10",
    gospel: "Mateus 25:14-15,19-29"
  },
  {
    date_reference: "proper_29",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 34:11-17",
    psalm: "95:1-7",
    second_reading: "I Coríntios 15:20-28",
    gospel: "Mateus 25:31-46"
  }
]

additional.each do |r|
  r[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(date_reference: r[:date_reference], cycle: r[:cycle], service_type: r[:service_type], prayer_book_id: prayer_book.id)
  if existing.nil?
    LectionaryReading.create!(r)
    print "." if rand(10) == 0
  end
end

Rails.logger.info "\n✅ Próprios 10→29 importados (quando não existentes)"

