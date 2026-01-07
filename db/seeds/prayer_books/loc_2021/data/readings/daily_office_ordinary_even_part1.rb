# ================================================================================
# LEITURAS DIÁRIAS DO TEMPO COMUM (PARTE 1) - LOC 2021 IAB (ANO PAR / A-B)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Tempo Comum (Parte 1 - Ano Par) (LOC 2021 IAB)..."

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
# PRÓPRIO 1 (Continuação) - PRÓXIMO A 11 DE MAIO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_1_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "Ezequiel 34:1-16", "1 João 2:12-17", "Mateus 10:5-15"
)

create_daily_reading.call("proper_1_thursday",
  "Salmo 131, 132, [133]", "Salmo 134, 135",
  "Ezequiel 37:21b-28", "1 João 2:18-29", "Mateus 10:16-23"
)

create_daily_reading.call("proper_1_friday",
  "Salmo 140, 142", "Salmo 141, 143:1-11(12)",
  "Ezequiel 39:21-29", "1 João 3:1-10", "Mateus 10:24-33"
)

create_daily_reading.call("proper_1_saturday",
  "Salmo 137:1-6(7-9) 144", "Salmo 104",
  "Ezequiel 47:1-12", "1 João 3:11-18", "Mateus 10:34-42"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 2 - PRÓXIMO A 18 DE MAIO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_2_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Provérbios 3:11-20", "1 João 3:18-4:6", "Mateus 11:1-6"
)

create_daily_reading.call("proper_2_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Provérbios 4:1-27", "1 João 4:7-21", "Mateus 11:7-15"
)

create_daily_reading.call("proper_2_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Provérbios 6:1-19", "1 João 5:1-12", "Mateus 11:16-24"
)

create_daily_reading.call("proper_2_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Provérbios 7:1-27", "1 João 5:13-21", "Mateus 11:25-30"
)

create_daily_reading.call("proper_2_friday",
  "Salmo 16, 17", "Salmo 22",
  "Provérbios 8:1-21", "2 João 1-13", "Mateus 12:1-14"
)

create_daily_reading.call("proper_2_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-7(6-7) 116-117",
  "Provérbios 8:22-36", "3 João 1-15", "Mateus 12:15-21"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 3 - PRÓXIMO A 25 DE MAIO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_3_monday",
  "Salmo 25", "Salmo 9, 15",
  "Provérbios 10:1-12", "1 Timóteo 1:1-17", "Mateus 12:22-32"
)

create_daily_reading.call("proper_3_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Provérbios 15:16-33", "1 Timóteo 1:18-2:8", "Mateus 12:33-42"
)

create_daily_reading.call("proper_3_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Provérbios 17:1-20", "1 Timóteo 3:1-16", "Mateus 12:43-50"
)

create_daily_reading.call("proper_3_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Provérbios 21:30-22:6", "1 Timóteo 4:1-16", "Mateus 13:1-9"
)

create_daily_reading.call("proper_3_friday",
  "Salmo 31", "Salmo 35",
  "Provérbios 23:19-21, 29-24:2", "1 Timóteo 5:17-25(23-25)", "Mateus 13:10-17"
)

create_daily_reading.call("proper_3_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Provérbios 25:15-28", "1 Timóteo 6:6-21", "Mateus 13:36-43"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 4 - PRÓXIMO A 31 DE MAIO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_4_monday",
  "Salmo 41, 52", "Salmo 44",
  "Eclesiastes 2:1-15", "Gálatas 1:1-17", "Mateus 13:44-52"
)

create_daily_reading.call("proper_4_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Eclesiastes 2:16-26", "Gálatas 1:18-2:10", "Mateus 13:53-58"
)

create_daily_reading.call("proper_4_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Eclesiastes 3:1-15", "Gálatas 2:11-21", "Mateus 14:1-12"
)

create_daily_reading.call("proper_4_thursday",
  "Salmo 50", "Salmo [59, 60]ou 8, 84",
  "Eclesiastes 3:16-4:3", "Gálatas 3:1-14", "Mateus 14:13-21"
)

create_daily_reading.call("proper_4_friday",
  "Salmo 40, 54", "Salmo 51",
  "Eclesiastes 5:1-7", "Gálatas 3:15-22", "Mateus 14:22-36"
)

