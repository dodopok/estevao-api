# ================================================================================
# LEITURAS DA SEMANA SANTA - LOCB 2008
# ================================================================================

Rails.logger.info "📖 Criando Leituras da Semana Santa - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

holy_week_readings = [
  # DOMINGO DE RAMOS - LITURGIA DE RAMOS (Cor: Vermelho)
  {
    date_reference: "palm_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Mt 21:1-11",
    psalm: "Sl 118:1-2, 19-29",
    gospel: nil
  },
  {
    date_reference: "palm_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Mc 11:1-11",
    psalm: "Sl 118:1-2, 19-29",
    gospel: nil
  },
  {
    date_reference: "palm_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Lc 19:28-40 ou Jo 12:12-16",
    psalm: "Sl 118:1-2, 19-29",
    gospel: nil
  },

  # DOMINGO DE RAMOS - LITURGIA DA PAIXÃO (Cor: Vermelho)
  {
    date_reference: "palm_sunday_passion",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 50:4-9a",
    psalm: "Sl 31:9-16",
    second_reading: "Fp 2:5-11",
    gospel: "Mt 26:14-27.66 ou Mt 27:11-26"
  },
  {
    date_reference: "palm_sunday_passion",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 42:1-9",
    psalm: "Sl 36:5-11",
    second_reading: "Hb 9:11-15",
    gospel: "Mc 14:1 – 15:47 ou Mc 14:1-9 ou Mc 14:53-65 ou Mc 15:1-9"
  },
  {
    date_reference: "palm_sunday_passion",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 49:1-7",
    psalm: "Sl 71:1-14",
    second_reading: "1 Co 1:18-31",
    gospel: "Lc 22:14 – 23:56 ou Lc 22:54-62"
  },

  # SEGUNDA-FEIRA DA SEMANA SANTA
  {
    date_reference: "monday_of_holy_week",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 42:1-7",
    psalm: "Sl 27:1-8",
    second_reading: "Heb 9:11-15",
    gospel: "Jo 12:1-8"
  },

  # TERÇA-FEIRA DA SEMANA SANTA
  {
    date_reference: "tuesday_of_holy_week",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 49:1-6",
    psalm: "Sl 71:1-12",
    second_reading: "1 Cor 1:18-31",
    gospel: "Jo 12:27-36"
  },

  # QUARTA-FEIRA DA SEMANA SANTA
  {
    date_reference: "wednesday_of_holy_week",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 50:4-9a",
    psalm: "Sl 70",
    second_reading: "Heb 12:1-3",
    gospel: "Jo 13:21-30 ou Mc 12:1-11"
  },

  # QUINTA-FEIRA SANTA (Cor: Branco - Canta-se o Glória)
  {
    date_reference: "maundy_thursday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êx 24:1-11",
    psalm: "Sl 116",
    second_reading: "1 Co 10:16-17",
    gospel: "Mt 26:36-56"
  },
  {
    date_reference: "maundy_thursday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 42:1-4(5-9)",
    psalm: "Sl 116:1-2, 12-19",
    second_reading: "Ap 19:6-10",
    gospel: "Mc 14:12-26"
  },
  {
    date_reference: "maundy_thursday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êx 12:1-14",
    psalm: "Sl 116:1-2, 12-19",
    second_reading: "1 Co 11:23-26",
    gospel: "Jo 13:1-17, 31b-35"
  },

  # SEXTA-FEIRA SANTA (Cor: Preto ou Vermelho)
  {
    date_reference: "good_friday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 50:4-7",
    psalm: "Sl 22",
    second_reading: "2 Co 5:(14-18)19-21",
    gospel: "Mt 27:(27-32)33-50"
  },
  {
    date_reference: "good_friday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 52:13 – 53:12",
    psalm: "Sl 22",
    second_reading: "Hb 10:16-25",
    gospel: "Jo 19:16-30(31-37)"
  },
  {
    date_reference: "good_friday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Os 5:15b – 6:6",
    psalm: "Sl 22",
    second_reading: "Hb 4:14-16, 5:7-9",
    gospel: "Lc 23:33-49"
  },

  # SÁBADO SANTO (Cor: Preto ou Vermelho)
  {
    date_reference: "holy_saturday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 14:1-14 ou Lm 3:1-9, 19-24",
    psalm: "Sl 31:1-4,15-16",
    second_reading: "1 Pe 4:1-8",
    gospel: "Mt 27:57-66 ou Jo 19:38-42"
  }
]

holy_week_readings.each do |reading|
  LectionaryReading.create!(reading.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{holy_week_readings.count} leituras da Semana Santa criadas"
