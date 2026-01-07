# ================================================================================
# LEITURAS DO TEMPO DE NATAL - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo de Natal (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

christmas_readings = [
  # ============================================================================
  # VIGÍLIA DE NATAL (24 de dezembro - noite)
  # ============================================================================
  {
    date_reference: "christmas_eve",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 11:1-9",
    psalm: "Salmo 96",
    second_reading: "Romanos 1:1-7 or Gálatas 4:4-7",
    gospel: "Lucas 2:1-7"
  },

  # ============================================================================
  # DIA DE NATAL (25 de dezembro)
  # ============================================================================
  {
    date_reference: "christmas_day",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 9:2-7",
    psalm: "Salmo 96",
    second_reading: "Tito 2:11-14",
    gospel: "Lucas 2:1-14 (15-20)"
  },
  {
    date_reference: "christmas_day",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 52:7-10",
    psalm: "Salmo 97",
    second_reading: "Hebreus 1:1-4 (5-12)",
    gospel: "Lucas 2:1-20"
  },
  {
    date_reference: "christmas_day",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 62:6-12",
    psalm: "Salmo 98",
    second_reading: "Tito 3:4-7",
    gospel: "João 1:1-14"
  }
]

count = 0
skipped = 0

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
    count += 1
  else
    existing.update!(reading)
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Tempo de Natal criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
