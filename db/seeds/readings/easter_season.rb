# ================================================================================
# LEITURAS DO TEMPO PASCAL
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - 2º ao 7º Domingo da Páscoa (Ciclos A, B, C)
# - Ascensão do Senhor (Ciclos A, B, C)
#
# Nota: O Domingo de Páscoa e a Semana de Páscoa estão em holy_week_easter_readings.rb
#       Pentecostes está em pentecost_readings.rb
#
# ================================================================================

puts "📖 Carregando leituras do Tempo Pascal..."

easter_season_readings = [
  # ============================================================================
  # DOMINGOS DO TEMPO PASCAL
  # ============================================================================

  # ----------------------------------------------------------------------------
  # 2º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 2:14a, 22-32",
    psalm: "Psalm 16",
    second_reading: "1 Peter 1:3-9",
    gospel: "John 20:19-31"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 4:32-35",
    psalm: "Psalm 133",
    second_reading: "1 John 1:1-2:2",
    gospel: "John 20:19-31"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 5:27-32",
    psalm: "Psalm 118:14-29 or Psalm 150",
    second_reading: "Revelation 1:4-8",
    gospel: "John 20:19-31"
  },

  # ----------------------------------------------------------------------------
  # 3º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 2:14a, 36-41",
    psalm: "Psalm 116:1-4, 12-19",
    second_reading: "1 Peter 1:17-23",
    gospel: "Luke 24:13-35"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 3:12-19",
    psalm: "Psalm 4",
    second_reading: "1 John 3:1-7",
    gospel: "Luke 24:36b-48"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 9:1-6, (7-20)",
    psalm: "Psalm 30",
    second_reading: "Revelation 5:11-14",
    gospel: "John 21:1-19"
  },

  # ----------------------------------------------------------------------------
  # 4º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
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

  # ----------------------------------------------------------------------------
  # 5º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
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

  # ----------------------------------------------------------------------------
  # 6º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
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

  # ============================================================================
  # ASCENSÃO DO SENHOR
  # (40 dias após a Páscoa, geralmente quinta-feira ou transferido para domingo)
  # ============================================================================
  {
    date_reference: "ascension",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 1:1-11",
    psalm: "Psalm 47 or Psalm 93",
    second_reading: "Ephesians 1:15-23",
    gospel: "Luke 24:44-53"
  },
  {
    date_reference: "ascension",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 1:1-11",
    psalm: "Psalm 47 or Psalm 93",
    second_reading: "Ephesians 1:15-23",
    gospel: "Luke 24:44-53"
  },
  {
    date_reference: "ascension",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 1:1-11",
    psalm: "Psalm 47 or Psalm 93",
    second_reading: "Ephesians 1:15-23",
    gospel: "Luke 24:44-53"
  },

  # ----------------------------------------------------------------------------
  # 7º DOMINGO DA PÁSCOA
  # (entre Ascensão e Pentecostes)
  # ----------------------------------------------------------------------------
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 1:6-14",
    psalm: "Psalm 68:1-10, 32-35",
    second_reading: "1 Peter 4:12-14; 5:6-11",
    gospel: "John 17:1-11"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 1:15-17, 21-26",
    psalm: "Psalm 1",
    second_reading: "1 John 5:9-13",
    gospel: "John 17:6-19"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 16:16-34",
    psalm: "Psalm 97",
    second_reading: "Revelation 22:12-14, 16-17, 20-21",
    gospel: "John 17:20-26"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

easter_season_readings.each do |reading|
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

puts "\n✅ #{count} leituras do Tempo Pascal criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
