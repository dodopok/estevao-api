# ================================================================================
# LEITURAS - QUARESMA (Lent) - LOC 1987 - ANO C
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Quaresma (LOC 1987) - Ano C..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

lent_readings = [
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronômio 26:(1-4)5-11",
    psalm: "91 ou 91:9-15",
    second_reading: "Romanos 10:(5-8a)8b-13",
    gospel: "Lucas 4:1-13"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 15:1-12,17-18",
    psalm: "27 ou 27:10-18",
    second_reading: "Filipenses 3:17-4:1",
    gospel: "Lucas 13:(22-30)31-35"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 3:1-5",
    psalm: "103 ou 103:1-11",
    second_reading: "I Coríntios 10:1-13",
    gospel: "Lucas 13:1-9"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Josué (4:19-24)5:9-12",
    psalm: "34 ou 34:1-8",
    second_reading: "II Coríntios 5:17-21",
    gospel: "Lucas 15:11-32"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 43:16-21",
    psalm: "126",
    second_reading: "Filipenses 3:8-14",
    gospel: "Lucas 20:9-19"
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

Rails.logger.info "\n✅ #{count} leituras da Quaresma (Ano C) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
