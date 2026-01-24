# ================================================================================
# LEITURAS - Páscoa e Pentecostes - LOC REB
# ================================================================================

Rails.logger.info "📖 Carregando leituras - Páscoa e Pentecostes (LOC REB)..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_reb')

readings = [
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 2.42-47",
    psalm: "Salmos 118.1-2, 14-29",
    second_reading: "1 Pedro 1.3-9",
    gospel: "João 20.19-31",
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 4.32-35",
    psalm: "Salmos 118.1-2, 14-29",
    second_reading: "1 João 5.1-6",
    gospel: "João 20.19-31 ou Marcos 16.12-18",
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 5.12-16",
    psalm: "Salmos 118.1-2, 14-29",
    second_reading: "Apocalipse 1.4-19",
    gospel: "João 20.19-31",
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 2.14a,22-33",
    psalm: "Salmos 16.1-11",
    second_reading: "1 Pedro 1.17-23",
    gospel: "Lucas 24.13-35",
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 3.12-19",
    psalm: "Salmos 4",
    second_reading: "1 João 2.1-5",
    gospel: "Lucas 24.35-48",
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 5. 27b-32.40b-41",
    psalm: "Salmos 30",
    second_reading: "Apocalipse 5.11-14",
    gospel: "João 21.1-19",
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 2.14a,36-41",
    psalm: "Salmos 23",
    second_reading: "1 Pedro 2.19-25",
    gospel: "João 10.1-10",
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 4.5-12",
    psalm: "Salmos 23",
    second_reading: "1 João 3.1-2",
    gospel: "João 10.11-18",
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 12.14,43-52",
    psalm: "Salmos 23",
    second_reading: "Apocalipse 7.9-17",
    gospel: "João 10.22-30",
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 6.1-7",
    psalm: "Salmos 31.1-5, 15-16",
    second_reading: "1 Pedro 2.2-10",
    gospel: "João 14.1-14",
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 9.26-31",
    psalm: "Salmos 22.25-31",
    second_reading: "1 João 3.18-24",
    gospel: "João 15.1-8",
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 14., 21b-27",
    psalm: "Salmos 145.1-13",
    second_reading: "Apocalipse 21.1-6",
    gospel: "João 13.31-35",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 8.5-8.14-17",
    psalm: "Salmos 66.8-20",
    second_reading: "1 Pedro 3.13-22",
    gospel: "João 14.15-21",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 10. 25-26.34-35.44-48",
    psalm: "Salmos 98",
    second_reading: "1 João 4.7-10",
    gospel: "João 15.9-17",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 15.1-2.22-29",
    psalm: "Salmos 67",
    second_reading: "Apocalipse 21.10–22.5",
    gospel: "João 14.23-29",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 1.1-11",
    psalm: "Salmos 47",
    second_reading: "Efésios 1.15-23",
    gospel: "Mateus 28.16-20",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 1.1-11",
    psalm: "Salmos 113",
    second_reading: "Efésios 1.15-23 ou Efésios 4.1-13",
    gospel: "Marcos 16.15-20",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 1.1-11",
    psalm: "Salmos 93",
    second_reading: "Efésios 1.15-23 ou Hebreus 9.24-28",
    gospel: "Lucas 24.46-53",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 1.6-14",
    psalm: "Salmos 68.1-10, 32-35",
    second_reading: "1 Pedro 4.12-14",
    gospel: "João 17.1-11",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 1.15-17, 21-26",
    psalm: "Salmos 103",
    second_reading: "1 João 5.9-13",
    gospel: "João 17.1a, 6-19",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 16.16-34",
    psalm: "Salmos 97",
    second_reading: "Apocalipse 22.12-21",
    gospel: "João 17.1a, 20-26",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    first_reading: "Atos 2.1-21",
    psalm: "Salmos 104.24-34, 35b",
    second_reading: "1 Coríntios 12.3b-13 ou Gênesis 11.1-9",
    gospel: "João 20.19-23",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    first_reading: "Atos 2.1-21",
    psalm: "Salmos 104.24-34, 35b",
    second_reading: "1 Coríntios 12.3b-13 ou Gálatas 5.16-25",
    gospel: "16.12-15",
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    first_reading: "Atos 2.1-21",
    psalm: "Salmos 104.24-34, 35b",
    second_reading: "1 Coríntios 12.3b-13 ou Romanos 8.8-17",
    gospel: "João 20.19-23 ou João 14.8-17",
  },
]

# Create the readings
LectionaryReading.create!(
  readings.map { |r| r.merge(prayer_book_id: prayer_book.id) }
)

Rails.logger.info "✓ {season_name}: #{readings.size} leituras carregadas"
