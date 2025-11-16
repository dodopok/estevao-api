# Domingos após Epifania
# Estes domingos preenchem o período entre Epifania (6 jan) e Quaresma
# O número de domingos varia conforme a data da Páscoa

puts "📖 Carregando domingos após Epifania..."

epiphany_sundays = [
  # 2º Domingo após Epifania
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 49:1-7",
    psalm: "Psalm 40:1-11",
    second_reading: "1 Corinthians 1:1-9",
    gospel: "John 1:29-42"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 3:1-10, (11-20)",
    psalm: "Psalm 139:1-6, 13-18",
    second_reading: "1 Corinthians 6:12-20",
    gospel: "John 1:43-51"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaiah 62:1-5",
    psalm: "Psalm 36:5-10",
    second_reading: "1 Corinthians 12:1-11",
    gospel: "John 2:1-11"
  },

  # 3º Domingo após Epifania
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 9:1-4",
    psalm: "Psalm 27:1, 4-9",
    second_reading: "1 Corinthians 1:10-18",
    gospel: "Matthew 4:12-23"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jonah 3:1-5, 10",
    psalm: "Psalm 62:5-12",
    second_reading: "1 Corinthians 7:29-31",
    gospel: "Mark 1:14-20"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Nehemiah 8:1-3, 5-6, 8-10",
    psalm: "Psalm 19",
    second_reading: "1 Corinthians 12:12-31a",
    gospel: "Luke 4:14-21"
  },

  # 4º Domingo após Epifania
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Micah 6:1-8",
    psalm: "Psalm 15",
    second_reading: "1 Corinthians 1:18-31",
    gospel: "Matthew 5:1-12"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronomy 18:15-20",
    psalm: "Psalm 111",
    second_reading: "1 Corinthians 8:1-13",
    gospel: "Mark 1:21-28"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 1:4-10",
    psalm: "Psalm 71:1-6",
    second_reading: "1 Corinthians 13:1-13",
    gospel: "Luke 4:21-30"
  },

  # 5º Domingo após Epifania
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 58:1-9a, (9b-12)",
    psalm: "Psalm 112:1-9, (10)",
    second_reading: "1 Corinthians 2:1-12, (13-16)",
    gospel: "Matthew 5:13-20"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 40:21-31",
    psalm: "Psalm 147:1-11, 20c",
    second_reading: "1 Corinthians 9:16-23",
    gospel: "Mark 1:29-39"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaiah 6:1-8, (9-13)",
    psalm: "Psalm 138",
    second_reading: "1 Corinthians 15:1-11",
    gospel: "Luke 5:1-11"
  },

  # 6º Domingo após Epifania
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronomy 30:15-20",
    psalm: "Psalm 119:1-8",
    second_reading: "1 Corinthians 3:1-9",
    gospel: "Matthew 5:21-37"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Kings 5:1-14",
    psalm: "Psalm 30",
    second_reading: "1 Corinthians 9:24-27",
    gospel: "Mark 1:40-45"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 17:5-10",
    psalm: "Psalm 1",
    second_reading: "1 Corinthians 15:12-20",
    gospel: "Luke 6:17-26"
  },

  # 7º Domingo após Epifania
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Leviticus 19:1-2, 9-18",
    psalm: "Psalm 119:33-40",
    second_reading: "1 Corinthians 3:10-11, 16-23",
    gospel: "Matthew 5:38-48"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 43:18-25",
    psalm: "Psalm 41",
    second_reading: "2 Corinthians 1:18-22",
    gospel: "Mark 2:1-12"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 45:3-11, 15",
    psalm: "Psalm 37:1-11, 39-40",
    second_reading: "1 Corinthians 15:35-38, 42-50",
    gospel: "Luke 6:27-38"
  },

  # 8º Domingo após Epifania
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 49:8-16a",
    psalm: "Psalm 131",
    second_reading: "1 Corinthians 4:1-5",
    gospel: "Matthew 6:24-34"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Hosea 2:14-20",
    psalm: "Psalm 103:1-13, 22",
    second_reading: "2 Corinthians 3:1-6",
    gospel: "Mark 2:13-22"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Sirach 27:4-7 or Isaiah 55:10-13",
    psalm: "Psalm 92:1-4, 12-15",
    second_reading: "1 Corinthians 15:51-58",
    gospel: "Luke 6:39-49"
  },

  # Último Domingo após Epifania (Transfiguração)
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 24:12-18",
    psalm: "Psalm 2 or Psalm 99",
    second_reading: "2 Peter 1:16-21",
    gospel: "Matthew 17:1-9"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Kings 2:1-12",
    psalm: "Psalm 50:1-6",
    second_reading: "2 Corinthians 4:3-6",
    gospel: "Mark 9:2-9"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Exodus 34:29-35",
    psalm: "Psalm 99",
    second_reading: "2 Corinthians 3:12-4:2",
    gospel: "Luke 9:28-36, (37-43)"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
epiphany_sundays.each do |reading|
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type]
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 9 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} domingos após Epifania criados!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
