# ================================================================================
# LEITURAS DA QUARESMA - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Quaresma (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

lent_readings = [
  # ----------------------------------------------------------------------------
  # QUARTA-FEIRA DE CINZAS
  # ----------------------------------------------------------------------------
  {
    date_reference: "ash_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Joel 2.1-2, 12-17 ou Isaías 58.1-12",
    psalm: "Salmo 51.1-17",
    second_reading: "2 Coríntios 5.20b-6.10",
    gospel: "Mateus 6.1-6, 16-21"
  },

  # ----------------------------------------------------------------------------
  # 1º DOMINGO DA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 2.15-17; 3.1-7",
    psalm: "Salmo 32",
    second_reading: "Romanos 5.12-19",
    gospel: "Mateus 4.1-11"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 9.8-17",
    psalm: "Salmo 25.1-10",
    second_reading: "1 Pedro 3.18-22",
    gospel: "Marcos 1.9-15"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronômio 26.1-11",
    psalm: "Salmo 91.1-2, 9-16",
    second_reading: "Romanos 10.8b-13",
    gospel: "Lucas 4.1-13"
  },

  # ----------------------------------------------------------------------------
  # 2º DOMINGO DA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 12.1-4a",
    psalm: "Salmo 121",
    second_reading: "Romanos 4.1-5, 13-17",
    gospel: "João 3.1-17"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 17.1-16",
    psalm: "Salmo 22.23-31",
    second_reading: "Romanos 4.13-25",
    gospel: "Marcos 8.31-38"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 15.1-18",
    psalm: "Salmo 27",
    second_reading: "Filipenses 3.17-4.1",
    gospel: "Lucas 13.31-35"
  },

  # ----------------------------------------------------------------------------
  # 3º DOMINGO DA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 17.1-7",
    psalm: "Salmo 95",
    second_reading: "Romanos 5.1-11",
    gospel: "João 4.5-42"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Êxodo 20.1-17",
    psalm: "Salmo 19",
    second_reading: "1 Coríntios 1.18-25",
    gospel: "João 2.13-22"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 55.1-9",
    psalm: "Salmo 63.1-8",
    second_reading: "1 Coríntios 10.1-13",
    gospel: "Lucas 13.1-9"
  },

  # ----------------------------------------------------------------------------
  # 4º DOMINGO DA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "1 Samuel 16.1-13",
    psalm: "Salmo 23",
    second_reading: "Efésios 5.8-14",
    gospel: "João 9.1-41"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Números 21.4-9",
    psalm: "Salmo 107.1-3, 17-22",
    second_reading: "Efésios 2.1-10",
    gospel: "João 3.14-21"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Josué 5.9-12",
    psalm: "Salmo 32",
    second_reading: "2 Coríntios 5.16-21",
    gospel: "Lucas 15.1-3, 11b-32"
  },

  # ----------------------------------------------------------------------------
  # 5º DOMINGO DA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 37.1-14",
    psalm: "Salmo 130",
    second_reading: "Romanos 8.6-11",
    gospel: "João 11.1-45"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 31.31-34",
    psalm: "Salmo 51.1-12",
    second_reading: "Hebreus 5.5-10",
    gospel: "João 12.20-33"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 43.16-21",
    psalm: "Salmo 126 ou Salmo 119.9-16",
    second_reading: "Filipenses 3.4b-14",
    gospel: "João 12.1-8"
  }
]

count = 0
skipped = 0

lent_readings.each do |reading|
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

Rails.logger.info "\n✅ #{count} leituras da Quaresma criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
