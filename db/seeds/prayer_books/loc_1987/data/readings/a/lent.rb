# ================================================================================
# LEITURAS - QUARESMA (Lent) - LOC 1987 - ANO A
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Quaresma (LOC 1987) - Ano A..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

lent_readings = [
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 2:4b-9,15-17,25-3:7",
    psalm: "51 ou 51:1-13",
    second_reading: "Romanos 5:12-19(20-21)",
    gospel: "Mateus 4:1-11"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 12:1-8",
    psalm: "33:12-22",
    second_reading: "Romanos 4:1-5(6-12)13-17",
    gospel: "João 3:1-17"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 17:1-7",
    psalm: "95 ou 95:6-11",
    second_reading: "Romanos 5:1-11",
    gospel: "João 4:5-26(27-38)39-42"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "I Samuel 16:1-13",
    psalm: "23",
    second_reading: "Efésios 5:(1-7)8-14",
    gospel: "João 9:1-13(14-27)28-38"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 37:1-3(4-10)11-14",
    psalm: "130",
    second_reading: "Romanos 6:16-23",
    gospel: "João 11:(1-17)18-47"
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

Rails.logger.info "\n✅ #{count} leituras da Quaresma criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
