# ================================================================================
# LEITURAS DA EPIFANIA - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Epifania for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

epiphany_readings = [
  # --- 1ST SUNDAY OF EPIPHANY (BAPTISM OF OUR LORD) ---
  { date_reference: "1st_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Isaías 42:1-9", psalm: "Salmo 89:1-29 ou 89:20-29", second_reading: "Atos 10:34-38", gospel: "Mateus 3:13-17" },
  { date_reference: "1st_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Isaías 42:1-9", psalm: "Salmo 89:1-29 ou 89:20-29", second_reading: "Atos 10:34-38", gospel: "Marcos 1:7-11" },
  { date_reference: "1st_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Isaías 42:1-9", psalm: "Salmo 89:1-29 ou 89:20-29", second_reading: "Atos 10:34-38", gospel: "Lucas 3:15-22" },

  # --- 2ND SUNDAY OF EPIPHANY ---
  { date_reference: "2nd_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Êxodo 12:21-28", psalm: "Salmo 40:1-11", second_reading: "1 Coríntios 1:1-9", gospel: "João 1:29-42" },
  { date_reference: "2nd_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "1 Samuel 3:1-20", psalm: "Salmo 63:1-9(10-12)", second_reading: "1 Coríntios 6:9-20", gospel: "João 1:43-51" },
  { date_reference: "2nd_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Isaías 62:1-5", psalm: "Salmo 96", second_reading: "1 Coríntios 12:1-11", gospel: "João 2:1-11" },

  # --- 3RD SUNDAY OF EPIPHANY ---
  { date_reference: "3rd_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Amós 3:1-11", psalm: "Salmo 139:1-18", second_reading: "1 Coríntios 1:10-17", gospel: "Mateus 4:12-22" },
  { date_reference: "3rd_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Jeremias 3:19-4:4", psalm: "Salmo 130", second_reading: "1 Coríntios 7:17-24", gospel: "Marcos 1:14-20" },
  { date_reference: "3rd_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Neemias 8:1-12", psalm: "Salmo 113", second_reading: "1 Coríntios 12:12-27", gospel: "Lucas 4:14-21" },

  # --- 4TH SUNDAY OF EPIPHANY ---
  { date_reference: "4th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Miquéias 6:1-8", psalm: "Salmo 37:1-11", second_reading: "1 Coríntios 1:18-31", gospel: "Mateus 5:1-12" },
  { date_reference: "4th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Deuteronômio 18:15-22", psalm: "Salmo 111", second_reading: "1 Coríntios 8:1-13", gospel: "Marcos 1:21-28" },
  { date_reference: "4th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 1:4-10", psalm: "Salmo 71:11-20", second_reading: "1 Coríntios 14:12-25", gospel: "Lucas 4:21-32" },

  # --- PRESENTATION OF CHRIST IN THE TEMPLE (FEB 2) ---
  { date_reference: "presentation_of_christ_in_the_temple", cycle: "A", service_type: "eucharist", first_reading: "Malaquias 3:1-4", psalm: "Salmo 84", second_reading: "Hebreus 2:14-18", gospel: "Lucas 2:22-40" },
  { date_reference: "presentation_of_christ_in_the_temple", cycle: "B", service_type: "eucharist", first_reading: "Malaquias 3:1-4", psalm: "Salmo 84", second_reading: "Hebreus 2:14-18", gospel: "Lucas 2:22-40" },
  { date_reference: "presentation_of_christ_in_the_temple", cycle: "C", service_type: "eucharist", first_reading: "Malaquias 3:1-4", psalm: "Salmo 84", second_reading: "Hebreus 2:14-18", gospel: "Lucas 2:22-40" },

  # --- 5TH SUNDAY OF EPIPHANY ---
  { date_reference: "5th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "2 Reis 22:8-20", psalm: "Salmo 27", second_reading: "1 Coríntios 2:1-16", gospel: "Mateus 5:13-20" },
  { date_reference: "5th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "2 Reis 4:8-21(22-31)32-37", psalm: "Salmo 142", second_reading: "1 Coríntios 9:16-23", gospel: "Marcos 1:29-39" },
  { date_reference: "5th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Juízes 6:11-24", psalm: "Salmo 85", second_reading: "1 Coríntios 15:1-11", gospel: "Lucas 5:1-11" },

  # --- 6TH SUNDAY OF EPIPHANY ---
  { date_reference: "6th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Eclesiástico 15:11-20", psalm: "Salmo 119:(1-8)9-16", second_reading: "1 Coríntios 3:1-9", gospel: "Mateus 5:21-37" },
  { date_reference: "6th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "2 Reis 5:1-15a", psalm: "Salmo 42:1-7(8-15)", second_reading: "1 Coríntios 9:24-27", gospel: "Marcos 1:40-45" },
  { date_reference: "6th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 17:5-10", psalm: "Salmo 1", second_reading: "1 Coríntios 15:12-20", gospel: "Lucas 6:17-26" },

  # --- 7TH SUNDAY OF EPIPHANY ---
  { date_reference: "7th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Levítico 19:1-2, 9-18", psalm: "Salmo 71 ou 71:11-23", second_reading: "1 Coríntios 3:10-23", gospel: "Mateus 5:38-48" },
  { date_reference: "7th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Isaías 43:18-25", psalm: "Salmo 32", second_reading: "2 Coríntios 1:18-22", gospel: "Marcos 2:1-12" },
  { date_reference: "7th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 45:3-11, 21-28", psalm: "Salmo 37:(1-7)8-17", second_reading: "1 Coríntios 15:35-49", gospel: "Lucas 6:27-38" },

  # --- 8TH SUNDAY OF EPIPHANY ---
  { date_reference: "8th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Isaías 49:8-18(19-23)", psalm: "Salmo 62", second_reading: "1 Coríntios 4:1-13", gospel: "Mateus 6:24-34" },
  { date_reference: "8th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Oséias 2:14-23", psalm: "Salmo 103 ou 103:1-14", second_reading: "2 Coríntios 3:4-18", gospel: "Marcos 2:18-22" },
  { date_reference: "8th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 7:1-15", psalm: "Salmo 92", second_reading: "1 Coríntios 15:50-58", gospel: "Lucas 6:39-49" },

  # --- WORLD MISSION SUNDAY ---
  { date_reference: "world_mission_sunday", cycle: "A", service_type: "eucharist", first_reading: "Isaías 49:1-7", psalm: "Salmo 67", second_reading: "Atos 1:1-8", gospel: "Mateus 9:35-38" },
  { date_reference: "world_mission_sunday", cycle: "B", service_type: "eucharist", first_reading: "Gênesis 12:1-3", psalm: "Salmo 86:8-13", second_reading: "Apocalipse 7:9-17", gospel: "Mateus 28:16-20" },
  { date_reference: "world_mission_sunday", cycle: "C", service_type: "eucharist", first_reading: "Isaías 61:1-4", psalm: "Salmo 96", second_reading: "Romanos 10:9-17", gospel: "João 20:19-31" },

  # --- LAST SUNDAY OF EPIPHANY (TRANSFIGURATION) ---
  { date_reference: "last_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Êxodo 24:12-18", psalm: "Salmo 99", second_reading: "Filipenses 3:7-14", gospel: "Mateus 17:1-9" },
  { date_reference: "last_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "1 Reis 19:9-18", psalm: "Salmo 27", second_reading: "2 Pedro 1:13-21", gospel: "Marcos 9:2-9" },
  { date_reference: "last_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Êxodo 34:29-35", psalm: "Salmo 99", second_reading: "1 Coríntios 12:27-13:13", gospel: "Lucas 9:28-36" }
]

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
  else
    existing.update!(reading)
  end
end
