# ================================================================================
# LEITURAS - Quaresma e Semana Santa - LOC REB
# ================================================================================

Rails.logger.info "📖 Carregando leituras - Quaresma e Semana Santa (LOC REB)..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_reb')

readings = [
  {
    date_reference: "1st_sunday_of_lent",
    cycle: "A",
    first_reading: "Gênesis 2.15-17",
    second_reading: "3.1-7",
    psalm: "Salmos 32",
    gospel: "Mateus 4.1-11",
  },
  {
    date_reference: "1st_sunday_of_lent",
    cycle: "B",
    first_reading: "Gênesis 9.8-17",
    psalm: "Salmos 25.1-10",
    second_reading: "1 Pedro 3.18-22",
    gospel: "Marcos 1.9-15",
  },
  {
    date_reference: "1st_sunday_of_lent",
    cycle: "C",
    first_reading: "Deuteronômio 26.1-11",
    psalm: "Salmos 91.1-2, 9-16",
    second_reading: "Romanos 10.8b-13",
    gospel: "Lucas 4.1-13",
  },
  {
    date_reference: "2nd_sunday_of_lent",
    cycle: "A",
    first_reading: "Gênesis 12.1-4a",
    psalm: "Salmos 121",
    second_reading: "Romanos 4.1-5, 13-17",
    gospel: "João 3.1-17",
  },
  {
    date_reference: "2nd_sunday_of_lent",
    cycle: "B",
    first_reading: "Gênesis 17.1-16",
    psalm: "Salmos 22.23-31",
    second_reading: "Romanos 4.13-25",
    gospel: "Marcos 8.31-38",
  },
  {
    date_reference: "2nd_sunday_of_lent",
    cycle: "C",
    first_reading: "Gênesis 15.1-18",
    psalm: "Salmos 27",
    second_reading: "Filipenses 3.17–4.1",
    gospel: "Lucas 13.31-35",
  },
  {
    date_reference: "3rd_sunday_of_lent",
    cycle: "A",
    first_reading: "Êxodo 17.1-7",
    psalm: "Salmos 95",
    second_reading: "Romanos 5.1-11",
    gospel: "João 4.5-42",
  },
  {
    date_reference: "3rd_sunday_of_lent",
    cycle: "B",
    first_reading: "Êxodo 20.1-17",
    psalm: "Salmos 19",
    second_reading: "1 Coríntios 1.18-25",
    gospel: "João 2.13-22",
  },
  {
    date_reference: "3rd_sunday_of_lent",
    cycle: "C",
    first_reading: "Isaías 55.1-9",
    psalm: "Salmos 63.1-8",
    second_reading: "1 Coríntios 10.1-13",
    gospel: "Lucas 13.1-9",
  },
  {
    date_reference: "3rd_sunday_of_lent",
    cycle: "A",
    first_reading: "1 Samuel 16.1-13",
    psalm: "Salmos 23",
    second_reading: "Efésios 5.8-14",
    gospel: "João 9.1-41",
  },
  {
    date_reference: "3rd_sunday_of_lent",
    cycle: "B",
    first_reading: "Números 21.4-9",
    psalm: "Salmos 107.1-3, 17-22",
    second_reading: "Efésios 2.1-10",
    gospel: "João 3.14-21",
  },
  {
    date_reference: "3rd_sunday_of_lent",
    cycle: "C",
    first_reading: "Josué 5.9-12",
    psalm: "Salmos 32",
    second_reading: "2 Coríntios 5.16-21",
    gospel: "Lucas 15.1-3, 11b-32",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "A",
    first_reading: "Ezequiel 37.1-14",
    psalm: "Salmos 130",
    second_reading: "Romanos 8.6-11",
    gospel: "João 11.1-45",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "B",
    first_reading: "Jeremias 31.31-34",
    psalm: "Salmos 51.1-12",
    second_reading: "Hebreus 5.5-10",
    gospel: "João 12.20-33",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "C",
    first_reading: "Isaías 43.16-21",
    psalm: "Salmos 126",
    second_reading: "Filipenses 3.4b-14",
    gospel: "João 12.1-8",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "A",
    first_reading: "Mateus 21.1-11",
    psalm: "Salmos 118.1-2, 19-29",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "B",
    first_reading: "Marcos 11.1-11",
    psalm: "Salmos 118.1-2, 19-29",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "C",
    first_reading: "Lucas 19.28-40 ou João 12.12-16",
    psalm: "Salmos 118.1-2, 19-29",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "A",
    first_reading: "Isaías 50.4-9a",
    psalm: "Salmos 31.9-16",
    second_reading: "Filipenses 2.5-11",
    gospel: "Mateus 26.14-27.66 ou Mateus 27.11-26",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "B",
    first_reading: "Isaías 42.1-9",
    psalm: "Salmos 36.5-11",
    second_reading: "Hebreus 9.11-15",
    gospel: "Marcos 14.1–15.47 ou Marcos 14.1-9 ou Marcos 14.53-65 ou Marcos 15.1-9",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "C",
    first_reading: "Isaías 49.1-7",
    psalm: "Salmos 71.1-14",
    second_reading: "1 Coríntios 1.18-31",
    gospel: "Lucas 22.14–23.56 ou Lucas 22.54-62",
  },
  {
    date_reference: "5th_sunday_of_lent",
    cycle: "A",
    first_reading: "Mateus 28.1-10",
    second_reading: "Ano B: Marcos 16.1-8",
    gospel: "Ano C: Lucas 24.1-12",
  },
]

# Create the readings
LectionaryReading.create!(
  readings.map { |r| r.merge(prayer_book_id: prayer_book.id) }
)

Rails.logger.info "✓ {season_name}: #{readings.size} leituras carregadas"