create_daily_reading.call("proper_4_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Eclesiastes 5:8-20", "Gálatas 3:23-4:11", "Mateus 15:1-20"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 5 - PRÓXIMO A 8 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_5_monday",
  "Salmo 56-57, [58]", "Salmo 64, 65",
  "Eclesiastes 7:1-14", "Gálatas 4:12-20", "Mateus 15:21-28"
)

create_daily_reading.call("proper_5_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Eclesiastes 8:14-9:10", "Gálatas 4:21-31", "Mateus 15:29-39"
)

create_daily_reading.call("proper_5_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Eclesiastes 9:11-18", "Gálatas 5:1-15", "Mateus 16:1-12"
)

create_daily_reading.call("proper_5_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Eclesiastes 11:1-8", "Gálatas 5:16-24", "Mateus 16:13-20"
)

create_daily_reading.call("proper_5_friday",
  "Salmo 69:1-23[24-30]31-38", "Salmo 73",
  "Eclesiastes 11:9-12:14", "Gálatas 5:25-6:10", "Mateus 16:21-28"
)

create_daily_reading.call("proper_5_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Números 3:1-13", "Gálatas 6:11-18", "Mateus 17:1-13"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 6 - PRÓXIMO A 15 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_6_monday",
  "Salmo 80", "Salmo 77, [79]",
  "Números 9:15-23, 10:29-36", "Romanos 1:1-15", "Mateus 17:14-21"
)

create_daily_reading.call("proper_6_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "Números 11:1-23", "Romanos 1:16-25", "Mateus 17:22-27"
)

create_daily_reading.call("proper_6_wednesday",
  "Salmo 119:97-120", "Salmo 81, 82",
  "Números 11:24-35(34-35)", "Romanos 1:28-2:11", "Mateus 18:1-9"
)

create_daily_reading.call("proper_6_thursday",
  "Salmo [83]ou 34", "Salmo 85, 86",
  "Números 12:1-16", "Romanos 2:12-24", "Mateus 18:10-20"
)

create_daily_reading.call("proper_6_friday",
  "Salmo 88", "Salmo 91, 92",
  "Números 13:1-3, 21-30", "Romanos 2:25-3:8", "Mateus 18:21-35"
)

create_daily_reading.call("proper_6_saturday",
  "Salmo 87, 90", "Salmo 136",
  "Números 13:31-14:25", "Romanos 3:9-20", "Mateus 19:1-12"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 7 - PRÓXIMO A 22 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_7_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "Números 16:1-19", "Romanos 3:21-31", "Mateus 19:13-22"
)

create_daily_reading.call("proper_7_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "Números 16:20-35", "Romanos 4:1-12", "Mateus 19:23-30"
)

create_daily_reading.call("proper_7_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "Números 16:36-50", "Romanos 4:13-25", "Mateus 20:1-16"
)

create_daily_reading.call("proper_7_thursday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "Números 17:1-11", "Romanos 5:1-11", "Mateus 20:17-28"
)

create_daily_reading.call("proper_7_friday",
  "Salmo 102", "Salmo 107:1-32",
  "Números 20:1-13", "Romanos 5:12-21", "Mateus 20:29-34"
)

create_daily_reading.call("proper_7_saturday",
  "Salmo 107:33-43, 108:1-6(7-13)", "Salmo 33",
  "Números 20:14-29", "Romanos 6:1-11", "Mateus 21:1-11"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 8 - PRÓXIMO A 29 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_8_monday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "Números 22:1-21", "Romanos 6:12-23", "Mateus 21:12-22"
)

create_daily_reading.call("proper_8_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "Números 22:21-38", "Romanos 7:1-12", "Mateus 21:23-32"
)

create_daily_reading.call("proper_8_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "Números 22:41-23:12", "Romanos 7:13-25", "Mateus 21:33-46"
)

create_daily_reading.call("proper_8_thursday",
  "Salmo 131, 132, [133]", "Salmo 134, 135",
  "Números 23:11-26", "Romanos 8:1-11", "Mateus 22:1-14"
)

create_daily_reading.call("proper_8_friday",
  "Salmo 140, 142", "Salmo 141, 143:1-11(12)",
  "Números 24:1-13", "Romanos 8:12-17", "Mateus 22:15-22"
)

