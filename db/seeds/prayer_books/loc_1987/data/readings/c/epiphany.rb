# ================================================================================
# LEITURAS - EPIFANIA E PERÍODO SEGUINTE - LOC 1987 - ANO C
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Epifania (LOC 1987) - Ano C..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

epiphany_readings = [
  {
    date_reference: "epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 60:1-6,9",
    psalm: "72 ou 72:1-2,10-17",
    second_reading: "Efésios 3:1-12",
    gospel: "Mateus 2:1 12"
  },
  {
    date_reference: "1st_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "89:1-29 ou 89:20-29",
    second_reading: "Atos 10:34-38",
    gospel: "Lucas 3:15-16,21-22"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 62:1-5",
    psalm: "96 ou 96:1-10",
    second_reading: "I Coríntios 12:1-11",
    gospel: "João 2:1-11"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Neemias 8:2-10",
    psalm: "113",
    second_reading: "I Coríntios 12:12-27",
    gospel: "Lucas 4:14-21"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 4:1-10",
    psalm: "71:1-17 ou 71:1-6,15-17",
    second_reading: "I Coríntios 14:12b-20",
    gospel: "Lucas 4:21-32"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Juízes 6:11-24a",
    psalm: "85 ou 85:7-15",
    second_reading: "I Coríntios 15:1-11",
    gospel: "Lucas 5:1-11"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 17:5-10",
    psalm: "1",
    second_reading: "I Coríntios 15:12-20",
    gospel: "Lucas 6:17-26"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 45:3-11,21-28",
    psalm: "37:1-18 ou 37:3-10",
    second_reading: "I Coríntios 15:35-38,42-50",
    gospel: "Lucas 6:27-38"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 7:1-7(8-15)",
    psalm: "92 ou 92:1-5,11-14",
    second_reading: "I Coríntios 15:50-58",
    gospel: "Lucas 6:39-49"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 34:29-35",
    psalm: "99",
    second_reading: "I Coríntios 12:27 - 13:13",
    gospel: "Lucas 9:28-36"
  },
  {
    date_reference: "ash_wednesday",
    cycle: "C",
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

Rails.logger.info "\n✅ #{count} leituras da Epifania (Ano C) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
