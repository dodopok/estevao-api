# ================================================================================
# LEITURAS - QUARESMA (Lent) - LOC 1987 - ANO B
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Quaresma (LOC 1987) - Ano B..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

lent_readings = [
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 9:8-17",
    psalm: "25 ou 25:3-9",
    second_reading: "I Pedro 3:18-22",
    gospel: "Marcos 1:9-13"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 22:1-14",
    psalm: "16 ou 16:5-11",
    second_reading: "Romanos 8:31-39",
    gospel: "Marcos 8:31-38"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Êxodo 20:1-17",
    psalm: "19:7-14",
    second_reading: "Romanos 7:13-25",
    gospel: "João 2:13-22"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "II Crônicas 36:14-23",
    psalm: "122",
    second_reading: "Efésios 2:4-10",
    gospel: "João 6:4-15"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 31:31-34",
    psalm: "51 ou 51:11-16",
    second_reading: "Hebreus 5:(1-4)5-10",
    gospel: "João 12:20-33"
  }
]

# create
count = 0
skipped = 0
lent_readings.each do |r|
  r[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(date_reference: r[:date_reference], cycle: r[:cycle], service_type: r[:service_type], prayer_book_id: prayer_book.id)
  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras da Quaresma (Ano B) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
