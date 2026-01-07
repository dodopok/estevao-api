# ================================================================================
# LEITURAS DIÁRIAS DO TEMPO COMUM (PARTE 1) - LOC 2021 IAB (ANO ÍMPAR / C)
# ================================================================================

Rails.logger.info "📖 Carregando leituras diárias do Tempo Comum (Parte 1) (LOC 2021 IAB)..."

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
# PRÓPRIO 3 - PRÓXIMO A 25 DE MAIO (Continuação)
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_3_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "Deuteronômio 4:25-31", "2 Coríntios 1:23-2:17", "Lucas 15:1-2, 11-32"
)

create_daily_reading.call("proper_3_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "Deuteronômio 4:32-40", "2 Coríntios 3:1-18", "Lucas 16:1-9"
)

create_daily_reading.call("proper_3_friday",
  "Salmo 31", "Salmo 35",
  "Deuteronômio 5:1-22", "2 Coríntios 4:1-12", "Lucas 16:10-17(18)"
)

create_daily_reading.call("proper_3_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "Deuteronômio 5:22-33", "2 Coríntios 4:13-5:10", "Lucas 16:19-31"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 4 - PRÓXIMO A 31 DE MAIO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_4_monday",
  "Salmo 41, 52", "Salmo 44",
  "Deuteronômio 11:13-19", "2 Coríntios 5:11-6:2", "Lucas 17:1-10"
)

create_daily_reading.call("proper_4_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "Deuteronômio 12:1-12", "2 Coríntios 6:3-13(14-7:1)", "Lucas 17:11-19"
)

create_daily_reading.call("proper_4_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "Deuteronômio 13:1-11", "2 Coríntios 7:2-16", "Lucas 17:20-37"
)

create_daily_reading.call("proper_4_thursday",
  "Salmo 50", "Salmo [59, 60] ou 8, 84",
  "Deuteronômio 16:18-20, 17:14-20", "2 Coríntios 8:1-16", "Lucas 18:1-8"
)

create_daily_reading.call("proper_4_friday",
  "Salmo 40, 54", "Salmo 51",
  "Deuteronômio 26:1-11", "2 Coríntios 8:16-24", "Lucas 18:9-14"
)

create_daily_reading.call("proper_4_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "Deuteronômio 29:2-15", "2 Coríntios 9:1-15", "Lucas 18:15-30"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 5 - PRÓXIMO A 8 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_5_monday",
  "Salmo 56, 57, [58]", "Salmo 64, 65",
  "Deuteronômio 30:1-10", "2 Coríntios 10:1-18", "Lucas 18:31-43"
)

create_daily_reading.call("proper_5_tuesday",
  "Salmo 61, 62", "Salmo 68:1-20(21-23)24-36",
  "Deuteronômio 30:11-20", "2 Coríntios 11:1-21a", "Lucas 19:1-10"
)

create_daily_reading.call("proper_5_wednesday",
  "Salmo 72", "Salmo 119:73-96",
  "Deuteronômio 31:30-32:14", "2 Coríntios 11:21b-33", "Lucas 19:11-27"
)

create_daily_reading.call("proper_5_thursday",
  "Salmo [70], 71", "Salmo 74",
  "Gênesis 5:21-24", "2 Coríntios 12:1-10", "Lucas 19:28-40"
)

create_daily_reading.call("proper_5_friday",
  "Salmo 69:1-23[24-30]31-38", "Salmo 73",
  "Josué 1:1-9", "2 Coríntios 12:11-21", "Lucas 19:41-48"
)

create_daily_reading.call("proper_5_saturday",
  "Salmo 75, 76", "Salmo 23, 27",
  "Números 13:17-33", "2 Coríntios 13:1-14", "Lucas 20:1-8"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 6 - PRÓXIMO A 15 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_6_monday",
  "Salmo 80", "Salmo 77, [79]",
  "1 Samuel 1:1-20", "Atos 1:1-14", "Lucas 20:9-19"
)

