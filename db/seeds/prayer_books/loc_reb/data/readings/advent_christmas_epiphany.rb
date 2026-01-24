# ================================================================================
# LEITURAS - Advento, Natal e Epifania - LOC REB
# ================================================================================

Rails.logger.info "📖 Carregando leituras - Advento, Natal e Epifania (LOC REB)..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_reb')

readings = [
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 2.1-5",
    psalm: "Salmos 122",
    second_reading: "Romanos 13.11-14",
    gospel: "Mateus 24.36-44",
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "B",
    first_reading: "Isaías 64.1-9",
    psalm: "Salmos 80.1-7, 17-19",
    second_reading: "1 Coríntios 1.3-9",
    gospel: "Marcos 13.24-37",
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "C",
    first_reading: "Jeremias 33.14-16",
    psalm: "Salmos 25.1-10",
    second_reading: "1 Tessalonicenses 3.9-13",
    gospel: "Lucas 21.25-36",
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 4.2-6",
    second_reading: "Anos B&C: Isaías 2.1-5",
    psalm: "Salmos 122",
    gospel: "Mateus 8.5-11",
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 11.1-10",
    psalm: "Salmos 72.1-7, 18-19",
    second_reading: "Romanos 15.4-13",
    gospel: "Mateus 3.1-12",
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "B",
    first_reading: "Isaías 40.1-11",
    psalm: "Salmos 85.1-2, 8-13",
    second_reading: "2 Pedro 3.8-15a",
    gospel: "Marcos 1.1-8",
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "C",
    first_reading: "Malaquias 3.1-4 ou Baruc 5.1-9",
    psalm: "Benedictus (Lucas 1.68-79)",
    second_reading: "Filipenses 1.3-11",
    gospel: "Lucas 3.1-6",
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 35.1-10",
    psalm: "Salmos 146.5-10 ou Magnificat (Lucas 1.46b-55)",
    second_reading: "Tiago 5.7-10",
    gospel: "Mateus 11.2-11",
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "B",
    first_reading: "Isaías 61.1-4, 8-11",
    psalm: "Salmos 126 ou Magnificat (Lucas 1.46b-55)",
    second_reading: "1 Tessalonicenses 5.16-24",
    gospel: "João 1.6-8, 19-28",
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "C",
    first_reading: "Sofonias 3.14-20",
    psalm: "Isaías 12.2-6 ou Magnificat (Lucas 1.46b-55)",
    second_reading: "Filipenses 4.4-7",
    gospel: "Lucas 3.7-18",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 7.10-16",
    psalm: "Salmos 80.1-7, 17-19 ou Salmos 89.1-4, 24-26",
    second_reading: "Romanos 1.1-7",
    gospel: "Mateus 1.18-25",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    first_reading: "2 Samuel 7.1-11, 16",
    psalm: "Magnificat (Lucas 1.46b-55) ou Salmos 80.1-7",
    second_reading: "Romanos 16.25-27",
    gospel: "Lucas 1.26-38",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    first_reading: "Miquéias 5.2-5a",
    psalm: "Magnificat (Lucas 1.46b-55) ou Salmos 80.1-7",
    second_reading: "Hebreus 10.5-10",
    gospel: "Lucas 1.39-45 [46-55]",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 9.2-7",
    psalm: "Salmos 96",
    second_reading: "Tito 2.11-14",
    gospel: "Lucas 2.1-14 [15-20]",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    first_reading: "Isaías 52.7-10",
    psalm: "Salmos 97",
    second_reading: "Hebreus 1.1-4 [5-12]",
    gospel: "Lucas 2.[1-7] 8-20",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    first_reading: "Isaías 62.6-12",
    psalm: "Salmos 98",
    second_reading: "Tito 3.4-7",
    gospel: "João 1.1-14",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 63.7-9 ou Sirácida 3.3-7, 14-17a",
    psalm: "Salmos 148",
    second_reading: "Hebreus 2.10-18 ou Colossenses 3.12-21",
    gospel: "Mateus 2.13-23",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    first_reading: "Isaías 61.10–62.3 ou Sirácida 3.3-7, 14-17a",
    psalm: "Salmos 148",
    second_reading: "Gálatas 4.4-7 ou Colossenses 3.12-21",
    gospel: "Lucas 2.22-40",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    first_reading: "1 Samuel 2.18-20, 26 ou Sirácida 3.3-7, 14-17a",
    psalm: "Salmos 148",
    second_reading: "Colossenses 3.12-21",
    gospel: "Lucas 2.41-52",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 60.1-6",
    psalm: "Salmos 72.[1-7] 10-14",
    second_reading: "Efésios 3.1-12 ou Efésios 3.2-3a, 5-6",
    gospel: "Mateus 2.1-12 (esta sequência de leituras pode ser usada nos anos A, B ou C)",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    first_reading: "Isaías 52.7-10",
    psalm: "Salmos 100.1-5",
    second_reading: "Colossenses 1.24-27",
    gospel: "Mateus 12.14-21",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    first_reading: "Isaías 49.1-7",
    psalm: "Salmos 44.1, 3, 4a, 6, 8",
    second_reading: "2 Coríntios 4.3-6",
    gospel: "João 1.43-51",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    first_reading: "Isaías 42.1-4, 6-7 ou Gênesis 1.1-5",
    psalm: "Salmos 29",
    second_reading: "Atos 10.34-38",
    gospel: "Mateus 3.13-17",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    first_reading: "Isaías 42.1-4, 6-7 ou Gênesis 1.1-5",
    psalm: "Salmos 29",
    second_reading: "Atos 10.34-38",
    gospel: "Marcos 1.4-11",
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    first_reading: "Isaías 42.1-4, 6-7 ou Gênesis 1.1-5",
    psalm: "Salmos 29",
    second_reading: "Atos 10.34-38",
    gospel: "Lucas 3.15-16, 21-22",
  },
]

# Create the readings
LectionaryReading.create!(
  readings.map { |r| r.merge(prayer_book_id: prayer_book.id) }
)

Rails.logger.info "✓ {season_name}: #{readings.size} leituras carregadas"
