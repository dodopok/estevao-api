# Leituras para Ocasiões Pastorais
# Casamentos, Funerais, Ordenações, Dedicação de Igreja, etc.

puts "📖 Carregando leituras para ocasiões pastorais..."

pastoral_readings = [
  # ========== MATRIMÔNIO (MARRIAGE) ==========

  # Matrimônio - Opção 1
  {
    date_reference: "marriage_1",
    cycle: "all",
    service_type: "marriage",
    first_reading: "Genesis 1:26-28, 31a",
    psalm: "Psalm 128",
    second_reading: "1 Corinthians 13:1-13",
    gospel: "Matthew 19:3-6"
  },

  # Matrimônio - Opção 2
  {
    date_reference: "marriage_2",
    cycle: "all",
    service_type: "marriage",
    first_reading: "Genesis 2:18-24",
    psalm: "Psalm 67",
    second_reading: "Ephesians 3:14-21",
    gospel: "Mark 10:6-9, 13-16"
  },

  # Matrimônio - Opção 3
  {
    date_reference: "marriage_3",
    cycle: "all",
    service_type: "marriage",
    first_reading: "Song of Solomon 2:10-13; 8:6-7",
    psalm: "Psalm 100",
    second_reading: "Colossians 3:12-17",
    gospel: "John 15:9-12"
  },

  # Matrimônio - Opção 4
  {
    date_reference: "marriage_4",
    cycle: "all",
    service_type: "marriage",
    first_reading: "Tobit 8:5b-8",
    psalm: "Psalm 145:8-14",
    second_reading: "Romans 12:1-2, 9-18",
    gospel: "John 2:1-11"
  },

  # ========== FUNERAL (BURIAL OF THE DEAD) ==========

  # Funeral - Opção 1
  {
    date_reference: "funeral_1",
    cycle: "all",
    service_type: "funeral",
    first_reading: "Isaiah 25:6-9",
    psalm: "Psalm 23",
    second_reading: "Romans 8:31-39",
    gospel: "John 11:21-27"
  },

  # Funeral - Opção 2
  {
    date_reference: "funeral_2",
    cycle: "all",
    service_type: "funeral",
    first_reading: "Wisdom 3:1-5, 9",
    psalm: "Psalm 42:1-7",
    second_reading: "1 Corinthians 15:51-57",
    gospel: "John 14:1-6"
  },

  # Funeral - Opção 3
  {
    date_reference: "funeral_3",
    cycle: "all",
    service_type: "funeral",
    first_reading: "Lamentations 3:22-26, 31-33",
    psalm: "Psalm 90:1-12",
    second_reading: "Revelation 21:1-7",
    gospel: "John 6:37-40"
  },

  # Funeral - Opção 4
  {
    date_reference: "funeral_4",
    cycle: "all",
    service_type: "funeral",
    first_reading: "Isaiah 61:1-3",
    psalm: "Psalm 130",
    second_reading: "1 Thessalonians 4:13-18",
    gospel: "Luke 24:1-9"
  },

  # ========== ORDENAÇÃO (ORDINATION) ==========

  # Ordenação de Bispo
  {
    date_reference: "ordination_bishop",
    cycle: "all",
    service_type: "ordination",
    first_reading: "Isaiah 61:1-8",
    psalm: "Psalm 40:1-11",
    second_reading: "1 Timothy 3:1-7",
    gospel: "John 21:15-17"
  },

  # Ordenação de Presbítero
  {
    date_reference: "ordination_priest",
    cycle: "all",
    service_type: "ordination",
    first_reading: "Jeremiah 1:4-10",
    psalm: "Psalm 84",
    second_reading: "1 Peter 5:1-11",
    gospel: "John 10:11-18"
  },

  # Ordenação de Diácono
  {
    date_reference: "ordination_deacon",
    cycle: "all",
    service_type: "ordination",
    first_reading: "Ecclesiasticus 39:1-8",
    psalm: "Psalm 119:33-40",
    second_reading: "Acts 6:2-7",
    gospel: "Luke 12:35-43"
  },

  # ========== DEDICAÇÃO DE IGREJA ==========

  # Dedicação de Igreja - Opção 1
  {
    date_reference: "church_dedication_1",
    cycle: "all",
    service_type: "dedication",
    first_reading: "1 Kings 8:22-30",
    psalm: "Psalm 122",
    second_reading: "Hebrews 12:18-24",
    gospel: "Matthew 21:12-16"
  },

  # Dedicação de Igreja - Opção 2
  {
    date_reference: "church_dedication_2",
    cycle: "all",
    service_type: "dedication",
    first_reading: "Genesis 28:10-17",
    psalm: "Psalm 84",
    second_reading: "Revelation 21:1-5a",
    gospel: "John 10:22-30"
  },

  # ========== BATISMO (BAPTISM) ==========

  # Batismo - Opção 1
  {
    date_reference: "baptism_1",
    cycle: "all",
    service_type: "baptism",
    first_reading: "Ezekiel 36:24-28",
    psalm: "Psalm 23",
    second_reading: "Romans 6:3-5",
    gospel: "Mark 1:9-11"
  },

  # Batismo - Opção 2
  {
    date_reference: "baptism_2",
    cycle: "all",
    service_type: "baptism",
    first_reading: "Ezekiel 47:1-9, 12",
    psalm: "Psalm 42:1-7",
    second_reading: "Romans 8:14-17",
    gospel: "John 3:1-6"
  },

  # ========== CONFIRMAÇÃO (CONFIRMATION) ==========

  # Confirmação - Opção 1
  {
    date_reference: "confirmation_1",
    cycle: "all",
    service_type: "confirmation",
    first_reading: "Isaiah 61:1-6",
    psalm: "Psalm 139:1-9",
    second_reading: "Acts 8:14-17",
    gospel: "John 14:15-21"
  },

  # Confirmação - Opção 2
  {
    date_reference: "confirmation_2",
    cycle: "all",
    service_type: "confirmation",
    first_reading: "Ezekiel 37:1-10",
    psalm: "Psalm 104:25-32",
    second_reading: "Acts 19:1-6",
    gospel: "Matthew 3:13-17"
  },

  # ========== VOCAÇÕES (VOCATIONS) ==========

  # Para Vocações Religiosas
  {
    date_reference: "vocations",
    cycle: "all",
    service_type: "special",
    first_reading: "1 Samuel 3:1-10",
    psalm: "Psalm 63:1-8",
    second_reading: "Philippians 3:8-14",
    gospel: "Luke 5:1-11"
  },

  # ========== CELEBRAÇÃO DA NOVA VIDA (NEW LIFE) ==========

  # Nascimento/Adoção de Criança
  {
    date_reference: "new_life",
    cycle: "all",
    service_type: "special",
    first_reading: "1 Samuel 1:20-28",
    psalm: "Psalm 116:12-19",
    second_reading: "Galatians 4:4-7",
    gospel: "Luke 2:22-40"
  },

  # ========== MINISTÉRIO LEIGO (LAY MINISTRY) ==========

  # Comissionamento de Ministros Leigos
  {
    date_reference: "lay_ministry",
    cycle: "all",
    service_type: "special",
    first_reading: "Isaiah 6:1-8",
    psalm: "Psalm 96:1-9",
    second_reading: "1 Corinthians 12:4-11",
    gospel: "Matthew 9:35-38"
  },

  # ========== CURA (HEALING) ==========

  # Serviço de Cura
  {
    date_reference: "healing_service",
    cycle: "all",
    service_type: "special",
    first_reading: "2 Kings 20:1-5",
    psalm: "Psalm 103:1-5",
    second_reading: "James 5:13-16",
    gospel: "Luke 17:11-19"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
pastoral_readings.each do |reading|
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

puts "\n✅ #{count} leituras para ocasiões pastorais criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