create_daily_reading.call("proper_6_tuesday",
  "Salmo 78:1-39", "Salmo 78:40-72",
  "1 Samuel 1:21-2:11", "Atos 1:15-26", "Lucas 20:19-26"
)

create_daily_reading.call("proper_6_wednesday",
  "Salmo 119:97-120", "Salmo 81, 82",
  "1 Samuel 2:12-26", "Atos 2:1-21", "Lucas 20:27-40"
)

create_daily_reading.call("proper_6_thursday",
  "Salmo [83] ou 34", "Salmo 85, 86",
  "1 Samuel 2:27-36", "Atos 2:22-36", "Lucas 20:41-21:4"
)

create_daily_reading.call("proper_6_friday",
  "Salmo 88", "Salmo 91, 92",
  "1 Samuel 3:1-21", "Atos 2:37-47", "Lucas 21:5-19"
)

create_daily_reading.call("proper_6_saturday",
  "Salmo 87, 90", "Salmo 136",
  "1 Samuel 4:1b-11", "Atos 4:32-5:11", "Lucas 21:20-28"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 7 - PRÓXIMO A 22 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_7_monday",
  "Salmo 89:1-18", "Salmo 89:19-52",
  "1 Samuel 5:1-12", "Atos 5:12-26", "Lucas 21:29-36"
)

create_daily_reading.call("proper_7_tuesday",
  "Salmo 97, 99, [100]", "Salmo 94, [95]",
  "1 Samuel 6:1-16", "Atos 5:27-42", "Lucas 21:37-22:13"
)

create_daily_reading.call("proper_7_wednesday",
  "Salmo 101, 109:1-4(5-19)20-30", "Salmo 119:121-144",
  "1 Samuel 7:2-17", "Atos 6:1-15", "Lucas 22:14-23"
)

create_daily_reading.call("proper_7_thursday",
  "Salmo 105:1-22", "Salmo 105:23-45",
  "1 Samuel 8:1-22", "Atos 6:15-7:16", "Lucas 22:24-30"
)

create_daily_reading.call("proper_7_friday",
  "Salmo 102", "Salmo 107:1-32",
  "1 Samuel 9:1-14", "Atos 7:17-29", "Lucas 22:31-38"
)

create_daily_reading.call("proper_7_saturday",
  "Salmo 33", "Salmo 107:33-43, 108:1-6(7-13)",
  "1 Samuel 9:15-10:1", "Atos 7:30-43", "Lucas 22:39-51"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 8 - PRÓXIMO A 29 DE JUNHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_8_monday",
  "Salmo 106:1-18", "Salmo 106:19-48",
  "1 Samuel 10:17-27", "Atos 7:44-8:1a", "Lucas 22:52-62"
)

create_daily_reading.call("proper_8_tuesday",
  "Salmo [120], 121, 122, 123", "Salmo 124, 125, 126, [127]",
  "1 Samuel 11:1-15", "Atos 8:1-13", "Lucas 22:63-71"
)

create_daily_reading.call("proper_8_wednesday",
  "Salmo 119:145-176", "Salmo 128, 129, 130",
  "1 Samuel 12:1-6, 16-25", "Atos 8:14-25", "Lucas 23:1-12"
)

create_daily_reading.call("proper_8_thursday",
  "Salmo 131, 132, [133]", "Salmo 134, 135",
  "1 Samuel 13:5-18", "Atos 8:26-40", "Lucas 23:13-25"
)

create_daily_reading.call("proper_8_friday",
  "Salmo 140, 142", "Salmo 141, 143:1-11(12)",
  "1 Samuel 13:19-14:15", "Atos 9:1-9", "Lucas 23:26-31"
)

create_daily_reading.call("proper_8_saturday",
  "Salmo 137:1-6(7-9), 144", "Salmo 104",
  "1 Samuel 14:16-30", "Atos 9:10-19a", "Lucas 23:32-43"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 9 - PRÓXIMO A 6 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_9_monday",
  "Salmo 1, 2, 3", "Salmo 4, 7",
  "1 Samuel 15:1-3, 7-23", "Atos 9:19b-31", "Lucas 23:44-56a"
)

