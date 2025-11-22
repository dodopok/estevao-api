# Leituras do Lecionário - Revised Common Lectionary (RCL)
# Este arquivo contém todas as leituras para domingos e festas principais

puts "📖 Carregando leituras do lecionário..."

readings = [
  # ============= ADVENTO =============

  # 1º Domingo do Advento
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 2:1-5",
    psalm: "Psalm 122",
    second_reading: "Romans 13:11-14",
    gospel: "Matthew 24:36-44"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 64:1-9",
    psalm: "Psalm 80:1-7, 17-19",
    second_reading: "1 Corinthians 1:3-9",
    gospel: "Mark 13:24-37"
  },
  {
    date_reference: "1st_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremiah 33:14-16",
    psalm: "Psalm 25:1-10",
    second_reading: "1 Thessalonians 3:9-13",
    gospel: "Luke 21:25-36"
  },

  # 2º Domingo do Advento
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 11:1-10",
    psalm: "Psalm 72:1-7, 18-19",
    second_reading: "Romans 15:4-13",
    gospel: "Matthew 3:1-12"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 40:1-11",
    psalm: "Psalm 85:1-2, 8-13",
    second_reading: "2 Peter 3:8-15a",
    gospel: "Mark 1:1-8"
  },
  {
    date_reference: "2nd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Baruch 5:1-9 or Malachi 3:1-4",
    psalm: "Luke 1:68-79",
    second_reading: "Philippians 1:3-11",
    gospel: "Luke 3:1-6"
  },

  # 3º Domingo do Advento
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 35:1-10",
    psalm: "Psalm 146:5-10 or Luke 1:47-55",
    second_reading: "James 5:7-10",
    gospel: "Matthew 11:2-11"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 61:1-4, 8-11",
    psalm: "Psalm 126 or Luke 1:47-55",
    second_reading: "1 Thessalonians 5:16-24",
    gospel: "John 1:6-8, 19-28"
  },
  {
    date_reference: "3rd_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Zephaniah 3:14-20",
    psalm: "Isaiah 12:2-6",
    second_reading: "Philippians 4:4-7",
    gospel: "Luke 3:7-18"
  },

  # 4º Domingo do Advento
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 7:10-16",
    psalm: "Psalm 80:1-7, 17-19",
    second_reading: "Romans 1:1-7",
    gospel: "Matthew 1:18-25"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Samuel 7:1-11, 16",
    psalm: "Luke 1:47-55 or Psalm 89:1-4, 19-26",
    second_reading: "Romans 16:25-27",
    gospel: "Luke 1:26-38"
  },
  {
    date_reference: "4th_sunday_of_advent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Micah 5:2-5a",
    psalm: "Luke 1:47-55 or Psalm 80:1-7",
    second_reading: "Hebrews 10:5-10",
    gospel: "Luke 1:39-45, (46-55)"
  },

  # ============= NATAL =============

  # Natal - Missa da Noite
  {
    date_reference: "christmas_eve",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 9:2-7",
    psalm: "Psalm 96",
    second_reading: "Titus 2:11-14",
    gospel: "Luke 2:1-14, (15-20)"
  },

  # Natal - Missa do Dia
  {
    date_reference: "christmas_day",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 52:7-10",
    psalm: "Psalm 98",
    second_reading: "Hebrews 1:1-4, (5-12)",
    gospel: "John 1:1-14"
  },

  # 1º Domingo depois do Natal
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 63:7-9",
    psalm: "Psalm 148",
    second_reading: "Hebrews 2:10-18",
    gospel: "Matthew 2:13-23"
  },
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 61:10-62:3",
    psalm: "Psalm 148",
    second_reading: "Galatians 4:4-7",
    gospel: "Luke 2:22-40"
  },
  {
    date_reference: "1st_sunday_after_christmas",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Samuel 2:18-20, 26",
    psalm: "Psalm 148",
    second_reading: "Colossians 3:12-17",
    gospel: "Luke 2:41-52"
  },

  # ============= EPIFANIA =============

  # Epifania
  {
    date_reference: "epiphany",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 60:1-6",
    psalm: "Psalm 72:1-7, 10-14",
    second_reading: "Ephesians 3:1-12",
    gospel: "Matthew 2:1-12"
  },

  # Batismo do Senhor
  {
    date_reference: "baptism_of_the_lord",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 42:1-9",
    psalm: "Psalm 29",
    second_reading: "Acts 10:34-43",
    gospel: "Matthew 3:13-17"
  },
  {
    date_reference: "baptism_of_the_lord",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 1:1-5",
    psalm: "Psalm 29",
    second_reading: "Acts 19:1-7",
    gospel: "Mark 1:4-11"
  },
  {
    date_reference: "baptism_of_the_lord",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaiah 43:1-7",
    psalm: "Psalm 29",
    second_reading: "Acts 8:14-17",
    gospel: "Luke 3:15-17, 21-22"
  },

  # ============= QUARESMA =============

  # Quarta-feira de Cinzas
  {
    date_reference: "ash_wednesday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Joel 2:1-2, 12-17 or Isaiah 58:1-12",
    psalm: "Psalm 51:1-17",
    second_reading: "2 Corinthians 5:20b-6:10",
    gospel: "Matthew 6:1-6, 16-21"
  },

  # 1º Domingo na Quaresma
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 2:15-17; 3:1-7",
    psalm: "Psalm 32",
    second_reading: "Romans 5:12-19",
    gospel: "Matthew 4:1-11"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 9:8-17",
    psalm: "Psalm 25:1-10",
    second_reading: "1 Peter 3:18-22",
    gospel: "Mark 1:9-15"
  },
  {
    date_reference: "1st_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronomy 26:1-11",
    psalm: "Psalm 91:1-2, 9-16",
    second_reading: "Romans 10:8b-13",
    gospel: "Luke 4:1-13"
  },

  # 2º Domingo na Quaresma
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 12:1-4a",
    psalm: "Psalm 121",
    second_reading: "Romans 4:1-5, 13-17",
    gospel: "John 3:1-17 or Matthew 17:1-9"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Genesis 17:1-7, 15-16",
    psalm: "Psalm 22:23-31",
    second_reading: "Romans 4:13-25",
    gospel: "Mark 8:31-38 or Mark 9:2-9"
  },
  {
    date_reference: "2nd_sunday_in_lent",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Genesis 15:1-12, 17-18",
    psalm: "Psalm 27",
    second_reading: "Philippians 3:17-4:1",
    gospel: "Luke 13:31-35 or Luke 9:28-36, (37-43)"
  },

  # Domingo de Ramos
  {
    date_reference: "palm_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 31:9-16",
    second_reading: "Philippians 2:5-11",
    gospel: "Matthew 26:14-27:66 or Matthew 27:11-54"
  },
  {
    date_reference: "palm_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 31:9-16",
    second_reading: "Philippians 2:5-11",
    gospel: "Mark 14:1-15:47 or Mark 15:1-39, (40-47)"
  },
  {
    date_reference: "palm_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaiah 50:4-9a",
    psalm: "Psalm 31:9-16",
    second_reading: "Philippians 2:5-11",
    gospel: "Luke 22:14-23:56 or Luke 23:1-49"
  },

  # Quinta-feira Santa
  {
    date_reference: "maundy_thursday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Exodus 12:1-4, (5-10), 11-14",
    psalm: "Psalm 116:1-2, 12-19",
    second_reading: "1 Corinthians 11:23-26",
    gospel: "John 13:1-17, 31b-35"
  },

  # Sexta-feira da Paixão
  {
    date_reference: "good_friday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 52:13-53:12",
    psalm: "Psalm 22",
    second_reading: "Hebrews 10:16-25 or Hebrews 4:14-16; 5:7-9",
    gospel: "John 18:1-19:42"
  },

  # ============= PÁSCOA =============

  # Domingo de Páscoa
  {
    date_reference: "easter_sunday",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 10:34-43 or Jeremiah 31:1-6",
    psalm: "Psalm 118:1-2, 14-24",
    second_reading: "Colossians 3:1-4 or Acts 10:34-43",
    gospel: "John 20:1-18 or Matthew 28:1-10"
  },

  # 2º Domingo da Páscoa
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 2:14a, 22-32",
    psalm: "Psalm 16",
    second_reading: "1 Peter 1:3-9",
    gospel: "John 20:19-31"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 4:32-35",
    psalm: "Psalm 133",
    second_reading: "1 John 1:1-2:2",
    gospel: "John 20:19-31"
  },
  {
    date_reference: "2nd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 5:27-32",
    psalm: "Psalm 118:14-29 or Psalm 150",
    second_reading: "Revelation 1:4-8",
    gospel: "John 20:19-31"
  },

  # 3º Domingo da Páscoa
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 2:14a, 36-41",
    psalm: "Psalm 116:1-4, 12-19",
    second_reading: "1 Peter 1:17-23",
    gospel: "Luke 24:13-35"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 3:12-19",
    psalm: "Psalm 4",
    second_reading: "1 John 3:1-7",
    gospel: "Luke 24:36b-48"
  },
  {
    date_reference: "3rd_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 9:1-6, (7-20)",
    psalm: "Psalm 30",
    second_reading: "Revelation 5:11-14",
    gospel: "John 21:1-19"
  },

  # Ascensão
  {
    date_reference: "ascension",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 1:1-11",
    psalm: "Psalm 47 or Psalm 93",
    second_reading: "Ephesians 1:15-23",
    gospel: "Luke 24:44-53"
  },
  {
    date_reference: "ascension",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 1:1-11",
    psalm: "Psalm 47 or Psalm 93",
    second_reading: "Ephesians 1:15-23",
    gospel: "Luke 24:44-53"
  },
  {
    date_reference: "ascension",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 1:1-11",
    psalm: "Psalm 47 or Psalm 93",
    second_reading: "Ephesians 1:15-23",
    gospel: "Luke 24:44-53"
  },

  # 7º Domingo da Páscoa
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Acts 1:6-14",
    psalm: "Psalm 68:1-10, 32-35",
    second_reading: "1 Peter 4:12-14; 5:6-11",
    gospel: "John 17:1-11"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Acts 1:15-17, 21-26",
    psalm: "Psalm 1",
    second_reading: "1 John 5:9-13",
    gospel: "John 17:6-19"
  },
  {
    date_reference: "7th_sunday_of_easter",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Acts 16:16-34",
    psalm: "Psalm 97",
    second_reading: "Revelation 22:12-14, 16-17, 20-21",
    gospel: "John 17:20-26"
  },

  # Pentecostes
  {
    date_reference: "pentecost",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 2:1-21 or Numbers 11:24-30",
    psalm: "Psalm 104:24-34, 35b",
    second_reading: "1 Corinthians 12:3b-13 or Acts 2:1-21",
    gospel: "John 20:19-23 or John 7:37-39"
  },

  # Santíssima Trindade
  {
    date_reference: "trinity_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Genesis 1:1-2:4a",
    psalm: "Psalm 8",
    second_reading: "2 Corinthians 13:11-13",
    gospel: "Matthew 28:16-20"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaiah 6:1-8",
    psalm: "Psalm 29",
    second_reading: "Romans 8:12-17",
    gospel: "John 3:1-17"
  },
  {
    date_reference: "trinity_sunday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Proverbs 8:1-4, 22-31",
    psalm: "Psalm 8",
    second_reading: "Romans 5:1-5",
    gospel: "John 16:12-15"
  },

  # Cristo Rei
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
  },

  # ============= FESTAS FIXAS =============

  # Apresentação do Senhor (2 de fevereiro)
  {
    date_reference: "presentation_of_the_lord",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Malachi 3:1-4",
    psalm: "Psalm 84 or Psalm 24:7-10",
    second_reading: "Hebrews 2:14-18",
    gospel: "Luke 2:22-40"
  },

  # Anunciação (25 de março)
  {
    date_reference: "annunciation",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 7:10-14",
    psalm: "Psalm 45 or Psalm 40:5-10",
    second_reading: "Hebrews 10:4-10",
    gospel: "Luke 1:26-38"
  },

  # Visitação (31 de maio)
  {
    date_reference: "visitation",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "1 Samuel 2:1-10",
    psalm: "Psalm 113",
    second_reading: "Romans 12:9-16b",
    gospel: "Luke 1:39-57"
  },

  # Transfiguração (6 de agosto)
  {
    date_reference: "transfiguration",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Daniel 7:9-10, 13-14",
    psalm: "Psalm 99",
    second_reading: "2 Peter 1:16-19",
    gospel: "Luke 9:28-36"
  },

  # Todos os Santos (1º de novembro)
  {
    date_reference: "all_saints",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Revelation 7:9-17",
    psalm: "Psalm 34:1-10, 22",
    second_reading: "1 John 3:1-3",
    gospel: "Matthew 5:1-12"
  },

  # ============= TEMPO COMUM (ORDINARY TIME) - PROPERS =============
  # Domingos após Epifania e após Pentecostes

  # Proper 4 (9)
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

  # Proper 10 (15)
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

  # Proper 15 (20)
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

  # Proper 20 (25)
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

  # Proper 25 (30)
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

  # Proper 28 (33) - Último domingo antes de Cristo Rei
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

  # ============= FESTAS DE APÓSTOLOS E EVANGELISTAS =============

  # São Pedro e São Paulo (29 de junho)
  {
    date_reference: "peter_and_paul",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Acts 12:1-11",
    psalm: "Psalm 87",
    second_reading: "2 Timothy 4:6-8, 17-18",
    gospel: "Matthew 16:13-19"
  },

  # São Tiago (25 de julho)
  {
    date_reference: "james_apostle",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "2 Corinthians 4:7-15",
    psalm: "Psalm 126",
    second_reading: "Acts 11:27-12:2",
    gospel: "Matthew 20:20-28"
  },

  # São Bartolomeu (24 de agosto)
  {
    date_reference: "bartholomew",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Exodus 19:1-6a",
    psalm: "Psalm 12",
    second_reading: "1 Corinthians 12:27-31a",
    gospel: "John 1:43-51"
  },

  # São Mateus (21 de setembro)
  {
    date_reference: "matthew",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Proverbs 3:1-6",
    psalm: "Psalm 119:33-40",
    second_reading: "2 Corinthians 4:1-6",
    gospel: "Matthew 9:9-13"
  },

  # São Lucas (18 de outubro)
  {
    date_reference: "luke",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 35:5-8",
    psalm: "Psalm 147:1-7",
    second_reading: "2 Timothy 4:5-13",
    gospel: "Luke 1:1-4"
  },

  # São Simão e São Judas (28 de outubro)
  {
    date_reference: "simon_and_jude",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Deuteronomy 32:1-4",
    psalm: "Psalm 119:89-96",
    second_reading: "Ephesians 2:13-22",
    gospel: "John 15:17-27"
  },

  # Santo André (30 de novembro)
  {
    date_reference: "andrew",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Isaiah 52:7-10",
    psalm: "Psalm 19:1-6",
    second_reading: "Romans 10:12-18",
    gospel: "Matthew 4:18-22"
  },

  # São Tomás (21 de dezembro)
  {
    date_reference: "thomas_apostle",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Habakkuk 2:1-4",
    psalm: "Psalm 126",
    second_reading: "Hebrews 10:35-11:1",
    gospel: "John 20:24-29"
  },

  # São João (27 de dezembro)
  {
    date_reference: "john_apostle",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Exodus 33:18-23",
    psalm: "Psalm 92:1-4, 11-14",
    second_reading: "1 John 1:1-9",
    gospel: "John 21:19b-24"
  },

  # Santos Inocentes (28 de dezembro)
  {
    date_reference: "holy_innocents",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jeremiah 31:15-17",
    psalm: "Psalm 124",
    second_reading: "Revelation 21:1-7",
    gospel: "Matthew 2:13-18"
  }
]

# Criar leituras (evita duplicatas)
count = 0
skipped = 0
readings.each do |reading|
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

puts "\n✅ #{count} leituras criadas!"
puts "⏭️  #{skipped} leituras já existiam." if skipped > 0
