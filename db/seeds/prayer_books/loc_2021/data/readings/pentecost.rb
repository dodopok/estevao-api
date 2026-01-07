# ================================================================================
# LEITURAS DE PENTECOSTES - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras de Pentecostes (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

pentecost_readings = [
  # ----------------------------------------------------------------------------
  # VÉSPERA DO PENTECOSTES
  # ----------------------------------------------------------------------------
  {
    date_reference: "pentecost_vigil",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êxodo 19.1-9a ou Atos 2.1-11",
    psalm: "Salmo 33.12-22 ou 130",
    second_reading: "Romanos 8.14-17, 22-27",
    gospel: "João 7.37-39a"
  },

  # ----------------------------------------------------------------------------
  # DIA DE PENTECOSTES
  # ----------------------------------------------------------------------------
  {
    date_reference: "pentecost_day",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 2.1-21 ou Números 11.24-30",
    psalm: "Salmo 104.24-34, 35b",
    second_reading: "1 Coríntios 12.3b-13 ou Atos 2.1-21",
    gospel: "João 20.19-23 ou João 7.37-39"
  },
  {
    date_reference: "pentecost_day",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 2.1-21 ou Ezequiel 37.1-14",
    psalm: "Salmo 104.24-34, 35b",
    second_reading: "Romanos 8.22-27 ou Atos 2.1-21",
    gospel: "João 15.26-27; 16.4b-15"
  },
  {
    date_reference: "pentecost_day",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 2.1-21 ou Gênesis 11.1-9",
    psalm: "Salmo 104.24-34, 35b",
    second_reading: "Romanos 8.14-17 ou Atos 2.1-21",
    gospel: "João 14.8-17 (25-27)"
  },

  # ----------------------------------------------------------------------------
  # DOMINGO APÓS PENTECOSTES - TRINDADE
  # ----------------------------------------------------------------------------
  {
    date_reference: "trinity_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 1.1-2.4a",
    psalm: "Salmo 8",
    second_reading: "2 Coríntios 13.11-13",
    gospel: "Mateus 28.16-20"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 6.1-8",
    psalm: "Salmo 29",
    second_reading: "Romanos 8.12-17",
    gospel: "João 3.1-17"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Provérbios 8.1-4, 22-31",
    psalm: "Salmo 8",
    second_reading: "Romanos 5.1-5",
    gospel: "João 16.12-15"
  }
]

count = 0
skipped = 0

pentecost_readings.each do |reading|
  reading[:prayer_book_id] = prayer_book.id

  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
  else
    existing.update!(reading)
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras de Pentecostes criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
