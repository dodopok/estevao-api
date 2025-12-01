# ================================================================================
# LEITURAS DO ADVENTO - LOCB 2008
# Cor litúrgica: Roxo
# ================================================================================

Rails.logger.info "📖 Criando Leituras do Advento - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

advent_readings = [
  # 1º DOMINGO DO ADVENTO (entre 27 de novembro e 3 de dezembro)
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 2:1-5",
    psalm: "Sl 122",
    second_reading: "Rm 13:11-14",
    gospel: "Mt 24:36-44"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 64:1-9",
    psalm: "Sl 80:1-7, 17-19",
    second_reading: "1 Co 1:3-9",
    gospel: "Mc 13:24-37"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jr 33:14-16",
    psalm: "Sl 25:1-10",
    second_reading: "1 Ts 3:9-13",
    gospel: "Lc 21:25-36"
  },

  # 2º DOMINGO DO ADVENTO (entre 4 e 10 de dezembro)
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 11:1-10",
    psalm: "Sl 72:1-7, 18-19",
    second_reading: "Rm 15:4-13",
    gospel: "Mt 3:1-12"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 40:1-11",
    psalm: "Sl 85:1-2, 8-13",
    second_reading: "2 Pe 3:8-15a",
    gospel: "Mc 1:1-8"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Ml 3:1-4",
    psalm: "Lc 1:68-79",
    second_reading: "Fp 1:3-11",
    gospel: "Lc 3:1-6"
  },

  # 3º DOMINGO DO ADVENTO (entre 11 e 17 de dezembro)
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 35:1-10",
    psalm: "Sl 146:5-10 ou Lc 1:46-55",
    second_reading: "Tg 5:7-10",
    gospel: "Mt 11:2-11"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 61:1-4, 8-11",
    psalm: "Sl 126 ou Lc 1:46-55",
    second_reading: "1 Ts 5:16-24",
    gospel: "Jo 1:6-8, 19-28"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Sf 3:14-20",
    psalm: "Is 12:2-6 ou Lc 1:46-55",
    second_reading: "Fp 4:4-7",
    gospel: "Lc 3:7-18"
  },

  # 4º DOMINGO DO ADVENTO (entre 18 e 24 de dezembro)
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 7:10-16",
    psalm: "Sl 80:1-7, 17-19 ou Sl 89:1-4, 24-26",
    second_reading: "Rm 1:1-7",
    gospel: "Mt 1:18-25"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Sm 7:1-11, 16",
    psalm: "Lc 1:47-55 ou Sl 80:1-7",
    second_reading: "Rm 16:25-27",
    gospel: "Lc 1:26-38"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Mq 5:2-5",
    psalm: "Lc 1:47-55",
    second_reading: "Hb 10:5-10",
    gospel: "Lc 1:39-45 (46-55)"
  }
]

advent_readings.each do |reading|
  LectionaryReading.create!(reading.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{advent_readings.count} leituras do Advento criadas"
