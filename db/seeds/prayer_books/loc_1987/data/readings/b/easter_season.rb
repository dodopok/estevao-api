# ================================================================================
# LEITURAS - TEMPO PASCAL (Easter Season) - LOC 1987 - ANO B
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Pascal (LOC 1987) - Ano B..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

easter_readings = [
  {
    date_reference: "easter_evening",
    cycle: "B",
    service_type: "evening_prayer",
    first_reading: "Atos 5:29a,30-32 ou Daniel 12:1-3",
    psalm: "114 ou 136 ou 118:14-17,22-24",
    second_reading: "I Coríntios 5:6b-8 ou Atos 5:29a,30-32",
    gospel: "Lucas 24:13-35"
  },
  {
    date_reference: "easter_monday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 2:14,22-32",
    psalm: "16:8-11 ou 118:19-24",
    second_reading: nil,
    gospel: "Mateus 28:9-15"
  },
  {
    date_reference: "easter_tuesday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 2:36-41",
    psalm: "33:18-22 ou 118:19-24",
    second_reading: nil,
    gospel: "João 20:11-18"
  },
  {
    date_reference: "easter_wednesday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 3:1-10",
    psalm: "105:1-8 ou 118:19-24",
    second_reading: nil,
    gospel: "Lucas 24:13-35"
  },
  {
    date_reference: "easter_thursday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 3:11-26",
    psalm: "8 ou 114 ou 118:19-24",
    second_reading: nil,
    gospel: "Lucas 24:36b-48"
  },
  {
    date_reference: "easter_friday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 4:1-12",
    psalm: "116:1-8 ou 118:19-24",
    second_reading: nil,
    gospel: "João 21:1-14"
  },
  {
    date_reference: "easter_saturday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 4:13-21",
    psalm: "118:14-18 ou 118:19-24",
    second_reading: nil,
    gospel: "Marcos 16:9-15,20"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 3:12a,13-15,17-26 ou Isaías 26:2-9,19",
    psalm: "111 ou 118:19-24",
    second_reading: "I João 5:1-6 ou Atos 3:12a,13-15,17-26",
    gospel: "João 20:19-31"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 4:5-12 ou Miquéias 4:1-5",
    psalm: "98 ou 98:1-5",
    second_reading: "I João 1:1-2:2 ou Atos 4:5-12",
    gospel: "Lucas 24:36b-48"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 4:(23-31)32-37 ou Ezequiel 34:1-10",
    psalm: "23 ou 100",
    second_reading: "I João 3:1-8 ou Atos 4:(23-31)32-37",
    gospel: "João 10:11-16"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 8:26-40 ou Deuteronômio 4:32-40",
    psalm: "66:1-11 ou 66:1-8",
    second_reading: "I João 3:(14-17)18-24 ou Atos 8:26-40",
    gospel: "João 14:15-21"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 11:19-30 ou Isaías 45:11-13,18-19",
    psalm: "33 ou 33:1-8,18-22",
    second_reading: "I João 4:7-21 ou Atos 11:19-30",
    gospel: "João 15:9-17"
  },
  {
    date_reference: "ascension_day",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 1:1-11 ou Ezequiel 1:3-5a,15-22,26-28",
    psalm: "47 ou 110:1-5",
    second_reading: "Efésios 1:15-23 ou Atos 1:1-11",
    gospel: "Lucas 24:49-53 ou Marcos 16:9-15,19-20"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 1:15-26 ou Êxodo 28:1-4,9-10,29-30",
    psalm: "68:1-20 ou 47",
    second_reading: "I João 5:9-15 ou Atos 1:15-26",
    gospel: "João 17:11b-19"
  }
]

# create
count = 0
skipped = 0
easter_readings.each do |r|
  r[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(date_reference: r[:date_reference], cycle: r[:cycle], service_type: r[:service_type], prayer_book_id: prayer_book.id)
  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Tempo Pascal (Ano B) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
