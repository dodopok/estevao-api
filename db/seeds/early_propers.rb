# Propers Iniciais do Tempo Comum (1-3)
# Estes Propers são usados entre Epifania e Quaresma
# Nem sempre são todos usados, dependendo da data da Páscoa

puts "📖 Carregando Propers iniciais (1-3)..."

early_propers = [
  # Proper 1
  {
    date_reference: "proper_1",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 58:1-9a, (9b-12)",
    psalm: "Psalm 112:1-9, (10)",
    second_reading: "1 Corinthians 2:1-12, (13-16)",
    gospel: "Matthew 5:13-20"
  },
  {
    date_reference: "proper_1",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 40:21-31",
    psalm: "Psalm 147:1-11, 20c",
    second_reading: "1 Corinthians 9:16-23",
    gospel: "Mark 1:29-39"
  },
  {
    date_reference: "proper_1",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 17:5-10",
    psalm: "Psalm 1",
    second_reading: "1 Corinthians 15:12-20",
    gospel: "Luke 6:17-26"
  },

  # Proper 2
  {
    date_reference: "proper_2",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronomy 30:15-20",
    psalm: "Psalm 119:1-8",
    second_reading: "1 Corinthians 3:1-9",
    gospel: "Matthew 5:21-37"
  },
  {
    date_reference: "proper_2",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Kings 5:1-14",
    psalm: "Psalm 30",
    second_reading: "1 Corinthians 9:24-27",
    gospel: "Mark 1:40-45"
  },
  {
    date_reference: "proper_2",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 45:3-11, 15",
    psalm: "Psalm 37:1-11, 39-40",
    second_reading: "1 Corinthians 15:35-38, 42-50",
    gospel: "Luke 6:27-38"
  },

  # Proper 3
  {
    date_reference: "proper_3",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Leviticus 19:1-2, 9-18",
    psalm: "Psalm 119:33-40",
    second_reading: "1 Corinthians 3:10-11, 16-23",
    gospel: "Matthew 5:38-48"
  },
  {
    date_reference: "proper_3",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Hosea 2:14-20",
    psalm: "Psalm 103:1-13, 22",
    second_reading: "2 Corinthians 3:1-6",
    gospel: "Mark 2:13-22"
  },
  {
    date_reference: "proper_3",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Sirach 27:4-7 or Isaiah 55:10-13",
    psalm: "Psalm 92:1-4, 12-15",
    second_reading: "1 Corinthians 15:51-58",
    gospel: "Luke 6:39-49"
  }
]

# Criar leituras
count = 0
early_propers.each do |reading|
  LectionaryReading.create!(reading)
  count += 1
  print "." if count % 3 == 0
end

puts "\n✅ #{count} Propers iniciais criados (1-3)!"
