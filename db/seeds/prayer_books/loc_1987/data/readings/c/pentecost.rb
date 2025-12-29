# ================================================================================
# LEITURAS - PENTECOSTES E SEMANA PASCAL - LOC 1987 - ANO C
# ================================================================================

Rails.logger.info "📖 Carregando leituras de Pentecostes (LOC 1987) - Ano C..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

pentecost_readings = [
  {
    date_reference: "pentecost_vigil",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 11:1-9 ou Êxodo 19:1-9,16-20a,20:18-20 ou Ezequiel 37:1-14 ou Joel 2:28-32",
    psalm: "33:12-22 ou 130 ou 104:25-32",
    second_reading: "Atos 2:1-11 ou Romanos 8:14-17,22-27",
    gospel: "João 7:37-39a"
  },
  {
    date_reference: "pentecost",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 2:1-11 ou Joel 2:28-32",
    psalm: "104:25-37 ou 104:25-32 ou 33:12-15,18-22",
    second_reading: "I Coríntios 12:4-13 ou Atos 2:1-11",
    gospel: "João 20:19-23 ou João 14:8-17"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 6:1-8",
    psalm: "29",
    second_reading: "Apocalipse 4:1-11",
    gospel: "João 16:(5-11)12-15"
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

Rails.logger.info "\n✅ #{count} leituras de Pentecostes (Ano C) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
