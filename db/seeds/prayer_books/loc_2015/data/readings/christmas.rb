# ================================================================================
# LEITURAS DO TEMPO DE NATAL
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - Vigília de Natal (24 dez)
# - Dia de Natal (25 dez)
# - 1º Domingo após o Natal
# - Sagrada Família
# - 2º Domingo após o Natal
#
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo de Natal..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

christmas_readings = [
  # ============================================================================
  # NATAL
  # ============================================================================

  # ----------------------------------------------------------------------------
  # VIGÍLIA DE NATAL (24 de dezembro - noite)
  # ----------------------------------------------------------------------------
  {
    date_reference: "christmas_eve",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 9:2-7",
    psalm: "Salmo 96",
    second_reading: "Tito 2:11-14",
    gospel: "Lucas 2:1-14, (15-20)"
  },

  # ----------------------------------------------------------------------------
  # DIA DE NATAL (25 de dezembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "christmas_day",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 52:7-10",
    psalm: "Salmo 98",
    second_reading: "Hebreus 1:1-4, (5-12)",
    gospel: "João 1:1-14"
  },

  # ============================================================================
  # DOMINGOS E FESTAS APÓS O NATAL
  # ============================================================================

  # ----------------------------------------------------------------------------
  # 1º DOMINGO APÓS O NATAL
  # ----------------------------------------------------------------------------
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 63:7-9",
    psalm: "Salmo 148",
    second_reading: "Hebreus 2:10-18",
    gospel: "Mateus 2:13-23"
  },
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 61:10-62:3",
    psalm: "Salmo 148",
    second_reading: "Gálatas 4:4-7",
    gospel: "Lucas 2:22-40"
  },
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Samuel 2:18-20, 26",
    psalm: "Salmo 148",
    second_reading: "Colossenses 3:12-17",
    gospel: "Lucas 2:41-52"
  },

  # ----------------------------------------------------------------------------
  # SAGRADA FAMÍLIA (Domingo após Natal ou 30 de dezembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "holy_family",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Eclesiástico 3:2-6, 12-14",
    psalm: "Salmo 128:1-5",
    second_reading: "Colossenses 3:12-21",
    gospel: "Mateus 2:13-15, 19-23"
  },
  {
    date_reference: "holy_family",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 15:1-6; 21:1-3",
    psalm: "Salmo 105:1-9",
    second_reading: "Hebreus 11:8, 11-12, 17-19",
    gospel: "Lucas 2:22-40"
  },
  {
    date_reference: "holy_family",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Samuel 1:20-22, 24-28",
    psalm: "Salmo 84:2-3, 5-6, 9-10",
    second_reading: "1 João 3:1-2, 21-24",
    gospel: "Lucas 2:41-52"
  },

  # ----------------------------------------------------------------------------
  # 2º DOMINGO APÓS O NATAL
  # ----------------------------------------------------------------------------
  {
    date_reference: "2nd_sunday_after_christmas",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 31:7-14 or Eclesiástico 24:1-12",
    psalm: "Salmo 147:12-20 or Sabedoria 10:15-21",
    second_reading: "Efésios 1:3-14",
    gospel: "João 1:(1-9), 10-18"
  }
]

# Criar leituras (evita duplicatas)
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
    print "." if count % 5 == 0
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Tempo de Natal criadas!"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
