# ================================================================================
# LEITURAS - TEMPO COMUM (Ordinary Time) - LOC 1987 - ANO B
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Comum (LOC 1987) - Ano B..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

ordinary_readings = [
  {
    date_reference: "proper_1",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "II Reis 5:1-15ab",
    psalm: "42 ou 42:1-7",
    second_reading: "I Coríntios 9:24-27",
    gospel: "Marcos 1:40-45"
  },
  {
    date_reference: "proper_2",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 43:18-25",
    psalm: "32 ou 32:1-8",
    second_reading: "II Coríntios 1:18-22",
    gospel: "Marcos 2:1-12"
  },
  {
    date_reference: "proper_3",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Oséias 2:14-23",
    psalm: "103 ou 103:1-6",
    second_reading: "II Coríntios 3:(4-11)17-4:2",
    gospel: "Marcos 2:18-22"
  },
  {
    date_reference: "proper_4",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 5:6-21",
    psalm: "81 ou 81:1-10",
    second_reading: "II Coríntios 4:5-12",
    gospel: "Marcos 2:23-28"
  },
  {
    date_reference: "proper_5",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 3:(1-7)8-21",
    psalm: "130",
    second_reading: "II Coríntios 4:13-18",
    gospel: "Marcos 3:20-35"
  },
  {
    date_reference: "proper_6",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ezequiel 31:1-6,10-14",
    psalm: "92 ou 92:1-4,11-14",
    second_reading: "II Coríntios 5:1-10",
    gospel: "Marcos 4:26-34"
  },
  {
    date_reference: "proper_7",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jó 38:1-11,16-18",
    psalm: "107:1-32 ou 107:1-3,23-32",
    second_reading: "II Coríntios 5:14-21",
    gospel: "Marcos 4:35-41(5:1-20)"
  },
  {
    date_reference: "proper_8",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 15:7-11",
    psalm: "112",
    second_reading: "II Coríntios 8:1-9,13-15",
    gospel: "Marcos 5:22-24,35b-43"
  },
  {
    date_reference: "proper_9",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ezequiel 2:1-7",
    psalm: "123",
    second_reading: "II Coríntios 12:2-10",
    gospel: "Marcos 6:1-6"
  },
  {
    date_reference: "proper_10",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amós 7:7-15",
    psalm: "85 ou 85:7-13",
    second_reading: "Efésios 1:1-14",
    gospel: "Marcos 6:7-13"
  },
  {
    date_reference: "proper_11",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 57:14b-21",
    psalm: "22:22-30",
    second_reading: "Efésios 2:11-22",
    gospel: "Marcos 6:30-44"
  },
  {
    date_reference: "proper_12",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "II Reis 2:1-15",
    psalm: "114",
    second_reading: "Efésios 4:1-7,11-16",
    gospel: "Marcos 6:45-52"
  },
  {
    date_reference: "proper_13",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Êxodo 16:2-4,9-15",
    psalm: "78:1-25 ou 78:14-20,23-25",
    second_reading: "Efésios 4:17-25",
    gospel: "João 6:24-35"
  },
  {
    date_reference: "proper_14",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 8:1-10",
    psalm: "34 ou 34:1-8",
    second_reading: "Efésios 4:(25-29)30-5:2",
    gospel: "João 6:37-51"
  },
  {
    date_reference: "proper_15",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Provérbios 9:1-6",
    psalm: "147 ou 34:9-14",
    second_reading: "Efésios 5:15-20",
    gospel: "João 6:53-59"
  },
  {
    date_reference: "proper_16",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Josué 24:1-2a,14-25",
    psalm: "16 ou 34:15-22",
    second_reading: "Efésios 5:21-33",
    gospel: "João 6:60-69"
  },
  {
    date_reference: "proper_17",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 4:1-9",
    psalm: "15",
    second_reading: "Efésios 6:10-20",
    gospel: "Marcos 7:1-8,14-15,21-23"
  },
  {
    date_reference: "proper_18",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 35:4-7",
    psalm: "146 ou 146:4-9",
    second_reading: "Tiago 1:17-27",
    gospel: "Marcos 7:31-37"
  },
  {
    date_reference: "proper_19",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 50:4-9",
    psalm: "116:1-8 ou 116",
    second_reading: "Tiago 2:1-5,8-10,14-18",
    gospel: "Marcos 8:27-38 ou Marcos 9:14-29"
  },
  {
    date_reference: "proper_20",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Sabedoria 1:16-2:1(6-11),12-22",
    psalm: "54",
    second_reading: "Tiago 3:16-4:6",
    gospel: "Marcos 9:30-37"
  },
  {
    date_reference: "proper_21",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Números 11:4-6,10-16,24-29",
    psalm: "19 ou 19:7-14",
    second_reading: "Tiago 4:7-12(13-5:6)",
    gospel: "Marcos 9:38-43,45,47-48"
  },
  {
    date_reference: "proper_22",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 2:18-24",
    psalm: "8 ou 128",
    second_reading: "Hebreus 2:(1-8)9-18",
    gospel: "Marcos 10:2-9"
  },
  {
    date_reference: "proper_23",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amós 5:6-7,10-15",
    psalm: "90 ou 90:1-8,12",
    second_reading: "Hebreus 3:1-6",
    gospel: "Marcos 10:17-27(28-31)"
  },
  {
    date_reference: "proper_24",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 53:4-12",
    psalm: "91 ou 91:9-16",
    second_reading: "Hebreus 4:12-16",
    gospel: "Marcos 10:35-45"
  },
  {
    date_reference: "proper_25",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 59:(1-4)9-19",
    psalm: "13",
    second_reading: "Hebreus 5:12-6:1,9-12",
    gospel: "Marcos 10:46-52"
  },
  {
    date_reference: "proper_26",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 6:1-9",
    psalm: "119:1-16 ou 119:1-8",
    second_reading: "Hebreus 7:23-28",
    gospel: "Marcos 12:28-34"
  },
  {
    date_reference: "proper_27",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "I Reis 17:8-16",
    psalm: "146 ou 146:4-9",
    second_reading: "Hebreus 9:24-28",
    gospel: "Marcos 12:38-48"
  },
  {
    date_reference: "proper_28",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Daniel 12:1-4a(5-13)",
    psalm: "16 ou 16:5-11",
    second_reading: "Hebreus 10:31-39",
    gospel: "Marcos 13:14-23"
  },
  {
    date_reference: "proper_29",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Daniel 7:9-14",
    psalm: "93",
    second_reading: "Apocalipse 1:1-8",
    gospel: "João 18:33-37 ou Marcos 11:1-11"
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

Rails.logger.info "\n✅ #{count} leituras do Tempo Comum (Ano B) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
