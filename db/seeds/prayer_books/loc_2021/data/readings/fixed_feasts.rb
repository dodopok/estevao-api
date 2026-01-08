# ================================================================================
# LEITURAS DE DIAS SANTOS E FESTAS FIXAS - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras de Dias Santos (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

fixed_readings = [
  # JANEIRO
  {
    date_reference: "january_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 9.2-7",
    psalm: "Salmo 8",
    second_reading: "Atos 4.8-12",
    gospel: "Lucas 2.15-21"
  },
  {
    date_reference: "january_25",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 26.9-23",
    psalm: "Salmo 67",
    second_reading: "Gálatas 1.11-24",
    gospel: "Marcos 10.46-52"
  },

  # FEVEREIRO
  {
    date_reference: "february_2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Malaquias 3.1-4",
    psalm: "Salmo 24",
    second_reading: "Hebreus 2.14-18",
    gospel: "Lucas 2.22-40"
  },

  # MARÇO
  {
    date_reference: "march_19",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronômio 33.13-16",
    psalm: "Salmo 89.2-9",
    second_reading: "Filipenses 4.5-8",
    gospel: "Mateus 13:53-58"
  },
  {
    date_reference: "march_25",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 7.10-14",
    psalm: "Salmo 113",
    second_reading: "Romanos 5.12-17",
    gospel: "Lucas 1.26-38"
  },

  # ABRIL
  {
    date_reference: "april_25",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 52.7-10",
    psalm: "Salmo 119.9-16",
    second_reading: "Efésios 4.7-16",
    gospel: "Marcos 1.1-15"
  },

  # MAIO
  {
    date_reference: "may_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 4.10-18",
    psalm: "Salmo 84",
    second_reading: "1 Coríntios 12.4-13",
    gospel: "João 14.1-14"
  },
  {
    date_reference: "may_14",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 22.15-22",
    psalm: "Salmo 16",
    second_reading: "Atos 1.15-26",
    gospel: "João 13.12-30"
  },
  {
    date_reference: "may_31",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Sofonias 3.14-18a",
    psalm: "Salmo 113",
    second_reading: "Efésios 5.18b-20",
    gospel: "Lucas 1.39-49"
  },

  # JUNHO
  {
    date_reference: "june_11",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 29.11-16",
    psalm: "Salmo 112",
    second_reading: "Atos 11.19-30",
    gospel: "João 15.12-17"
  },
  {
    date_reference: "june_24",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 40.1-11",
    psalm: "Salmo 119.161-168",
    second_reading: "Atos 13.16-25",
    gospel: "Lucas 1.57-66"
  },
  {
    date_reference: "june_29",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "João 3",
    psalm: "Salmo 34.2-10",
    second_reading: "2 Timóteo 4.1-8",
    gospel: "Mateus 16.13-19"
  },

  # JULHO
  {
    date_reference: "july_3",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 42.1-6",
    psalm: "Salmo 126",
    second_reading: "Hebreus 10.35-11.1",
    gospel: "João 20.24-29"
  },
  {
    date_reference: "july_22",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Cântico dos Cânticos 3.1-4a",
    psalm: "Salmo 63.2-10",
    second_reading: "2 Coríntios 5.14-17",
    gospel: "João 20.1-18"
  },
  {
    date_reference: "july_25",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 45",
    psalm: "Salmo 15",
    second_reading: "Atos 11.27-12.3",
    gospel: "Marcos 10.35-45"
  },

  # AGOSTO
  {
    date_reference: "august_6",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êxodo 34.29-35",
    psalm: "Salmo 99",
    second_reading: "2 Coríntios 3.4-18",
    gospel: "Lucas 9.28-36"
  },
  {
    date_reference: "august_24",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Gênesis 28.10-17",
    psalm: "Salmo 103.1b-8",
    second_reading: "Atos 5.12-16",
    gospel: "João 1.43-51"
  },

  # SETEMBRO
  {
    date_reference: "september_8",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Gênesis 3.8-15",
    psalm: "Salmo 113",
    second_reading: "Gálatas 4.4-7",
    gospel: "Lucas 11.27-28, 39-49"
  },
  {
    date_reference: "september_21",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Provérbios 3.9-18",
    psalm: "Salmo 19",
    second_reading: "2 Timóteo 3.14-17",
    gospel: "Mateus 9.9-13"
  },
  {
    date_reference: "september_29",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 38.1-7",
    psalm: "Salmo 148.1-6",
    second_reading: "Apocalipse 12.7-12",
    gospel: "Mateus 18.1-10"
  },

  # OUTUBRO
  {
    date_reference: "october_18",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 61.1-6",
    psalm: "Salmo 147.1-7",
    second_reading: "Atos 1.1-8",
    gospel: "Lucas 10.1-9"
  },
  {
    date_reference: "october_28",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 28.9-16",
    psalm: "Salmo 119.89-96",
    second_reading: "Apocalipse 21.9-14",
    gospel: "Lucas 6.12-23"
  },

  # NOVEMBRO
  {
    date_reference: "november_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 31.31-34",
    psalm: "Salmo 150",
    second_reading: "Apocalipse 7.2-4, 9-14",
    gospel: "Mateus 5.1-12"
  },
  {
    date_reference: "november_30",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Zacarias 8.20-23",
    psalm: "Salmo 47",
    second_reading: "Romanos 10.8b-18",
    gospel: "João 1.35-42"
  },

  # DEZEMBRO
  {
    date_reference: "december_26",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "2 Crônicas 24.17-22",
    psalm: "Salmo 31.2-6",
    second_reading: "Atos 6.8-10; 7.54-60",
    gospel: "Mateus 10.17-22"
  },
  {
    date_reference: "december_27",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 6.1-8",
    psalm: "Salmo 97",
    second_reading: "1 João 1",
    gospel: "João 21.20-24"
  },
  {
    date_reference: "december_28",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 31.15-17",
    psalm: "Salmo 124",
    second_reading: "1 Pedro 4.12-16",
    gospel: "Mateus 2.13-18"
  }
]

count = 0
skipped = 0

fixed_readings.each do |reading|
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

Rails.logger.info "\n✅ #{count} leituras de Dias Santos criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
