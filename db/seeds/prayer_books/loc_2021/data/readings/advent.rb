# ================================================================================
# LEITURAS DO ADVENTO - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Advento (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

advent_readings = [
  # ============================================================================
  # 1º DOMINGO DO ADVENTO
  # ============================================================================
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 2:1-5",
    psalm: "Salmo 122",
    second_reading: "Romanos 13:11-14",
    gospel: "Mateus 24:36-44"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 64:1-9",
    psalm: "Salmo 80:1-7, 17-19",
    second_reading: "1 Coríntios 1:3-9",
    gospel: "Marcos 13:24-37"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 33:14-16",
    psalm: "Salmo 25:1-10",
    second_reading: "1 Tessalonicenses 3:9-13",
    gospel: "Lucas 21:25-36"
  },

  # ============================================================================
  # 2º DOMINGO DO ADVENTO
  # ============================================================================
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 11:1-10",
    psalm: "Salmo 72:1-7, 18-19",
    second_reading: "Romanos 15:4-13",
    gospel: "Mateus 3:1-12"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 40:1-11",
    psalm: "Salmo 85:1-2, 8-13",
    second_reading: "2 Pedro 3:8-15a",
    gospel: "Marcos 1:1-8"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Malaquias 3:1-4",
    psalm: "Lucas 1:68-79",
    second_reading: "Filipenses 1:3-11",
    gospel: "Lucas 3:1-6"
  },

  # ============================================================================
  # 3º DOMINGO DO ADVENTO
  # ============================================================================
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 35:1-10",
    psalm: "Salmo 146:5-10",
    second_reading: "Tiago 5:7-10",
    gospel: "Mateus 11:2-11"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 61:1-4, 8-11",
    psalm: "Salmo 126",
    second_reading: "1 Tessalonicenses 5:16-24",
    gospel: "João 1:6-8, 19-28"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Sofonias 3:14-20",
    psalm: "Isaías 12:2-6",
    second_reading: "Filipenses 4:4-7",
    gospel: "Lucas 3:7-18"
  },

  # ============================================================================
  # 4º DOMINGO DO ADVENTO
  # ============================================================================
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 7:10-16",
    psalm: "Salmo 80:1-7, 17-19",
    second_reading: "Romanos 1:1-7",
    gospel: "Mateus 1:18-25"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 7:1-11, 16",
    psalm: "Lucas 1:47-55",
    second_reading: "Romanos 16:25-27",
    gospel: "Lucas 1:26-38"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Miqueias 5:2-5a",
    psalm: "Lucas 1:47-55",
    second_reading: "Hebreus 10:5-10",
    gospel: "Lucas 1:39-45 (46-55)"
  }
]

count = 0
skipped = 0

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
    count += 1
  else
    existing.update!(reading)
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Advento criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
