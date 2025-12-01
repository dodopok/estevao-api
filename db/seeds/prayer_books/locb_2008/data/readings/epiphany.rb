# ================================================================================
# LEITURAS DO TEMPO COMUM I (Domingos após a Epifania) - LOCB 2008
# Cor litúrgica: Verde
# ================================================================================

Rails.logger.info "📖 Criando Leituras do Tempo Comum I - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

epiphany_readings = [
  # 1º DOMINGO APÓS A EPIFANIA - Festa do Batismo de Cristo (entre 7 e 13 de janeiro)
  {
    date_reference: "baptism_of_the_lord",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 42:1-9",
    psalm: "Sl 29",
    second_reading: "At 10:34-43",
    gospel: "Mt 3:13-17"
  },
  {
    date_reference: "baptism_of_the_lord",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gn 1:1-5",
    psalm: "Sl 29",
    second_reading: "At 19:1-7",
    gospel: "Mc 1:4-11"
  },
  {
    date_reference: "baptism_of_the_lord",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 43:1-7",
    psalm: "Sl 29",
    second_reading: "At 8:14-17",
    gospel: "Lc 3:15-17, 21-22"
  },

  # 2º DOMINGO APÓS A EPIFANIA (entre 14 e 20 de janeiro)
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 49:1-7",
    psalm: "Sl 40:1-11",
    second_reading: "1 Co 1:1-9",
    gospel: "Jo 1:29-42"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Sm 3:1-10 (11-20)",
    psalm: "Sl 139:1-6, 13-18",
    second_reading: "1 Co 6:12-20",
    gospel: "Jo 1:43-51"
  },
  {
    date_reference: "2nd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 62.1-5",
    psalm: "Sl 36.5-10",
    second_reading: "1 Co 12.1-11",
    gospel: "Jo 2.1-11"
  },

  # 3º DOMINGO APÓS A EPIFANIA (entre 21 e 27 de janeiro)
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 9:1-4",
    psalm: "Sl 27:1,4-9",
    second_reading: "1 Co 1:10-18",
    gospel: "Mt 4:12-23"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jn 3:1-5,10",
    psalm: "Sl 62:5-12",
    second_reading: "1 Co 7:29-3",
    gospel: "Mc 1:14-20"
  },
  {
    date_reference: "3rd_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Ne 8:1-10",
    psalm: "Sl 19",
    second_reading: "1 Co 12:12-31a",
    gospel: "Lc 4:14-21"
  },

  # 4º DOMINGO APÓS A EPIFANIA (entre 28 de janeiro e 3 de fevereiro)
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Mq 6:1-8",
    psalm: "Sl 15",
    second_reading: "1 Co 1:18-31",
    gospel: "Mt 5:1-12"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Dt 18:15-20",
    psalm: "Sl 111",
    second_reading: "1 Co 8:1-13",
    gospel: "Mc 1:21-28"
  },
  {
    date_reference: "4th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jr 1:4-10",
    psalm: "Sl 71:1-6",
    second_reading: "1 Co 13:1-13",
    gospel: "Lc 4:21-30"
  },

  # 5º DOMINGO APÓS A EPIFANIA (entre 4 e 10 de fevereiro, salvo se a Quaresma começou)
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 58:1-9a (9b-12)",
    psalm: "Sl 112:1-9 (10)",
    second_reading: "1 Co 2:1-12 (13-16)",
    gospel: "Mt 5:13-20"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 40:21-31",
    psalm: "Sl 147:1-11,20c",
    second_reading: "1 Co 9:16-23",
    gospel: "Mc 1:29-39"
  },
  {
    date_reference: "5th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 6:1-8 (9-13)",
    psalm: "Sl 138",
    second_reading: "1 Co 15:1-11",
    gospel: "Lc 5:1-11"
  },

  # 6º DOMINGO APÓS A EPIFANIA (entre 11 e 17 de fevereiro, ou se a Quaresma já começou, entre 8 e 14 de maio)
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Dt 30:15-20",
    psalm: "Sl 119:1-8",
    second_reading: "1 Co 3:1-9",
    gospel: "Mt 5:21-37"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Rs 5:1-14",
    psalm: "Sl 30",
    second_reading: "1 Co 9:24-27",
    gospel: "Mc 1:40-45"
  },
  {
    date_reference: "6th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jr 17:5-10",
    psalm: "Sl 1",
    second_reading: "1 Co 15:12-20",
    gospel: "Lc 6:17-26"
  },

  # 7º DOMINGO APÓS A EPIFANIA (entre 18 e 24 de fevereiro, ou, se a Quaresma já começou, entre 15 e 21 de maio)
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Lv 19:1-2, 9-18",
    psalm: "Sl 119:33-40",
    second_reading: "1 Co 3:10-23",
    gospel: "Mt 5:38-48"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 43:18-25",
    psalm: "Sl 41",
    second_reading: "2 Co 1:18-22",
    gospel: "Mc 2:1-12"
  },
  {
    date_reference: "7th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gn 45:3-11,15",
    psalm: "Sl 37:1-11, 39-40",
    second_reading: "1 Co 15:35-50",
    gospel: "Lc 6:27-38"
  },

  # 8º DOMINGO APÓS A EPIFANIA (entre 25 de fevereiro e 3 de março – em ano bissexto, 2 de março – ou, se a Quaresma já começou, entre 22 e 28 de maio)
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 49:8-16a",
    psalm: "Sl 131",
    second_reading: "1 Co 4:1-5",
    gospel: "Mt 6:24-34"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Os 2:14-20",
    psalm: "Sl 103:1-13, 22",
    second_reading: "2 Co 3:1-6",
    gospel: "Mc 2:13-22"
  },
  {
    date_reference: "8th_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 55:10-13",
    psalm: "Sl 92:1-15",
    second_reading: "1 Co 15:51-58",
    gospel: "Lc 6:39-49"
  },

  # 9º DOMINGO APÓS A EPIFANIA ou Último Domingo antes da Quaresma (Transfiguração)
  # (entre 4 e 10 de março — em ano bissexto, 3 e 9 de março ou, se a Quaresma já começou, entre 29 de maio e 4 de junho)
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êx 24:12-18",
    psalm: "Sl 2 ou Sl 99",
    second_reading: "2 Pe 1:16-21",
    gospel: "Mt 17:1-9"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Rs 2:1-12",
    psalm: "Sl 50:1-6",
    second_reading: "2 Co 4:3-6",
    gospel: "Mc 9:2-9"
  },
  {
    date_reference: "last_sunday_after_epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êx 34:29-35",
    psalm: "Sl 99",
    second_reading: "2 Co 3:12-4.2",
    gospel: "Lc 9:28-36 (37-43)"
  }
]

epiphany_readings.each do |reading|
  LectionaryReading.create!(reading.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{epiphany_readings.count} leituras do Tempo Comum I criadas"
