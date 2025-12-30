# ================================================================================
# LEITURAS DA PÁSCOA - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Páscoa for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

easter_readings = [
  # --- THE GREAT VIGIL OF EASTER ---
  { date_reference: "easter_vigil", cycle: "A", service_type: "vigil", first_reading: "Gênesis 1:1-2:3, Gênesis 3, Gênesis 7:1-5, 11-18; 8:6-20; 9:8-13, Gênesis 22:1-18, Êxodo 14:10-15:1, Isaías 4:2-6, Isaías 55:1-11, Ezequiel 36:24-28, Ezequiel 37:1-14, Daniel 3:1-28, Jonas 1:1-2:10, Sofonias 3:12-20", psalm: "Salmo 114", second_reading: "Romanos 6:3-11", gospel: "Mateus 28:1-10" },
  { date_reference: "easter_vigil", cycle: "B", service_type: "vigil", first_reading: "Gênesis 1:1-2:3, Gênesis 3, Gênesis 7:1-5, 11-18; 8:6-20; 9:8-13, Gênesis 22:1-18, Êxodo 14:10-15:1, Isaías 4:2-6, Isaías 55:1-11, Ezequiel 36:24-28, Ezequiel 37:1-14, Daniel 3:1-28, Jonas 1:1-2:10, Sofonias 3:12-20", psalm: "Salmo 114", second_reading: "Romanos 6:3-11", gospel: "Mateus 28:1-10" },
  { date_reference: "easter_vigil", cycle: "C", service_type: "vigil", first_reading: "Gênesis 1:1-2:3, Gênesis 3, Gênesis 7:1-5, 11-18; 8:6-20; 9:8-13, Gênesis 22:1-18, Êxodo 14:10-15:1, Isaías 4:2-6, Isaías 55:1-11, Ezequiel 36:24-28, Ezequiel 37:1-14, Daniel 3:1-28, Jonas 1:1-2:10, Sofonias 3:12-20", psalm: "Salmo 114", second_reading: "Romanos 6:3-11", gospel: "Mateus 28:1-10" },

  # --- EASTER DAY (PRINCIPAL SERVICE) ---
  { date_reference: "easter_day", cycle: "A", service_type: "eucharist", first_reading: "Atos 10:34-43 ou Êxodo 14:10-14, 21-31", psalm: "Salmo 118:14-17, 22-24", second_reading: "Colossenses 3:1-4 ou Atos 10:34-43", gospel: "João 20:1-10(11-18) ou Mateus 28:1-10" },
  { date_reference: "easter_day", cycle: "B", service_type: "eucharist", first_reading: "Atos 10:34-43 ou Isaías 25:6-9", psalm: "Salmo 118:14-17, 22-24", second_reading: "Colossenses 3:1-4 ou Atos 10:34-43", gospel: "Marcos 16:1-8" },
  { date_reference: "easter_day", cycle: "C", service_type: "eucharist", first_reading: "Atos 10:34-43 ou Isaías 51:9-11", psalm: "Salmo 118:14-17, 22-24", second_reading: "Colossenses 3:1-4 ou Atos 10:34-43", gospel: "Lucas 24:1-12" },

  # --- MONDAY OF EASTER WEEK ---
  { date_reference: "monday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Atos 2:14, 22-32", psalm: "Salmo 16", gospel: "Mateus 28:9-15" },
  { date_reference: "monday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Atos 2:14, 22-32", psalm: "Salmo 16", gospel: "Mateus 28:9-15" },
  { date_reference: "monday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Atos 2:14, 22-32", psalm: "Salmo 16", gospel: "Mateus 28:9-15" },

  # --- TUESDAY OF EASTER WEEK ---
  { date_reference: "tuesday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Atos 2:14, 36-41", psalm: "Salmo 33:17-21", gospel: "João 20:11-18" },
  { date_reference: "tuesday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Atos 2:14, 36-41", psalm: "Salmo 33:17-21", gospel: "João 20:11-18" },
  { date_reference: "tuesday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Atos 2:14, 36-41", psalm: "Salmo 33:17-21", gospel: "João 20:11-18" },

  # --- WEDNESDAY OF EASTER WEEK ---
  { date_reference: "wednesday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Atos 3:1-10", psalm: "Salmo 105:1-8", gospel: "Lucas 24:13-35" },
  { date_reference: "wednesday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Atos 3:1-10", psalm: "Salmo 105:1-8", gospel: "Lucas 24:13-35" },
  { date_reference: "wednesday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Atos 3:1-10", psalm: "Salmo 105:1-8", gospel: "Lucas 24:13-35" },

  # --- THURSDAY OF EASTER WEEK ---
  { date_reference: "thursday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Atos 3:11-26", psalm: "Salmo 8", gospel: "Lucas 24:36-49" },
  { date_reference: "thursday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Atos 3:11-26", psalm: "Salmo 8", gospel: "Lucas 24:36-49" },
  { date_reference: "thursday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Atos 3:11-26", psalm: "Salmo 8", gospel: "Lucas 24:36-49" },

  # --- FRIDAY OF EASTER WEEK ---
  { date_reference: "friday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "1 Pedro 1:3-9", psalm: "Salmo 116:1-9", gospel: "João 21:1-14" },
  { date_reference: "friday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "1 Pedro 1:3-9", psalm: "Salmo 116:1-9", gospel: "João 21:1-14" },
  { date_reference: "friday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "1 Pedro 1:3-9", psalm: "Salmo 116:1-9", gospel: "João 21:1-14" },

  # --- SATURDAY OF EASTER WEEK ---
  { date_reference: "saturday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Atos 4:1-22", psalm: "Salmo 118:14-18", gospel: "Marcos 16:9-20" },
  { date_reference: "saturday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Atos 4:1-22", psalm: "Salmo 118:14-18", gospel: "Marcos 16:9-20" },
  { date_reference: "saturday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Atos 4:1-22", psalm: "Salmo 118:14-18", gospel: "Marcos 16:9-20" },

  # --- 2ND SUNDAY OF EASTER ---
  { date_reference: "2nd_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Atos 2:14a, 22-32 ou Gênesis 8:6-16, 9:8-16", psalm: "Salmo 111", second_reading: "1 Pedro 1:3-9", gospel: "João 20:19-31" },
  { date_reference: "2nd_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Atos 3:12a, 13-15, 17-26 ou Isaías 26:1-9, 19", psalm: "Salmo 111", second_reading: "1 João 5:1-5", gospel: "João 20:19-31" },
  { date_reference: "2nd_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Atos 5:12a, 17-22, 25-29 ou Jó 42:1-6", psalm: "Salmo 111", second_reading: "Apocalipse 1:(1-8)9-19", gospel: "João 20:19-31" },

  # --- 3RD SUNDAY OF EASTER ---
  { date_reference: "3rd_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Atos 2:14a, 36-47 ou Isaías 43:1-12", psalm: "Salmo 116:11-16", second_reading: "1 Pedro 1:13-25", gospel: "Lucas 24:13-35" },
  { date_reference: "3rd_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Atos 4:5-14 ou Miquéias 4:1-5", psalm: "Salmo 98 ou 98:1-5", second_reading: "1 João 1:1-2:2", gospel: "Lucas 24:36-49" },
  { date_reference: "3rd_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Atos 9:1-19a ou Jeremias 32:36-41", psalm: "Salmo 33 ou 33:1-11", second_reading: "Apocalipse 5:(1-5)6-14", gospel: "João 21:1-14" },

  # --- 4TH SUNDAY OF EASTER ---
  { date_reference: "4th_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Atos 6:1-9, 7:2a, 51-60 ou Neemias 9:(1-3)6-15", psalm: "Salmo 23", second_reading: "1 Pedro 2:13-25", gospel: "João 10:1-10" },
  { date_reference: "4th_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Atos 4:(23-31)32-37 ou Ezequiel 34:1-10", psalm: "Salmo 23", second_reading: "1 João 3:1-10", gospel: "João 10:11-16" },
  { date_reference: "4th_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Atos 13:14b-16, 26-39 ou Números 27:12-23", psalm: "Salmo 100", second_reading: "Apocalipse 7:9-17", gospel: "João 10:22-30" },

  # --- 5TH SUNDAY OF EASTER ---
  { date_reference: "5th_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Atos 17:1-15 ou Deuteronômio 6:20-25", psalm: "Salmo 66:1-11 ou 66:1-8", second_reading: "1 Pedro 2:1-12", gospel: "João 14:1-14" },
  { date_reference: "5th_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Atos 8:26-40 ou Deuteronômio 4:32-40", psalm: "Salmo 66:1-11 ou 66:1-8", second_reading: "1 João 3:(11-17)18-24", gospel: "João 14:15-21" },
  { date_reference: "5th_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Atos 13:44-52 ou Levítico 19:1-2, 9-18", psalm: "Salmo 145 ou 145:1-9", second_reading: "Apocalipse 19:1-9", gospel: "João 13:31-35" },

  # --- 6TH SUNDAY OF EASTER ---
  { date_reference: "6th_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Atos 17:(16-21)22-34 ou Isaías 41:17-20", psalm: "Salmo 148 ou 148:7-14", second_reading: "1 Pedro 3:8-18", gospel: "João 15:1-11" },
  { date_reference: "6th_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Atos 11:19-30 ou Isaías 45:11-13, 18-19(20-25)", psalm: "Salmo 33 ou 33:1-8, 18-22", second_reading: "1 João 4:7-21", gospel: "João 15:9-17" },
  { date_reference: "6th_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Atos 14:8-18 ou Joel 2:21-27", psalm: "Salmo 67", second_reading: "Apocalipse 21:1-4, 22-22:5", gospel: "João 14:21-29" },

  # --- ASCENSION DAY ---
  { date_reference: "ascension_day", cycle: "A", service_type: "eucharist", first_reading: "Atos 1:1-11", psalm: "Salmo 47 ou 110:1-5", second_reading: "Efésios 1:15-23", gospel: "Lucas 24:44-53 ou Marcos 16:9-20" },
  { date_reference: "ascension_day", cycle: "B", service_type: "eucharist", first_reading: "Atos 1:1-11", psalm: "Salmo 47 ou 110:1-5", second_reading: "Efésios 1:15-23", gospel: "Lucas 24:44-53 ou Marcos 16:9-20" },
  { date_reference: "ascension_day", cycle: "C", service_type: "eucharist", first_reading: "Atos 1:1-11", psalm: "Salmo 47 ou 110:1-5", second_reading: "Efésios 1:15-23", gospel: "Lucas 24:44-53 ou Marcos 16:9-20" },

  # --- SUNDAY AFTER ASCENSION DAY ---
  { date_reference: "sunday_after_ascension", cycle: "A", service_type: "eucharist", first_reading: "Atos 1:(1-5)6-14 ou Ezequiel 39:21-29", psalm: "Salmo 68:1-20 ou 47", second_reading: "1 Pedro 4:12-19", gospel: "João 17:1-11" },
  { date_reference: "sunday_after_ascension", cycle: "B", service_type: "eucharist", first_reading: "Atos 1:15-26 ou Êxodo 28:1-4, 9-10, 29-30", psalm: "Salmo 68:1-20 ou 47", second_reading: "1 João 5:6-15", gospel: "João 17:11b-19" },
  { date_reference: "sunday_after_ascension", cycle: "C", service_type: "eucharist", first_reading: "Atos 16:16-34 ou 1 Samuel 12:19-24", psalm: "Salmo 68:1-20 ou 47", second_reading: "Apocalipse 22:10-21", gospel: "João 17:20-26" }
]

easter_readings.each do |reading|
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
