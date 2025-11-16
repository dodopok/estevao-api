# Dias Especiais do Advento e Natal
# Dias de semana importantes com leituras próprias

puts "📖 Carregando dias especiais do Advento e Natal..."

special_advent_christmas = [
  # 17 de dezembro - O Antífonas começam
  {
    date_reference: "december_17",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Genesis 49:2, 8-10",
    psalm: "Psalm 72:1-4, 7-8, 17",
    second_reading: "Matthew 1:1-17",
    gospel: "Matthew 1:1-17"
  },

  # 18 de dezembro
  {
    date_reference: "december_18",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremiah 23:5-8",
    psalm: "Psalm 72:1-2, 12-13, 18-19",
    second_reading: "Matthew 1:18-25",
    gospel: "Matthew 1:18-25"
  },

  # 19 de dezembro
  {
    date_reference: "december_19",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Judges 13:2-7, 24-25a",
    psalm: "Psalm 71:3-6, 16-17",
    second_reading: "Luke 1:5-25",
    gospel: "Luke 1:5-25"
  },

  # 20 de dezembro
  {
    date_reference: "december_20",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 7:10-14",
    psalm: "Psalm 24:1-6",
    second_reading: "Luke 1:26-38",
    gospel: "Luke 1:26-38"
  },

  # 21 de dezembro
  {
    date_reference: "december_21",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Song of Solomon 2:8-14 or Zephaniah 3:14-18a",
    psalm: "Psalm 33:2-3, 11-12, 20-21",
    second_reading: "Luke 1:39-45",
    gospel: "Luke 1:39-45"
  },

  # 22 de dezembro
  {
    date_reference: "december_22",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "1 Samuel 1:24-28",
    psalm: "1 Samuel 2:1, 4-8",
    second_reading: "Luke 1:46-56",
    gospel: "Luke 1:46-56"
  },

  # 23 de dezembro
  {
    date_reference: "december_23",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Malachi 3:1-4, 23-24",
    psalm: "Psalm 25:4-5, 8-10, 14",
    second_reading: "Luke 1:57-66",
    gospel: "Luke 1:57-66"
  },

  # 24 de dezembro (Véspera de Natal - manhã)
  {
    date_reference: "december_24_morning",
    cycle: "all",
    service_type: "morning",
    first_reading: "2 Samuel 7:1-5, 8-12, 14, 16",
    psalm: "Psalm 89:2-5, 27, 29",
    second_reading: "Luke 1:67-79",
    gospel: "Luke 1:67-79"
  },

  # Sagrada Família (Domingo depois do Natal ou 30 dez)
  {
    date_reference: "holy_family",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Sirach 3:2-6, 12-14",
    psalm: "Psalm 128:1-5",
    second_reading: "Colossians 3:12-21",
    gospel: "Matthew 2:13-15, 19-23"
  },
  {
    date_reference: "holy_family",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 15:1-6; 21:1-3",
    psalm: "Psalm 105:1-9",
    second_reading: "Hebrews 11:8, 11-12, 17-19",
    gospel: "Luke 2:22-40"
  },
  {
    date_reference: "holy_family",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Samuel 1:20-22, 24-28",
    psalm: "Psalm 84:2-3, 5-6, 9-10",
    second_reading: "1 John 3:1-2, 21-24",
    gospel: "Luke 2:41-52"
  },

  # 2º Domingo depois do Natal
  {
    date_reference: "2nd_sunday_after_christmas",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremiah 31:7-14 or Sirach 24:1-12",
    psalm: "Psalm 147:12-20 or Wisdom 10:15-21",
    second_reading: "Ephesians 1:3-14",
    gospel: "John 1:(1-9), 10-18"
  }
]

# Criar leituras
count = 0
special_advent_christmas.each do |reading|
  LectionaryReading.create!(reading)
  count += 1
  print "." if count % 5 == 0
end

puts "\n✅ #{count} dias especiais do Advento e Natal criados!"
