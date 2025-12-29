# ================================================================================
# LEITURAS - EPIFANIA E PERÍODO SEGUINTE - LOC 1987 - ANO A
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Epifania (LOC 1987) - Ano A..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

epiphany_readings = [
  {
    date_reference: "epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 60:1-6,9",
    psalm: "72 ou 72:1-2,10-17",
    second_reading: "Efésios 3:1-12",
    gospel: "Mateus 2:1-12"
  },
  {
    date_reference: "1st_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "89:1-29 ou 89:20-29",
    second_reading: "Atos 10:34-38",
    gospel: "Mateus 3:13-17"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 49:1-7",
    psalm: "40:1-10",
    second_reading: "I Coríntios 1:1-9",
    gospel: "João 1:29-41"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Amós 3:1-8",
    psalm: "139:1-7 ou 139:1-11",
    second_reading: "I Coríntios 1:10-17",
    gospel: "Mateus 4:12-23"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Miquéias 6:1-8",
    psalm: "37:1-18 ou 37:1-6",
    second_reading: "I Coríntios 1: (18-25)26-31",
    gospel: "Mateus 5:1-12"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Habacuque 3:1-6,17-19",
    psalm: "27 ou 27:1-7",
    second_reading: "I Coríntios 2:1-11",
    gospel: "Mateus 5:13-20"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Eclesiástico 15:11-20",
    psalm: "119:1-16 ou 119:9-16",
    second_reading: "I Coríntios 3:1-9",
    gospel: "Mateus 5:21-24,27-30,33-37"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Levítico 19:1-2,9-18",
    psalm: "71 ou 71:16-24",
    second_reading: "I Coríntios 3:10-11,16-23",
    gospel: "Mateus 5:38-48"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 49:8-18",
    psalm: "62 ou 62:6-14",
    second_reading: "I Coríntios 4:1-5(6-7)8-13",
    gospel: "Mateus 6:24-34"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 24:24:12(13-14)15-18",
    psalm: "99",
    second_reading: "Filipenses 3:7-14",
    gospel: "Mateus 17:1-9"
  },
  {
    date_reference: "ash_wednesday",
    cycle: "A",
    service_type: "morning_prayer",
    first_reading: "Joel 2:1-2,12-17 ou Isaías 58:1-12",
    psalm: "103 ou 103:8-14",
    second_reading: "II Coríntios 5:20b",
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

Rails.logger.info "\n✅ #{count} leituras da Epifania criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
