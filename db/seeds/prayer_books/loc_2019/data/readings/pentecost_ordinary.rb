# ================================================================================
# LEITURAS DE PENTECOSTES E TEMPO COMUM - LOC 2019
# ================================================================================

Rails.logger.info "📖 Carregando leituras de Pentecostes e Tempo Comum for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

ordinary_readings = [
  # --- PENTECOST ---
  { date_reference: "pentecost", cycle: "A", service_type: "eucharist", first_reading: "Gênesis 11:1-9 ou Atos 2:1-11(12-21)", psalm: "Salmo 104:24-35", second_reading: "Atos 2:1-11(12-21) ou 1 Coríntios 12:4-13", gospel: "João 14:8-17" },
  { date_reference: "pentecost", cycle: "B", service_type: "eucharist", first_reading: "Gênesis 11:1-9 ou Atos 2:1-11(12-21)", psalm: "Salmo 104:24-35", second_reading: "Atos 2:1-11(12-21) ou 1 Coríntios 12:4-13", gospel: "João 14:8-17" },
  { date_reference: "pentecost", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 11:1-9 ou Atos 2:1-11(12-21)", psalm: "Salmo 104:24-35", second_reading: "Atos 2:1-11(12-21) ou 1 Coríntios 12:4-13", gospel: "João 14:8-17" },

  # --- TRINITY SUNDAY ---
  { date_reference: "trinity_sunday", cycle: "A", service_type: "eucharist", first_reading: "Gênesis 1:1-2:3", psalm: "Salmo 150", second_reading: "2 Coríntios 13:5-14", gospel: "Mateus 28:16-20" },
  { date_reference: "trinity_sunday", cycle: "B", service_type: "eucharist", first_reading: "Êxodo 3:1-6", psalm: "Salmo 93", second_reading: "Romanos 8:12-17", gospel: "João 3:1-16" },
  { date_reference: "trinity_sunday", cycle: "C", service_type: "eucharist", first_reading: "Isaías 6:1-7", psalm: "Salmo 29", second_reading: "Apocalipse 4:1-11", gospel: "João 16:(5-11)12-15" },

  # --- PROPER 1 ---
  { date_reference: "proper_1", cycle: "A", service_type: "eucharist", first_reading: "Eclesiástico 15:11-20", psalm: "Salmo 119:1-16", second_reading: "1 Coríntios 3:1-9", gospel: "Mateus 5:21-37" },
  { date_reference: "proper_1", cycle: "B", service_type: "eucharist", first_reading: "2 Reis 5:1-15a", psalm: "Salmo 42", second_reading: "1 Coríntios 9:24-27", gospel: "Marcos 1:40-45" },
  { date_reference: "proper_1", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 17:5-10", psalm: "Salmo 1", second_reading: "1 Coríntios 15:12-20", gospel: "Lucas 6:17-26" },

  # --- PROPER 2 ---
  { date_reference: "proper_2", cycle: "A", service_type: "eucharist", first_reading: "Levítico 19:1-2, 9-18", psalm: "Salmo 71 ou 71:11-23", second_reading: "1 Coríntios 3:10-23", gospel: "Mateus 5:38-48" },
  { date_reference: "proper_2", cycle: "B", service_type: "eucharist", first_reading: "Isaías 43:18-25", psalm: "Salmo 32", second_reading: "2 Coríntios 1:18-22", gospel: "Marcos 2:1-12" },
  { date_reference: "proper_2", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 45:3-11, 21-28", psalm: "Salmo 37:(1-7)8-17", second_reading: "1 Coríntios 15:35-49", gospel: "Lucas 6:27-38" },

  # --- PROPER 3 ---
  { date_reference: "proper_3", cycle: "A", service_type: "eucharist", first_reading: "Isaías 49:8-18(19-23)", psalm: "Salmo 62", second_reading: "1 Coríntios 4:1-13", gospel: "Mateus 6:24-34" },
  { date_reference: "proper_3", cycle: "B", service_type: "eucharist", first_reading: "Oséias 2:14-23", psalm: "Salmo 103 ou 103:1-14", second_reading: "2 Coríntios 3:4-18", gospel: "Marcos 2:18-22" },
  { date_reference: "proper_3", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 7:1-15", psalm: "Salmo 92", second_reading: "1 Coríntios 15:50-58", gospel: "Lucas 6:39-49" },

  # --- PROPER 4 ---
  { date_reference: "proper_4", cycle: "A", service_type: "eucharist", first_reading: "Deuteronômio 11:18-32", psalm: "Salmo 31 ou 31:18-27", second_reading: "Romanos 3:21-31", gospel: "Mateus 7:21-27" },
  { date_reference: "proper_4", cycle: "B", service_type: "eucharist", first_reading: "Deuteronômio 5:6-21", psalm: "Salmo 81:1-10(11-16)", second_reading: "2 Coríntios 4:1-12", gospel: "Marcos 2:23-28" },
  { date_reference: "proper_4", cycle: "C", service_type: "eucharist", first_reading: "1 Reis 8:22-30, 41-43", psalm: "Salmo 96", second_reading: "Gálatas 1:1-10", gospel: "Lucas 7:1-10" },

  # --- PROPER 5 ---
  { date_reference: "proper_5", cycle: "A", service_type: "eucharist", first_reading: "Oséias 5:15-6:6", psalm: "Salmo 50", second_reading: "Romanos 4:13-18", gospel: "Mateus 9:9-13" },
  { date_reference: "proper_5", cycle: "B", service_type: "eucharist", first_reading: "Gênesis 3:1-21", psalm: "Salmo 130", second_reading: "2 Coríntios 4:13-18", gospel: "Marcos 3:20-35" },
  { date_reference: "proper_5", cycle: "C", service_type: "eucharist", first_reading: "1 Reis 17:17-24", psalm: "Salmo 30", second_reading: "Gálatas 1:11-24", gospel: "Lucas 7:11-17" },

  # --- PROPER 6 ---
  { date_reference: "proper_6", cycle: "A", service_type: "eucharist", first_reading: "Êxodo 19:1-8", psalm: "Salmo 100", second_reading: "Romanos 5:1-11", gospel: "Mateus 9:35-10:15" },
  { date_reference: "proper_6", cycle: "B", service_type: "eucharist", first_reading: "Ezequiel 31:1-6(7-9)10-14", psalm: "Salmo 92", second_reading: "2 Coríntios 5:1-10", gospel: "Marcos 4:26-34" },
  { date_reference: "proper_6", cycle: "C", service_type: "eucharist", first_reading: "2 Samuel 11:26-12:15", psalm: "Salmo 32:1-6(7-12)", second_reading: "Gálatas 2:11-21", gospel: "Lucas 7:36-8:3" },

  # --- PROPER 7 ---
  { date_reference: "proper_7", cycle: "A", service_type: "eucharist", first_reading: "Jeremias 20:7-13", psalm: "Salmo 69:1-15(16-18)", second_reading: "Romanos 5:15b-19", gospel: "Mateus 10:16-33" },
  { date_reference: "proper_7", cycle: "B", service_type: "eucharist", first_reading: "Jó 38:1-11(12-15)16-18", psalm: "Salmo 107:1-3(4-22)23-32", second_reading: "2 Coríntios 5:14-21", gospel: "Marcos 4:35-41(5:1-20)" },
  { date_reference: "proper_7", cycle: "C", service_type: "eucharist", first_reading: "Zacarias 12:8-10, 13:1", psalm: "Salmo 63", second_reading: "Gálatas 3:23-29", gospel: "Lucas 9:18-24" },

  # --- PROPER 8 ---
  { date_reference: "proper_8", cycle: "A", service_type: "eucharist", first_reading: "Isaías 2:10-17", psalm: "Salmo 89:1-18", second_reading: "Romanos 6:1-11", gospel: "Mateus 10:34-42" },
  { date_reference: "proper_8", cycle: "B", service_type: "eucharist", first_reading: "Deuteronômio 15:7-11", psalm: "Salmo 112", second_reading: "2 Coríntios 8:1-15", gospel: "Marcos 5:22-43" },
  { date_reference: "proper_8", cycle: "C", service_type: "eucharist", first_reading: "1 Reis 19:15-21", psalm: "Salmo 16", second_reading: "Gálatas 5:1, 13-25", gospel: "Lucas 9:51-62" },

  # --- PROPER 9 ---
  { date_reference: "proper_9", cycle: "A", service_type: "eucharist", first_reading: "Zacarias 9:9-12", psalm: "Salmo 145:1-13(14-21)", second_reading: "Romanos 7:21-8:6", gospel: "Mateus 11:25-30" },
  { date_reference: "proper_9", cycle: "B", service_type: "eucharist", first_reading: "Ezequiel 2:1-7", psalm: "Salmo 123", second_reading: "2 Coríntios 12:2-10", gospel: "Marcos 6:1-6" },
  { date_reference: "proper_9", cycle: "C", service_type: "eucharist", first_reading: "Isaías 66:10-16", psalm: "Salmo 66 ou 66:1-8", second_reading: "Gálatas 6:(1-5)6-18", gospel: "Lucas 10:1-20" },

  # --- PROPER 10 ---
  { date_reference: "proper_10", cycle: "A", service_type: "eucharist", first_reading: "Isaías 55", psalm: "Salmo 65", second_reading: "Romanos 8:7-17", gospel: "Mateus 13:1-9, 18-23" },
  { date_reference: "proper_10", cycle: "B", service_type: "eucharist", first_reading: "Amós 7:7-15", psalm: "Salmo 85", second_reading: "Efésios 1:1-14(15-23)", gospel: "Marcos 6:7-13" },
  { date_reference: "proper_10", cycle: "C", service_type: "eucharist", first_reading: "Deuteronômio 30:9-14", psalm: "Salmo 25:1-14(15-21)", second_reading: "Colossenses 1:1-14", gospel: "Lucas 10:25-37" },

  # --- PROPER 11 ---
  { date_reference: "proper_11", cycle: "A", service_type: "eucharist", first_reading: "Sabedoria 12:13, 16-19", psalm: "Salmo 86", second_reading: "Romanos 8:18-25", gospel: "Mateus 13:24-30, 34-43" },
  { date_reference: "proper_11", cycle: "B", service_type: "eucharist", first_reading: "Isaías 57:14-21", psalm: "Salmo 22:23-31", second_reading: "Efésios 2:11-22", gospel: "Marcos 6:30-44" },
  { date_reference: "proper_11", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 18:1-14", psalm: "Salmo 15", second_reading: "Colossenses 1:21-29", gospel: "Lucas 10:38-42" },

  # --- PROPER 12 ---
  { date_reference: "proper_12", cycle: "A", service_type: "eucharist", first_reading: "1 Reis 3:3-14", psalm: "Salmo 119:121-136", second_reading: "Romanos 8:26-34", gospel: "Mateus 13:31-33, 44-50" },
  { date_reference: "proper_12", cycle: "B", service_type: "eucharist", first_reading: "2 Reis 2:1-15", psalm: "Salmo 114", second_reading: "Efésios 3:(1-7)8-21", gospel: "Marcos 6:45-52" },
  { date_reference: "proper_12", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 18:20-33", psalm: "Salmo 138", second_reading: "Colossenses 2:6-15", gospel: "Lucas 11:1-13" },

  # --- PROPER 13 ---
  { date_reference: "proper_13", cycle: "A", service_type: "eucharist", first_reading: "Neemias 9:16-21", psalm: "Salmo 78:(1-13)14-26", second_reading: "Romanos 8:35-39", gospel: "Mateus 14:13-21" },
  { date_reference: "proper_13", cycle: "B", service_type: "eucharist", first_reading: "Êxodo 16:2-4(5-8)9-15", psalm: "Salmo 78:(1-13)14-26", second_reading: "Efésios 4:1-16", gospel: "João 6:24-35" },
  { date_reference: "proper_13", cycle: "C", service_type: "eucharist", first_reading: "Eclesiastes 1:12-2:11", psalm: "Salmo 49:1-12(13-21)", second_reading: "Colossenses 3:5-17", gospel: "Lucas 12:13-21" },

  # --- PROPER 14 ---
  { date_reference: "proper_14", cycle: "A", service_type: "eucharist", first_reading: "Jonas 2:1-10", psalm: "Salmo 29", second_reading: "Romanos 9:1-5", gospel: "Mateus 14:22-33" },
  { date_reference: "proper_14", cycle: "B", service_type: "eucharist", first_reading: "Deuteronômio 8:1-10", psalm: "Salmo 34:(1-7)8-15(16-22)", second_reading: "Efésios 4:17-5:2", gospel: "João 6:37-51" },
  { date_reference: "proper_14", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 15:1-6", psalm: "Salmo 33(1-9)10-21", second_reading: "Hebreus 11:1-16", gospel: "Lucas 12:32-40" },

  # --- PROPER 15 ---
  { date_reference: "proper_15", cycle: "A", service_type: "eucharist", first_reading: "Isaías 56:1-8", psalm: "Salmo 67", second_reading: "Romanos 11:13-24", gospel: "Mateus 15:21-28" },
  { date_reference: "proper_15", cycle: "B", service_type: "eucharist", first_reading: "Provérbios 9:1-6", psalm: "Salmo 147", second_reading: "Efésios 5:3-14", gospel: "João 6:53-59" },
  { date_reference: "proper_15", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 23:23-29", psalm: "Salmo 82", second_reading: "Hebreus 12:1-14", gospel: "Lucas 12:49-56" },

  # --- PROPER 16 ---
  { date_reference: "proper_16", cycle: "A", service_type: "eucharist", first_reading: "Isaías 51:1-6", psalm: "Salmo 138", second_reading: "Romanos 11:25-36", gospel: "Mateus 16:13-20" },
  { date_reference: "proper_16", cycle: "B", service_type: "eucharist", first_reading: "Josué 24:1-22, 14-25", psalm: "Salmo 16", second_reading: "Efésios 5:15-33(6:1-9)", gospel: "João 6:60-69" },
  { date_reference: "proper_16", cycle: "C", service_type: "eucharist", first_reading: "Isaías 28:14-22", psalm: "Salmo 46", second_reading: "Hebreus 12:(15-17)18-29", gospel: "Lucas 13:22-30" },

  # --- PROPER 17 ---
  { date_reference: "proper_17", cycle: "A", service_type: "eucharist", first_reading: "Jeremias 15:15-21", psalm: "Salmo 26", second_reading: "Romanos 12:1-8", gospel: "Mateus 16:21-27" },
  { date_reference: "proper_17", cycle: "B", service_type: "eucharist", first_reading: "Deuteronômio 4:1-9", psalm: "Salmo 15", second_reading: "Efésios 6:10-20", gospel: "Marcos 7:1-23" },
  { date_reference: "proper_17", cycle: "C", service_type: "eucharist", first_reading: "Eclesiástico 10:7-18", psalm: "Salmo 112", second_reading: "Hebreus 13:1-8", gospel: "Lucas 14:1, 7-14" },

  # --- PROPER 18 ---
  { date_reference: "proper_18", cycle: "A", service_type: "eucharist", first_reading: "Ezequiel 33:1-11", psalm: "Salmo 119:33-48", second_reading: "Romanos 12:9-21", gospel: "Mateus 18:15-20" },
  { date_reference: "proper_18", cycle: "B", service_type: "eucharist", first_reading: "Isaías 35:4-7a", psalm: "Salmo 146", second_reading: "Tiago 1:17-27", gospel: "Marcos 7:31-37" },
  { date_reference: "proper_18", cycle: "C", service_type: "eucharist", first_reading: "Deuteronômio 30:15-20", psalm: "Salmo 1", second_reading: "Filemom (1-3)4-21(22-25)", gospel: "Lucas 14:25-33" },

  # --- PROPER 19 ---
  { date_reference: "proper_19", cycle: "A", service_type: "eucharist", first_reading: "Eclesiástico 27:30-28:7", psalm: "Salmo 103 ou 103:1-14", second_reading: "Romanos 14:5-12", gospel: "Mateus 18:21-35" },
  { date_reference: "proper_19", cycle: "B", service_type: "eucharist", first_reading: "Isaías 50:4-9", psalm: "Salmo 116:1-9(10-16)", second_reading: "Tiago 2:1-18", gospel: "Marcos 9:14-29" },
  { date_reference: "proper_19", cycle: "C", service_type: "eucharist", first_reading: "Êxodo 32:1, 7-14", psalm: "Salmo 51:1-17", second_reading: "1 Timóteo 1:12-17", gospel: "Lucas 15:1-10" },

  # --- PROPER 20 ---
  { date_reference: "proper_20", cycle: "A", service_type: "eucharist", first_reading: "Jonas 3:10-4:11", psalm: "Salmo 145:(1-13)14-21", second_reading: "Filipenses 1:21-27", gospel: "Mateus 20:1-16" },
  { date_reference: "proper_20", cycle: "B", service_type: "eucharist", first_reading: "Sabedoria 1:16-2:1, 12-22", psalm: "Salmo 54", second_reading: "Tiago 3:16-4:6", gospel: "Marcos 9:30-37" },
  { date_reference: "proper_20", cycle: "C", service_type: "eucharist", first_reading: "Amós 8:4-12", psalm: "Salmo 138", second_reading: "1 Timóteo 2:1-7(8-15)", gospel: "Lucas 16:1-13" },

  # --- PROPER 21 ---
  { date_reference: "proper_21", cycle: "A", service_type: "eucharist", first_reading: "Ezequiel 18:1-4, 25-32", psalm: "Salmo 25:1-14(15-21)", second_reading: "Filipenses 2:1-13", gospel: "Mateus 21:28-32" },
  { date_reference: "proper_21", cycle: "B", service_type: "eucharist", first_reading: "Números 11:4-6, 10-17, 24-29", psalm: "Salmo 19:(1-6)7-14", second_reading: "Tiago 4:7-12(13-5:6)", gospel: "Marcos 9:38-48" },
  { date_reference: "proper_21", cycle: "C", service_type: "eucharist", first_reading: "Amós 6:1-7", psalm: "Salmo 146", second_reading: "1 Timóteo 6:11-19", gospel: "Lucas 16:19-31" },

  # --- PROPER 22 ---
  { date_reference: "proper_22", cycle: "A", service_type: "eucharist", first_reading: "Isaías 5:1-7", psalm: "Salmo 80:(1-6)7-19", second_reading: "Filipenses 3:14-21", gospel: "Mateus 21:33-44" },
  { date_reference: "proper_22", cycle: "B", service_type: "eucharist", first_reading: "Gênesis 2:18-24", psalm: "Salmo 8", second_reading: "Hebreus 2:(1-8)9-18", gospel: "Marcos 10:2-16" },
  { date_reference: "proper_22", cycle: "C", service_type: "eucharist", first_reading: "Habacuque 1:1-13, 2:1-4", psalm: "Salmo 37:1-17", second_reading: "2 Timóteo 1:1-14", gospel: "Lucas 17:5-10" },

  # --- PROPER 23 ---
  { date_reference: "proper_23", cycle: "A", service_type: "eucharist", first_reading: "Isaías 25:1-9", psalm: "Salmo 23", second_reading: "Filipenses 4:4-13", gospel: "Mateus 22:1-14" },
  { date_reference: "proper_23", cycle: "B", service_type: "eucharist", first_reading: "Amós 5:6-15", psalm: "Salmo 90:1-12(13-17)", second_reading: "Hebreus 3:1-6", gospel: "Marcos 10:17-31" },
  { date_reference: "proper_23", cycle: "C", service_type: "eucharist", first_reading: "Rute 1:1-19a", psalm: "Salmo 113", second_reading: "2 Timóteo 2:1-15", gospel: "Lucas 17:11-19" },

  # --- PROPER 24 ---
  { date_reference: "proper_24", cycle: "A", service_type: "eucharist", first_reading: "Malaquias 3:6-12", psalm: "Salmo 96", second_reading: "1 Tessalonicenses 1:1-10", gospel: "Mateus 22:15-22" },
  { date_reference: "proper_24", cycle: "B", service_type: "eucharist", first_reading: "Isaías 53:4-12", psalm: "Salmo 91", second_reading: "Hebreus 4:12-16", gospel: "Marcos 10:35-45" },
  { date_reference: "proper_24", cycle: "C", service_type: "eucharist", first_reading: "Gênesis 32:3-8, 22-30", psalm: "Salmo 121", second_reading: "2 Timóteo 3:14-4:5", gospel: "Lucas 18:1-8" },

  # --- PROPER 25 ---
  { date_reference: "proper_25", cycle: "A", service_type: "eucharist", first_reading: "Êxodo 22:21-27", psalm: "Salmo 1", second_reading: "1 Tessalonicenses 2:1-8", gospel: "Mateus 22:34-46" },
  { date_reference: "proper_25", cycle: "B", service_type: "eucharist", first_reading: "Isaías 59:9-20", psalm: "Salmo 13", second_reading: "Hebreus 5:11-6:12", gospel: "Marcos 10:46-52" },
  { date_reference: "proper_25", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 14:(1-6)7-10, 19-22", psalm: "Salmo 84", second_reading: "2 Timóteo 4:6-18", gospel: "Lucas 18:9-14" },

  # --- PROPER 26 ---
  { date_reference: "proper_26", cycle: "A", service_type: "eucharist", first_reading: "Miquéias 3:5-12", psalm: "Salmo 43", second_reading: "1 Tessalonicenses 2:9-20", gospel: "Mateus 23:1-12" },
  { date_reference: "proper_26", cycle: "B", service_type: "eucharist", first_reading: "Deuteronômio 6:1-9", psalm: "Salmo 119:1-16", second_reading: "Hebreus 7:23-28", gospel: "Marcos 12:28-34" },
  { date_reference: "proper_26", cycle: "C", service_type: "eucharist", first_reading: "Isaías 1:10-20", psalm: "Salmo 32", second_reading: "2 Tessalonicenses 1:1-12", gospel: "Lucas 19:1-10" },

  # --- PROPER 27 ---
  { date_reference: "proper_27", cycle: "A", service_type: "eucharist", first_reading: "Amós 5:18-24", psalm: "Salmo 70", second_reading: "1 Tessalonicenses 4:13-18", gospel: "Mateus 25:1-13" },
  { date_reference: "proper_27", cycle: "B", service_type: "eucharist", first_reading: "1 Reis 17:8-16", psalm: "Salmo 146", second_reading: "Hebreus 9:24-28", gospel: "Marcos 12:38-44" },
  { date_reference: "proper_27", cycle: "C", service_type: "eucharist", first_reading: "Jó 19:23-27a", psalm: "Salmo 17", second_reading: "2 Tessalonicenses 2:13-3:5", gospel: "Lucas 20:27-38" },

  # --- PROPER 28 ---
  { date_reference: "proper_28", cycle: "A", service_type: "eucharist", first_reading: "Sofonias 1:7, 12-18", psalm: "Salmo 90:1-12(13-17)", second_reading: "1 Tessalonicenses 5:1-10", gospel: "Mateus 25:14-30" },
  { date_reference: "proper_28", cycle: "B", service_type: "eucharist", first_reading: "Daniel 12:1-4a(4b-13)", psalm: "Salmo 16", second_reading: "Hebreus 10:31-39", gospel: "Marcos 13:14-23" },
  { date_reference: "proper_28", cycle: "C", service_type: "eucharist", first_reading: "Malaquias 3:13-4:6", psalm: "Salmo 98", second_reading: "2 Tessalonicenses 3:6-16", gospel: "Lucas 21:5-19" },

  # --- PROPER 29 (CHRIST THE KING) ---
  { date_reference: "christ_the_king", cycle: "A", service_type: "eucharist", first_reading: "Ezequiel 34:11-20", psalm: "Salmo 95", second_reading: "1 Coríntios 15:20-28", gospel: "Mateus 25:31-46" },
  { date_reference: "christ_the_king", cycle: "B", service_type: "eucharist", first_reading: "Daniel 7:9-14", psalm: "Salmo 93", second_reading: "Apocalipse 1:1-8", gospel: "João 18:33-37" },
  { date_reference: "christ_the_king", cycle: "C", service_type: "eucharist", first_reading: "Jeremias 23:1-6", psalm: "Salmo 46", second_reading: "Colossenses 1:11-20", gospel: "Lucas 23:35-43" }
]

ordinary_readings.each do |reading|
  reading[:prayer_book_id] = prayer_book.id

  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(reading)
  else
    existing.update!(reading)
  end
end
