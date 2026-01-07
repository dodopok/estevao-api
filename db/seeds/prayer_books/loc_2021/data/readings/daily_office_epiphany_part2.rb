# ================================================================================
# LEITURAS DIÁRIAS DA EPIFANIA (SEMANAS 4-8) - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Epifania (Semanas 4-8) (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

create_daily_reading = ->(day_ref, mp_psalms, ep_psalms, r1, r2, r3) {
  # Manhã
  LectionaryReading.find_or_create_by!(
    date_reference: day_ref,
    cycle: "odd",
    service_type: "morning_prayer",
    prayer_book_id: prayer_book.id
  ) do |r|
    r.psalm = mp_psalms
    r.first_reading = r1
    r.second_reading = r2
    r.gospel = r3
  end

  # Tarde
  LectionaryReading.find_or_create_by!(
    date_reference: day_ref,
    cycle: "odd",
    service_type: "evening_prayer",
    prayer_book_id: prayer_book.id
  ) do |r|
    r.psalm = ep_psalms
    r.first_reading = r1
    r.second_reading = r2
    r.gospel = r3
  end
}

# ----------------------------------------------------------------------------
# 4ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("4th_sunday_after_epiphany_monday",
  "Salmo 56, 57, [58]", "Salmo 64, 65",
  "Isaías 51:17-23", "Gálatas 4:1-11", "Marcos 7:24-37"
)

create_daily_reading.call("4th_sunday_after_epiphany_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Isaías 52:1-12", "Gálatas 4:12-20", "Marcos 8:1-10"
)

create_daily_reading.call("4th_sunday_after_epiphany_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Isaías 54:1-10(11-17)", "Gálatas 4:21-31", "Marcos 8:11-26"
)

create_daily_reading.call("4th_sunday_after_epiphany_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Isaías 55:1-13", "Gálatas 5:1-15", "Marcos 8:27-9:1"
)

create_daily_reading.call("4th_sunday_after_epiphany_friday",
  "Salmo 69:1-23[24-30]31-38", "Salmo 73",
  "Isaías 56:1-8", "Gálatas 5:16-24", "Marcos 9:2-13"
)

create_daily_reading.call("4th_sunday_after_epiphany_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Isaías 57:3-13", "Gálatas 5:25-6:10", "Marcos 9:14-29"
)

# ----------------------------------------------------------------------------
# 5ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("5th_sunday_after_epiphany_monday",
  "Salmo 80", "Salmo 77, [79]",
  "Isaías 58:1-12", "Gálatas 6:11-18", "Marcos 9:30-41"
)

create_daily_reading.call("5th_sunday_after_epiphany_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "Isaías 59:1-15a", "2 Timóteo 1:1-14", "Marcos 9:42-50"
)

create_daily_reading.call("5th_sunday_after_epiphany_wednesday",
  "Salmo 119:97-120", "Salmo 81, 82",
  "Isaías 59:15b-21", "2 Timóteo 1:15-2:13", "Marcos 10:1-16"
)

create_daily_reading.call("5th_sunday_after_epiphany_thursday",
  "Salmo [83] ou 146, 147", "Salmo 85, 86",
  "Isaías 60:1-17", "2 Timóteo 2:14-26", "Marcos 10:17-31"
)

create_daily_reading.call("5th_sunday_after_epiphany_friday",
  "Salmo 88", "Salmo 91, 92",
  "Isaías 61:1-9", "2 Timóteo 3:1-17", "Marcos 10:32-45"
)

create_daily_reading.call("5th_sunday_after_epiphany_saturday",
  "Salmo 87, 90", "Salmo 136",
  "Isaías 61:10-62:5", "2 Timóteo 4:1-8", "Marcos 10:46-52"
)

# ----------------------------------------------------------------------------
# 6ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("6th_sunday_after_epiphany_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "Isaías 63:1-6", "1 Timóteo 1:1-17", "Marcos 11:1-11"
)

create_daily_reading.call("6th_sunday_after_epiphany_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "Isaías 63:7-14", "1 Timóteo 1:18-2:8", "Marcos 11:12-26"
)

create_daily_reading.call("6th_sunday_after_epiphany_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "Isaías 63:15-64:9", "1 Timóteo 3:1-16", "Marcos 11:27-12:12"
)

create_daily_reading.call("6th_sunday_after_epiphany_thursday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "Isaías 65:1-12", "1 Timóteo 4:1-16", "Marcos 12:13-27"
)

create_daily_reading.call("6th_sunday_after_epiphany_friday",
  "Salmo 102", "Salmo 107:1-32",
  "Isaías 65:17-25", "1 Timóteo 5:17-22(23-25)", "Marcos 12:28-34"
)

create_daily_reading.call("6th_sunday_after_epiphany_saturday",
  "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33",
  "Isaías 66:1-6", "1 Timóteo 6:6-21", "Marcos 12:35-44"
)

# ----------------------------------------------------------------------------
# 7ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("7th_sunday_after_epiphany_monday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "Rute 1:1-14", "2 Coríntios 1:1-11", "Mateus 5:1-12"
)

create_daily_reading.call("7th_sunday_after_epiphany_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Rute 1:15-22", "2 Coríntios 1:12-22", "Mateus 5:13-20"
)

create_daily_reading.call("7th_sunday_after_epiphany_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "Rute 2:1-13", "2 Coríntios 1:23-2:17", "Mateus 5:21-26"
)

create_daily_reading.call("7th_sunday_after_epiphany_thursday",
  "Salmo 131, 132, [133]", "Salmo 134, 135",
  "Rute 2:14-23", "2 Coríntios 3:1-18", "Mateus 5:27-37"
)

create_daily_reading.call("7th_sunday_after_epiphany_friday",
  "Salmo 140, 142", "Salmo 141, 143:1-11(12)",
  "Rute 3:1-18", "2 Coríntios 4:1-12", "Mateus 5:38-48"
)

create_daily_reading.call("7th_sunday_after_epiphany_saturday",
  "Salmo 37:1-6(7-9), 144", "Salmo 104",
  "Rute 4:1-17", "2 Coríntios 4:13-5:10", "Mateus 6:1-16"
)

# ----------------------------------------------------------------------------
# 8ª SEMANA DA EPIFANIA (SE HOUVER)
# ----------------------------------------------------------------------------
create_daily_reading.call("8th_sunday_after_epiphany_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Deuteronômio 4:9-14", "2 Coríntios 10:1-18", "Mateus 6:7-15"
)

create_daily_reading.call("8th_sunday_after_epiphany_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Deuteronômio 4:15-24", "2 Coríntios 11:1-21a", "Mateus 6:16-23"
)

create_daily_reading.call("8th_sunday_after_epiphany_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Deuteronômio 4:25-31", "2 Coríntios 11:21b-33", "Mateus 6:24-34"
)

create_daily_reading.call("8th_sunday_after_epiphany_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Deuteronômio 4:32-40", "2 Coríntios 12:1-10", "Mateus 7:1-12"
)

create_daily_reading.call("8th_sunday_after_epiphany_friday",
  "Salmo 16, 17", "Salmo 22",
  "Deuteronômio 5:1-22", "2 Coríntios 12:11-21", "Mateus 7:13-21"
)

create_daily_reading.call("8th_sunday_after_epiphany_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Deuteronômio 5:22-33", "2 Coríntios 13:1-14", "Mateus 7:22-29"
)

Rails.logger.info "✅ Leituras diárias da Epifania (Semanas 4-8) (Ano Ímpar) carregadas!"
