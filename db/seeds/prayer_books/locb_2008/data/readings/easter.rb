# ================================================================================
# LEITURAS DO TEMPO PASCAL - LOCB 2008
# Cor litúrgica: Branco ou Dourado
# ================================================================================

Rails.logger.info "📖 Criando Leituras do Tempo Pascal - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

easter_readings = [
  # Evangelho da Vigília
  {
    date_reference: "easter_vigil",
    cycle: "A",
    service_type: "vigil",
    gospel: "Mt 28:1-10"
  },
  {
    date_reference: "easter_vigil",
    cycle: "B",
    service_type: "vigil",
    gospel: "Mc 16:1-8"
  },
  {
    date_reference: "easter_vigil",
    cycle: "C",
    service_type: "vigil",
    gospel: "Lc 24:1-12"
  },

  # DOMINGO DE PÁSCOA - MANHÃ
  {
    date_reference: "easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 10:34-43 ou Jr 31:1-6",
    psalm: "Sl 118:1-2, 14-24",
    second_reading: "Cl 3:1-4 ou At 10:34-43",
    gospel: "Jo 20:1-18 ou Mt 28:1-10"
  },
  {
    date_reference: "easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 10:34-43 ou Is 25:6-9",
    psalm: "Sl 118:1-2, 14-24",
    second_reading: "1 Co 15:1-11 ou At 10:34-43",
    gospel: "Jo 20:1-18 ou Mc 16:1-8"
  },
  {
    date_reference: "easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 10:34-43 ou Is 65:17-25",
    psalm: "Sl 118:1-2, 14-24",
    second_reading: "1 Co 15:19-26 ou At 10:34-43",
    gospel: "Jo 20:1-18 ou Lc 24:1-12"
  },

  # DOMINGO DE PÁSCOA - CELEBRAÇÃO VESPERTINA
  {
    date_reference: "easter_evening",
    cycle: "all",
    service_type: "evening_prayer",
    first_reading: "Is 25:6-9",
    psalm: "Sl 114",
    second_reading: "1 Co 5:6b-8",
    gospel: "Lc 24:13-49"
  },

  # 2º DOMINGO DA PÁSCOA
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 2:14a, 22-32",
    psalm: "Sl 16",
    second_reading: "1 Pe 1:3-9",
    gospel: "Jo 20:19-25"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 4:32-35",
    psalm: "Sl 133",
    second_reading: "1 Jo 1:1-2.2",
    gospel: "Mc 16:12-18"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 5:27-32",
    psalm: "Sl 118:14-29",
    second_reading: "Ap 1:4-8",
    gospel: "Jo 20:26-31"
  },

  # 3º DOMINGO DA PÁSCOA
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 2:14a, 36-41",
    psalm: "Sl 116:1-4, 12-19",
    second_reading: "1 Pe 1:17-23",
    gospel: "Lc 24:13-35"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 3:12-19",
    psalm: "Sl 4",
    second_reading: "1 Jo 3:1-7",
    gospel: "Lc 24:36b-48"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 9:1-6 (7-20)",
    psalm: "Sl 30",
    second_reading: "Ap 5:11-14",
    gospel: "Jo 21:1-19"
  },

  # 4º DOMINGO DA PÁSCOA
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 2:42-47",
    psalm: "Sl 23",
    second_reading: "1 Pe 2:19-25",
    gospel: "Jo 10:1-10"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 4:5-12",
    psalm: "Sl 23",
    second_reading: "1 Jo 3:16-24",
    gospel: "Jo 10:11-18"
  },
  {
    date_reference: "4th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 9:36-43",
    psalm: "Sl 23",
    second_reading: "Ap 7:9-17",
    gospel: "Jo 10:22-30"
  },

  # 5º DOMINGO DA PÁSCOA
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 7:55-60",
    psalm: "Sl 31:1-5, 15-16",
    second_reading: "1 Pe 2:2-10",
    gospel: "Jo 14:1-14"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 8:26-40",
    psalm: "Sl 22:25-31",
    second_reading: "1 Jo 4:7-21",
    gospel: "Jo 15:1-8"
  },
  {
    date_reference: "5th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 11:1-18",
    psalm: "Sl 148",
    second_reading: "Ap 21:1-6",
    gospel: "Jo 13:31-35"
  },

  # 6º DOMINGO DA PÁSCOA
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 17:22-31",
    psalm: "Sl 66:8-20",
    second_reading: "1 Pe 3:13-22",
    gospel: "Jo 14:15-21"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 10:44-48",
    psalm: "Sl 98",
    second_reading: "1 Jo 2:1-6",
    gospel: "Jo 15:9-17"
  },
  {
    date_reference: "6th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 16:9-15",
    psalm: "Sl 67",
    second_reading: "Ap 21:10, 22-22:5",
    gospel: "Jo 14:23-29 ou Jo 5:1-9"
  },

  # VÉSPERA DA ASCENSÃO
  {
    date_reference: "eve_of_ascension",
    cycle: "all",
    service_type: "eucharist",
    notes: "Ver, no Lecionário bi-anual, as leituras próprias (p.358)"
  },

  # DIA DA ASCENSÃO (Quinta-feira da sexta semana da Páscoa)
  {
    date_reference: "ascension_day",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 1:1-11 ou 1 Rs 8:22-28",
    psalm: "Sl 47",
    second_reading: "Ef 1:15-23",
    gospel: "Lc 24:44-53"
  },
  {
    date_reference: "ascension_day",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 1:1-11 ou Is 33:13-17,22",
    psalm: "Sl 113",
    second_reading: "Cl 3:1-11",
    gospel: "Jo 14:1-12"
  },
  {
    date_reference: "ascension_day",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 1:1-11 ou 2 Rs 2:9-18",
    psalm: "Sl 93",
    second_reading: "Ap 1:4-8",
    gospel: "Mt 28:16-20"
  },

  # 7º DOMINGO DA PÁSCOA
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "At 1:6-14",
    psalm: "Sl 68:1-10, 32-35",
    second_reading: "1 Pe 4:12-14; 5:6-11",
    gospel: "Jo 17:1-11"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "At 1:15-17, 21-26",
    psalm: "Sl 1",
    second_reading: "1 Jo 5:9-13",
    gospel: "Jo 17:1a,6-19"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "At 16:16-34",
    psalm: "Sl 97",
    second_reading: "Ap 22:12-21",
    gospel: "Jo 17:1a,20-26"
  }
]

easter_readings.each do |reading|
  LectionaryReading.create!(reading.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{easter_readings.count} leituras do Tempo Pascal criadas"
