# ================================================================================
# LEITURAS DA QUARESMA
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - Quarta-feira de Cinzas
# - 5 Domingos da Quaresma (Ciclos A, B, C)
# - Domingo de Ramos (Ciclos A, B, C)
#
# ================================================================================

puts "📖 Carregando leituras da Quaresma..."

lent_readings = [
  # ============================================================================
  # QUARTA-FEIRA DE CINZAS
  # ============================================================================
  {
    date_reference: "ash_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Joel 2:1-2, 12-17 or Isaiah 58:1-12",
    psalm: "Psalm 51:1-17",
    second_reading: "2 Corinthians 5:20b-6:10",
    gospel: "Matthew 6:1-6, 16-21"
  },

  # ============================================================================
  # DOMINGOS DA QUARESMA
  # ============================================================================

  # ----------------------------------------------------------------------------
  # 1º DOMINGO NA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 2:15-17; 3:1-7",
    psalm: "Psalm 32",
    second_reading: "Romans 5:12-19",
    gospel: "Matthew 4:1-11"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 9:8-17",
    psalm: "Psalm 25:1-10",
    second_reading: "1 Peter 3:18-22",
    gospel: "Mark 1:9-15"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronomy 26:1-11",
    psalm: "Psalm 91:1-2, 9-16",
    second_reading: "Romans 10:8b-13",
    gospel: "Luke 4:1-13"
  },

  # ----------------------------------------------------------------------------
  # 2º DOMINGO NA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 12:1-4a",
    psalm: "Psalm 121",
    second_reading: "Romans 4:1-5, 13-17",
    gospel: "John 3:1-17 or Matthew 17:1-9"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 17:1-7, 15-16",
    psalm: "Psalm 22:23-31",
    second_reading: "Romans 4:13-25",
    gospel: "Mark 8:31-38 or Mark 9:2-9"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 15:1-12, 17-18",
    psalm: "Psalm 27",
    second_reading: "Philippians 3:17-4:1",
    gospel: "Luke 13:31-35 or Luke 9:28-36, (37-43)"
  },

  # ----------------------------------------------------------------------------
  # 3º DOMINGO NA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 17:1-7",
    psalm: "Psalm 95",
    second_reading: "Romans 5:1-11",
    gospel: "John 4:5-42"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Exodus 20:1-17",
    psalm: "Psalm 19",
    second_reading: "1 Corinthians 1:18-25",
    gospel: "John 2:13-22"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaiah 55:1-9",
    psalm: "Psalm 63:1-8",
    second_reading: "1 Corinthians 10:1-13",
    gospel: "Luke 13:1-9"
  },

  # ----------------------------------------------------------------------------
  # 4º DOMINGO NA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "1 Samuel 16:1-13",
    psalm: "Psalm 23",
    second_reading: "Ephesians 5:8-14",
    gospel: "John 9:1-41"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Numbers 21:4-9",
    psalm: "Psalm 107:1-3, 17-22",
    second_reading: "Ephesians 2:1-10",
    gospel: "John 3:14-21"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Joshua 5:9-12",
    psalm: "Psalm 32",
    second_reading: "2 Corinthians 5:16-21",
    gospel: "Luke 15:1-3, 11b-32"
  },

  # ----------------------------------------------------------------------------
  # 5º DOMINGO NA QUARESMA
  # ----------------------------------------------------------------------------
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezekiel 37:1-14",
    psalm: "Psalm 130",
    second_reading: "Romans 8:6-11",
    gospel: "John 11:1-45"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremiah 31:31-34",
    psalm: "Psalm 51:1-12 or Psalm 119:9-16",
    second_reading: "Hebrews 5:5-10",
    gospel: "John 12:20-33"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaiah 43:16-21",
    psalm: "Psalm 126",
    second_reading: "Philippians 3:4b-14",
    gospel: "John 12:1-8"
  },

  # ----------------------------------------------------------------------------
  # DOMINGO DE RAMOS (Paixão do Senhor)
  # ----------------------------------------------------------------------------
  {
    date_reference: "palm_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 31:9-16",
    second_reading: "Philippians 2:5-11",
    gospel: "Matthew 26:14-27:66 or Matthew 27:11-54"
  },
  {
    date_reference: "palm_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 31:9-16",
    second_reading: "Philippians 2:5-11",
    gospel: "Mark 14:1-15:47 or Mark 15:1-39, (40-47)"
  },
  {
    date_reference: "palm_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 31:9-16",
    second_reading: "Philippians 2:5-11",
    gospel: "Luke 22:14-23:56 or Luke 23:1-49"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

lent_readings.each do |reading|
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

puts "\n✅ #{count} leituras da Quaresma criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
