# ================================================================================
# LEITURAS - TEMPO PASCAL (Easter Season) - LOC 1987 - ANO C
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Pascal (LOC 1987) - Ano C..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

easter_readings = [
  {
    date_reference: "easter_evening",
    cycle: "C",
    service_type: "evening_prayer",
    first_reading: "Atos 5:29a,30-32 ou Daniel 12:1-3",
    psalm: "114 ou 136 ou 118:14-17,22-24",
    second_reading: "I Coríntios 5:6b-8 ou Atos 5:29a,30-32",
    gospel: "Lucas 24:13-35"
  },
  {
    date_reference: "easter_monday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 2:14,22-32",
    psalm: "16:8-11 ou 118:19-24",
    second_reading: nil,
    gospel: "Mateus 28:9-15"
  },
  {
    date_reference: "easter_tuesday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 2:36-41",
    psalm: "33:18-22 ou 118:19-24",
    second_reading: nil,
    gospel: "João 20:11-18"
  },
  {
    date_reference: "easter_wednesday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 3:1-10",
    psalm: "105:1-8 ou 118:19-24",
    second_reading: nil,
    gospel: "Lucas 24:13-35"
  },
  {
    date_reference: "easter_thursday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 3:11-26",
    psalm: "8 ou 114 ou 118:19-24",
    second_reading: nil,
    gospel: "Lucas 24:36b-48"
  },
  {
    date_reference: "easter_friday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 4:1-12",
    psalm: "116:1-8 ou 118:19-24",
    second_reading: nil,
    gospel: "João 21:1-14"
  },
  {
    date_reference: "easter_saturday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 4:13-21",
    psalm: "118:14-18 ou 118:19-24",
    second_reading: nil,
    gospel: "Marcos 16:9-15,20"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 5:12a,17-22,25-29 ou Jó 42:1-6",
    psalm: "111 ou 118:19-24",
    second_reading: "Apocalipse 1:1-8,9-19 ou Atos 5:12a,17-22,25-29",
    gospel: "João 20:19-31"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 9:1-19a ou Jeremias 32:36-41",
    psalm: "33 ou 33:1-11",
    second_reading: "Apocalipse 5:6-14 ou Atos 9:1-19a",
    gospel: "João 21:1-14"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 13:15-16,26-33(34-39) ou Números 27:12-23",
    psalm: "100",
    second_reading: "Apocalipse 7:9-17 ou Atos 13:15-16,26-33(34-39)",
    gospel: "João 10:22-30"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 13:44-52 ou Levítico 19:1-2,9-18",
    psalm: "145 ou 145:1-9",
    second_reading: "Apocalipse 19:1,4-9 ou Atos 13:44-52",
    gospel: "João 13:31-35"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 14:8-18 ou Joel 2:21-27",
    psalm: "67",
    second_reading: "Apocalipse 21:22 - 22:5 ou Atos 14:8-18",
    gospel: "João 14:23-29"
  },
  {
    date_reference: "ascension_day",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 1:1-11 ou II Reis 2:1-15",
    psalm: "47 ou 110:1-5",
    second_reading: "Efésios 1:15-23 ou Atos 1:1-11",
    gospel: "Lucas 24:49-53 ou Marcos 16:9-15,19-20"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 16:16-34 ou I Samuel 12:19-24",
    psalm: "68:1-20 ou 47",
    second_reading: "Apocalipse 22:12-14,16-17,20 ou Atos 16:16-34",
    gospel: "João 17:20-26"
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

Rails.logger.info "\n✅ #{count} leituras do Tempo Pascal (Ano C) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
