# ================================================================================
# LEITURAS DA SEMANA SANTA E PÁSCOA - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Semana Santa e Páscoa (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

holy_week_readings = [
  # ----------------------------------------------------------------------------
  # DOMINGO DE RAMOS
  # ----------------------------------------------------------------------------
  {
    date_reference: "palm_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Mateus 21.1-11",
    psalm: "Salmo 118.1-2, 19-29",
    second_reading: "Isaías 50.4-9a",
    gospel: "Mateus 26.14-27.66 ou 27.11-26"
  },
  {
    date_reference: "palm_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Marcos 11.1-11",
    psalm: "Salmo 118.1-2, 19-29",
    second_reading: "Isaías 42.1-9",
    gospel: "Marcos 14.1-15.47 ou 14.1-9"
  },
  {
    date_reference: "palm_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Lucas 19.28-40",
    psalm: "Salmo 118.1-2, 19-29",
    second_reading: "Isaías 49.1-7",
    gospel: "Lucas 22.14-23.56 ou 22.54-62"
  },

  # ----------------------------------------------------------------------------
  # SEGUNDA-FEIRA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "monday_holy_week",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 42.1-7",
    psalm: "Salmo 27.1-8",
    second_reading: "Hebreus 9.11-15",
    gospel: "João 12.1-8"
  },

  # ----------------------------------------------------------------------------
  # TERÇA-FEIRA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "tuesday_holy_week",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 49.1-6",
    psalm: "Salmo 71.1-12",
    second_reading: "1 Coríntios 1.18-31",
    gospel: "João 12.27-36"
  },

  # ----------------------------------------------------------------------------
  # QUARTA-FEIRA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "wednesday_holy_week",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 50.4-9a",
    psalm: "Salmo 70",
    second_reading: "Hebreus 12.1-3",
    gospel: "João 13.21-30"
  },

  # ----------------------------------------------------------------------------
  # QUINTA-FEIRA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "maundy_thursday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 24.1-11",
    psalm: "Salmo 116",
    second_reading: "1 Coríntios 10.16-17",
    gospel: "Mateus 26.36-56"
  },
  {
    date_reference: "maundy_thursday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 42.1-4 (5-9)",
    psalm: "Salmo 116.1-2, 12-19",
    second_reading: "Apocalipse 19.6-10",
    gospel: "Marcos 14.12-26"
  },
  {
    date_reference: "maundy_thursday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 12.1-14",
    psalm: "Salmo 116.1-2, 12-19",
    second_reading: "1 Coríntios 11.23-26",
    gospel: "João 13.1-17, 31b-35"
  },

  # ----------------------------------------------------------------------------
  # SEXTA-FEIRA SANTA
  # ----------------------------------------------------------------------------
  {
    date_reference: "good_friday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 50.4-7",
    psalm: "Salmo 22",
    second_reading: "2 Coríntios 5.(14-18)19-21",
    gospel: "Mateus 27.(27-32)33-50"
  },
  {
    date_reference: "good_friday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 52.13-53.12",
    psalm: "Salmo 22",
    second_reading: "Hebreus 10.16-25",
    gospel: "João 19.16-30 (31-37)"
  },
  {
    date_reference: "good_friday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Oseias 5.15b-6.6",
    psalm: "Salmo 22",
    second_reading: "Hebreus 4.14-16, 5.7-9",
    gospel: "Lucas 23.33-49"
  },

  # ----------------------------------------------------------------------------
  # SÁBADO SANTO
  # ----------------------------------------------------------------------------
  {
    date_reference: "holy_saturday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 14.1-14 ou Lamentações 3.1-9, 19-24",
    psalm: "Salmo 31.1-4, 15-16",
    second_reading: "1 Pedro 4.1-8",
    gospel: "Mateus 27.57-66 ou João 19.38-42"
  },

  # ----------------------------------------------------------------------------
  # VIGÍLIA PASCAL
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_vigil",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Romanos 6.3-11",
    psalm: "Salmo 114",
    second_reading: "Mateus 28.1-10",
    gospel: "Mateus 28.1-10"
  },
  {
    date_reference: "easter_vigil",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Romanos 6.3-11",
    psalm: "Salmo 114",
    second_reading: "Marcos 16.1-8",
    gospel: "Marcos 16.1-8"
  },
  {
    date_reference: "easter_vigil",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Romanos 6.3-11",
    psalm: "Salmo 114",
    second_reading: "Lucas 24.1-12",
    gospel: "Lucas 24.1-12"
  },

  # ----------------------------------------------------------------------------
  # DOMINGO DE PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 10.34-43 ou Jeremias 31.1-6",
    psalm: "Salmo 118.1-2, 14-24",
    second_reading: "Colossenses 3.1-4 ou Atos 10.34-43",
    gospel: "João 20.1-18 ou Mateus 28.1-10"
  },
  {
    date_reference: "easter_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 10.34-43 ou Isaías 25.6-9",
    psalm: "Salmo 118.1-2, 14-24",
    second_reading: "1 Coríntios 15.1-11 ou Atos 10.34-43",
    gospel: "João 20.1-18 ou Marcos 16.1-8"
  },
  {
    date_reference: "easter_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 10.34-43 ou Isaías 65.17-25",
    psalm: "Salmo 118.1-2, 14-24",
    second_reading: "1 Coríntios 15.19-26 ou Atos 10.34-43",
    gospel: "João 20.1-18 ou Lucas 24.1-12"
  },

  # ----------------------------------------------------------------------------
  # CELEBRAÇÃO VESPERTINA DE PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "easter_evening",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 25.6-9",
    psalm: "Salmo 114",
    second_reading: "1 Coríntios 5.6b-8",
    gospel: "Lucas 24.13-49"
  }
]

count = 0
skipped = 0

holy_week_readings.each do |reading|
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

Rails.logger.info "\n✅ #{count} leituras da Semana Santa/Páscoa criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
