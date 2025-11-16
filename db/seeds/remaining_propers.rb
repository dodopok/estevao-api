# Propers Restantes do Tempo Comum (13-27)
# Completa a cobertura total dos domingos do Tempo Comum

puts "📖 Carregando Propers restantes (13-27)..."

remaining_propers = [
  # Proper 13
  {
    date_reference: "proper_13",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 32:22-31",
    psalm: "Psalm 17:1-7, 15",
    second_reading: "Romans 9:1-5",
    gospel: "Matthew 14:13-21"
  },
  {
    date_reference: "proper_13",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 11:26-12:13a",
    psalm: "Psalm 51:1-12",
    second_reading: "Ephesians 4:1-16",
    gospel: "John 6:24-35"
  },
  {
    date_reference: "proper_13",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Ecclesiastes 1:2, 12-14; 2:18-23",
    psalm: "Psalm 49:1-12",
    second_reading: "Colossians 3:1-11",
    gospel: "Luke 12:13-21"
  },

  # Proper 14
  {
    date_reference: "proper_14",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 37:1-4, 12-28",
    psalm: "Psalm 105:1-6, 16-22, 45b",
    second_reading: "Romans 10:5-15",
    gospel: "Matthew 14:22-33"
  },
  {
    date_reference: "proper_14",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 18:5-9, 15, 31-33",
    psalm: "Psalm 130",
    second_reading: "Ephesians 4:25-5:2",
    gospel: "John 6:35, 41-51"
  },
  {
    date_reference: "proper_14",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 15:1-6",
    psalm: "Psalm 33:12-22",
    second_reading: "Hebrews 11:1-3, 8-16",
    gospel: "Luke 12:32-40"
  },

  # Proper 16
  {
    date_reference: "proper_16",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 1:8-2:10",
    psalm: "Psalm 124",
    second_reading: "Romans 12:1-8",
    gospel: "Matthew 16:13-20"
  },
  {
    date_reference: "proper_16",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Joshua 24:1-2a, 14-18",
    psalm: "Psalm 34:15-22",
    second_reading: "Ephesians 6:10-20",
    gospel: "John 6:56-69"
  },
  {
    date_reference: "proper_16",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 1:4-10",
    psalm: "Psalm 71:1-6",
    second_reading: "Hebrews 12:18-29",
    gospel: "Luke 13:10-17"
  },

  # Proper 17
  {
    date_reference: "proper_17",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 3:1-15",
    psalm: "Psalm 105:1-6, 23-26, 45c",
    second_reading: "Romans 12:9-21",
    gospel: "Matthew 16:21-28"
  },
  {
    date_reference: "proper_17",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronomy 4:1-2, 6-9",
    psalm: "Psalm 15",
    second_reading: "James 1:17-27",
    gospel: "Mark 7:1-8, 14-15, 21-23"
  },
  {
    date_reference: "proper_17",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 2:4-13",
    psalm: "Psalm 81:1, 10-16",
    second_reading: "Hebrews 13:1-8, 15-16",
    gospel: "Luke 14:1, 7-14"
  },

  # Proper 18
  {
    date_reference: "proper_18",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 12:1-14",
    psalm: "Psalm 149",
    second_reading: "Romans 13:8-14",
    gospel: "Matthew 18:15-20"
  },
  {
    date_reference: "proper_18",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 35:4-7a",
    psalm: "Psalm 146",
    second_reading: "James 2:1-10, (11-13), 14-17",
    gospel: "Mark 7:24-37"
  },
  {
    date_reference: "proper_18",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 18:1-11",
    psalm: "Psalm 139:1-6, 13-18",
    second_reading: "Philemon 1-21",
    gospel: "Luke 14:25-33"
  },

  # Proper 19
  {
    date_reference: "proper_19",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 14:19-31",
    psalm: "Psalm 114 or Exodus 15:1b-11, 20-21",
    second_reading: "Romans 14:1-12",
    gospel: "Matthew 18:21-35"
  },
  {
    date_reference: "proper_19",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 116:1-9",
    second_reading: "James 3:1-12",
    gospel: "Mark 8:27-38"
  },
  {
    date_reference: "proper_19",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 4:11-12, 22-28",
    psalm: "Psalm 14",
    second_reading: "1 Timothy 1:12-17",
    gospel: "Luke 15:1-10"
  },

  # Proper 21
  {
    date_reference: "proper_21",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 17:1-7",
    psalm: "Psalm 78:1-4, 12-16",
    second_reading: "Philippians 2:1-13",
    gospel: "Matthew 21:23-32"
  },
  {
    date_reference: "proper_21",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Numbers 11:4-6, 10-16, 24-29",
    psalm: "Psalm 19:7-14",
    second_reading: "James 5:13-20",
    gospel: "Mark 9:38-50"
  },
  {
    date_reference: "proper_21",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 32:1-3a, 6-15",
    psalm: "Psalm 91:1-6, 14-16",
    second_reading: "1 Timothy 6:6-19",
    gospel: "Luke 16:19-31"
  },

  # Proper 22
  {
    date_reference: "proper_22",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 20:1-4, 7-9, 12-20",
    psalm: "Psalm 19",
    second_reading: "Philippians 3:4b-14",
    gospel: "Matthew 21:33-46"
  },
  {
    date_reference: "proper_22",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 2:18-24",
    psalm: "Psalm 8",
    second_reading: "Hebrews 1:1-4; 2:5-12",
    gospel: "Mark 10:2-16"
  },
  {
    date_reference: "proper_22",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Lamentations 1:1-6",
    psalm: "Lamentations 3:19-26 or Psalm 137",
    second_reading: "2 Timothy 1:1-14",
    gospel: "Luke 17:5-10"
  },

  # Proper 23
  {
    date_reference: "proper_23",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 32:1-14",
    psalm: "Psalm 106:1-6, 19-23",
    second_reading: "Philippians 4:1-9",
    gospel: "Matthew 22:1-14"
  },
  {
    date_reference: "proper_23",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amos 5:6-7, 10-15",
    psalm: "Psalm 90:12-17",
    second_reading: "Hebrews 4:12-16",
    gospel: "Mark 10:17-31"
  },
  {
    date_reference: "proper_23",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 29:1, 4-7",
    psalm: "Psalm 66:1-12",
    second_reading: "2 Timothy 2:8-15",
    gospel: "Luke 17:11-19"
  },

  # Proper 24
  {
    date_reference: "proper_24",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 33:12-23",
    psalm: "Psalm 99",
    second_reading: "1 Thessalonians 1:1-10",
    gospel: "Matthew 22:15-22"
  },
  {
    date_reference: "proper_24",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 53:4-12",
    psalm: "Psalm 91:9-16",
    second_reading: "Hebrews 5:1-10",
    gospel: "Mark 10:35-45"
  },
  {
    date_reference: "proper_24",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 31:27-34",
    psalm: "Psalm 119:97-104",
    second_reading: "2 Timothy 3:14-4:5",
    gospel: "Luke 18:1-8"
  },

  # Proper 26
  {
    date_reference: "proper_26",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Joshua 3:7-17",
    psalm: "Psalm 107:1-7, 33-37",
    second_reading: "1 Thessalonians 2:9-13",
    gospel: "Matthew 23:1-12"
  },
  {
    date_reference: "proper_26",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ruth 1:1-18",
    psalm: "Psalm 146",
    second_reading: "Hebrews 9:11-14",
    gospel: "Mark 12:28-34"
  },
  {
    date_reference: "proper_26",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Habakkuk 1:1-4; 2:1-4",
    psalm: "Psalm 119:137-144",
    second_reading: "2 Thessalonians 1:1-4, 11-12",
    gospel: "Luke 19:1-10"
  },

  # Proper 27
  {
    date_reference: "proper_27",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Joshua 24:1-3a, 14-25",
    psalm: "Psalm 78:1-7",
    second_reading: "1 Thessalonians 4:13-18",
    gospel: "Matthew 25:1-13"
  },
  {
    date_reference: "proper_27",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ruth 3:1-5; 4:13-17",
    psalm: "Psalm 127",
    second_reading: "Hebrews 9:24-28",
    gospel: "Mark 12:38-44"
  },
  {
    date_reference: "proper_27",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Haggai 1:15b-2:9",
    psalm: "Psalm 145:1-5, 17-21 or Psalm 98",
    second_reading: "2 Thessalonians 2:1-5, 13-17",
    gospel: "Luke 20:27-38"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
remaining_propers.each do |reading|
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

puts "\n✅ #{count} Propers restantes criados (13-27)!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
