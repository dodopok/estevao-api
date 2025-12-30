# ================================================================================
# LEITURAS DE NATAL E EPIFANIA - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras de Natal e Epifania for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

christmas_readings = [
  # --- CHRISTMAS DAY I ---
  { date_reference: "christmas_day_1", cycle: "A", service_type: "eucharist", first_reading: "Isaías 9:1-7", psalm: "Salmo 96", second_reading: "Tito 2:11-14", gospel: "Lucas 2:1-14(15-20)" },
  { date_reference: "christmas_day_1", cycle: "B", service_type: "eucharist", first_reading: "Isaías 9:1-7", psalm: "Salmo 96", second_reading: "Tito 2:11-14", gospel: "Lucas 2:1-14(15-20)" },
  { date_reference: "christmas_day_1", cycle: "C", service_type: "eucharist", first_reading: "Isaías 9:1-7", psalm: "Salmo 96", second_reading: "Tito 2:11-14", gospel: "Lucas 2:1-14(15-20)" },

  # --- CHRISTMAS DAY II ---
  { date_reference: "christmas_day_2", cycle: "A", service_type: "eucharist", first_reading: "Isaías 62:6-12", psalm: "Salmo 97", second_reading: "Tito 3:4-7", gospel: "Lucas 2:(1-14)15-20" },
  { date_reference: "christmas_day_2", cycle: "B", service_type: "eucharist", first_reading: "Isaías 62:6-12", psalm: "Salmo 97", second_reading: "Tito 3:4-7", gospel: "Lucas 2:(1-14)15-20" },
  { date_reference: "christmas_day_2", cycle: "C", service_type: "eucharist", first_reading: "Isaías 62:6-12", psalm: "Salmo 97", second_reading: "Tito 3:4-7", gospel: "Lucas 2:(1-14)15-20" },

  # --- CHRISTMAS DAY III ---
  { date_reference: "christmas_day_3", cycle: "A", service_type: "eucharist", first_reading: "Isaías 52:7-12", psalm: "Salmo 98", second_reading: "Hebreus 1:1-12", gospel: "João 1:1-18" },
  { date_reference: "christmas_day_3", cycle: "B", service_type: "eucharist", first_reading: "Isaías 52:7-12", psalm: "Salmo 98", second_reading: "Hebreus 1:1-12", gospel: "João 1:1-18" },
  { date_reference: "christmas_day_3", cycle: "C", service_type: "eucharist", first_reading: "Isaías 52:7-12", psalm: "Salmo 98", second_reading: "Hebreus 1:1-12", gospel: "João 1:1-18" },

  # --- 1ST SUNDAY OF CHRISTMAS ---
  { date_reference: "1st_sunday_after_christmas", cycle: "A", service_type: "eucharist", first_reading: "Isaías 61:10-62:5", psalm: "Salmo 147:12-20", second_reading: "Gálatas 3:23-4:7", gospel: "João 1:1-18" },
  { date_reference: "1st_sunday_after_christmas", cycle: "B", service_type: "eucharist", first_reading: "Isaías 61:10-62:5", psalm: "Salmo 147:12-20", second_reading: "Gálatas 3:23-4:7", gospel: "João 1:1-18" },
  { date_reference: "1st_sunday_after_christmas", cycle: "C", service_type: "eucharist", first_reading: "Isaías 61:10-62:5", psalm: "Salmo 147:12-20", second_reading: "Gálatas 3:23-4:7", gospel: "João 1:1-18" },

  # --- THE CIRCUMCISION & HOLY NAME ---
  { date_reference: "the_circumcision_and_holy_name", cycle: "A", service_type: "eucharist", first_reading: "Êxodo 34:1-9", psalm: "Salmo 8", second_reading: "Romanos 1:1-7", gospel: "Lucas 2:15-21" },
  { date_reference: "the_circumcision_and_holy_name", cycle: "B", service_type: "eucharist", first_reading: "Êxodo 34:1-9", psalm: "Salmo 8", second_reading: "Romanos 1:1-7", gospel: "Lucas 2:15-21" },
  { date_reference: "the_circumcision_and_holy_name", cycle: "C", service_type: "eucharist", first_reading: "Êxodo 34:1-9", psalm: "Salmo 8", second_reading: "Romanos 1:1-7", gospel: "Lucas 2:15-21" },

  # --- 2ND SUNDAY OF CHRISTMAS ---
  { date_reference: "2nd_sunday_after_christmas", cycle: "A", service_type: "eucharist", first_reading: "Jeremias 31:7-14", psalm: "Salmo 84", second_reading: "Efésios 1:3-14", gospel: "Lucas 2:41-52 ou Mateus 2:1-12" },
  { date_reference: "2nd_sunday_after_christmas", cycle: "B", service_type: "eucharist", first_reading: "Jeremias 31:7-14", psalm: "Salmo 84", second_reading: "Efésios 1:3-14", gospel: "Mateus 2:13-23 ou Mateus 2:1-12" },
  { date_reference: "2nd_sunday_after_christmas", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 31:7-14", psalm: "Salmo 84", second_reading: "Efésios 1:3-14", gospel: "Lucas 2:22-40 ou Mateus 2:1-12" },

  # --- THE EPIPHANY ---
  { date_reference: "the_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Isaías 60:1-9", psalm: "Salmo 72 ou 72:1-11", second_reading: "Efésios 3:1-13", gospel: "Mateus 2:1-12" },
  { date_reference: "the_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Isaías 60:1-9", psalm: "Salmo 72 ou 72:1-11", second_reading: "Efésios 3:1-13", gospel: "Mateus 2:1-12" },
  { date_reference: "the_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Isaías 60:1-9", psalm: "Salmo 72 ou 72:1-11", second_reading: "Efésios 3:1-13", gospel: "Mateus 2:1-12" }
]

christmas_readings.each do |reading|
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
