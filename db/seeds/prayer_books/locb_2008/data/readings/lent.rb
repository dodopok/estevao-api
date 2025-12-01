# ================================================================================
# LEITURAS DA QUARESMA - LOCB 2008
# Cor litúrgica: Roxo
# ================================================================================

Rails.logger.info "📖 Criando Leituras da Quaresma - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

lent_readings = [
  # QUARTA-FEIRA DE CINZAS
  {
    date_reference: "ash_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jl 2:1-2, 12-17 ou Is 58:1-12",
    psalm: "Sl 51:1-17",
    second_reading: "2 Co 5:20b-6.10",
    gospel: "Mt 6:1-6, 16-21"
  },

  # 1º DOMINGO DA QUARESMA
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gn 2:15-17; 3:1-7",
    psalm: "Sl 32",
    second_reading: "Rm 5:12-19",
    gospel: "Mt 4:1-11"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gn 9:8-17",
    psalm: "Sl 25:1-10",
    second_reading: "1 Pe 3:18-22",
    gospel: "Mc 1:9-15"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Dt 26:1-11",
    psalm: "Sl 91:1-2, 9-16",
    second_reading: "Rm 10:8b-13",
    gospel: "Lc 4:1-13"
  },

  # 2º DOMINGO DA QUARESMA
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gn 12:1-4a",
    psalm: "Sl 121",
    second_reading: "Rm 4:1-5, 13-17",
    gospel: "Jo 3:1-17"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gn 17:1-16",
    psalm: "Sl 22:23-31",
    second_reading: "Rm 4:13-25",
    gospel: "Mc 8:31-38"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gn 15:1-18",
    psalm: "Sl 27",
    second_reading: "Fp 3:17-4.1",
    gospel: "Lc 13:31-35"
  },

  # 3º DOMINGO DA QUARESMA
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êx 17:1-7",
    psalm: "Sl 95",
    second_reading: "Rm 5:1-11",
    gospel: "Jo 4:5-42"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Êx 20:1-17",
    psalm: "Sl 19",
    second_reading: "1 Co 1:18-25",
    gospel: "Jo 2:13-22"
  },
  {
    date_reference: "3rd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 55:1-9",
    psalm: "Sl 63:1-8",
    second_reading: "1 Co 10:1-13",
    gospel: "Lc 13:1-9"
  },

  # 4º DOMINGO DA QUARESMA
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "1 Sm 16:1-13",
    psalm: "Sl 23",
    second_reading: "Ef 5:8-14",
    gospel: "Jo 9:1-41"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Nm 21:4-9",
    psalm: "Sl 107:1-3, 17-22",
    second_reading: "Ef 2:1-10",
    gospel: "Jo 3:14-21"
  },
  {
    date_reference: "4th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Js 5:9-12",
    psalm: "Sl 32",
    second_reading: "2 Co 5:16-21",
    gospel: "Lc 15:1-3, 11b-32"
  },

  # 5º DOMINGO DA QUARESMA
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ez 37:1-14",
    psalm: "Sl 130",
    second_reading: "Rm 8:6-11",
    gospel: "Jo 11:1-45"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jr 31:31-34",
    psalm: "Sl 51:1-12",
    second_reading: "Hb 5:5-10",
    gospel: "Jo 12:20-33"
  },
  {
    date_reference: "5th_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 43:16-21",
    psalm: "Sl 126 ou Sl 119:9-16",
    second_reading: "Fp 3:4b-14",
    gospel: "Jo 12:1-8"
  }
]

lent_readings.each do |reading|
  LectionaryReading.create!(reading.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{lent_readings.count} leituras da Quaresma criadas"