create_daily_reading.call("proper_8_saturday",
  "Salmo 137(7-9), 144", "Salmo 104",
  "Números 24:12-25", "Romanos 8:18-25", "Mateus 22:23-40"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 9 - PRÓXIMO A 6 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_9_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "Números 32:1-6, 16-27", "Romanos 8:26-30", "Mateus 23:1-12"
)

create_daily_reading.call("proper_9_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "Números 35:1-3, 9-15, 30-34", "Romanos 8:31-39", "Mateus 23:13-26"
)

create_daily_reading.call("proper_9_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "Deuteronômio 1:1-18", "Romanos 9:1-18", "Mateus 23:27-39"
)

create_daily_reading.call("proper_9_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "Deuteronômio 3:18-28", "Romanos 9:19-33", "Mateus 24:1-14"
)

create_daily_reading.call("proper_9_friday",
  "Salmo 16, 17", "Salmo 22",
  "Deuteronômio 31:1-13, 24-32:4", "Romanos 10:1-13", "Mateus 24:15-31"
)

create_daily_reading.call("proper_9_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "Deuteronômio 34", "Romanos 10:14-21", "Mateus 24:32-51"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 10 - PRÓXIMO A 13 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_10_monday",
  "Salmo 25", "Salmo 9, 15",
  "Josué 2:1-14", "Romanos 11:1-12", "Mateus 25:1-13"
)

create_daily_reading.call("proper_10_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "Josué 2:15-24", "Romanos 11:13-24", "Mateus 25:14-30"
)

create_daily_reading.call("proper_10_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Josué 3:1-13", "Romanos 11:25-36", "Mateus 25:31-46"
)

create_daily_reading.call("proper_10_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Josué 3:14-4:7", "Romanos 12:1-8", "Mateus 26:1-16"
)

create_daily_reading.call("proper_10_friday",
  "Salmo 31", "Salmo 35",
  "Josué 4:19-5:1, 10-15", "Romanos 12:9-21", "Mateus 26:17-25"
)

create_daily_reading.call("proper_10_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Josué 6:1-14", "Romanos 13:1-7", "Mateus 26:26-35"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 11 - PRÓXIMO A 20 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_11_monday",
  "Salmo 41, 52", "Salmo 44",
  "Josué 7:1-13", "Romanos 13:8-14", "Mateus 26:36-46"
)

create_daily_reading.call("proper_11_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Josué 8:1-22", "Romanos 14:1-12", "Mateus 26:47-56"
)

create_daily_reading.call("proper_11_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Josué 8:30-35", "Romanos 14:13-23", "Mateus 26:57-68"
)

create_daily_reading.call("proper_11_thursday",
  "Salmo 50", "Salmo [59, 60]ou 66, 67",
  "Josué 9:3-21", "Romanos 15:1-13", "Mateus 26:69-75"
)

create_daily_reading.call("proper_11_friday",
  "Salmo 40, 54", "Salmo 51",
  "Josué 9:22-10:15", "Romanos 15:14-24", "Mateus 27:1-10"
)

create_daily_reading.call("proper_11_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Josué 23:1-16", "Romanos 15:25-33", "Mateus 27:11-23"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 12 - PRÓXIMO A 27 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_12_monday",
  "Salmo 56-57, [58]", "Salmo 64, 65",
  "Josué 24:16-33", "Romanos 16:1-16", "Mateus 27:24-31"
)

create_daily_reading.call("proper_12_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Juízes 2:1-5, 11-23", "Romanos 16:17-27", "Mateus 27:32-44"
)

create_daily_reading.call("proper_12_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Juízes 3:12-30", "Atos 1:1-14", "Mateus 27:45-54"
)

create_daily_reading.call("proper_12_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Juízes 4:4-23", "Atos 1:15-26", "Mateus 27:55-66"
)

create_daily_reading.call("proper_12_friday",
  "Salmo 69:1-23[24-30]31-38", "Salmo 73",
  "Juízes 5:1-18", "Atos 2:1-21", "Mateus 28:1-10"
)

create_daily_reading.call("proper_12_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Juízes 5:19-31", "Atos 2:22-36", "Mateus 28:11-20"
)

Rails.logger.info "✅ Leituras diárias do Tempo Comum (Parte 1 - Ano Par) carregadas!"
