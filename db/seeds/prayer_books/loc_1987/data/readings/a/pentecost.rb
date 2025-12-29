# ================================================================================
# LEITURAS - PENTECOSTES E SEMANA PASCAL - LOC 1987 - ANO A
# ================================================================================

Rails.logger.info "📖 Carregando leituras de Pentecostes (LOC 1987) - Ano A..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

pentecost_readings = [
  {
    date_reference: "pentecost_vigil",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 11:1-9,16-20",
    psalm: "33:12-22 ou 33:12-22",
    second_reading: "Atos 2:1-11 ou Romanos 8:14-17,22-27",
    gospel: "João 7:37-39a"
  },
  {
    date_reference: "pentecost",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 2:1-11",
    psalm: "33:12-22",
    second_reading: "I Coríntios 12:3-11 or Atos 2:1-11",
    gospel: "João 1:29-41"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 1:1-2:3",
    psalm: "150",
    second_reading: "II Coríntios 13:(5-10)11-14",
    gospel: "Mateus 28:16-20"
  }
]

# create
count = 0
skipped = 0
pentecost_readings.each do |r|
  r[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(date_reference: r[:date_reference], cycle: r[:cycle], service_type: r[:service_type], prayer_book_id: prayer_book.id)
  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras de Pentecostes criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
