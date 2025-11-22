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

puts "📖 Carregando leituras do Tempo Comum..."

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
    first_reading: "Isaiah 58:1-9a, (9b-12)",
    psalm: "Psalm 112:1-9, (10)",
    second_reading: "1 Corinthians 2:1-12, (13-16)",
    gospel: "Matthew 5:13-20"
  },
  {
    date_reference: "proper_1",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 40:21-31",
    psalm: "Psalm 147:1-11, 20c",
    second_reading: "1 Corinthians 9:16-23",
    gospel: "Mark 1:29-39"
  },
  {
    date_reference: "proper_1",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 17:5-10",
    psalm: "Psalm 1",
    second_reading: "1 Corinthians 15:12-20",
    gospel: "Luke 6:17-26"
  },

  # ----------------------------------------------------------------------------
  # PROPER 2
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_2",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronomy 30:15-20",
    psalm: "Psalm 119:1-8",
    second_reading: "1 Corinthians 3:1-9",
    gospel: "Matthew 5:21-37"
  },
  {
    date_reference: "proper_2",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Kings 5:1-14",
    psalm: "Psalm 30",
    second_reading: "1 Corinthians 9:24-27",
    gospel: "Mark 1:40-45"
  },
  {
    date_reference: "proper_2",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 45:3-11, 15",
    psalm: "Psalm 37:1-11, 39-40",
    second_reading: "1 Corinthians 15:35-38, 42-50",
    gospel: "Luke 6:27-38"
  },

  # ----------------------------------------------------------------------------
  # PROPER 3
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_3",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Leviticus 19:1-2, 9-18",
    psalm: "Psalm 119:33-40",
    second_reading: "1 Corinthians 3:10-11, 16-23",
    gospel: "Matthew 5:38-48"
  },
  {
    date_reference: "proper_3",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Hosea 2:14-20",
    psalm: "Psalm 103:1-13, 22",
    second_reading: "2 Corinthians 3:1-6",
    gospel: "Mark 2:13-22"
  },
  {
    date_reference: "proper_3",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Sirach 27:4-7 or Isaiah 55:10-13",
    psalm: "Psalm 92:1-4, 12-15",
    second_reading: "1 Corinthians 15:51-58",
    gospel: "Luke 6:39-49"
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
    first_reading: "Deuteronomy 11:18-21, 26-28",
    psalm: "Psalm 31:1-5, 19-24",
    second_reading: "Romans 1:16-17; 3:22b-28, (29-31)",
    gospel: "Matthew 7:21-29"
  },
  {
    date_reference: "proper_4",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronomy 5:12-15",
    psalm: "Psalm 81:1-10",
    second_reading: "2 Corinthians 4:5-12",
    gospel: "Mark 2:23-3:6"
  },
  {
    date_reference: "proper_4",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Kings 18:20-21, (22-29), 30-39",
    psalm: "Psalm 96",
    second_reading: "Galatians 1:1-12",
    gospel: "Luke 7:1-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 5
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_5",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 12:1-9",
    psalm: "Psalm 33:1-12",
    second_reading: "Romans 4:13-25",
    gospel: "Matthew 9:9-13, 18-26"
  },
  {
    date_reference: "proper_5",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 8:4-11, (12-15), 16-20, (11:14-15)",
    psalm: "Psalm 138",
    second_reading: "2 Corinthians 4:13-5:1",
    gospel: "Mark 3:20-35"
  },
  {
    date_reference: "proper_5",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Kings 17:8-16, (17-24)",
    psalm: "Psalm 146",
    second_reading: "Galatians 1:11-24",
    gospel: "Luke 7:11-17"
  },

  # ----------------------------------------------------------------------------
  # PROPER 6
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_6",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 18:1-15, (21:1-7)",
    psalm: "Psalm 116:1-2, 12-19",
    second_reading: "Romans 5:1-8",
    gospel: "Matthew 9:35-10:8, (9-23)"
  },
  {
    date_reference: "proper_6",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 15:34-16:13",
    psalm: "Psalm 20",
    second_reading: "2 Corinthians 5:6-10, (11-13), 14-17",
    gospel: "Mark 4:26-34"
  },
  {
    date_reference: "proper_6",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Kings 21:1-10, (11-14), 15-21a",
    psalm: "Psalm 5:1-8",
    second_reading: "Galatians 2:15-21",
    gospel: "Luke 7:36-8:3"
  },

  # ----------------------------------------------------------------------------
  # PROPER 7
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_7",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 21:8-21",
    psalm: "Psalm 86:1-10, 16-17",
    second_reading: "Romans 6:1b-11",
    gospel: "Matthew 10:24-39"
  },
  {
    date_reference: "proper_7",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Samuel 17:(1a, 4-11, 19-23), 32-49",
    psalm: "Psalm 9:9-20 or Psalm 133",
    second_reading: "2 Corinthians 6:1-13",
    gospel: "Mark 4:35-41"
  },
  {
    date_reference: "proper_7",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Kings 19:1-4, (5-7), 8-15a",
    psalm: "Psalm 42 and 43",
    second_reading: "Galatians 3:23-29",
    gospel: "Luke 8:26-39"
  },

  # ----------------------------------------------------------------------------
  # PROPER 8
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_8",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 22:1-14",
    psalm: "Psalm 13",
    second_reading: "Romans 6:12-23",
    gospel: "Matthew 10:40-42"
  },
  {
    date_reference: "proper_8",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 1:1, 17-27",
    psalm: "Psalm 130",
    second_reading: "2 Corinthians 8:7-15",
    gospel: "Mark 5:21-43"
  },
  {
    date_reference: "proper_8",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Kings 2:1-2, 6-14",
    psalm: "Psalm 77:1-2, 11-20",
    second_reading: "Galatians 5:1, 13-25",
    gospel: "Luke 9:51-62"
  },

  # ----------------------------------------------------------------------------
  # PROPER 9
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_9",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 24:34-38, 42-49, 58-67",
    psalm: "Psalm 45:10-17 or Song of Solomon 2:8-13",
    second_reading: "Romans 7:15-25a",
    gospel: "Matthew 11:16-19, 25-30"
  },
  {
    date_reference: "proper_9",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 5:1-5, 9-10",
    psalm: "Psalm 48",
    second_reading: "2 Corinthians 12:2-10",
    gospel: "Mark 6:1-13"
  },
  {
    date_reference: "proper_9",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Kings 5:1-14",
    psalm: "Psalm 30",
    second_reading: "Galatians 6:(1-6), 7-16",
    gospel: "Luke 10:1-11, 16-20"
  },

  # ----------------------------------------------------------------------------
  # PROPER 10
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_10",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 55:10-13",
    psalm: "Psalm 65:(1-8), 9-13",
    second_reading: "Romans 8:1-11",
    gospel: "Matthew 13:1-9, 18-23"
  },
  {
    date_reference: "proper_10",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amos 7:7-15",
    psalm: "Psalm 85:8-13",
    second_reading: "Ephesians 1:3-14",
    gospel: "Mark 6:14-29"
  },
  {
    date_reference: "proper_10",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amos 8:1-12",
    psalm: "Psalm 52",
    second_reading: "Colossians 1:15-28",
    gospel: "Luke 10:38-42"
  },

  # ----------------------------------------------------------------------------
  # PROPER 11
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_11",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 28:10-19a",
    psalm: "Psalm 139:1-12, 23-24",
    second_reading: "Romans 8:12-25",
    gospel: "Matthew 13:24-30, 36-43"
  },
  {
    date_reference: "proper_11",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 7:1-14a",
    psalm: "Psalm 89:20-37",
    second_reading: "Ephesians 2:11-22",
    gospel: "Mark 6:30-34, 53-56"
  },
  {
    date_reference: "proper_11",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 18:1-10a",
    psalm: "Psalm 15",
    second_reading: "Colossians 1:15-28",
    gospel: "Luke 10:38-42"
  },

  # ----------------------------------------------------------------------------
  # PROPER 12
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_12",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 29:15-28",
    psalm: "Psalm 105:1-11, 45b or Psalm 128",
    second_reading: "Romans 8:26-39",
    gospel: "Matthew 13:31-33, 44-52"
  },
  {
    date_reference: "proper_12",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 11:1-15",
    psalm: "Psalm 14",
    second_reading: "Ephesians 3:14-21",
    gospel: "John 6:1-21"
  },
  {
    date_reference: "proper_12",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 18:20-32",
    psalm: "Psalm 138",
    second_reading: "Colossians 2:6-15, (16-19)",
    gospel: "Luke 11:1-13"
  },

  # ----------------------------------------------------------------------------
  # PROPER 13
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_13",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 32:22-31",
    psalm: "Psalm 17:1-7, 15",
    second_reading: "Romans 9:1-5",
    gospel: "Matthew 14:13-21"
  },
  {
    date_reference: "proper_13",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 11:26-12:13a",
    psalm: "Psalm 51:1-12",
    second_reading: "Ephesians 4:1-16",
    gospel: "John 6:24-35"
  },
  {
    date_reference: "proper_13",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Ecclesiastes 1:2, 12-14; 2:18-23",
    psalm: "Psalm 49:1-12",
    second_reading: "Colossians 3:1-11",
    gospel: "Luke 12:13-21"
  },

  # ----------------------------------------------------------------------------
  # PROPER 14
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_14",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 37:1-4, 12-28",
    psalm: "Psalm 105:1-6, 16-22, 45b",
    second_reading: "Romans 10:5-15",
    gospel: "Matthew 14:22-33"
  },
  {
    date_reference: "proper_14",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 18:5-9, 15, 31-33",
    psalm: "Psalm 130",
    second_reading: "Ephesians 4:25-5:2",
    gospel: "John 6:35, 41-51"
  },
  {
    date_reference: "proper_14",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 15:1-6",
    psalm: "Psalm 33:12-22",
    second_reading: "Hebrews 11:1-3, 8-16",
    gospel: "Luke 12:32-40"
  },

  # ----------------------------------------------------------------------------
  # PROPER 15
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_15",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 56:1, 6-8",
    psalm: "Psalm 67",
    second_reading: "Romans 11:1-2a, 29-32",
    gospel: "Matthew 15:(10-20), 21-28"
  },
  {
    date_reference: "proper_15",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Proverbs 9:1-6",
    psalm: "Psalm 34:9-14",
    second_reading: "Ephesians 5:15-20",
    gospel: "John 6:51-58"
  },
  {
    date_reference: "proper_15",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 23:23-29",
    psalm: "Psalm 82",
    second_reading: "Hebrews 11:29-12:2",
    gospel: "Luke 12:49-56"
  },

  # ----------------------------------------------------------------------------
  # PROPER 16
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_16",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 1:8-2:10",
    psalm: "Psalm 124",
    second_reading: "Romans 12:1-8",
    gospel: "Matthew 16:13-20"
  },
  {
    date_reference: "proper_16",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Joshua 24:1-2a, 14-18",
    psalm: "Psalm 34:15-22",
    second_reading: "Ephesians 6:10-20",
    gospel: "John 6:56-69"
  },
  {
    date_reference: "proper_16",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 1:4-10",
    psalm: "Psalm 71:1-6",
    second_reading: "Hebrews 12:18-29",
    gospel: "Luke 13:10-17"
  },

  # ----------------------------------------------------------------------------
  # PROPER 17
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_17",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 3:1-15",
    psalm: "Psalm 105:1-6, 23-26, 45c",
    second_reading: "Romans 12:9-21",
    gospel: "Matthew 16:21-28"
  },
  {
    date_reference: "proper_17",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronomy 4:1-2, 6-9",
    psalm: "Psalm 15",
    second_reading: "James 1:17-27",
    gospel: "Mark 7:1-8, 14-15, 21-23"
  },
  {
    date_reference: "proper_17",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 2:4-13",
    psalm: "Psalm 81:1, 10-16",
    second_reading: "Hebrews 13:1-8, 15-16",
    gospel: "Luke 14:1, 7-14"
  },

  # ----------------------------------------------------------------------------
  # PROPER 18
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_18",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 12:1-14",
    psalm: "Psalm 149",
    second_reading: "Romans 13:8-14",
    gospel: "Matthew 18:15-20"
  },
  {
    date_reference: "proper_18",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 35:4-7a",
    psalm: "Psalm 146",
    second_reading: "James 2:1-10, (11-13), 14-17",
    gospel: "Mark 7:24-37"
  },
  {
    date_reference: "proper_18",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 18:1-11",
    psalm: "Psalm 139:1-6, 13-18",
    second_reading: "Philemon 1-21",
    gospel: "Luke 14:25-33"
  },

  # ----------------------------------------------------------------------------
  # PROPER 19
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_19",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 14:19-31",
    psalm: "Psalm 114 or Exodus 15:1b-11, 20-21",
    second_reading: "Romans 14:1-12",
    gospel: "Matthew 18:21-35"
  },
  {
    date_reference: "proper_19",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 116:1-9",
    second_reading: "James 3:1-12",
    gospel: "Mark 8:27-38"
  },
  {
    date_reference: "proper_19",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 4:11-12, 22-28",
    psalm: "Psalm 14",
    second_reading: "1 Timothy 1:12-17",
    gospel: "Luke 15:1-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 20
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_20",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jonah 3:10-4:11",
    psalm: "Psalm 145:1-8",
    second_reading: "Philippians 1:21-30",
    gospel: "Matthew 20:1-16"
  },
  {
    date_reference: "proper_20",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremiah 11:18-20",
    psalm: "Psalm 54",
    second_reading: "James 3:13-4:3, 7-8a",
    gospel: "Mark 9:30-37"
  },
  {
    date_reference: "proper_20",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amos 8:4-7",
    psalm: "Psalm 113",
    second_reading: "1 Timothy 2:1-7",
    gospel: "Luke 16:1-13"
  },

  # ----------------------------------------------------------------------------
  # PROPER 21
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_21",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 17:1-7",
    psalm: "Psalm 78:1-4, 12-16",
    second_reading: "Philippians 2:1-13",
    gospel: "Matthew 21:23-32"
  },
  {
    date_reference: "proper_21",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Numbers 11:4-6, 10-16, 24-29",
    psalm: "Psalm 19:7-14",
    second_reading: "James 5:13-20",
    gospel: "Mark 9:38-50"
  },
  {
    date_reference: "proper_21",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 32:1-3a, 6-15",
    psalm: "Psalm 91:1-6, 14-16",
    second_reading: "1 Timothy 6:6-19",
    gospel: "Luke 16:19-31"
  },

  # ----------------------------------------------------------------------------
  # PROPER 22
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_22",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 20:1-4, 7-9, 12-20",
    psalm: "Psalm 19",
    second_reading: "Philippians 3:4b-14",
    gospel: "Matthew 21:33-46"
  },
  {
    date_reference: "proper_22",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 2:18-24",
    psalm: "Psalm 8",
    second_reading: "Hebrews 1:1-4; 2:5-12",
    gospel: "Mark 10:2-16"
  },
  {
    date_reference: "proper_22",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Lamentations 1:1-6",
    psalm: "Lamentations 3:19-26 or Psalm 137",
    second_reading: "2 Timothy 1:1-14",
    gospel: "Luke 17:5-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 23
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_23",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 32:1-14",
    psalm: "Psalm 106:1-6, 19-23",
    second_reading: "Philippians 4:1-9",
    gospel: "Matthew 22:1-14"
  },
  {
    date_reference: "proper_23",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amos 5:6-7, 10-15",
    psalm: "Psalm 90:12-17",
    second_reading: "Hebrews 4:12-16",
    gospel: "Mark 10:17-31"
  },
  {
    date_reference: "proper_23",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 29:1, 4-7",
    psalm: "Psalm 66:1-12",
    second_reading: "2 Timothy 2:8-15",
    gospel: "Luke 17:11-19"
  },

  # ----------------------------------------------------------------------------
  # PROPER 24
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_24",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Exodus 33:12-23",
    psalm: "Psalm 99",
    second_reading: "1 Thessalonians 1:1-10",
    gospel: "Matthew 22:15-22"
  },
  {
    date_reference: "proper_24",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 53:4-12",
    psalm: "Psalm 91:9-16",
    second_reading: "Hebrews 5:1-10",
    gospel: "Mark 10:35-45"
  },
  {
    date_reference: "proper_24",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 31:27-34",
    psalm: "Psalm 119:97-104",
    second_reading: "2 Timothy 3:14-4:5",
    gospel: "Luke 18:1-8"
  },

  # ----------------------------------------------------------------------------
  # PROPER 25
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_25",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Leviticus 19:1-2, 15-18",
    psalm: "Psalm 1",
    second_reading: "1 Thessalonians 2:1-8",
    gospel: "Matthew 22:34-46"
  },
  {
    date_reference: "proper_25",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremiah 31:7-9",
    psalm: "Psalm 126",
    second_reading: "Hebrews 7:23-28",
    gospel: "Mark 10:46-52"
  },
  {
    date_reference: "proper_25",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Joel 2:23-32",
    psalm: "Psalm 65",
    second_reading: "2 Timothy 4:6-8, 16-18",
    gospel: "Luke 18:9-14"
  },

  # ----------------------------------------------------------------------------
  # PROPER 26
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_26",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Joshua 3:7-17",
    psalm: "Psalm 107:1-7, 33-37",
    second_reading: "1 Thessalonians 2:9-13",
    gospel: "Matthew 23:1-12"
  },
  {
    date_reference: "proper_26",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ruth 1:1-18",
    psalm: "Psalm 146",
    second_reading: "Hebrews 9:11-14",
    gospel: "Mark 12:28-34"
  },
  {
    date_reference: "proper_26",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Habakkuk 1:1-4; 2:1-4",
    psalm: "Psalm 119:137-144",
    second_reading: "2 Thessalonians 1:1-4, 11-12",
    gospel: "Luke 19:1-10"
  },

  # ----------------------------------------------------------------------------
  # PROPER 27
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_27",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Joshua 24:1-3a, 14-25",
    psalm: "Psalm 78:1-7",
    second_reading: "1 Thessalonians 4:13-18",
    gospel: "Matthew 25:1-13"
  },
  {
    date_reference: "proper_27",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ruth 3:1-5; 4:13-17",
    psalm: "Psalm 127",
    second_reading: "Hebrews 9:24-28",
    gospel: "Mark 12:38-44"
  },
  {
    date_reference: "proper_27",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Haggai 1:15b-2:9",
    psalm: "Psalm 145:1-5, 17-21 or Psalm 98",
    second_reading: "2 Thessalonians 2:1-5, 13-17",
    gospel: "Luke 20:27-38"
  },

  # ----------------------------------------------------------------------------
  # PROPER 28
  # (Último domingo antes de Cristo Rei)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_28",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Zephaniah 1:7, 12-18",
    psalm: "Psalm 90:1-8, (9-11), 12",
    second_reading: "1 Thessalonians 5:1-11",
    gospel: "Matthew 25:14-30"
  },
  {
    date_reference: "proper_28",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Daniel 12:1-3",
    psalm: "Psalm 16",
    second_reading: "Hebrews 10:11-14, (15-18), 19-25",
    gospel: "Mark 13:1-8"
  },
  {
    date_reference: "proper_28",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Malachi 4:1-2a",
    psalm: "Psalm 98",
    second_reading: "2 Thessalonians 3:6-13",
    gospel: "Luke 21:5-19"
  },

  # ============================================================================
  # CRISTO REI
  # (Último domingo do ano litúrgico, antes do 1º Domingo do Advento)
  # ============================================================================
  {
    date_reference: "christ_the_king",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezekiel 34:11-16, 20-24",
    psalm: "Psalm 100",
    second_reading: "Ephesians 1:15-23",
    gospel: "Matthew 25:31-46"
  },
  {
    date_reference: "christ_the_king",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 23:1-7",
    psalm: "Psalm 132:1-12, (13-18)",
    second_reading: "Revelation 1:4b-8",
    gospel: "John 18:33-37"
  },
  {
    date_reference: "christ_the_king",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 23:1-6",
    psalm: "Psalm 46",
    second_reading: "Colossians 1:11-20",
    gospel: "Luke 23:33-43"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0

ordinary_time_readings.each do |reading|
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type]
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 10 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} leituras do Tempo Comum criadas!"
puts "⏭️  #{skipped} já existiam." if skipped > 0
