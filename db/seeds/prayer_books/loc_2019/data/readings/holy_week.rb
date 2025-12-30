# ================================================================================
# LEITURAS DA SEMANA SANTA - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Semana Santa for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

holy_week_readings = [
  # --- PALM SUNDAY ---
  { date_reference: "palm_sunday", cycle: "A", service_type: "eucharist", first_reading: "Isaías 52:13-53:12", psalm: "Salmo 22:1-21 ou Salmo 22:1-11", second_reading: "Filipenses 2:5-11", gospel: "Mateus (26:36-75)27:1-54(55-66)" },
  { date_reference: "palm_sunday", cycle: "B", service_type: "eucharist", first_reading: "Isaías 52:13-53:12", psalm: "Salmo 22:1-11 ou Salmo 22:1-21", second_reading: "Filipenses 2:5-11", gospel: "Marcos (14:32-72)15:1-39(40-47)" },
  { date_reference: "palm_sunday", cycle: "C", service_type: "eucharist", first_reading: "Isaías 52:13-53:12", psalm: "Salmo 22:1-11 ou Salmo 22:1-21", second_reading: "Filipenses 2:5-11", gospel: "Lucas (22:39-71)23:1-49(50-56)" },

  # --- MONDAY OF HOLY WEEK ---
  { date_reference: "monday_of_holy_week", cycle: "A", service_type: "eucharist", first_reading: "Isaías 42:1-9", psalm: "Salmo 36:5-10", second_reading: "Hebreus 11:39-12:3", gospel: "João 12:1-11 ou Marcos 14:3-9" },
  { date_reference: "monday_of_holy_week", cycle: "B", service_type: "eucharist", first_reading: "Isaías 42:1-9", psalm: "Salmo 36:5-10", second_reading: "Hebreus 11:39-12:3", gospel: "João 12:1-11 ou Marcos 14:3-9" },
  { date_reference: "monday_of_holy_week", cycle: "C", service_type: "eucharist", first_reading: "Isaías 42:1-9", psalm: "Salmo 36:5-10", second_reading: "Hebreus 11:39-12:3", gospel: "João 12:1-11 ou Marcos 14:3-9" },

  # --- TUESDAY OF HOLY WEEK ---
  { date_reference: "tuesday_of_holy_week", cycle: "A", service_type: "eucharist", first_reading: "Isaías 49:1-6", psalm: "Salmo 71:1-11", second_reading: "1 Coríntios 1:18-31", gospel: "João 12:37-38, 42-50 ou Marcos 11:15-19" },
  { date_reference: "tuesday_of_holy_week", cycle: "B", service_type: "eucharist", first_reading: "Isaías 49:1-6", psalm: "Salmo 71:1-11", second_reading: "1 Coríntios 1:18-31", gospel: "João 12:37-38, 42-50 ou Marcos 11:15-19" },
  { date_reference: "tuesday_of_holy_week", cycle: "C", service_type: "eucharist", first_reading: "Isaías 49:1-6", psalm: "Salmo 71:1-11", second_reading: "1 Coríntios 1:18-31", gospel: "João 12:37-38, 42-50 ou Marcos 11:15-19" },

  # --- WEDNESDAY OF HOLY WEEK ---
  { date_reference: "wednesday_of_holy_week", cycle: "A", service_type: "eucharist", first_reading: "Isaías 50:4-9", psalm: "Salmo 69:6-14, 21-22", second_reading: "Hebreus 9:11-28", gospel: "Mateus 26:1-5, 14-25" },
  { date_reference: "wednesday_of_holy_week", cycle: "B", service_type: "eucharist", first_reading: "Isaías 50:4-9", psalm: "Salmo 69:6-14, 21-22", second_reading: "Hebreus 9:11-28", gospel: "Mateus 26:1-5, 14-25" },
  { date_reference: "wednesday_of_holy_week", cycle: "C", service_type: "eucharist", first_reading: "Isaías 50:4-9", psalm: "Salmo 69:6-14, 21-22", second_reading: "Hebreus 9:11-28", gospel: "Mateus 26:1-5, 14-25" },

  # --- MAUNDY THURSDAY ---
  { date_reference: "maundy_thursday", cycle: "A", service_type: "eucharist", first_reading: "Êxodo 12:1-14", psalm: "Salmo 78:15-26", second_reading: "1 Coríntios 11:23-26(27-34)", gospel: "João 13:1-15 ou Lucas 22:14-30" },
  { date_reference: "maundy_thursday", cycle: "B", service_type: "eucharist", first_reading: "Êxodo 12:1-14", psalm: "Salmo 78:15-26", second_reading: "1 Coríntios 11:23-26(27-34)", gospel: "João 13:1-15 ou Lucas 22:14-30" },
  { date_reference: "maundy_thursday", cycle: "C", service_type: "eucharist", first_reading: "Êxodo 12:1-14", psalm: "Salmo 78:15-26", second_reading: "1 Coríntios 11:23-26(27-34)", gospel: "João 13:1-15 ou Lucas 22:14-30" },

  # --- GOOD FRIDAY ---
  { date_reference: "good_friday", cycle: "A", service_type: "eucharist", first_reading: "Gênesis 22:1-18 ou Isaías 52:13-53:12", psalm: "Salmo 22:1-11(12-21) ou Salmo 40:1-16 ou Salmo 69:1-22", second_reading: "Hebreus 10:1-25", gospel: "João (18:1-40)19:1-37" },
  { date_reference: "good_friday", cycle: "B", service_type: "eucharist", first_reading: "Gênesis 22:1-18 ou Isaías 52:13-53:12", psalm: "Salmo 22:1-11(12-21) ou Salmo 40:1-16 ou Salmo 69:1-22", second_reading: "Hebreus 10:1-25", gospel: "João (18:1-40)19:1-37" },
  { date_reference: "good_friday", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 22:1-18 ou Isaías 52:13-53:12", psalm: "Salmo 22:1-11(12-21) ou Salmo 40:1-16 ou Salmo 69:1-22", second_reading: "Hebreus 10:1-25", gospel: "João (18:1-40)19:1-37" },

  # --- HOLY SATURDAY ---
  { date_reference: "holy_saturday", cycle: "A", service_type: "eucharist", first_reading: "Jó 14:1-17", psalm: "Salmo 130 ou 31:1-6", second_reading: "1 Pedro 4:1-8", gospel: "Mateus 27:57-66 ou João 19:38-42" },
  { date_reference: "holy_saturday", cycle: "B", service_type: "eucharist", first_reading: "Jó 14:1-17", psalm: "Salmo 130 ou 31:1-6", second_reading: "1 Pedro 4:1-8", gospel: "Mateus 27:57-66 ou João 19:38-42" },
  { date_reference: "holy_saturday", cycle: "C", service_type: "eucharist", first_reading: "Jó 14:1-17", psalm: "Salmo 130 ou 31:1-6", second_reading: "1 Pedro 4:1-8", gospel: "Mateus 27:57-66 ou João 19:38-42" }
]

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
  else
    existing.update!(reading)
  end
end
