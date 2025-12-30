# ================================================================================
# LEITURAS DA QUARESMA - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Quaresma for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

lent_readings = [
  # --- ASH WEDNESDAY ---
  { date_reference: "ash_wednesday", cycle: "A", service_type: "eucharist", first_reading: "Joel 2:1-2, 12-17 ou Isaías 58:1-12", psalm: "Salmo 103 ou 103:8-14", second_reading: "2 Coríntios 5:20-6:10", gospel: "Mateus 6:1-6, 16-21" },
  { date_reference: "ash_wednesday", cycle: "B", service_type: "eucharist", first_reading: "Joel 2:1-2, 12-17 ou Isaías 58:1-12", psalm: "Salmo 103 ou 103:8-14", second_reading: "2 Coríntios 5:20-6:10", gospel: "Mateus 6:1-6, 16-21" },
  { date_reference: "ash_wednesday", cycle: "C", service_type: "eucharist", first_reading: "Joel 2:1-2, 12-17 ou Isaías 58:1-12", psalm: "Salmo 103 ou 103:8-14", second_reading: "2 Coríntios 5:20-6:10", gospel: "Mateus 6:1-6, 16-21" },

  # --- 1ST SUNDAY IN LENT ---
  { date_reference: "1st_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Gênesis 2:4-9, 15-17, 25-3:7", psalm: "Salmo 51 ou 51:1-12", second_reading: "Romanos 5:12-21", gospel: "Mateus 4:1-11" },
  { date_reference: "1st_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Gênesis 9:8-17", psalm: "Salmo 25 ou 25:3-9", second_reading: "1 Pedro 3:18-22", gospel: "Marcos 1:9-13" },
  { date_reference: "1st_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Deuteronômio 26:(1-4)5-11", psalm: "Salmo 91 ou 91:9-16", second_reading: "Romanos 10:4-13", gospel: "Lucas 4:1-13" },

  # --- 2ND SUNDAY IN LENT ---
  { date_reference: "2nd_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Gênesis 12:1-9", psalm: "Salmo 33:12-21", second_reading: "Romanos 4:1-5(6-12)13-17", gospel: "João 3:1-16" },
  { date_reference: "2nd_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Gênesis 22:1-14", psalm: "Salmo 16 ou 16:6-12", second_reading: "Romanos 8:31-39", gospel: "Marcos 8:31-38" },
  { date_reference: "2nd_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 15:1-18", psalm: "Salmo 27 ou 27:9-17", second_reading: "Filipenses 3:17-4:1", gospel: "Lucas 13:(22-30)31-35" },

  # --- 3RD SUNDAY IN LENT ---
  { date_reference: "3rd_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Êxodo 17:1-7", psalm: "Salmo 95", second_reading: "Romanos 1:16-32", gospel: "João 4:5-26(27-38)39-42" },
  { date_reference: "3rd_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Êxodo 20:1-21", psalm: "Salmo 19:7-14", second_reading: "Romanos 7:12-25", gospel: "João 2:13-22" },
  { date_reference: "3rd_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Êxodo 3:1-15", psalm: "Salmo 103 ou 103:1-12", second_reading: "1 Coríntios 10:1-13", gospel: "Lucas 13:1-9(10-17)" },

  # --- 4TH SUNDAY IN LENT ---
  { date_reference: "4th_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "1 Samuel 16:1-13", psalm: "Salmo 23", second_reading: "Efésios 5:1-14", gospel: "João 9:1-13, 28-38(39-41)" },
  { date_reference: "4th_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "2 Crônicas 36:14-23", psalm: "Salmo 122", second_reading: "Efésios 2:1-10", gospel: "João 6:1-15" },
  { date_reference: "4th_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Josué (4:19-24)5:1(2-8)9-12", psalm: "Salmo 34 ou 34:1-8", second_reading: "2 Coríntios 5:17-21", gospel: "Lucas 15:11-32" },

  # --- 5TH SUNDAY IN LENT (PASSION SUNDAY) ---
  { date_reference: "5th_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Ezequiel 37:1-14", psalm: "Salmo 130", second_reading: "Romanos 6:15-23", gospel: "João 11:(1-17)18-44" },
  { date_reference: "5th_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Jeremias 31:31-34", psalm: "Salmo 51 ou 51:10-15", second_reading: "Hebreus (4:14-16)5:1-10", gospel: "João 12:20-33(34-36)" },
  { date_reference: "5th_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Isaías 43:16-21", psalm: "Salmo 126", second_reading: "Filipenses 3:7-16", gospel: "Lucas 20:9-19" }
]

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
  else
    existing.update!(reading)
  end
end