create_daily_reading.call("proper_9_tuesday",
  "Salmo 5, 6", "Salmo 10, 11",
  "1 Samuel 15:24-35", "Atos 9:32-43", "Lucas 23:56b-24:11"
)

create_daily_reading.call("proper_9_wednesday",
  "Salmo 119:1-24", "Salmo 12, 13, 14",
  "1 Samuel 16:1-13", "Atos 10:1-16", "Lucas 24:12-35"
)

create_daily_reading.call("proper_9_thursday",
  "Salmo 18:1-20", "Salmo 18:21-50",
  "1 Samuel 16:14-17:11", "Atos 10:17-33", "Lucas 24:36-53"
)

create_daily_reading.call("proper_9_friday",
  "Salmo 16, 17", "Salmo 22",
  "1 Samuel 17:17-30", "Atos 10:34-48", "Marcos 1:1-13"
)

create_daily_reading.call("proper_9_saturday",
  "Salmo 20, 21:1-7(8-14)", "Salmo 110:1-5(6-7), 116, 117",
  "1 Samuel 17:31-49", "Atos 11:1-18", "Marcos 1:14-28"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 10 - PRÓXIMO A 13 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_10_monday",
  "Salmo 25", "Salmo 9, 15",
  "1 Samuel 18:5-16, 27b-30", "Atos 11:19-30", "Marcos 1:29-45"
)

create_daily_reading.call("proper_10_tuesday",
  "Salmo 26, 28", "Salmo 36, 39",
  "1 Samuel 19:1-18", "Atos 12:1-17", "Marcos 2:1-12"
)

create_daily_reading.call("proper_10_wednesday",
  "Salmo 38", "Salmo 119:25-48",
  "1 Samuel 20:1-23", "Atos 12:18-25", "Marcos 2:13-22"
)

create_daily_reading.call("proper_10_thursday",
  "Salmo 37:1-18", "Salmo 37:19-42",
  "1 Samuel 20:24-42", "Atos 13:1-12", "Marcos 2:23-3:6"
)

create_daily_reading.call("proper_10_friday",
  "Salmo 31", "Salmo 35",
  "1 Samuel 21:1-15", "Atos 13:13-25", "Marcos 3:7-19a"
)

create_daily_reading.call("proper_10_saturday",
  "Salmo 30, 32", "Salmo 42, 43",
  "1 Samuel 22:1-23", "Atos 13:26-43", "Marcos 3:19b-35"
)

# ----------------------------------------------------------------------------
# PRÓPRIO 11 - PRÓXIMO A 20 DE JULHO
# ----------------------------------------------------------------------------
create_daily_reading.call("proper_11_monday",
  "Salmo 41, 52", "Salmo 44",
  "1 Samuel 24:1-22", "Atos 13:44-52", "Marcos 4:1-20"
)

create_daily_reading.call("proper_11_tuesday",
  "Salmo 45", "Salmo 47, 48",
  "1 Samuel 25:1-22", "Atos 14:1-18", "Marcos 4:21-34"
)

create_daily_reading.call("proper_11_wednesday",
  "Salmo 119:49-72", "Salmo 49, [53]",
  "1 Samuel 25:23-44", "Atos 14:19-28", "Marcos 4:35-41"
)

create_daily_reading.call("proper_11_thursday",
  "Salmo 50", "Salmo [59, 60] ou 66, 67",
  "1 Samuel 28:3-20", "Atos 15:1-11", "Marcos 5:1-20"
)

create_daily_reading.call("proper_11_friday",
  "Salmo 40, 54", "Salmo 51",
  "1 Samuel 31:1-13", "Atos 15:12-21", "Marcos 5:21-43"
)

create_daily_reading.call("proper_11_saturday",
  "Salmo 55", "Salmo 138, 139:1-17(18-23)",
  "2 Samuel 1:1-16", "Atos 15:22-35", "Marcos 6:1-13"
)

Rails.logger.info "✅ Leituras diárias do Tempo Comum (Parte 1) carregadas!"