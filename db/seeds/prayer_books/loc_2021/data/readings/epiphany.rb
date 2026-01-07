# ================================================================================
# LEITURAS DA EPIFANIA E DOMINGOS APÓS A EPIFANIA - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Epifania (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

epiphany_readings = [
  # ----------------------------------------------------------------------------
  # EPIFANIA DE NOSSO SENHOR (6 de Janeiro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 60:1-6",
    psalm: "Salmo 72:1-7, 10-14",
    second_reading: "Efésios 3:1-12",
    gospel: "Mateus 2.1-12"
  },
  {
    date_reference: "epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 52.7-10",
    psalm: "Salmo 100.1-5",
    second_reading: "Colossenses 1.24-27",
    gospel: "Mateus 12.14-21"
  },
  {
    date_reference: "epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 49.1-7",
    psalm: "Salmo 44.1, 3, 4a, 6, 8",
    second_reading: "2 Coríntios 4.3-6",
    gospel: "João 1.43-51"
  },

  # ----------------------------------------------------------------------------
  # 1º DOMINGO APÓS A EPIFANIA - BATISMO DE CRISTO
  # ----------------------------------------------------------------------------
  {
    date_reference: "baptism_of_the_lord",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 42.1-9",
    psalm: "Salmo 29",
    second_reading: "Atos 10.34-43",
    gospel: "Mateus 3.13-17"
  },
  {
    date_reference: "baptism_of_the_lord",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 1.1-5",
    psalm: "Salmo 29",
    second_reading: "Atos 19.1-7",
    gospel: "Marcos 1.4-11"
  },
  {
    date_reference: "baptism_of_the_lord",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 43.1-7",
    psalm: "Salmo 29",
    second_reading: "Atos 8.14-17",
    gospel: "Lucas 3.15-17, 21-22"
  },

  # ----------------------------------------------------------------------------
  # 2º DOMINGO APÓS A EPIFANIA
  # ----------------------------------------------------------------------------
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 49.1-7",
    psalm: "Salmo 40.1-11",
    second_reading: "1 Coríntios 1.1-9",
    gospel: "João 1.29-42"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 3.1-10 (11-20)",
    psalm: "Salmo 139.1-6, 13-18",
    second_reading: "1 Coríntios 6.12-20",
    gospel: "João 1.43-51"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 62.1-5",
    psalm: "Salmo 36.5-10",
    second_reading: "1 Coríntios 12.1-11",
    gospel: "João 2.1-11"
  },

  # ----------------------------------------------------------------------------
  # 3º DOMINGO APÓS A EPIFANIA
  # ----------------------------------------------------------------------------
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 9.1-4",
    psalm: "Salmo 27.1, 4-9",
    second_reading: "1 Coríntios 1.10-18",
    gospel: "Mateus 4.12-23"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jonas 3.1-5, 10",
    psalm: "Salmo 62.5-12",
    second_reading: "1 Coríntios 7.29-31",
    gospel: "Marcos 1.14-20"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Neemias 8.1-10",
    psalm: "Salmo 19",
    second_reading: "1 Coríntios 12.12-31a",
    gospel: "Lucas 4.14-21"
  },

  # ----------------------------------------------------------------------------
  # 4º DOMINGO APÓS A EPIFANIA
  # ----------------------------------------------------------------------------
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Miqueias 6.1-8",
    psalm: "Salmo 15",
    second_reading: "1 Coríntios 1.18-31",
    gospel: "Mateus 5.1-12"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 18.15-20",
    psalm: "Salmo 111",
    second_reading: "1 Coríntios 8.1-13",
    gospel: "Marcos 1.21-28"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 1.4-10",
    psalm: "Salmo 71.1-6",
    second_reading: "1 Coríntios 13.1-13",
    gospel: "Lucas 4.21-30"
  },

  # ----------------------------------------------------------------------------
  # 5º DOMINGO APÓS A EPIFANIA
  # ----------------------------------------------------------------------------
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 58.1-9a (9b-12)",
    psalm: "Salmo 112.1-9 (10)",
    second_reading: "1 Coríntios 2.1-12 (13-16)",
    gospel: "Mateus 5.13-20"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 40.21-31",
    psalm: "Salmo 147.1-11, 20c",
    second_reading: "1 Coríntios 9.16-23",
    gospel: "Marcos 1.29-39"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 6.1-8 (9-13)",
    psalm: "Salmo 138",
    second_reading: "1 Coríntios 15.1-11",
    gospel: "Lucas 5.1-11"
  },

  # ----------------------------------------------------------------------------
  # 6º DOMINGO APÓS A EPIFANIA
  # ----------------------------------------------------------------------------
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30.15-20",
    psalm: "Salmo 119.1-8",
    second_reading: "1 Coríntios 3.1-9",
    gospel: "Mateus 5.21-37"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Reis 5.1-14",
    psalm: "Salmo 30",
    second_reading: "1 Coríntios 9.24-27",
    gospel: "Marcos 1.40-45"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 17.5-10",
    psalm: "Salmo 1",
    second_reading: "1 Coríntios 15.12-20",
    gospel: "Lucas 6.17-26"
  },

  # ----------------------------------------------------------------------------
  # 7º DOMINGO APÓS A EPIFANIA
  # ----------------------------------------------------------------------------
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Levítico 19.1-2, 9-18",
    psalm: "Salmo 119.33-40",
    second_reading: "1 Coríntios 3.10-23",
    gospel: "Mateus 5.38-48"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 43.18-25",
    psalm: "Salmo 41",
    second_reading: "2 Coríntios 1.18-22",
    gospel: "Marcos 2.1-12"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 45.3-11, 15",
    psalm: "Salmo 37.1-11, 39-40",
    second_reading: "1 Coríntios 15.35-50",
    gospel: "Lucas 6.27-38"
  },

  # ----------------------------------------------------------------------------
  # 8º DOMINGO APÓS A EPIFANIA
  # ----------------------------------------------------------------------------
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 49.8-16a",
    psalm: "Salmo 131",
    second_reading: "1 Coríntios 4.1-5",
    gospel: "Mateus 6.24-34"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Oseias 2.14-20",
    psalm: "Salmo 103.1-13, 22",
    second_reading: "2 Coríntios 3.1-6",
    gospel: "Marcos 2.13-22"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 55.10-13",
    psalm: "Salmo 92.1-15",
    second_reading: "1 Coríntios 15.51-58",
    gospel: "Lucas 6.39-49"
  },

  # ----------------------------------------------------------------------------
  # ÚLTIMO DOMINGO APÓS A EPIFANIA - TRANSFIGURAÇÃO
  # ----------------------------------------------------------------------------
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 24.12-18",
    psalm: "Salmo 2 ou 99",
    second_reading: "2 Pedro 1.16-21",
    gospel: "Mateus 17.1-9"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Reis 2.1-12",
    psalm: "Salmo 50.1-6",
    second_reading: "2 Coríntios 4.3-6",
    gospel: "Marcos 9.2-9"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 34.29-35",
    psalm: "Salmo 99",
    second_reading: "2 Coríntios 3.12-4.2",
    gospel: "Lucas 9.28-36 (37-43)"
  }
]

count = 0
skipped = 0

epiphany_readings.each do |reading|
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

Rails.logger.info "\n✅ #{count} leituras da Epifania criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
