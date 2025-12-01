# ================================================================================
# LEITURAS DO NATAL - LOCB 2008
# Cor litúrgica: Branco
# ================================================================================

Rails.logger.info "📖 Criando Leituras do Natal - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

christmas_readings = [
  # VIGÍLIA DO NATAL
  {
    date_reference: "christmas_eve",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 11:1-9",
    psalm: "Sl 96",
    second_reading: "Rm 1:1-7 ou Gl 4:4-7",
    gospel: "Lc 2:1-7"
  },

  # DIA DE NATAL (25 de dezembro)
  {
    date_reference: "christmas_day",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 9:2-7",
    psalm: "Sl 96",
    second_reading: "Tt 2:11-14",
    gospel: "Lc 2:1-14(15-20)"
  },
  {
    date_reference: "christmas_day",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 52:7-10",
    psalm: "Sl 97",
    second_reading: "Hb 1:1-4 (5-12)",
    gospel: "Lc 2:(1-7)8-20"
  },
  {
    date_reference: "christmas_day",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 62:6-12",
    psalm: "Sl 98",
    second_reading: "Tt 3:4-7",
    gospel: "Jo 1:1-14"
  },

  # 1º DOMINGO DEPOIS DO NATAL (entre 26 de dezembro e 1 de janeiro)
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 63:7-9",
    psalm: "Sl 148",
    second_reading: "Hb 2:10-18",
    gospel: "Mt 2:13-23"
  },
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 61:10-62:3",
    psalm: "Sl 148",
    second_reading: "Gl 4:4-7",
    gospel: "Lc 2:22-40"
  },
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Sm 2:18-20,26",
    psalm: "Sl 148",
    second_reading: "Cl 3:12-17",
    gospel: "Lc 2:41-52"
  },

  # 2º DOMINGO DEPOIS DO NATAL (entre 2 e 5 de janeiro)
  {
    date_reference: "2nd_sunday_after_christmas",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jr 31:7-14",
    psalm: "Sl 147:12-20",
    second_reading: "Ef 1:3-14",
    gospel: "Jo 1:(1-9) 10-18"
  },

  # EPIFANIA DE NOSSO SENHOR (6 de janeiro ou domingo mais próximo)
  {
    date_reference: "epiphany",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 60:1-6",
    psalm: "Sl 72:1-7, 10-14",
    second_reading: "Ef 3:1-12",
    gospel: "Mt 2:1-12"
  },
  {
    date_reference: "epiphany",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 52:7-10",
    psalm: "Sl 100:1-5",
    second_reading: "Cl 1:24-27",
    gospel: "Mt 12:14-21"
  },
  {
    date_reference: "epiphany",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 49:1-7",
    psalm: "Sl 44:1,3,4a,6,8",
    second_reading: "2 Co 4:3-6",
    gospel: "Jo 1:43-51"
  }
]

christmas_readings.each do |reading|
  LectionaryReading.create!(reading.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{christmas_readings.count} leituras do Natal criadas"
