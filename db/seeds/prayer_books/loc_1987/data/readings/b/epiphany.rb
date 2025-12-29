# ================================================================================
# LEITURAS - EPIFANIA E PERÍODO SEGUINTE - LOC 1987 - ANO B
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Epifania (LOC 1987) - Ano B..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

epiphany_readings = [
  {
    date_reference: "epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 60:1-6,9",
    psalm: "72 ou 72:1-2,10-17",
    second_reading: "Efésios 3:1-12",
    gospel: "Mateus 2:1-12"
  },
  {
    date_reference: "1st_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "89:1-29 ou 89:20-29",
    second_reading: "Atos 10:34-38",
    gospel: "Marcos 1:7-11"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "I Samuel 3:1-10(11-20)",
    psalm: "61:1-8",
    second_reading: "I Coríntios 6:11b-20",
    gospel: "João 1:43-51"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 3:21-4:2",
    psalm: "130",
    second_reading: "I Coríntios 7:17-23",
    gospel: "Marcos 1:14-20"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 18:15-20",
    psalm: "111",
    second_reading: "I Coríntios 8:1b-13",
    gospel: "Marcos 1:21-28"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "II Reis 4:(8-17)18-21,(22-31)32-37",
    psalm: "142",
    second_reading: "I Coríntios 9:16-23",
    gospel: "Marcos 1:29-39"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "II Reis 5:1-15ab",
    psalm: "42 ou 42:1-7",
    second_reading: "I Coríntios 9:24-27",
    gospel: "Marcos 1:40-45"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 43:18-25",
    psalm: "32 ou 32:1-8",
    second_reading: "II Coríntios 1:18-22",
    gospel: "Marcos 2:1-12"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Oséias 2:14-23",
    psalm: "103 ou 103:1-6",
    second_reading: "II Coríntios 3:(4-11)17-4:2",
    gospel: "Marcos 2:18-22"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "I Reis 19:9-18",
    psalm: "27 ou 27:5-11",
    second_reading: "II Pedro 1:16-19(20-21)",
    gospel: "Marcos 9:2-9"
  },
  {
    date_reference: "ash_wednesday",
    cycle: "B",
    service_type: "morning_prayer",
    first_reading: "Joel 2:1-2,12-17 ou Isaías 58:1-12",
    psalm: "103 ou 103:8-14",
    second_reading: "II Coríntios 5:20b-6:10",
    gospel: "Mateus 6:1-6,16-21"
  }
]

# create
count = 0
skipped = 0
epiphany_readings.each do |r|
  r[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(date_reference: r[:date_reference], cycle: r[:cycle], service_type: r[:service_type], prayer_book_id: prayer_book.id)
  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras da Epifania (Ano B) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
