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

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

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
    first_reading: "Atos 2:14a, 22-32",
    psalm: "Salmo 16",
    second_reading: "1 Pedro 1:3-9",
    gospel: "João 20:19-31"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 4:32-35",
    psalm: "Salmo 133",
    second_reading: "1 João 1:1-2:2",
    gospel: "João 20:19-31"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 5:27-32",
    psalm: "Salmo 118:14-29 or Salmo 150",
    second_reading: "Apocalipse 1:4-8",
    gospel: "João 20:19-31"
  },

  # ----------------------------------------------------------------------------
  # 3º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 2:14a, 36-41",
    psalm: "Salmo 116:1-4, 12-19",
    second_reading: "1 Pedro 1:17-23",
    gospel: "Lucas 24:13-35"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 3:12-19",
    psalm: "Salmo 4",
    second_reading: "1 João 3:1-7",
    gospel: "Lucas 24:36b-48"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 9:1-6, (7-20)",
    psalm: "Salmo 30",
    second_reading: "Apocalipse 5:11-14",
    gospel: "João 21:1-19"
  },

  # ----------------------------------------------------------------------------
  # 4º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 2:42-47",
    psalm: "Salmo 23",
    second_reading: "1 Pedro 2:19-25",
    gospel: "João 10:1-10"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 4:5-12",
    psalm: "Salmo 23",
    second_reading: "1 João 3:16-24",
    gospel: "João 10:11-18"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 9:36-43",
    psalm: "Salmo 23",
    second_reading: "Apocalipse 7:9-17",
    gospel: "João 10:22-30"
  },

  # ----------------------------------------------------------------------------
  # 5º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 7:55-60",
    psalm: "Salmo 31:1-5, 15-16",
    second_reading: "1 Pedro 2:2-10",
    gospel: "João 14:1-14"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 8:26-40",
    psalm: "Salmo 22:25-31",
    second_reading: "1 João 4:7-21",
    gospel: "João 15:1-8"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 11:1-18",
    psalm: "Salmo 148",
    second_reading: "Apocalipse 21:1-6",
    gospel: "João 13:31-35"
  },

  # ----------------------------------------------------------------------------
  # 6º DOMINGO DA PÁSCOA
  # ----------------------------------------------------------------------------
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 17:22-31",
    psalm: "Salmo 66:8-20",
    second_reading: "1 Pedro 3:13-22",
    gospel: "João 14:15-21"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 10:44-48",
    psalm: "Salmo 98",
    second_reading: "1 João 5:1-6",
    gospel: "João 15:9-17"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 16:9-15",
    psalm: "Salmo 67",
    second_reading: "Apocalipse 21:10, 22-22:5",
    gospel: "João 14:23-29"
  },

  # ============================================================================
  # ASCENSÃO DO SENHOR
  # (40 dias após a Páscoa, geralmente quinta-feira ou transferido para domingo)
  # ============================================================================
  {
    date_reference: "ascension",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 1:1-11",
    psalm: "Salmo 47 or Salmo 93",
    second_reading: "Efésios 1:15-23",
    gospel: "Lucas 24:44-53"
  },
  {
    date_reference: "ascension",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 1:1-11",
    psalm: "Salmo 47 or Salmo 93",
    second_reading: "Efésios 1:15-23",
    gospel: "Lucas 24:44-53"
  },
  {
    date_reference: "ascension",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 1:1-11",
    psalm: "Salmo 47 or Salmo 93",
    second_reading: "Efésios 1:15-23",
    gospel: "Lucas 24:44-53"
  },

  # ----------------------------------------------------------------------------
  # 7º DOMINGO DA PÁSCOA
  # (entre Ascensão e Pentecostes)
  # ----------------------------------------------------------------------------
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 1:6-14",
    psalm: "Salmo 68:1-10, 32-35",
    second_reading: "1 Pedro 4:12-14; 5:6-11",
    gospel: "João 17:1-11"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Atos 1:15-17, 21-26",
    psalm: "Salmo 1",
    second_reading: "1 João 5:9-13",
    gospel: "João 17:6-19"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 16:16-34",
    psalm: "Salmo 97",
    second_reading: "Apocalipse 22:12-14, 16-17, 20-21",
    gospel: "João 17:20-26"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

easter_season_readings.each do |reading|
  reading[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book.id
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
