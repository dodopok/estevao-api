# ================================================================================
# LEITURAS DIÁRIAS DA QUARESMA - LOC 2021 IAB (ANO PAR / A-B)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Quaresma (Ano Par) (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

create_daily_reading = ->(day_ref, mp_psalms, ep_psalms, r1, r2, r3) {
  # Manhã
  LectionaryReading.find_or_create_by!(
    date_reference: day_ref,
    cycle: "even",
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
    cycle: "even",
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
# 1ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("1st_sunday_of_lent_monday",
  "Salmo 41, 52", "Salmo 44",
  "Gênesis 37:1-11", "1 Coríntios 1:1-19", "Marcos 1:1-13"
)

create_daily_reading.call("1st_sunday_of_lent_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Gênesis 37:12-24", "1 Coríntios 1:20-31", "Marcos 1:14-28"
)

create_daily_reading.call("1st_sunday_of_lent_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Gênesis 37:25-36", "1 Coríntios 2:1-13", "Marcos 1:29-45"
)

create_daily_reading.call("1st_sunday_of_lent_thursday",
  "Salmo 50", "Salmo [59-60]ou 19, 46",
  "Gênesis 39:1-23", "1 Coríntios 2:14-3:15", "Marcos 2:1-12"
)

create_daily_reading.call("1st_sunday_of_lent_friday",
  "Salmo 95, 40, 54", "Salmo 51",
  "Gênesis 40:1-23", "1 Coríntios 3:16-23", "Marcos 2:13-22"
)

create_daily_reading.call("1st_sunday_of_lent_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Gênesis 41:1-13", "1 Coríntios 4:1-7", "Marcos 2:23-3:6"
)

# ----------------------------------------------------------------------------
# 2ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("2nd_sunday_of_lent_monday",
  "Salmo 56, 57, [58]", "Salmo 64, 65",
  "Gênesis 41:46-57", "1 Coríntios 4:8-20(21)", "Marcos 3:7-19a"
)

create_daily_reading.call("2nd_sunday_of_lent_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Gênesis 42:1-17", "1 Coríntios 5:1-8", "Marcos 3:19b-35"
)

create_daily_reading.call("2nd_sunday_of_lent_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Gênesis 42:18-28", "1 Coríntios 5:9-6:8", "Marcos 4:1-20"
)

create_daily_reading.call("2nd_sunday_of_lent_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Gênesis 42:29-38", "1 Coríntios 6:12-20", "Marcos 4:21-34"
)

create_daily_reading.call("2nd_sunday_of_lent_friday",
  "Salmo 95, 69:1-23(24-30)31-38", "Salmo 73",
  "Gênesis 43:1-15", "1 Coríntios 7:1-9", "Marcos 4:35-41"
)

create_daily_reading.call("2nd_sunday_of_lent_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Gênesis 43:16-34", "1 Coríntios 7:10-24", "Marcos 5:1-20"
)

# ----------------------------------------------------------------------------
# 3ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("3rd_sunday_of_lent_monday",
  "Salmo 80", "Salmo 77, [79]",
  "Gênesis 44:18-34", "1 Coríntios 7:25-31", "Marcos 5:21-43"
)

create_daily_reading.call("3rd_sunday_of_lent_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "Gênesis 45:1-15", "1 Coríntios 7:32-40", "Marcos 6:1-13"
)

create_daily_reading.call("3rd_sunday_of_lent_wednesday",
  "Salmo 119:97-120", "Salmo 81, 82",
  "Gênesis 45:16-28", "1 Coríntios 8:1-13", "Marcos 6:13-29"
)

create_daily_reading.call("3rd_sunday_of_lent_thursday",
  "Salmo [83] ou 42, 43", "Salmo 85, 86",
  "Gênesis 46:1-7, 28-34", "1 Coríntios 9:1-15", "Marcos 6:30-46"
)

create_daily_reading.call("3rd_sunday_of_lent_friday",
  "Salmo 95, 88", "Salmo 91, 92",
  "Gênesis 47:1-26", "1 Coríntios 9:16-27", "Marcos 6:47-56"
)

create_daily_reading.call("3rd_sunday_of_lent_saturday",
  "Salmo 87, 90", "Salmo 136",
  "Gênesis 47:27-48:7", "1 Coríntios 10:1-13", "Marcos 7:1-23"
)

# ----------------------------------------------------------------------------
# 4ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("4th_sunday_of_lent_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "Gênesis 49:1-28", "1 Coríntios 10:14-11:1", "Marcos 7:24-37"
)

create_daily_reading.call("4th_sunday_of_lent_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "Gênesis 49:29-50:14", "1 Coríntios 11:17-34", "Marcos 8:1-10"
)

create_daily_reading.call("4th_sunday_of_lent_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "Gênesis 50:15-26", "1 Coríntios 12:1-11", "Marcos 8:11-26"
)

create_daily_reading.call("4th_sunday_of_lent_thursday",
  "Salmo 69:1-23(24-30)31-38", "Salmo 73",
  "Êxodo 1:6-22", "1 Coríntios 12:12-26", "Marcos 8:27-9:1"
)

create_daily_reading.call("4th_sunday_of_lent_friday",
  "Salmo 95, 102", "Salmo 107:1-32",
  "Êxodo 2:1-22", "1 Coríntios 12:27-13:3", "Marcos 9:2-13"
)

create_daily_reading.call("4th_sunday_of_lent_saturday",
  "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33",
  "Êxodo 2:23-3:15", "1 Coríntios 13:1-13", "Marcos 9:14-29"
)

# ----------------------------------------------------------------------------
# 5ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("5th_sunday_of_lent_monday",
  "Salmo 31", "Salmo 35",
  "Êxodo 4:10-20(21-26)27-31", "1 Coríntios 14:1-19", "Marcos 9:30-41"
)

create_daily_reading.call("5th_sunday_of_lent_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Êxodo 5:1-6:1", "1 Coríntios 14:20-33a, 39-40", "Marcos 9:42-50"
)

create_daily_reading.call("5th_sunday_of_lent_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "Êxodo 7:8-24", "2 Coríntios 2:14-3:6", "Marcos 10:1-16"
)

create_daily_reading.call("5th_sunday_of_lent_thursday",
  "Salmo 131, 132, [133]", "Salmo 140, 142",
  "Êxodo 7:25-8:19", "2 Coríntios 3:7-18", "Marcos 10:17-31"
)

create_daily_reading.call("5th_sunday_of_lent_friday",
  "Salmo 95, 22", "Salmo 141, 143:1-11(12)",
  "Êxodo 9:13-35", "2 Coríntios 4:1-12", "Marcos 10:32-45"
)

create_daily_reading.call("5th_sunday_of_lent_saturday",
  "Salmo 137:1-6(7-9), 144", "Salmo 42, 43",
  "Êxodo 10:21-11:8", "2 Coríntios 4:13-18", "Marcos 10:46-52"
)

Rails.logger.info "✅ Leituras diárias da Quaresma (Ano Par) carregadas!"
