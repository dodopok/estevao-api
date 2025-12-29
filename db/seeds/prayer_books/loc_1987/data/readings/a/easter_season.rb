# ================================================================================
# LEITURAS - TEMPO PASCAL (Easter Season) - LOC 1987 - ANO A
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Pascal (LOC 1987) - Ano A..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

easter_readings = [
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 2:14a,36-47 ou Isaías 43:1-12",
    psalm: "116 ou 116:10-17",
    second_reading: "I Pedro 1:3-9 ou Atos 2:14a,36-47",
    gospel: "João 20:19-31"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 2:36-41",
    psalm: "33:18-22 ou 118:19-24",
    second_reading: "Atos 2:36-41",
    gospel: "João 20:11-18"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 3:1-10",
    psalm: "105:1-8 ou 118:19-24",
    second_reading: "Atos 3:1-10",
    gospel: "Lucas 24:13-35"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 3:11-26",
    psalm: "8 ou 114 ou 118:19-24",
    second_reading: "Atos 3:11-26",
    gospel: "Lucas 24:36b-48"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 4:1-12",
    psalm: "119:1-8 ou 118:19-24",
    second_reading: "Atos 4:1-12",
    gospel: "João 21:1-14"
  },
  {
    date_reference: "easter_saturday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 4:13-21",
    psalm: "118:14-18 ou 118:19-24",
    second_reading: "Atos 4:13-21",
    gospel: "Marcos 16:9-15,20"
  },
  {
    date_reference: "ascension_day",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 1:1-11 ou Daniel 7:9-14",
    psalm: "47 ou 110:1-5",
    second_reading: "Efésios 1:15-23 ou Atos 1:1-11",
    gospel: "Lucas 24:49-53 ou Marcos 16:9-15,19-20"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 1:1-14 ou Ezequiel 39:21-29",
    psalm: "47 ou 68:1-20",
    second_reading: "I Pedro 4:12-19 ou Atos 1:14",
    gospel: "João 17:1-11"
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
    # Update existing if needed
    existing.update!(r)
    skipped += 1
  end
end

# Clean up old non-standard references if they exist
old_references = ["easter_2nd_week", "easter_3rd_week", "easter_4th_week", "easter_5th_week", "easter_6th_week", "easter_saturday_week"]
LectionaryReading.where(prayer_book_id: prayer_book.id, cycle: "A", date_reference: old_references).destroy_all

Rails.logger.info "\n✅ #{count} leituras do Tempo Pascal (Ano A) criadas"
Rails.logger.info "⏭️  #{skipped} registros atualizados/mantidos."