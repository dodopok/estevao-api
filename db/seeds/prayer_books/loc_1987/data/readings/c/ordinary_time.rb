# ================================================================================
# LEITURAS - TEMPO COMUM (Ordinary Time) - LOC 1987 - ANO C
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Comum (LOC 1987) - Ano C..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

ordinary_readings = [
  {
    date_reference: "proper_1",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 17:5-17",
    psalm: "1",
    second_reading: "I Coríntios 15:12-20",
    gospel: "Lucas 6:17-26"
  },
  {
    date_reference: "proper_2",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 45:3-11,21-28",
    psalm: "37:1-18 ou 37:3-10",
    second_reading: "I Coríntios 15:35-38,42-50",
    gospel: "Lucas 6:27-38"
  },
  {
    date_reference: "proper_3",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 7:1-7(8-15)",
    psalm: "92 ou 92:1-5,11-14",
    second_reading: "I Coríntios 15:50-58",
    gospel: "Lucas 6:39-49"
  },
  {
    date_reference: "proper_4",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "I Reis 8:22-23,27-30,41-43",
    psalm: "96 ou 96:1-9",
    second_reading: "Gálatas 1:1-10",
    gospel: "Lucas 7:1-10"
  },
  {
    date_reference: "proper_5",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "I Reis 17:17-24",
    psalm: "30 ou 30:1-6,12-13",
    second_reading: "Gálatas 1:11-24",
    gospel: "Lucas 7:11-17"
  },
  {
    date_reference: "proper_6",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "II Samuel 11:26-12:10,13-15",
    psalm: "32 ou 32:1-8",
    second_reading: "Gálatas 2:11-21",
    gospel: "Lucas 7:36-50"
  },
  {
    date_reference: "proper_7",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Zacarias 12:8-10,13:1",
    psalm: "63:1-8",
    second_reading: "Gálatas 3:23-29",
    gospel: "Lucas 9:18-24"
  },
  {
    date_reference: "proper_8",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "I Reis 19:15-16,19-21",
    psalm: "16 ou 16:5-11",
    second_reading: "Gálatas 5:1,13-25",
    gospel: "Lucas 9:51-62"
  },
  {
    date_reference: "proper_9",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 66:10-16",
    psalm: "66 ou 66:1-8",
    second_reading: "Gálatas 6:(1-10)14-18",
    gospel: "Lucas 10:1-12,16-20"
  },
  {
    date_reference: "proper_10",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30:9-14",
    psalm: "25 ou 25:3-9",
    second_reading: "Colossenses 1:1-14",
    gospel: "Lucas 10:25-37"
  },
  {
    date_reference: "proper_11",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 18:1-10a(10b-14)",
    psalm: "15",
    second_reading: "Colossenses 1:21-29",
    gospel: "Lucas 10:38-42"
  },
  {
    date_reference: "proper_12",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 18:20-33",
    psalm: "138",
    second_reading: "Colossenses 2:6-15",
    gospel: "Lucas 11:1-13"
  },
  {
    date_reference: "proper_13",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Eclesiastes 1:12-14,2:(1-7,11)18-23",
    psalm: "49 ou 49:1-11",
    second_reading: "Colossenses 3:(5-11)12-17",
    gospel: "Lucas 12:13-21"
  },
  {
    date_reference: "proper_14",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 15:1-6",
    psalm: "33 ou 33:12-15,18-22",
    second_reading: "Hebreus 11:1-3,(4-7)8-16",
    gospel: "Lucas 12:32-40"
  },
  {
    date_reference: "proper_15",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 23:23-29",
    psalm: "82",
    second_reading: "Hebreus 12:1-7,(8-10)11-14",
    gospel: "Lucas 12:49-56"
  },
  {
    date_reference: "proper_16",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 28:14-22",
    psalm: "46",
    second_reading: "Hebreus 12:18-19,22-29",
    gospel: "Lucas 13:22-30"
  },
  {
    date_reference: "proper_17",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Eclesiástico 10:(7-11)12-18",
    psalm: "112",
    second_reading: "Hebreus 13:1-8",
    gospel: "Lucas 14:1,7-14"
  },
  {
    date_reference: "proper_18",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30:15-20",
    psalm: "1",
    second_reading: "Filemom 1:1-20",
    gospel: "Lucas 14:25-33"
  },
  {
    date_reference: "proper_19",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 32:1,7-14",
    psalm: "51:1-18 ou 51:1-11",
    second_reading: "I Timóteo 1:12-17",
    gospel: "Lucas 15:1-10"
  },
  {
    date_reference: "proper_20",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amós 8:4-7(8-12)",
    psalm: "138",
    second_reading: "I Timóteo 2:1-8",
    gospel: "Lucas 16:1-13"
  },
  {
    date_reference: "proper_21",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amós 6:1-7",
    psalm: "146 ou 146:4-9",
    second_reading: "I Timóteo 6:11-19",
    gospel: "Lucas 16:19-31"
  },
  {
    date_reference: "proper_22",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Habacuque 1:1-6(7-11)12-13;2:1-4",
    psalm: "37:1-18 ou 37:3-10",
    second_reading: "II Timóteo 1:(1-5)6-14",
    gospel: "Lucas 17:5-10"
  },
  {
    date_reference: "proper_23",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Rute 1:(1-7)8-19a",
    psalm: "113",
    second_reading: "II Timóteo 2:(3-7)8-15",
    gospel: "Lucas 17:11-19"
  },
  {
    date_reference: "proper_24",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 32:3-8,22-30",
    psalm: "121",
    second_reading: "II Timóteo 3:14 - 4:5",
    gospel: "Lucas 18:1-8a"
  },
  {
    date_reference: "proper_25",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 14:(1-6)7-10,19-22",
    psalm: "84 ou 84:1-6",
    second_reading: "II Timóteo 4:6-8,16-18",
    gospel: "Lucas 18:9-14"
  },
  {
    date_reference: "proper_26",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 1:10-20",
    psalm: "32 ou 32:1-8",
    second_reading: "II Tessalonicenses 1:1-5(6-10)11-12",
    gospel: "Lucas 19:1-10"
  },
  {
    date_reference: "proper_27",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jó 19:23-27a",
    psalm: "17 ou 17:1-8",
    second_reading: "II Tessalonicenses 2:13 - 3:5",
    gospel: "Lucas 20:27,(28-33)34-38"
  },
  {
    date_reference: "proper_28",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Malaquias 3:13 - 4:2a,5-6",
    psalm: "98 ou 98:5-10",
    second_reading: "II Tessalonicenses 3:6-13",
    gospel: "Lucas 21:5-19"
  },
  {
    date_reference: "proper_29",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 23:1-6",
    psalm: "46",
    second_reading: "Colossenses 1:11-20",
    gospel: "Lucas 23:35-43 ou Lucas 19:29-38"
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

Rails.logger.info "\n✅ #{count} leituras do Tempo Comum (Ano C) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
