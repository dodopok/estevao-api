# Leituras Completas do Lecionário - Parte 2
# Complementa as leituras que faltavam

puts "📖 Carregando leituras complementares..."

additional_readings = [
  # ============= MAIS DOMINGOS DA QUARESMA =============

  # 3º Domingo na Quaresma
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

  # 4º Domingo na Quaresma
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

  # 5º Domingo na Quaresma
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

  # ============= MAIS DOMINGOS DA PÁSCOA =============

  # 4º Domingo da Páscoa
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 2:42-47",
    psalm: "Psalm 23",
    second_reading: "1 Peter 2:19-25",
    gospel: "John 10:1-10"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 4:5-12",
    psalm: "Psalm 23",
    second_reading: "1 John 3:16-24",
    gospel: "John 10:11-18"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 9:36-43",
    psalm: "Psalm 23",
    second_reading: "Revelation 7:9-17",
    gospel: "John 10:22-30"
  },

  # 5º Domingo da Páscoa
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 7:55-60",
    psalm: "Psalm 31:1-5, 15-16",
    second_reading: "1 Peter 2:2-10",
    gospel: "John 14:1-14"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 8:26-40",
    psalm: "Psalm 22:25-31",
    second_reading: "1 John 4:7-21",
    gospel: "John 15:1-8"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 11:1-18",
    psalm: "Psalm 148",
    second_reading: "Revelation 21:1-6",
    gospel: "John 13:31-35"
  },

  # 6º Domingo da Páscoa
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 17:22-31",
    psalm: "Psalm 66:8-20",
    second_reading: "1 Peter 3:13-22",
    gospel: "John 14:15-21"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 10:44-48",
    psalm: "Psalm 98",
    second_reading: "1 John 5:1-6",
    gospel: "John 15:9-17"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 16:9-15",
    psalm: "Psalm 67",
    second_reading: "Revelation 21:10, 22-22:5",
    gospel: "John 14:23-29"
  },

  # ============= MAIS PROPERS DO TEMPO COMUM =============

  # Proper 5
  {
    date_reference: "proper_5",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 12:1-9",
    psalm: "Psalm 33:1-12",
    second_reading: "Romans 4:13-25",
    gospel: "Matthew 9:9-13, 18-26"
  },
  {
    date_reference: "proper_5",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 8:4-11, (12-15), 16-20, (11:14-15)",
    psalm: "Psalm 138",
    second_reading: "2 Corinthians 4:13-5:1",
    gospel: "Mark 3:20-35"
  },
  {
    date_reference: "proper_5",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Kings 17:8-16, (17-24)",
    psalm: "Psalm 146",
    second_reading: "Galatians 1:11-24",
    gospel: "Luke 7:11-17"
  },

  # Proper 6
  {
    date_reference: "proper_6",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 18:1-15, (21:1-7)",
    psalm: "Psalm 116:1-2, 12-19",
    second_reading: "Romans 5:1-8",
    gospel: "Matthew 9:35-10:8, (9-23)"
  },
  {
    date_reference: "proper_6",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 15:34-16:13",
    psalm: "Psalm 20",
    second_reading: "2 Corinthians 5:6-10, (11-13), 14-17",
    gospel: "Mark 4:26-34"
  },
  {
    date_reference: "proper_6",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Kings 21:1-10, (11-14), 15-21a",
    psalm: "Psalm 5:1-8",
    second_reading: "Galatians 2:15-21",
    gospel: "Luke 7:36-8:3"
  },

  # Proper 7
  {
    date_reference: "proper_7",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 21:8-21",
    psalm: "Psalm 86:1-10, 16-17",
    second_reading: "Romans 6:1b-11",
    gospel: "Matthew 10:24-39"
  },
  {
    date_reference: "proper_7",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 17:(1a, 4-11, 19-23), 32-49",
    psalm: "Psalm 9:9-20 or Psalm 133",
    second_reading: "2 Corinthians 6:1-13",
    gospel: "Mark 4:35-41"
  },
  {
    date_reference: "proper_7",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Kings 19:1-4, (5-7), 8-15a",
    psalm: "Psalm 42 and 43",
    second_reading: "Galatians 3:23-29",
    gospel: "Luke 8:26-39"
  },

  # Proper 8
  {
    date_reference: "proper_8",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 22:1-14",
    psalm: "Psalm 13",
    second_reading: "Romans 6:12-23",
    gospel: "Matthew 10:40-42"
  },
  {
    date_reference: "proper_8",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 1:1, 17-27",
    psalm: "Psalm 130",
    second_reading: "2 Corinthians 8:7-15",
    gospel: "Mark 5:21-43"
  },
  {
    date_reference: "proper_8",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Kings 2:1-2, 6-14",
    psalm: "Psalm 77:1-2, 11-20",
    second_reading: "Galatians 5:1, 13-25",
    gospel: "Luke 9:51-62"
  },

  # Proper 9
  {
    date_reference: "proper_9",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 24:34-38, 42-49, 58-67",
    psalm: "Psalm 45:10-17 or Song of Solomon 2:8-13",
    second_reading: "Romans 7:15-25a",
    gospel: "Matthew 11:16-19, 25-30"
  },
  {
    date_reference: "proper_9",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 5:1-5, 9-10",
    psalm: "Psalm 48",
    second_reading: "2 Corinthians 12:2-10",
    gospel: "Mark 6:1-13"
  },
  {
    date_reference: "proper_9",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Kings 5:1-14",
    psalm: "Psalm 30",
    second_reading: "Galatians 6:(1-6), 7-16",
    gospel: "Luke 10:1-11, 16-20"
  },

  # Proper 11
  {
    date_reference: "proper_11",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 28:10-19a",
    psalm: "Psalm 139:1-12, 23-24",
    second_reading: "Romans 8:12-25",
    gospel: "Matthew 13:24-30, 36-43"
  },
  {
    date_reference: "proper_11",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 7:1-14a",
    psalm: "Psalm 89:20-37",
    second_reading: "Ephesians 2:11-22",
    gospel: "Mark 6:30-34, 53-56"
  },
  {
    date_reference: "proper_11",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 18:1-10a",
    psalm: "Psalm 15",
    second_reading: "Colossians 1:15-28",
    gospel: "Luke 10:38-42"
  },

  # Proper 12
  {
    date_reference: "proper_12",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 29:15-28",
    psalm: "Psalm 105:1-11, 45b or Psalm 128",
    second_reading: "Romans 8:26-39",
    gospel: "Matthew 13:31-33, 44-52"
  },
  {
    date_reference: "proper_12",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 11:1-15",
    psalm: "Psalm 14",
    second_reading: "Ephesians 3:14-21",
    gospel: "John 6:1-21"
  },
  {
    date_reference: "proper_12",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 18:20-32",
    psalm: "Psalm 138",
    second_reading: "Colossians 2:6-15, (16-19)",
    gospel: "Luke 11:1-13"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
additional_readings.each do |reading|
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type]
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 10 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} leituras complementares criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
