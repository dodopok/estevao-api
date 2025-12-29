# ================================================================================
# LEITURAS - COMUM DOS SANTOS - LOC 1987
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Comum dos Santos (LOC 1987)..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

common_readings = [
  # De um Mártir
  {
    date_reference: "common_of_martyr_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Neemias 2:11-20",
    psalm: "126 ou 121",
    second_reading: "I Pedro 3:14-18,22",
    gospel: "Mateus 10:16-22"
  },
  {
    date_reference: "common_of_martyr_2", # "De um Mártir 11" interpreted as II
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Eclesiástico 51:1-12",
    psalm: "116 ou 116:1-8",
    second_reading: "Apocalipse 7:13-17",
    gospel: "Lucas 12:2-12"
  },
  {
    date_reference: "common_of_martyr_3",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremias 15:15-21",
    psalm: "124 ou 31:1-5",
    second_reading: "I Pedro 4:12-19",
    gospel: "Marcos 8:34-38"
  },

  # De um Missionário
  {
    date_reference: "common_of_missionary_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 52:7-10",
    psalm: "96 ou 96:1-7",
    second_reading: "Atos 1:1-9",
    gospel: "Lucas 10:1-9"
  },
  {
    date_reference: "common_of_missionary_2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaías 49:1-6",
    psalm: "98 ou 98:1-4",
    second_reading: "Atos 17:22-31",
    gospel: "Mateus 28:16-20"
  },

  # De um Pastor
  {
    date_reference: "common_of_pastor_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Ezequiel 34:11-16",
    psalm: "23",
    second_reading: "I Pedro 5:1-4",
    gospel: "João 21:15-17"
  },
  {
    date_reference: "common_of_pastor_2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 20:17-35",
    psalm: "84 ou 84:7-11",
    second_reading: "Efésios 3:14-21",
    gospel: "Mateus 24:42-47"
  },

  # De um Teólogo e Professor
  {
    date_reference: "common_of_theologian_and_teacher_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Sabedoria 7:7-14",
    psalm: "119:97-104",
    second_reading: "I Coríntios 2:6-10,13-16",
    gospel: "João 17:18-23"
  },
  {
    date_reference: "common_of_theologian_and_teacher_2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Provérbios 3:1-7",
    psalm: "119:89-96",
    second_reading: "I Coríntios 3:5-11",
    gospel: "Mateus 13:47-52"
  },

  # De um Monge
  {
    date_reference: "common_of_monastic_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Cântico dos Cânticos 8:6-7",
    psalm: "34 ou 34:1-8",
    second_reading: "Filipenses 3:7-15",
    gospel: "Lucas 12:33-37 ou Lucas 9:57-62"
  },
  {
    date_reference: "common_of_monastic_2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Atos 2:42-47a",
    psalm: "133 ou 119:161-168",
    second_reading: "II Coríntios 6:1-10",
    gospel: "Mateus 6:24-33"
  },

  # De um Santo
  {
    date_reference: "common_of_saint_1",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Miquéias 6:6-8",
    psalm: "15",
    second_reading: "Hebreus 12:1-2",
    gospel: "Mateus 25:31-40"
  },
  {
    date_reference: "common_of_saint_2",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Sabedoria 3:1-9",
    psalm: "34 ou 34:15-22",
    second_reading: "Filipenses 4:4-9",
    gospel: "Lucas 6:17-23"
  },
  {
    date_reference: "common_of_saint_3",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Eclesiástico 2:7-11",
    psalm: "1",
    second_reading: "I Coríntios 1:26-31",
    gospel: "Mateus 25:1-13"
  }
]

# Create records if not present
count = 0
skipped = 0
common_readings.each do |r|
  r[:prayer_book_id] = prayer_book.id

  existing = LectionaryReading.find_by(
    date_reference: r[:date_reference],
    cycle: r[:cycle],
    service_type: r[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Comum dos Santos (LOC 1987) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
