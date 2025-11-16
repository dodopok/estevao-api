# Leituras da Semana Santa
# Completa as leituras dos dias da Semana Santa que não eram domingos

puts "📖 Carregando leituras da Semana Santa..."

holy_week_readings = [
  # Segunda-feira da Semana Santa
  {
    date_reference: "holy_monday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 42:1-9",
    psalm: "Psalm 36:5-11",
    second_reading: "Hebrews 9:11-15",
    gospel: "John 12:1-11"
  },

  # Terça-feira da Semana Santa
  {
    date_reference: "holy_tuesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 49:1-7",
    psalm: "Psalm 71:1-14",
    second_reading: "1 Corinthians 1:18-31",
    gospel: "John 12:20-36"
  },

  # Quarta-feira da Semana Santa
  {
    date_reference: "holy_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 70",
    second_reading: "Hebrews 12:1-3",
    gospel: "John 13:21-32"
  },

  # Sábado de Aleluia (Vigília Pascal) - Leituras principais
  {
    date_reference: "holy_saturday_vigil",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Genesis 1:1-2:4a (Creation)",
    psalm: "Psalm 136:1-9, 23-26",
    second_reading: "Genesis 7:1-5, 11-18; 8:6-18; 9:8-13 (Flood)",
    gospel: "Romans 6:3-11"
  },
  {
    date_reference: "holy_saturday_vigil_2",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Genesis 22:1-18 (Abraham and Isaac)",
    psalm: "Psalm 16",
    second_reading: "Exodus 14:10-31; 15:20-21 (Red Sea)",
    gospel: "Matthew 28:1-10"
  },
  {
    date_reference: "holy_saturday_vigil_3",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Isaiah 55:1-11 (Salvation offered)",
    psalm: "Isaiah 12:2-6",
    second_reading: "Ezekiel 36:24-28 (New heart)",
    gospel: "Mark 16:1-8"
  },
  {
    date_reference: "holy_saturday_vigil_4",
    cycle: "all",
    service_type: "vigil",
    first_reading: "Ezekiel 37:1-14 (Valley of dry bones)",
    psalm: "Psalm 143",
    second_reading: "Romans 6:3-11",
    gospel: "Luke 24:1-12"
  },

  # Segunda-feira da Páscoa
  {
    date_reference: "easter_monday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 2:14, 22-32",
    psalm: "Psalm 16:1-2, 5-11",
    second_reading: "Matthew 28:8-15",
    gospel: "Matthew 28:8-15"
  },

  # Terça-feira da Páscoa
  {
    date_reference: "easter_tuesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 2:36-41",
    psalm: "Psalm 33:4-5, 18-20, 22",
    second_reading: "John 20:11-18",
    gospel: "John 20:11-18"
  },

  # Quarta-feira da Páscoa
  {
    date_reference: "easter_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 3:1-10",
    psalm: "Psalm 105:1-9",
    second_reading: "Luke 24:13-35",
    gospel: "Luke 24:13-35"
  },

  # Quinta-feira da Páscoa
  {
    date_reference: "easter_thursday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 3:11-26",
    psalm: "Psalm 8:2, 5-9",
    second_reading: "Luke 24:35-48",
    gospel: "Luke 24:35-48"
  },

  # Sexta-feira da Páscoa
  {
    date_reference: "easter_friday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 4:1-12",
    psalm: "Psalm 118:1-2, 4, 22-27",
    second_reading: "John 21:1-14",
    gospel: "John 21:1-14"
  },

  # Sábado da Páscoa
  {
    date_reference: "easter_saturday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 4:13-21",
    psalm: "Psalm 118:1, 14-21",
    second_reading: "Mark 16:9-15",
    gospel: "Mark 16:9-15"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
holy_week_readings.each do |reading|
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

puts "\n✅ #{count} leituras da Semana Santa e Páscoa criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
