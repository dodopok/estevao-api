# ================================================================================
# LEITURAS DO ADVENTO
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - 4 Domingos do Advento (Ciclos A, B, C)
# - Dias especiais: 17-24 de dezembro (Antífonas "Ó")
#
# ================================================================================

puts "📖 Carregando leituras do Advento..."

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
    first_reading: "Isaiah 2:1-5",
    psalm: "Psalm 122",
    second_reading: "Romans 13:11-14",
    gospel: "Matthew 24:36-44"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 64:1-9",
    psalm: "Psalm 80:1-7, 17-19",
    second_reading: "1 Corinthians 1:3-9",
    gospel: "Mark 13:24-37"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 33:14-16",
    psalm: "Psalm 25:1-10",
    second_reading: "1 Thessalonians 3:9-13",
    gospel: "Luke 21:25-36"
  },

  # ----------------------------------------------------------------------------
  # 2º DOMINGO DO ADVENTO
  # ----------------------------------------------------------------------------
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 11:1-10",
    psalm: "Psalm 72:1-7, 18-19",
    second_reading: "Romans 15:4-13",
    gospel: "Matthew 3:1-12"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 40:1-11",
    psalm: "Psalm 85:1-2, 8-13",
    second_reading: "2 Peter 3:8-15a",
    gospel: "Mark 1:1-8"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Baruch 5:1-9 or Malachi 3:1-4",
    psalm: "Luke 1:68-79",
    second_reading: "Philippians 1:3-11",
    gospel: "Luke 3:1-6"
  },

  # ----------------------------------------------------------------------------
  # 3º DOMINGO DO ADVENTO
  # ----------------------------------------------------------------------------
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 35:1-10",
    psalm: "Psalm 146:5-10 or Luke 1:47-55",
    second_reading: "James 5:7-10",
    gospel: "Matthew 11:2-11"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 61:1-4, 8-11",
    psalm: "Psalm 126 or Luke 1:47-55",
    second_reading: "1 Thessalonians 5:16-24",
    gospel: "John 1:6-8, 19-28"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Zephaniah 3:14-20",
    psalm: "Isaiah 12:2-6",
    second_reading: "Philippians 4:4-7",
    gospel: "Luke 3:7-18"
  },

  # ----------------------------------------------------------------------------
  # 4º DOMINGO DO ADVENTO
  # ----------------------------------------------------------------------------
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 7:10-16",
    psalm: "Psalm 80:1-7, 17-19",
    second_reading: "Romans 1:1-7",
    gospel: "Matthew 1:18-25"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 7:1-11, 16",
    psalm: "Luke 1:47-55 or Psalm 89:1-4, 19-26",
    second_reading: "Romans 16:25-27",
    gospel: "Luke 1:26-38"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Micah 5:2-5a",
    psalm: "Luke 1:47-55 or Psalm 80:1-7",
    second_reading: "Hebrews 10:5-10",
    gospel: "Luke 1:39-45 (46-55)"
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
    first_reading: "Genesis 49:2, 8-10",
    psalm: "Psalm 72:1-4, 7-8, 17",
    second_reading: "Matthew 1:1-17",
    gospel: "Matthew 1:1-17"
  },

  # ----------------------------------------------------------------------------
  # 18 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_18",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremiah 23:5-8",
    psalm: "Psalm 72:1-2, 12-13, 18-19",
    second_reading: "Matthew 1:18-25",
    gospel: "Matthew 1:18-25"
  },

  # ----------------------------------------------------------------------------
  # 19 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_19",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Judges 13:2-7, 24-25a",
    psalm: "Psalm 71:3-6, 16-17",
    second_reading: "Luke 1:5-25",
    gospel: "Luke 1:5-25"
  },

  # ----------------------------------------------------------------------------
  # 20 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_20",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 7:10-14",
    psalm: "Psalm 24:1-6",
    second_reading: "Luke 1:26-38",
    gospel: "Luke 1:26-38"
  },

  # ----------------------------------------------------------------------------
  # 21 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_21",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Song of Solomon 2:8-14 or Zephaniah 3:14-18a",
    psalm: "Psalm 33:2-3, 11-12, 20-21",
    second_reading: "Luke 1:39-45",
    gospel: "Luke 1:39-45"
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
    second_reading: "Luke 1:46-56",
    gospel: "Luke 1:46-56"
  },

  # ----------------------------------------------------------------------------
  # 23 DE DEZEMBRO
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_23",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Malachi 3:1-4, 23-24",
    psalm: "Psalm 25:4-5, 8-10, 14",
    second_reading: "Luke 1:57-66",
    gospel: "Luke 1:57-66"
  },

  # ----------------------------------------------------------------------------
  # 24 DE DEZEMBRO (Véspera de Natal - manhã)
  # ----------------------------------------------------------------------------
  {
    date_reference: "december_24_morning",
    cycle: "all",
    service_type: "morning_prayer",
    first_reading: "2 Samuel 7:1-5, 8-12, 14, 16",
    psalm: "Psalm 89:2-5, 27, 29",
    second_reading: "Luke 1:67-79",
    gospel: "Luke 1:67-79"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

advent_readings.each do |reading|
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type]
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 5 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} leituras do Advento criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
