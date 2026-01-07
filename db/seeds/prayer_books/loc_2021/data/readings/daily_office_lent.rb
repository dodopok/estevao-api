# ================================================================================
# LEITURAS DIÁRIAS DA QUARESMA - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias da Quaresma (LOC 2021 IAB)..."

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
# ÚLTIMA SEMANA DA EPIFANIA (Continuação da imagem anterior, mas lógica de transição)
# ----------------------------------------------------------------------------
# Terça (Última semana da Epifania)
create_daily_reading.call("last_sunday_after_epiphany_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Deuteronômio 6:16-25", "Hebreus 2:1-10", "João 1:19-28"
)

# Quarta-feira de Cinzas
create_daily_reading.call("ash_wednesday",
  "Salmo 95, 32, 143", "Salmo 102, 130",
  "Jonas 3:1-4:11", "Hebreus 12:1-14", "Lucas 18:9-14"
)

# Quinta após Cinzas
create_daily_reading.call("thursday_after_ash_wednesday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Deuteronômio 7:6-11", "Tito 1:1-16", "João 1:29-34"
)

# Sexta após Cinzas
create_daily_reading.call("friday_after_ash_wednesday",
  "Salmo 95, 31", "Salmo 35",
  "Deuteronômio 7:12-16", "Tito 2:1-15", "João 1:35-42"
)

# Sábado após Cinzas
create_daily_reading.call("saturday_after_ash_wednesday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Deuteronômio 7:17-26", "Tito 3:1-15", "João 1:43-51"
)

# ----------------------------------------------------------------------------
# 1ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("1st_sunday_of_lent_monday",
  "Salmo 41, 52", "Salmo 44",
  "Deuteronômio 8:11-20", "Hebreus 2:11-18", "João 2:1-12"
)

create_daily_reading.call("1st_sunday_of_lent_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Deuteronômio 9:4-12", "Hebreus 3:1-11", "João 2:13-22"
)

create_daily_reading.call("1st_sunday_of_lent_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Deuteronômio 9:13-21", "Hebreus 3:12-19", "João 2:23-3:15"
)

create_daily_reading.call("1st_sunday_of_lent_thursday",
  "Salmo 50", "Salmo [59, 60] ou 19, 46",
  "Deuteronômio 9:23-10:5", "Hebreus 4:1-10", "João 3:16-21"
)

create_daily_reading.call("1st_sunday_of_lent_friday",
  "Salmo 95, 40, 54", "Salmo 51",
  "Deuteronômio 10:12-22", "Hebreus 4:11-16", "João 3:22-36"
)

create_daily_reading.call("1st_sunday_of_lent_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Deuteronômio 11:18-28", "Hebreus 5:1-10", "João 4:1-26"
)

# ----------------------------------------------------------------------------
# 2ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("2nd_sunday_of_lent_monday",
  "Salmo 56, 57, [58]", "Salmo 64, 65",
  "Jeremias 1:11-19", "Romanos 1:1-15", "João 4:27-42"
)

create_daily_reading.call("2nd_sunday_of_lent_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Jeremias 2:1-13", "Romanos 1:16-25", "João 4:43-54"
)

create_daily_reading.call("2nd_sunday_of_lent_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Jeremias 3:6-18", "Romanos 1:28-2:11", "João 5:1-18"
)

create_daily_reading.call("2nd_sunday_of_lent_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Jeremias 4:9-10, 19-28", "Romanos 2:12-24", "João 5:19-29"
)

create_daily_reading.call("2nd_sunday_of_lent_friday",
  "Salmo 95, 69:1-23(24-30)31-38", "Salmo 73",
  "Jeremias 5:1-9", "Romanos 2:25-3:18", "João 5:30-47"
)

create_daily_reading.call("2nd_sunday_of_lent_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Jeremias 5:20-31", "Romanos 3:19-31", "João 7:1-13"
)

# ----------------------------------------------------------------------------
# 3ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("3rd_sunday_of_lent_monday",
  "Salmo 80", "Salmo 77, [79]",
  "Jeremias 7:1-15", "Romanos 4:1-12", "João 7:14-36"
)

create_daily_reading.call("3rd_sunday_of_lent_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "Jeremias 7:21-34", "Romanos 4:13-25", "João 7:37-52"
)

create_daily_reading.call("3rd_sunday_of_lent_wednesday",
  "Salmo 119:97-120", "Salmo 81, 82",
  "Jeremias 8:18-9:6", "Romanos 5:1-11", "João 8:12-20"
)

create_daily_reading.call("3rd_sunday_of_lent_thursday",
  "Salmo [83] ou 42, 43", "Salmo 85, 86",
  "Jeremias 10:11-24", "Romanos 5:12-21", "João 8:21-32"
)

create_daily_reading.call("3rd_sunday_of_lent_friday",
  "Salmo 95, 88", "Salmo 91, 92",
  "Jeremias 11:1-8, 14-20", "Romanos 6:1-11", "João 8:33-47"
)

create_daily_reading.call("3rd_sunday_of_lent_saturday",
  "Salmo 87, 90", "Salmo 136",
  "Jeremias 13:1-11", "Romanos 6:12-23", "João 8:47-59"
)

# ----------------------------------------------------------------------------
# 4ª SEMANA DA QUARESMA
# ----------------------------------------------------------------------------
create_daily_reading.call("4th_sunday_of_lent_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "Jeremias 16:10-21", "Romanos 7:1-12", "João 6:1-15"
)

create_daily_reading.call("4th_sunday_of_lent_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "Jeremias 17:19-27", "Romanos 7:13-25", "João 6:16-27"
)

create_daily_reading.call("4th_sunday_of_lent_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "Jeremias 18:1-11", "Romanos 8:1-11", "João 6:27-40"
)

create_daily_reading.call("4th_sunday_of_lent_thursday",
  "Salmo 69:1-23(24-30)31-38", "Salmo 73",
  "Jeremias 22:13-23", "Romanos 8:12-27", "João 6:41-51"
)

create_daily_reading.call("4th_sunday_of_lent_friday",
  "Salmo 95, 102", "Salmo 107:1-32",
  "Jeremias 23:1-8", "Romanos 8:28-39", "João 6:52-59"
)

create_daily_reading.call("4th_sunday_of_lent_saturday",
  "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33",
  "Jeremias 23:9-15", "Romanos 9:1-18", "João 6:60-71"
)

# ----------------------------------------------------------------------------
# 5ª SEMANA DA QUARESMA (Até Quarta)
# ----------------------------------------------------------------------------
create_daily_reading.call("5th_sunday_of_lent_monday",
  "Salmo 31", "Salmo 35",
  "Jeremias 24:1-10", "Romanos 9:19-33", "João 9:1-17"
)

create_daily_reading.call("5th_sunday_of_lent_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Jeremias 25:8-17", "Romanos 10:1-13", "João 9:18-41"
)

create_daily_reading.call("5th_sunday_of_lent_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "Jeremias 25:30-38", "Romanos 10:14-21", "João 10:1-18"
)

Rails.logger.info "✅ Leituras diárias da Quaresma (Ano Ímpar) carregadas!"
