# ================================================================================
# Advento, Natal e Epifania - Diárias - LOC REB
# ================================================================================

Rails.logger.info "📖 Carregando leituras - Advento, Natal e Epifania - Diárias (LOC REB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_reb')

readings = [
  {
    first_reading: "Isaías 11.1-10",
    gospel: "Lucas 10.21-24",
    psalm: "Salmos 72.1-4, 18-19",
    service_type: "daily_office",
    week_reference: "1st_week_of_advent",
    weekday: "tuesday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 25.6-10a",
    gospel: "Mateus 15.29-37",
    psalm: "Salmos 23",
    service_type: "daily_office",
    week_reference: "1st_week_of_advent",
    weekday: "wednesday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 26.1-6",
    gospel: "Mateus 7.21, 24-27",
    psalm: "Salmos 118.18-27a",
    service_type: "daily_office",
    week_reference: "1st_week_of_advent",
    weekday: "thursday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 29.17-24",
    gospel: "Mateus 9.27-31",
    psalm: "Salmos 27.1-4b, 13-14",
    service_type: "daily_office",
    week_reference: "1st_week_of_advent",
    weekday: "friday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 30.19-21, 23-26",
    gospel: "Mateus 9.35–10.1, 6-8",
    psalm: "Salmos 146.5-9",
    service_type: "daily_office",
    week_reference: "1st_week_of_advent",
    weekday: "saturday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 35",
    gospel: "Lucas 5.17-26",
    psalm: "Salmos 85.7-13",
    service_type: "daily_office",
    week_reference: "2nd_week_of_advent",
    weekday: "monday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 40.1-11",
    gospel: "Mateus 18.12-14",
    psalm: "Salmos 96.1, 10-13",
    service_type: "daily_office",
    week_reference: "2nd_week_of_advent",
    weekday: "tuesday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 40.25-31",
    gospel: "Mateus 11.28-30",
    psalm: "Salmos 103.8-13",
    service_type: "daily_office",
    week_reference: "2nd_week_of_advent",
    weekday: "wednesday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 41.13-20",
    gospel: "Mateus 11.11-15",
    psalm: "Salmos 145.1, 8-13",
    service_type: "daily_office",
    week_reference: "2nd_week_of_advent",
    weekday: "thursday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 48.17-19",
    gospel: "Mateus 11.16-19",
    psalm: "Salmos 1",
    service_type: "daily_office",
    week_reference: "2nd_week_of_advent",
    weekday: "friday",
    year_type: "odd",
  },
  {
    first_reading: "Sirácida 48.1-4, 9-11 ou 2 Reis 2.9-12",
    gospel: "Mateus 17.10-13",
    psalm: "Salmos 80.1-3, 17-18",
    service_type: "daily_office",
    week_reference: "2nd_week_of_advent",
    weekday: "saturday",
    year_type: "odd",
  },
  {
    first_reading: "Números 24.2-7, 15-17",
    gospel: "Mateus 21.23-27",
    psalm: "Salmos 25.4-9",
    service_type: "daily_office",
    week_reference: "3rd_week_of_advent",
    weekday: "monday",
    year_type: "odd",
  },
  {
    first_reading: "Sofonias 3.1-2, 9-13",
    gospel: "Mateus 21.28-32",
    psalm: "Salmos 34.1-6, 21-22",
    service_type: "daily_office",
    week_reference: "3rd_week_of_advent",
    weekday: "tuesday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 45.6b-8, 18, 21b-25",
    gospel: "Lucas 7.18b-23",
    psalm: "Salmos 85.7-13",
    service_type: "daily_office",
    week_reference: "3rd_week_of_advent",
    weekday: "wednesday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 54.1-10",
    gospel: "Lucas 7.24-30",
    psalm: "Salmos 30.1-5, 11-2",
    service_type: "daily_office",
    week_reference: "3rd_week_of_advent",
    weekday: "thursday",
    year_type: "odd",
  },
  {
    first_reading: "Isaías 56.1-3a, 6-8",
    gospel: "João 5.33-36",
    psalm: "Salmos 67",
    service_type: "daily_office",
    week_reference: "3rd_week_of_advent",
    weekday: "friday",
    year_type: "odd",
  },
]

LectionaryReading.create!(
  readings.map { |r| r.merge(prayer_book_id: prayer_book.id) }
)

Rails.logger.info "✓ Advento, Natal e Epifania - Diárias: #{readings.size} leituras carregadas"
