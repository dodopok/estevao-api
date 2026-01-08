# ================================================================================
# LEITURAS DIÁRIAS DA EPIFANIA - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Epifania (LOC 2021 IAB)..."

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
# DIAS APÓS EPIFANIA (7-12 de Janeiro)
# ----------------------------------------------------------------------------

create_daily_reading.call("january_7",
  "Salmo 103", "Salmo 114, 115",
  "Isaías 52:3-6", "Apocalipse 2:1-7", "João 2:1-11"
)

create_daily_reading.call("january_8",
  "Salmo 117, 118", "Salmo 112, 113",
  "Isaías 59:15-21", "Apocalipse 2:8-17", "João 4:46-54"
)

create_daily_reading.call("january_9",
  "Salmo 121, 122, 123", "Salmo 131, 132",
  "Isaías 63:1-5", "Apocalipse 2:18-29", "João 5:1-15"
)

create_daily_reading.call("january_10",
  "Salmo 138, 139:1-17(18-23)", "Salmo 147",
  "Isaías 65:1-9", "Apocalipse 3:1-6", "João 6:1-14"
)

create_daily_reading.call("january_11",
  "Salmo 148, 150", "Salmo 91, 92",
  "Isaías 65:13-16", "Apocalipse 3:7-13", "João 6:15-27"
)

create_daily_reading.call("january_12",
  "Salmo 98, 99(100)", "Salmo 104",
  "Isaías 66:1-2, 22-23", "Apocalipse 3:14-22", "João 9:1-12, 35-38"
)

# ----------------------------------------------------------------------------
# 1ª SEMANA DA EPIFANIA
# ----------------------------------------------------------------------------
create_daily_reading.call("1st_sunday_after_epiphany_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Isaías 40:12-23", "Efésios 1:1-14", "Marcos 1:1-13"
)

create_daily_reading.call("1st_sunday_after_epiphany_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Isaías 40:25-31", "Efésios 1:15-23", "Marcos 1:14-28"
)

create_daily_reading.call("1st_sunday_after_epiphany_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Isaías 41:1-16", "Efésios 2:1-10", "Marcos 1:29-45"
)

create_daily_reading.call("1st_sunday_after_epiphany_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Isaías 41:17-29", "Efésios 2:11-22", "Marcos 2:1-12"
)

create_daily_reading.call("1st_sunday_after_epiphany_friday",
  "Salmo 16, 17", "Salmo 22",
  "Isaías 42:1-9(10-17)", "Efésios 3:1-13", "Marcos 2:13-22"
)

create_daily_reading.call("1st_sunday_after_epiphany_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Isaías 43:1-13", "Efésios 3:14-21", "Marcos 2:23-3:6"
)

# ----------------------------------------------------------------------------
# 2ª SEMANA DA EPIFANIA
# ----------------------------------------------------------------------------
create_daily_reading.call("2nd_sunday_after_epiphany_monday",
  "Salmo 25", "Salmo 9, 15",
  "Isaías 44:6-8, 21-23", "Efésios 4:1-16", "Marcos 3:7-19a"
)

create_daily_reading.call("2nd_sunday_after_epiphany_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Isaías 44:9-20", "Efésios 4:17-32", "Marcos 3:19b-35"
)

create_daily_reading.call("2nd_sunday_after_epiphany_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Isaías 44:24-45:7", "Efésios 5:1-14", "Marcos 4:1-20"
)

create_daily_reading.call("2nd_sunday_after_epiphany_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Isaías 45:5-17", "Efésios 5:15-33", "Marcos 4:21-34"
)

create_daily_reading.call("2nd_sunday_after_epiphany_friday",
  "Salmo 31", "Salmo 35",
  "Isaías 45:18-25", "Efésios 6:1-9", "Marcos 4:35-41"
)

create_daily_reading.call("2nd_sunday_after_epiphany_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Isaías 46:1-13", "Efésios 6:10-24", "Marcos 5:1-20"
)

# ----------------------------------------------------------------------------
# 3ª SEMANA DA EPIFANIA
# ----------------------------------------------------------------------------
create_daily_reading.call("3rd_sunday_after_epiphany_monday",
  "Salmo 41, 52", "Salmo 44",
  "Isaías 48:1-11", "Gálatas 1:1-17", "Marcos 5:21-43"
)

create_daily_reading.call("3rd_sunday_after_epiphany_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Isaías 48:12-21", "Gálatas 1:18-2:10", "Marcos 6:1-13"
)

create_daily_reading.call("3rd_sunday_after_epiphany_wednesday",
  "Salmo 119:49-72", "Salmo 49, 53",
  "Isaías 49:1-12", "Gálatas 2:11-21", "Marcos 6:13-29"
)

create_daily_reading.call("3rd_sunday_after_epiphany_thursday",
  "Salmo 50", "Salmo 59, 60 or 118",
  "Isaías 49:13-23", "Gálatas 3:1-14", "Marcos 6:30-46"
)

create_daily_reading.call("3rd_sunday_after_epiphany_friday",
  "Salmo 40, 54", "Salmo 51",
  "Isaías 50:1-11", "Gálatas 3:15-22", "Marcos 6:47-56"
)

create_daily_reading.call("3rd_sunday_after_epiphany_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Isaías 48:1-11", "Gálatas 1:1-17", "Marcos 5:21-43"
)

Rails.logger.info "✅ Leituras diárias da Epifania (Ano Ímpar) carregadas!"
