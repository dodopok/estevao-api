# ================================================================================
# LEITURAS DO ADVENTO - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Advento for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

advent_readings = [
  # --- 1ST SUNDAY IN ADVENT ---
  { date_reference: "1st_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaías 2:1-5", psalm: "Salmo 122", second_reading: "Romanos 13:8-14", gospel: "Mateus 24:29-44" },
  { date_reference: "1st_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "Isaías 64:1-9a", psalm: "Salmo 80 ou 80:1-7", second_reading: "1 Coríntios 1:1-9", gospel: "Marcos 13:24-37" },
  { date_reference: "1st_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Zacarias 14:(1-2)3-9", psalm: "Salmo 50 ou 50:1-6", second_reading: "1 Tessalonicenses 3:6-13", gospel: "Lucas 21:25-33" },

  # --- 2ND SUNDAY IN ADVENT ---
  { date_reference: "2nd_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaías 11:1-10", psalm: "Salmo 72:1-15(16-19)", second_reading: "Romanos 15:1-13", gospel: "Mateus 3:1-12" },
  { date_reference: "2nd_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "Isaías 40:1-11", psalm: "Salmo 85", second_reading: "2 Pedro 3:8-18", gospel: "Marcos 1:1-8" },
  { date_reference: "2nd_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Malaquias 3:1-5", psalm: "Salmo 126", second_reading: "1 Coríntios 4:(1-7)8-21", gospel: "Lucas 3:1-6" },

  # --- 3RD SUNDAY IN ADVENT ---
  { date_reference: "3rd_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaías 35:1-10", psalm: "Salmo 146", second_reading: "Tiago 5:7-20", gospel: "Mateus 11:2-19" },
  { date_reference: "3rd_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "Isaías 65:17-25", psalm: "Salmo 126", second_reading: "1 Tessalonicenses 5:12-28", gospel: "João 3:22-30 ou João 1:19-28" },
  { date_reference: "3rd_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Sofonias 3:14-20", psalm: "Salmo 85", second_reading: "Filipenses 4:4-9", gospel: "Lucas 3:7-20" },

  # --- 4TH SUNDAY IN ADVENT ---
  { date_reference: "4th_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaías 7:10-17", psalm: "Salmo 24", second_reading: "Romanos 1:1-7", gospel: "Mateus 1:18-25" },
  { date_reference: "4th_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "2 Samuel 7:1-17", psalm: "Salmo 132:(1-7) 8-19", second_reading: "Romanos 16:25-27", gospel: "Lucas 1:26-38" },
  { date_reference: "4th_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Miquéias 5:2-5a", psalm: "Salmo 80:1-7", second_reading: "Hebreus 10:1-10", gospel: "Lucas 1:39-56" }
]

advent_readings.each do |reading|
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
