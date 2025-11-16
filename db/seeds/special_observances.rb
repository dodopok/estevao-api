# Observâncias Especiais da Tradição Anglicana/Episcopal
# Dias de ação de graças, rogação, e outras celebrações nacionais

puts "📖 Carregando observâncias especiais..."

special_observances = [
  # Thanksgiving Day (EUA - 4ª quinta-feira de novembro)
  {
    date_reference: "thanksgiving_usa",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronomy 8:7-18",
    psalm: "Psalm 65",
    second_reading: "2 Corinthians 9:6-15",
    gospel: "Luke 17:11-19"
  },

  # Thanksgiving Day (Alternativa 1)
  {
    date_reference: "thanksgiving_usa_alt1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Joel 2:21-27",
    psalm: "Psalm 126",
    second_reading: "1 Timothy 2:1-7",
    gospel: "Matthew 6:25-33"
  },

  # Thanksgiving Day (Alternativa 2)
  {
    date_reference: "thanksgiving_usa_alt2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronomy 26:1-11",
    psalm: "Psalm 100",
    second_reading: "Philippians 4:4-9",
    gospel: "John 6:25-35"
  },

  # Thanksgiving Day (Canadá - 2ª segunda-feira de outubro)
  {
    date_reference: "thanksgiving_canada",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronomy 8:7-18",
    psalm: "Psalm 65",
    second_reading: "2 Corinthians 9:6-15",
    gospel: "Luke 12:15-21"
  },

  # Rogation Days (3 dias antes da Ascensão)
  {
    date_reference: "rogation_day",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronomy 11:10-15",
    psalm: "Psalm 104:13-23",
    second_reading: "1 Timothy 6:6-10, 17-19",
    gospel: "Luke 12:13-21"
  },

  # Independence Day (4 de julho - EUA)
  {
    date_reference: "independence_day_usa",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronomy 10:17-21",
    psalm: "Psalm 145:1-9",
    second_reading: "Hebrews 11:8-16",
    gospel: "Matthew 5:43-48"
  },

  # Ember Days - Primavera (Spring Ember Days)
  {
    date_reference: "ember_days_spring",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Ezekiel 34:11-16",
    psalm: "Psalm 23",
    second_reading: "1 Peter 5:1-11",
    gospel: "John 21:15-17"
  },

  # Ember Days - Verão (Summer Ember Days)
  {
    date_reference: "ember_days_summer",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremiah 1:4-10",
    psalm: "Psalm 84",
    second_reading: "Acts 13:44-49",
    gospel: "Luke 4:16-21"
  },

  # Ember Days - Outono (Fall Ember Days)
  {
    date_reference: "ember_days_fall",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 6:1-8",
    psalm: "Psalm 122",
    second_reading: "1 Corinthians 3:10-17",
    gospel: "Luke 12:35-43"
  },

  # Ember Days - Inverno (Winter Ember Days)
  {
    date_reference: "ember_days_winter",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 52:7-10",
    psalm: "Psalm 96",
    second_reading: "Acts 1:8-14",
    gospel: "Luke 10:1-9"
  },

  # For the Unity of the Church (Semana de Oração pela Unidade)
  {
    date_reference: "unity_of_church",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 35:1-10",
    psalm: "Psalm 122",
    second_reading: "1 Corinthians 1:10-17",
    gospel: "John 17:15-23"
  },

  # For the Mission of the Church
  {
    date_reference: "mission_of_church",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 49:1-6",
    psalm: "Psalm 67",
    second_reading: "Acts 13:44-49",
    gospel: "Luke 10:1-9"
  },

  # For Peace (Dia de Oração pela Paz)
  {
    date_reference: "for_peace",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Micah 4:1-5",
    psalm: "Psalm 85:7-13",
    second_reading: "Ephesians 2:13-18",
    gospel: "John 14:23-29"
  },

  # For Social Justice
  {
    date_reference: "social_justice",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Amos 5:18-24",
    psalm: "Psalm 72:1-4, 12-14",
    second_reading: "James 2:1-9, 14-17",
    gospel: "Matthew 25:31-46"
  },

  # Dia de Finados (2 de novembro)
  {
    date_reference: "all_souls",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Wisdom 3:1-9 or Isaiah 25:6-9",
    psalm: "Psalm 23",
    second_reading: "Romans 8:31-39",
    gospel: "John 6:37-40"
  },

  # Harvest Thanksgiving (Ação de Graças pela Colheita)
  {
    date_reference: "harvest_thanksgiving",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronomy 26:1-11",
    psalm: "Psalm 65",
    second_reading: "2 Corinthians 9:6-15",
    gospel: "Luke 12:16-30"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
special_observances.each do |reading|
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

puts "\n✅ #{count} observâncias especiais criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
