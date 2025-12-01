# ================================================================================
# LEITURAS DO ADVENTO - LOC 2015 IEAB
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - 4 Domingos do Advento (Ciclos A, B, C)
# - Dias especiais: 17-24 de dezembro (Antífonas "Ó")
#
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Advento (LOC 2015 IEAB)..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

advent_readings = [
  # ============================================================================
  # DOMINGOS DO ADVENTO
  # ============================================================================

  # ----------------------------------------------------------------------------
  # 1º DOMINGO DO ADVENTO
  # ----------------------------------------------------------------------------
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

  # ----------------------------------------------------------------------------
  # 2º DOMINGO DO ADVENTO
  # ----------------------------------------------------------------------------
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
    first_reading: "Baruque 5:1-9 or Malaquias 3:1-4",
    psalm: "Lucas 1:68-79",
    second_reading: "Filipenses 1:3-11",
    gospel: "Lucas 3:1-6"
  },

  # ----------------------------------------------------------------------------
  # 3º DOMINGO DO ADVENTO
  # ----------------------------------------------------------------------------
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 35:1-10",
    psalm: "Salmo 146:5-10 or Lucas 1:47-55",
    second_reading: "Tiago 5:7-10",
    gospel: "Mateus 11:2-11"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 61:1-4, 8-11",
    psalm: "Salmo 126 or Lucas 1:47-55",
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

  # ----------------------------------------------------------------------------
  # 4º DOMINGO DO ADVENTO
  # ----------------------------------------------------------------------------
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
    psalm: "Lucas 1:47-55 or Salmo 89:1-4, 19-26",
    second_reading: "Romanos 16:25-27",
    gospel: "Lucas 1:26-38"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Miqueias 5:2-5a",
    psalm: "Lucas 1:47-55 or Salmo 80:1-7",
    second_reading: "Hebreus 10:5-10",
    gospel: "Lucas 1:39-45 (46-55)"
  },

  # ============================================================================
  # DIAS ESPECIAIS DO ADVENTO (17-24 de dezembro)
  # Antífonas "Ó" - Preparação imediata para o Natal
  # ============================================================================

  # ----------------------------------------------------------------------------
  # 17 DE DEZEMBRO - Início das Antífonas "Ó"
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_17",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Gênesis 49:2, 8-10",
    psalm: "Salmo 72:1-4, 7-8, 17",
    second_reading: "Mateus 1:1-17",
    gospel: "Mateus 1:1-17"
  },

  # ----------------------------------------------------------------------------
  # 18 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_18",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 23:5-8",
    psalm: "Salmo 72:1-2, 12-13, 18-19",
    second_reading: "Mateus 1:18-25",
    gospel: "Mateus 1:18-25"
  },

  # ----------------------------------------------------------------------------
  # 19 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_19",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Juízes 13:2-7, 24-25a",
    psalm: "Salmo 71:3-6, 16-17",
    second_reading: "Lucas 1:5-25",
    gospel: "Lucas 1:5-25"
  },

  # ----------------------------------------------------------------------------
  # 20 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_20",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 7:10-14",
    psalm: "Salmo 24:1-6",
    second_reading: "Lucas 1:26-38",
    gospel: "Lucas 1:26-38"
  },

  # ----------------------------------------------------------------------------
  # 21 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_21",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Cântico dos Cânticos 2:8-14 or Sofonias 3:14-18a",
    psalm: "Salmo 33:2-3, 11-12, 20-21",
    second_reading: "Lucas 1:39-45",
    gospel: "Lucas 1:39-45"
  },

  # ----------------------------------------------------------------------------
  # 22 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_22",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "1 Samuel 1:24-28",
    psalm: "1 Samuel 2:1, 4-8",
    second_reading: "Lucas 1:46-56",
    gospel: "Lucas 1:46-56"
  },

  # ----------------------------------------------------------------------------
  # 23 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_23",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Malaquias 3:1-4, 23-24",
    psalm: "Salmo 25:4-5, 8-10, 14",
    second_reading: "Lucas 1:57-66",
    gospel: "Lucas 1:57-66"
  },

  # ----------------------------------------------------------------------------
  # 24 DE DEZEMBRO (Véspera de Natal - manhã)
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_24_morning",
    cycle: "all",
    service_type: "morning_prayer",
    first_reading: "2 Samuel 7:1-5, 8-12, 14, 16",
    psalm: "Salmo 89:2-5, 27, 29",
    second_reading: "Lucas 1:67-79",
    gospel: "Lucas 1:67-79"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

advent_readings.each do |reading|
  reading[:prayer_book_id] = prayer_book.id
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

Rails.logger.info "\n✅ #{count} leituras do Advento criadas!"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
