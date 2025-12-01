# ================================================================================
# LEITURAS DO TEMPO COMUM (ORDINARY TIME)
# Revised Common Lectionary (RCL)
# ================================================================================
#
# Conteúdo:
# - Propers 1-28 (Ciclos A, B, C)
# - Cristo Rei (Ciclos A, B, C)
#
# Nota: O Tempo Comum é dividido em dois períodos:
#       1. Entre Epifania e Quaresma (Propers 1-3, nem sempre todos usados)
#       2. Entre Pentecostes e Advento (Propers 4-28 + Cristo Rei)
#
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Comum..."

# Buscar o prayer book
prayer_book = PrayerBook.find_by!(code: 'loc_2015')

ordinary_time_readings = [
  # ============================================================================
  # PROPERS INICIAIS (1-3)
  # Entre Batismo do Senhor e Quarta-feira de Cinzas
  # ============================================================================

  # ----------------------------------------------------------------------------
  # PROPER 1
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_1",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 58:1-9a, (9b-12)",
    psalm: "Salmo 112:1-9, (10)",
    second_reading: "1 Coríntios 2:1-12, (13-16)",
    gospel: "Mateus 5:13-20"
  },
  {
    date_reference: "proper_1",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 40:21-31",
    psalm: "Salmo 147:1-11, 20c",
    second_reading: "1 Coríntios 9:16-23",
    gospel: "Marcos 1:29-39"
  },
  {
    date_reference: "proper_1",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 17:5-10",
    psalm: "Salmo 1",
    second_reading: "1 Coríntios 15:12-20",
    gospel: "Lucas 6:17-26"
  },

  # ----------------------------------------------------------------------------
  # PROPER 2
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_2",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30:15-20",
    psalm: "Salmo 119:1-8",
    second_reading: "1 Coríntios 3:1-9",
    gospel: "Mateus 5:21-37"
  },
  {
    date_reference: "proper_2",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Reis 5:1-14",
    psalm: "Salmo 30",
    second_reading: "1 Coríntios 9:24-27",
    gospel: "Marcos 1:40-45"
  },
  {
    date_reference: "proper_2",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 45:3-11, 15",
    psalm: "Salmo 37:1-11, 39-40",
    second_reading: "1 Coríntios 15:35-38, 42-50",
    gospel: "Lucas 6:27-38"
  },

  # ----------------------------------------------------------------------------
  # PROPER 3
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_3",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Levítico 19:1-2, 9-18",
    psalm: "Salmo 119:33-40",
    second_reading: "1 Coríntios 3:10-11, 16-23",
    gospel: "Mateus 5:38-48"
  },
  {
    date_reference: "proper_3",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Oséias 2:14-20",
    psalm: "Salmo 103:1-13, 22",
    second_reading: "2 Coríntios 3:1-6",
    gospel: "Marcos 2:13-22"
  },
  {
    date_reference: "proper_3",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Eclesiástico 27:4-7 or Isaías 55:10-13",
    psalm: "Salmo 92:1-4, 12-15",
    second_reading: "1 Coríntios 15:51-58",
    gospel: "Lucas 6:39-49"
  },

  # ============================================================================
  # PROPERS DO MEIO DO ANO (4-28)
  # Entre Trindade e Cristo Rei
  # ============================================================================

  # ----------------------------------------------------------------------------
  # PROPER 4
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_4",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronômio 11:18-21, 26-28",
    psalm: "Salmo 31:1-5, 19-24",
    second_reading: "Romanos 1:16-17; 3:22b-28, (29-31)",
    gospel: "Mateus 7:21-29"
  },
  {
    date_reference: "proper_4",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 5:12-15",
    psalm: "Salmo 81:1-10",
    second_reading: "2 Coríntios 4:5-12",
    gospel: "Marcos 2:23-3:6"
  },
  {
    date_reference: "proper_4",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Reis 18:20-21, (22-29), 30-39",
    psalm: "Salmo 96",
    second_reading: "Gálatas 1:1-12",
    gospel: "Lucas 7:1-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 5
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_5",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 12:1-9",
    psalm: "Salmo 33:1-12",
    second_reading: "Romanos 4:13-25",
    gospel: "Mateus 9:9-13, 18-26"
  },
  {
    date_reference: "proper_5",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 8:4-11, (12-15), 16-20, (11:14-15)",
    psalm: "Salmo 138",
    second_reading: "2 Coríntios 4:13-5:1",
    gospel: "Marcos 3:20-35"
  },
  {
    date_reference: "proper_5",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Reis 17:8-16, (17-24)",
    psalm: "Salmo 146",
    second_reading: "Gálatas 1:11-24",
    gospel: "Lucas 7:11-17"
  },

  # ----------------------------------------------------------------------------
  # PROPER 6
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_6",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 18:1-15, (21:1-7)",
    psalm: "Salmo 116:1-2, 12-19",
    second_reading: "Romanos 5:1-8",
    gospel: "Mateus 9:35-10:8, (9-23)"
  },
  {
    date_reference: "proper_6",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 15:34-16:13",
    psalm: "Salmo 20",
    second_reading: "2 Coríntios 5:6-10, (11-13), 14-17",
    gospel: "Marcos 4:26-34"
  },
  {
    date_reference: "proper_6",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Reis 21:1-10, (11-14), 15-21a",
    psalm: "Salmo 5:1-8",
    second_reading: "Gálatas 2:15-21",
    gospel: "Lucas 7:36-8:3"
  },

  # ----------------------------------------------------------------------------
  # PROPER 7
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_7",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 21:8-21",
    psalm: "Salmo 86:1-10, 16-17",
    second_reading: "Romanos 6:1b-11",
    gospel: "Mateus 10:24-39"
  },
  {
    date_reference: "proper_7",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 17:(1a, 4-11, 19-23), 32-49",
    psalm: "Salmo 9:9-20 or Salmo 133",
    second_reading: "2 Coríntios 6:1-13",
    gospel: "Marcos 4:35-41"
  },
  {
    date_reference: "proper_7",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Reis 19:1-4, (5-7), 8-15a",
    psalm: "Salmo 42 and 43",
    second_reading: "Gálatas 3:23-29",
    gospel: "Lucas 8:26-39"
  },

  # ----------------------------------------------------------------------------
  # PROPER 8
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_8",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 22:1-14",
    psalm: "Salmo 13",
    second_reading: "Romanos 6:12-23",
    gospel: "Mateus 10:40-42"
  },
  {
    date_reference: "proper_8",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 1:1, 17-27",
    psalm: "Salmo 130",
    second_reading: "2 Coríntios 8:7-15",
    gospel: "Marcos 5:21-43"
  },
  {
    date_reference: "proper_8",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Reis 2:1-2, 6-14",
    psalm: "Salmo 77:1-2, 11-20",
    second_reading: "Gálatas 5:1, 13-25",
    gospel: "Lucas 9:51-62"
  },

  # ----------------------------------------------------------------------------
  # PROPER 9
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_9",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 24:34-38, 42-49, 58-67",
    psalm: "Salmo 45:10-17 or Cântico dos Cânticos 2:8-13",
    second_reading: "Romanos 7:15-25a",
    gospel: "Mateus 11:16-19, 25-30"
  },
  {
    date_reference: "proper_9",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 5:1-5, 9-10",
    psalm: "Salmo 48",
    second_reading: "2 Coríntios 12:2-10",
    gospel: "Marcos 6:1-13"
  },
  {
    date_reference: "proper_9",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Reis 5:1-14",
    psalm: "Salmo 30",
    second_reading: "Gálatas 6:(1-6), 7-16",
    gospel: "Lucas 10:1-11, 16-20"
  },

  # ----------------------------------------------------------------------------
  # PROPER 10
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_10",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 55:10-13",
    psalm: "Salmo 65:(1-8), 9-13",
    second_reading: "Romanos 8:1-11",
    gospel: "Mateus 13:1-9, 18-23"
  },
  {
    date_reference: "proper_10",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amós 7:7-15",
    psalm: "Salmo 85:8-13",
    second_reading: "Efésios 1:3-14",
    gospel: "Marcos 6:14-29"
  },
  {
    date_reference: "proper_10",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amós 8:1-12",
    psalm: "Salmo 52",
    second_reading: "Colossenses 1:15-28",
    gospel: "Lucas 10:38-42"
  },

  # ----------------------------------------------------------------------------
  # PROPER 11
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_11",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 28:10-19a",
    psalm: "Salmo 139:1-12, 23-24",
    second_reading: "Romanos 8:12-25",
    gospel: "Mateus 13:24-30, 36-43"
  },
  {
    date_reference: "proper_11",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 7:1-14a",
    psalm: "Salmo 89:20-37",
    second_reading: "Efésios 2:11-22",
    gospel: "Marcos 6:30-34, 53-56"
  },
  {
    date_reference: "proper_11",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 18:1-10a",
    psalm: "Salmo 15",
    second_reading: "Colossenses 1:15-28",
    gospel: "Lucas 10:38-42"
  },

  # ----------------------------------------------------------------------------
  # PROPER 12
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_12",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 29:15-28",
    psalm: "Salmo 105:1-11, 45b or Salmo 128",
    second_reading: "Romanos 8:26-39",
    gospel: "Mateus 13:31-33, 44-52"
  },
  {
    date_reference: "proper_12",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 11:1-15",
    psalm: "Salmo 14",
    second_reading: "Efésios 3:14-21",
    gospel: "João 6:1-21"
  },
  {
    date_reference: "proper_12",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 18:20-32",
    psalm: "Salmo 138",
    second_reading: "Colossenses 2:6-15, (16-19)",
    gospel: "Lucas 11:1-13"
  },

  # ----------------------------------------------------------------------------
  # PROPER 13
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_13",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 32:22-31",
    psalm: "Salmo 17:1-7, 15",
    second_reading: "Romanos 9:1-5",
    gospel: "Mateus 14:13-21"
  },
  {
    date_reference: "proper_13",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 11:26-12:13a",
    psalm: "Salmo 51:1-12",
    second_reading: "Efésios 4:1-16",
    gospel: "João 6:24-35"
  },
  {
    date_reference: "proper_13",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Ecclesiastes 1:2, 12-14; 2:18-23",
    psalm: "Salmo 49:1-12",
    second_reading: "Colossenses 3:1-11",
    gospel: "Lucas 12:13-21"
  },

  # ----------------------------------------------------------------------------
  # PROPER 14
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_14",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 37:1-4, 12-28",
    psalm: "Salmo 105:1-6, 16-22, 45b",
    second_reading: "Romanos 10:5-15",
    gospel: "Mateus 14:22-33"
  },
  {
    date_reference: "proper_14",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 18:5-9, 15, 31-33",
    psalm: "Salmo 130",
    second_reading: "Efésios 4:25-5:2",
    gospel: "João 6:35, 41-51"
  },
  {
    date_reference: "proper_14",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 15:1-6",
    psalm: "Salmo 33:12-22",
    second_reading: "Hebreus 11:1-3, 8-16",
    gospel: "Lucas 12:32-40"
  },

  # ----------------------------------------------------------------------------
  # PROPER 15
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_15",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 56:1, 6-8",
    psalm: "Salmo 67",
    second_reading: "Romanos 11:1-2a, 29-32",
    gospel: "Mateus 15:(10-20), 21-28"
  },
  {
    date_reference: "proper_15",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Provérbios 9:1-6",
    psalm: "Salmo 34:9-14",
    second_reading: "Efésios 5:15-20",
    gospel: "João 6:51-58"
  },
  {
    date_reference: "proper_15",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 23:23-29",
    psalm: "Salmo 82",
    second_reading: "Hebreus 11:29-12:2",
    gospel: "Lucas 12:49-56"
  },

  # ----------------------------------------------------------------------------
  # PROPER 16
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_16",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 1:8-2:10",
    psalm: "Salmo 124",
    second_reading: "Romanos 12:1-8",
    gospel: "Mateus 16:13-20"
  },
  {
    date_reference: "proper_16",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Josué 24:1-2a, 14-18",
    psalm: "Salmo 34:15-22",
    second_reading: "Efésios 6:10-20",
    gospel: "João 6:56-69"
  },
  {
    date_reference: "proper_16",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 1:4-10",
    psalm: "Salmo 71:1-6",
    second_reading: "Hebreus 12:18-29",
    gospel: "Lucas 13:10-17"
  },

  # ----------------------------------------------------------------------------
  # PROPER 17
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_17",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 3:1-15",
    psalm: "Salmo 105:1-6, 23-26, 45c",
    second_reading: "Romanos 12:9-21",
    gospel: "Mateus 16:21-28"
  },
  {
    date_reference: "proper_17",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 4:1-2, 6-9",
    psalm: "Salmo 15",
    second_reading: "Tiago 1:17-27",
    gospel: "Marcos 7:1-8, 14-15, 21-23"
  },
  {
    date_reference: "proper_17",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 2:4-13",
    psalm: "Salmo 81:1, 10-16",
    second_reading: "Hebreus 13:1-8, 15-16",
    gospel: "Lucas 14:1, 7-14"
  },

  # ----------------------------------------------------------------------------
  # PROPER 18
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_18",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 12:1-14",
    psalm: "Salmo 149",
    second_reading: "Romanos 13:8-14",
    gospel: "Mateus 18:15-20"
  },
  {
    date_reference: "proper_18",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 35:4-7a",
    psalm: "Salmo 146",
    second_reading: "Tiago 2:1-10, (11-13), 14-17",
    gospel: "Marcos 7:24-37"
  },
  {
    date_reference: "proper_18",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 18:1-11",
    psalm: "Salmo 139:1-6, 13-18",
    second_reading: "Philemon 1-21",
    gospel: "Lucas 14:25-33"
  },

  # ----------------------------------------------------------------------------
  # PROPER 19
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_19",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 14:19-31",
    psalm: "Salmo 114 or Êxodo 15:1b-11, 20-21",
    second_reading: "Romanos 14:1-12",
    gospel: "Mateus 18:21-35"
  },
  {
    date_reference: "proper_19",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 50:4-9a",
    psalm: "Salmo 116:1-9",
    second_reading: "Tiago 3:1-12",
    gospel: "Marcos 8:27-38"
  },
  {
    date_reference: "proper_19",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 4:11-12, 22-28",
    psalm: "Salmo 14",
    second_reading: "1 Timóteo 1:12-17",
    gospel: "Lucas 15:1-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 20
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_20",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jonas 3:10-4:11",
    psalm: "Salmo 145:1-8",
    second_reading: "Filipenses 1:21-30",
    gospel: "Mateus 20:1-16"
  },
  {
    date_reference: "proper_20",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 11:18-20",
    psalm: "Salmo 54",
    second_reading: "Tiago 3:13-4:3, 7-8a",
    gospel: "Marcos 9:30-37"
  },
  {
    date_reference: "proper_20",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amós 8:4-7",
    psalm: "Salmo 113",
    second_reading: "1 Timóteo 2:1-7",
    gospel: "Lucas 16:1-13"
  },

  # ----------------------------------------------------------------------------
  # PROPER 21
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_21",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 17:1-7",
    psalm: "Salmo 78:1-4, 12-16",
    second_reading: "Filipenses 2:1-13",
    gospel: "Mateus 21:23-32"
  },
  {
    date_reference: "proper_21",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Números 11:4-6, 10-16, 24-29",
    psalm: "Salmo 19:7-14",
    second_reading: "Tiago 5:13-20",
    gospel: "Marcos 9:38-50"
  },
  {
    date_reference: "proper_21",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 32:1-3a, 6-15",
    psalm: "Salmo 91:1-6, 14-16",
    second_reading: "1 Timóteo 6:6-19",
    gospel: "Lucas 16:19-31"
  },

  # ----------------------------------------------------------------------------
  # PROPER 22
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_22",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 20:1-4, 7-9, 12-20",
    psalm: "Salmo 19",
    second_reading: "Filipenses 3:4b-14",
    gospel: "Mateus 21:33-46"
  },
  {
    date_reference: "proper_22",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 2:18-24",
    psalm: "Salmo 8",
    second_reading: "Hebreus 1:1-4; 2:5-12",
    gospel: "Marcos 10:2-16"
  },
  {
    date_reference: "proper_22",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Lamentations 1:1-6",
    psalm: "Lamentations 3:19-26 or Salmo 137",
    second_reading: "2 Timóteo 1:1-14",
    gospel: "Lucas 17:5-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 23
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_23",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 32:1-14",
    psalm: "Salmo 106:1-6, 19-23",
    second_reading: "Filipenses 4:1-9",
    gospel: "Mateus 22:1-14"
  },
  {
    date_reference: "proper_23",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amós 5:6-7, 10-15",
    psalm: "Salmo 90:12-17",
    second_reading: "Hebreus 4:12-16",
    gospel: "Marcos 10:17-31"
  },
  {
    date_reference: "proper_23",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 29:1, 4-7",
    psalm: "Salmo 66:1-12",
    second_reading: "2 Timóteo 2:8-15",
    gospel: "Lucas 17:11-19"
  },

  # ----------------------------------------------------------------------------
  # PROPER 24
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_24",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 33:12-23",
    psalm: "Salmo 99",
    second_reading: "1 Tessalonicenses 1:1-10",
    gospel: "Mateus 22:15-22"
  },
  {
    date_reference: "proper_24",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 53:4-12",
    psalm: "Salmo 91:9-16",
    second_reading: "Hebreus 5:1-10",
    gospel: "Marcos 10:35-45"
  },
  {
    date_reference: "proper_24",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 31:27-34",
    psalm: "Salmo 119:97-104",
    second_reading: "2 Timóteo 3:14-4:5",
    gospel: "Lucas 18:1-8"
  },

  # ----------------------------------------------------------------------------
  # PROPER 25
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_25",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Levítico 19:1-2, 15-18",
    psalm: "Salmo 1",
    second_reading: "1 Tessalonicenses 2:1-8",
    gospel: "Mateus 22:34-46"
  },
  {
    date_reference: "proper_25",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 31:7-9",
    psalm: "Salmo 126",
    second_reading: "Hebreus 7:23-28",
    gospel: "Marcos 10:46-52"
  },
  {
    date_reference: "proper_25",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Joel 2:23-32",
    psalm: "Salmo 65",
    second_reading: "2 Timóteo 4:6-8, 16-18",
    gospel: "Lucas 18:9-14"
  },

  # ----------------------------------------------------------------------------
  # PROPER 26
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_26",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Josué 3:7-17",
    psalm: "Salmo 107:1-7, 33-37",
    second_reading: "1 Tessalonicenses 2:9-13",
    gospel: "Mateus 23:1-12"
  },
  {
    date_reference: "proper_26",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ruth 1:1-18",
    psalm: "Salmo 146",
    second_reading: "Hebreus 9:11-14",
    gospel: "Marcos 12:28-34"
  },
  {
    date_reference: "proper_26",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Habacuque 1:1-4; 2:1-4",
    psalm: "Salmo 119:137-144",
    second_reading: "2 Tessalonicenses 1:1-4, 11-12",
    gospel: "Lucas 19:1-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 27
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_27",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Josué 24:1-3a, 14-25",
    psalm: "Salmo 78:1-7",
    second_reading: "1 Tessalonicenses 4:13-18",
    gospel: "Mateus 25:1-13"
  },
  {
    date_reference: "proper_27",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ruth 3:1-5; 4:13-17",
    psalm: "Salmo 127",
    second_reading: "Hebreus 9:24-28",
    gospel: "Marcos 12:38-44"
  },
  {
    date_reference: "proper_27",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Haggai 1:15b-2:9",
    psalm: "Salmo 145:1-5, 17-21 or Salmo 98",
    second_reading: "2 Tessalonicenses 2:1-5, 13-17",
    gospel: "Lucas 20:27-38"
  },

  # ----------------------------------------------------------------------------
  # PROPER 28
  # (Último domingo antes de Cristo Rei)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_28",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Sofonias 1:7, 12-18",
    psalm: "Salmo 90:1-8, (9-11), 12",
    second_reading: "1 Tessalonicenses 5:1-11",
    gospel: "Mateus 25:14-30"
  },
  {
    date_reference: "proper_28",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Daniel 12:1-3",
    psalm: "Salmo 16",
    second_reading: "Hebreus 10:11-14, (15-18), 19-25",
    gospel: "Marcos 13:1-8"
  },
  {
    date_reference: "proper_28",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Malaquias 4:1-2a",
    psalm: "Salmo 98",
    second_reading: "2 Tessalonicenses 3:6-13",
    gospel: "Lucas 21:5-19"
  },

  # ============================================================================
  # CRISTO REI
  # (Último domingo do ano litúrgico, antes do 1º Domingo do Advento)
  # ============================================================================
  {
    date_reference: "christ_the_king",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 34:11-16, 20-24",
    psalm: "Salmo 100",
    second_reading: "Efésios 1:15-23",
    gospel: "Mateus 25:31-46"
  },
  {
    date_reference: "christ_the_king",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 23:1-7",
    psalm: "Salmo 132:1-12, (13-18)",
    second_reading: "Apocalipse 1:4b-8",
    gospel: "João 18:33-37"
  },
  {
    date_reference: "christ_the_king",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 23:1-6",
    psalm: "Salmo 46",
    second_reading: "Colossenses 1:11-20",
    gospel: "Lucas 23:33-43"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

ordinary_time_readings.each do |reading|
  reading[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book.id
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 10 == 0
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Tempo Comum criadas!"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
