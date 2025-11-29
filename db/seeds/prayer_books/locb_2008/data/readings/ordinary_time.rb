# ================================================================================
# LEITURAS DO TEMPO COMUM II (PRÓPRIOS 1-29) - LOCB 2008
# Domingos após Pentecostes
# Cor litúrgica: Verde
# ================================================================================
#
# Nota sobre o Domingo da Trindade e Próprios:
# - Se o domingo entre 24 e 28 de maio (inclusive) seguir o Domingo da Trindade,
#   devem-se usar as leituras para o oitavo domingo após Epifania
#
# ================================================================================

puts "📖 Criando Leituras do Tempo Comum II (Próprios) - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

ordinary_time_readings = [
  # ================================================================================
  # PRÓPRIO 1 (entre 8 e 14 de maio)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_1",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Dt 30:15-20",
    psalm: "Sl 119:1-8",
    second_reading: "1 Co 3:1-9",
    gospel: "Mt 5:21-37"
  },
  {
    date_reference: "proper_1",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Rs 5:1-14",
    psalm: "Sl 30",
    second_reading: "1 Co 9:24-27",
    gospel: "Mc 1:40-45"
  },
  {
    date_reference: "proper_1",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jr 17:5-10",
    psalm: "Sl 1",
    second_reading: "1 Co 15:12-20",
    gospel: "Lc 6:17-26"
  },

  # ================================================================================
  # PRÓPRIO 2 (entre 15 e 21 de maio)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_2",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Lv 19:1-2, 9-18",
    psalm: "Sl 119:33-40",
    second_reading: "1 Co 3:10-23",
    gospel: "Mt 5:38-48"
  },
  {
    date_reference: "proper_2",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 43:18-25",
    psalm: "Sl 41",
    second_reading: "2 Co 1:18-22",
    gospel: "Mc 2:1-12"
  },
  {
    date_reference: "proper_2",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gn 45:3-11, 15",
    psalm: "Sl 37:1-11, 39-40",
    second_reading: "1 Co 15:35-50",
    gospel: "Lc 6:27-38"
  },

  # ================================================================================
  # PRÓPRIO 3 (entre 22 e 28 de maio)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_3",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 49:8-16a",
    psalm: "Sl 131",
    second_reading: "1 Co 4:1-5",
    gospel: "Mt 6:24-34"
  },
  {
    date_reference: "proper_3",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Os 2:14-20",
    psalm: "Sl 103:1-13, 22",
    second_reading: "2 Co 3:1-6",
    gospel: "Mc 2:13-22"
  },
  {
    date_reference: "proper_3",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 55:10-13",
    psalm: "Sl 92:1-15",
    second_reading: "1 Co 15:51-58",
    gospel: "Lc 6:39-49"
  },

  # ================================================================================
  # PRÓPRIO 4 (entre 29 de maio e 4 de junho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_4",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Dt 11:18-21,26-28",
    psalm: "Sl 31:1-5, 19-24",
    second_reading: "Rm 1:16-17, 3:22-31",
    gospel: "Mt 7:21-29"
  },
  {
    date_reference: "proper_4",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Dt 5:12-15",
    psalm: "Sl 81:1-10",
    second_reading: "2 Co 4:5-12",
    gospel: "Mc 2:23-3:6"
  },
  {
    date_reference: "proper_4",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Rs 8:22-23,41-43",
    psalm: "Sl 96:1-9",
    second_reading: "Gl 1:1-12",
    gospel: "Lc 7:1-10"
  },

  # ================================================================================
  # PRÓPRIO 5 (entre 5 e 11 de junho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_5",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Os 5:15-6.6",
    psalm: "Sl 50:7-15",
    second_reading: "Rm 4:13-25",
    gospel: "Mt 9:9-13, 18-26"
  },
  {
    date_reference: "proper_5",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gn 3:8-15",
    psalm: "Sl 130",
    second_reading: "2 Co 4:13-5.1",
    gospel: "Mc 3:20-35"
  },
  {
    date_reference: "proper_5",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Rs 17:17-24",
    psalm: "Sl 30",
    second_reading: "Gl 1:11-24",
    gospel: "Lc 7:11-17"
  },

  # ================================================================================
  # PRÓPRIO 6 (entre 12 e 18 de junho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_6",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êx 19:2-8a",
    psalm: "Sl 100",
    second_reading: "Rm 5:1-8",
    gospel: "Mt 9:35-10:8 (9-23)"
  },
  {
    date_reference: "proper_6",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ez 17:22-24",
    psalm: "Sl 92:1-4,11-14",
    second_reading: "2 Co 5:6-17",
    gospel: "Mc 4:26-34"
  },
  {
    date_reference: "proper_6",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Sm 11:26-12:15",
    psalm: "Sl 32",
    second_reading: "Gl 2:15-21",
    gospel: "Lc 7:36-8.3"
  },

  # ================================================================================
  # PRÓPRIO 7 (entre 19 e 25 de junho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_7",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jr 20:7-13",
    psalm: "Sl 69:8-20",
    second_reading: "Rm 6:1b-11",
    gospel: "Mt 10:24-39"
  },
  {
    date_reference: "proper_7",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jó 38:1-11",
    psalm: "Sl 107:1-3,23-32",
    second_reading: "2 Co 6:1-13",
    gospel: "Mc 4:35-41"
  },
  {
    date_reference: "proper_7",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 65:1-9",
    psalm: "Sl 22:18-27",
    second_reading: "Gl 3:23-29",
    gospel: "Lc 8:26-39"
  },

  # ================================================================================
  # PRÓPRIO 8 (entre 26 de junho e 2 de julho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_8",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jr 28:5-9",
    psalm: "Sl 89:1-4,15-18 ou Sl 33",
    second_reading: "Rm 6:12-23",
    gospel: "Mt 10:40-42"
  },
  {
    date_reference: "proper_8",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Lm 3:22-33",
    psalm: "Sl 30",
    second_reading: "2 Co 8:7-15",
    gospel: "Mc 5:21-43"
  },
  {
    date_reference: "proper_8",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Rs 19:15-21",
    psalm: "Sl 16",
    second_reading: "Gl 5:1,13-25",
    gospel: "Lc 9:51-62"
  },

  # ================================================================================
  # PRÓPRIO 9 (entre 3 e 9 de julho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_9",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Zc 9:9-12",
    psalm: "Sl 145:8-15",
    second_reading: "Rm 7:15-25a",
    gospel: "Mt 11:16-19, 25-30"
  },
  {
    date_reference: "proper_9",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ez 2:1-5",
    psalm: "Sl 123",
    second_reading: "2 Co 12:2-10",
    gospel: "Mc 6:1-13"
  },
  {
    date_reference: "proper_9",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 66:10-14",
    psalm: "Sl 66:1-8",
    second_reading: "Gl 6:(1-6) 7-16",
    gospel: "Lc 10:1-11,16-20"
  },

  # ================================================================================
  # PRÓPRIO 10 (entre 10 e 16 de julho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_10",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 55:10-13",
    psalm: "Sl 65:(1-8)9-13",
    second_reading: "Rm 8:1-11",
    gospel: "Mt 13:1-9, 18-23"
  },
  {
    date_reference: "proper_10",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Am 7:7-15",
    psalm: "Sl 85:8-13",
    second_reading: "Ef 1:3-14",
    gospel: "Mc 6:14-29"
  },
  {
    date_reference: "proper_10",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Dt 30:9-14",
    psalm: "Sl 25:1-9",
    second_reading: "Cl 1:1-14",
    gospel: "Lc 10:25-37"
  },

  # ================================================================================
  # PRÓPRIO 11 (entre 17 e 23 de julho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_11",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 44:6-8",
    psalm: "Sl 86:11-17",
    second_reading: "Rm 8:12-25",
    gospel: "Mt 13:24-30, 36-43"
  },
  {
    date_reference: "proper_11",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jr 23:1-6",
    psalm: "Sl 23",
    second_reading: "Ef 2:11-22",
    gospel: "Mc 6:30-34, 53-56"
  },
  {
    date_reference: "proper_11",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gn 18:1-10a",
    psalm: "Sl 15",
    second_reading: "Cl 1:15-28",
    gospel: "Lc 10:38-42"
  },

  # ================================================================================
  # PRÓPRIO 12 (entre 24 e 30 de julho)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_12",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "1 Rs 3:5-12",
    psalm: "Sl 119:129-136",
    second_reading: "Rm 8:26-39",
    gospel: "Mt 13:31-33, 44-52"
  },
  {
    date_reference: "proper_12",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Rs 4:42-44",
    psalm: "Sl 145:10-19",
    second_reading: "Ef 3:14-21",
    gospel: "Jo 6:1-21"
  },
  {
    date_reference: "proper_12",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gn 18:20-32",
    psalm: "Sl 138",
    second_reading: "Cl 2:6-19",
    gospel: "Lc 11:1-13"
  },

  # ================================================================================
  # PRÓPRIO 13 (entre 31 de julho e 6 de agosto)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_13",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 55:1-5",
    psalm: "Sl 145:8-9,15-21",
    second_reading: "Rm 9:1-5",
    gospel: "Mt 14:13-21"
  },
  {
    date_reference: "proper_13",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Êx 16:2-4,9-15",
    psalm: "Sl 78:23-29",
    second_reading: "Ef 4:1-16",
    gospel: "Jo 6:24-35"
  },
  {
    date_reference: "proper_13",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Ec 1:2,12-14; 2:18-23",
    psalm: "Sl 143",
    second_reading: "Cl 3:1-11",
    gospel: "Lc 12:13-21"
  },

  # ================================================================================
  # PRÓPRIO 14 (entre 7 e 13 de agosto)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_14",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "1 Rs 19:9-18",
    psalm: "Sl 85:8-13",
    second_reading: "Rm 10:5-15",
    gospel: "Mt 14:22-33"
  },
  {
    date_reference: "proper_14",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Rs 19:4-8",
    psalm: "Sl 34:1-8",
    second_reading: "Ef 4:25-5.2",
    gospel: "Jo 6:35, 41-51"
  },
  {
    date_reference: "proper_14",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gn 15:1-6",
    psalm: "Sl 33:12-22",
    second_reading: "Hb 11:1-3, 8-16",
    gospel: "Lc 12:32-40"
  },

  # ================================================================================
  # PRÓPRIO 15 (entre 14 e 20 de agosto)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_15",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 56:1,6-8",
    psalm: "Sl 67",
    second_reading: "Rm 11:1-2a, 29-32",
    gospel: "Mt 15:10-28"
  },
  {
    date_reference: "proper_15",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Pv 9:1-6",
    psalm: "Sl 34:9-14",
    second_reading: "Ef 5:15-20",
    gospel: "Jo 6:51-58"
  },
  {
    date_reference: "proper_15",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jr 23:23-29",
    psalm: "Sl 82",
    second_reading: "Hb 11:29-12.2",
    gospel: "Lc 12:49-56"
  },

  # ================================================================================
  # PRÓPRIO 16 (entre 21 e 27 de agosto)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_16",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 51:1-6",
    psalm: "Sl 138",
    second_reading: "Rm 12:1-8",
    gospel: "Mt 16:13-20"
  },
  {
    date_reference: "proper_16",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Js 24:1-2a,14-18",
    psalm: "Sl 34:15-22",
    second_reading: "Ef 6:10-20",
    gospel: "Jo 6:56-69"
  },
  {
    date_reference: "proper_16",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 58:9b-14",
    psalm: "Sl 103:1-8",
    second_reading: "Hb 12:18-29",
    gospel: "Lc 13:10-17"
  },

  # ================================================================================
  # PRÓPRIO 17 (entre 28 de agosto e 3 de setembro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_17",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jr 15:15-21",
    psalm: "Sl 26:1-8",
    second_reading: "Rm 12:9-21",
    gospel: "Mt 16:21-28"
  },
  {
    date_reference: "proper_17",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Dt 4:1-2,6-9",
    psalm: "Sl 15",
    second_reading: "Tg 1:17-27",
    gospel: "Mc 7:1-8, 14-15, 21-23"
  },
  {
    date_reference: "proper_17",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Pv 25:6-7",
    psalm: "Sl 112",
    second_reading: "Hb 13:1-8, 15-16",
    gospel: "Lc 14:1, 7-14"
  },

  # ================================================================================
  # PRÓPRIO 18 (entre 4 e 10 de setembro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_18",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ez 33:7-11",
    psalm: "Sl 119:33-40",
    second_reading: "Rm 13:8-14",
    gospel: "Mt 18:15-20"
  },
  {
    date_reference: "proper_18",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 35:4-7a",
    psalm: "Sl 146",
    second_reading: "Tg 2:1-10 (11-13) 14-17",
    gospel: "Mc 7:24-37"
  },
  {
    date_reference: "proper_18",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Dt 30:15-20",
    psalm: "Sl 1",
    second_reading: "Fm 1:21",
    gospel: "Lc 14:25-33"
  },

  # ================================================================================
  # PRÓPRIO 19 (entre 11 e 17 de setembro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_19",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gn 50:15-21",
    psalm: "Sl 103:(1-7)8-13",
    second_reading: "Rm 14:1-12",
    gospel: "Mt 18:21-35"
  },
  {
    date_reference: "proper_19",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 50:4-9a",
    psalm: "Sl 116:1-8",
    second_reading: "Tg 3:1-12",
    gospel: "Mc 8:27-38"
  },
  {
    date_reference: "proper_19",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êx 32:7-14",
    psalm: "Sl 51:1-11",
    second_reading: "1 Tm 1:12-17",
    gospel: "Lc 15:1-10"
  },

  # ================================================================================
  # PRÓPRIO 20 (entre 18 e 24 de setembro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_20",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jn 3:10-4.11",
    psalm: "Sl 145:1-8",
    second_reading: "Fp 1:21-30",
    gospel: "Mt 20:1-16"
  },
  {
    date_reference: "proper_20",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jr 11:18-20",
    psalm: "Sl 54",
    second_reading: "Tg 3:13-4.3, 7-8a",
    gospel: "Mc 9:30-37"
  },
  {
    date_reference: "proper_20",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Am 8:4-7",
    psalm: "Sl 113",
    second_reading: "1 Tm 2:1-7",
    gospel: "Lc 16:1-13"
  },

  # ================================================================================
  # PRÓPRIO 21 (entre 25 de setembro e 1 de outubro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_21",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ez 18:1-4,25-32",
    psalm: "Sl 25:1-8",
    second_reading: "Fp 2:1-13",
    gospel: "Mt 21:23-32"
  },
  {
    date_reference: "proper_21",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Nm 11:4-6,10-16,24-29",
    psalm: "Sl 19:7-14",
    second_reading: "Tg 5:13-20",
    gospel: "Mc 9:38-50"
  },
  {
    date_reference: "proper_21",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Am 6:1a,4-7",
    psalm: "Sl 146",
    second_reading: "1 Tm 6:6-19",
    gospel: "Lc 16:19-31"
  },

  # ================================================================================
  # PRÓPRIO 22 (entre 2 e 8 de outubro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_22",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 5:1-7",
    psalm: "Sl 80:7-14",
    second_reading: "Fp 3:4b-14",
    gospel: "Mt 21:33-46"
  },
  {
    date_reference: "proper_22",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gn 2:18-24",
    psalm: "Sl 8",
    second_reading: "Hb 1:1-4; 2:5-12",
    gospel: "Mc 10:2-12"
  },
  {
    date_reference: "proper_22",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Hc 1:1-4; 2:1-4",
    psalm: "Sl 37:1-10",
    second_reading: "2 Tm 1:1-14",
    gospel: "Lc 17:5-10"
  },

  # ================================================================================
  # PRÓPRIO 23 (entre 9 e 15 de outubro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_23",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 25:1-9",
    psalm: "Sl 23",
    second_reading: "Fp 4:1-9",
    gospel: "Mt 22:1-14"
  },
  {
    date_reference: "proper_23",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Am 5:6-7,10-15",
    psalm: "Sl 90:12-17",
    second_reading: "Hb 4:12-16",
    gospel: "Mc 10:17-31"
  },
  {
    date_reference: "proper_23",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Rs 5:1-3,7-15c",
    psalm: "Sl 111",
    second_reading: "2 Tm 2:8-15",
    gospel: "Lc 17:11-19"
  },

  # ================================================================================
  # PRÓPRIO 24 (entre 16 e 22 de outubro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_24",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Is 45:1-7",
    psalm: "Sl 96:1-9 (10-13)",
    second_reading: "1 Ts 1:1-10",
    gospel: "Mt 22:15-22"
  },
  {
    date_reference: "proper_24",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Is 53:4-12",
    psalm: "Sl 91:9-16",
    second_reading: "Hb 5:1-10",
    gospel: "Mc 10:35-45"
  },
  {
    date_reference: "proper_24",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gn 32:22-31",
    psalm: "Sl 121",
    second_reading: "2 Tm 3:14-4.5",
    gospel: "Lc 18:1-8"
  },

  # ================================================================================
  # PRÓPRIO 25 (entre 23 e 29 de outubro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_25",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Lv 19:1-2,15-18",
    psalm: "Sl 1",
    second_reading: "1 Ts 2:1-8",
    gospel: "Mt 22:34-46"
  },
  {
    date_reference: "proper_25",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jr 31:7-9",
    psalm: "Sl 126",
    second_reading: "Hb 7:23-28",
    gospel: "Mc 10:46-52"
  },
  {
    date_reference: "proper_25",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jr 14:7-10,19-22",
    psalm: "Sl 84:1-6",
    second_reading: "2 Tm 4:6-8, 16-18",
    gospel: "Lc 18:9-14"
  },

  # ================================================================================
  # PRÓPRIO 26 (entre 30 de outubro e 5 de novembro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_26",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Mq 3:5-12",
    psalm: "Sl 43",
    second_reading: "1 Ts 2:9-13",
    gospel: "Mt 23:1-12"
  },
  {
    date_reference: "proper_26",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Dt 6:1-9",
    psalm: "Sl 119:1-8",
    second_reading: "Hb 9:11-14",
    gospel: "Mc 12:28-34"
  },
  {
    date_reference: "proper_26",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Is 1:10-18",
    psalm: "Sl 32:1-8",
    second_reading: "2 Ts 1:1-4, 11-12",
    gospel: "Lc 19:1-10"
  },

  # ================================================================================
  # PRÓPRIO 27 (entre 6 e 12 de novembro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_27",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Am 5:18-24",
    psalm: "Sl 70",
    second_reading: "1 Ts 4:13-18",
    gospel: "Mt 25:1-13"
  },
  {
    date_reference: "proper_27",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Rs 17:8-16",
    psalm: "Sl 146",
    second_reading: "Hb 9:24-28",
    gospel: "Mc 12:38-44"
  },
  {
    date_reference: "proper_27",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jó 19:23-27a",
    psalm: "Sl 17:1-9",
    second_reading: "2 Ts 2:1-5, 13-17",
    gospel: "Lc 20:27-38"
  },

  # ================================================================================
  # PRÓPRIO 28 (entre 13 e 19 de novembro)
  # Cor litúrgica: Verde
  # ================================================================================
  {
    date_reference: "proper_28",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jz 4:1-7",
    psalm: "Sl 90:1-8 (9-10) 12",
    second_reading: "1 Ts 5:1-11",
    gospel: "Mt 25:14-30"
  },
  {
    date_reference: "proper_28",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Dn 12:1-3",
    psalm: "Sl 16",
    second_reading: "Hb 10:11-14(15-18) 19-25",
    gospel: "Mc 13:1-8"
  },
  {
    date_reference: "proper_28",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Ml 4:1-2a",
    psalm: "Sl 98",
    second_reading: "2 Ts 3:6-13",
    gospel: "Lc 21:5-19"
  },

  # ================================================================================
  # PRÓPRIO 29 - CRISTO REI (entre 20 e 26 de novembro)
  # Cor litúrgica: Branco
  # Último domingo após Pentecostes
  # ================================================================================
  {
    date_reference: "proper_29",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ez 34:11-16,20-24",
    psalm: "Sl 95:1-7a",
    second_reading: "Ef 1:15-23",
    gospel: "Mt 25:31-46"
  },
  {
    date_reference: "proper_29",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Dn 7:9-10,13-14",
    psalm: "Sl 93",
    second_reading: "Ap 1:4b-8",
    gospel: "Jo 18:33-37"
  },
  {
    date_reference: "proper_29",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jr 23:1-6",
    psalm: "Sl 46",
    second_reading: "Cl 1:11-20",
    gospel: "Lc 23:33-43"
  }
]

# Criar leituras
count = 0
skipped = 0

ordinary_time_readings.each do |reading|
  reading[:prayer_book_id] = prayer_book&.id
  existing = LectionaryReading.find_by(
    date_reference: reading[:date_reference],
    cycle: reading[:cycle],
    service_type: reading[:service_type],
    prayer_book_id: prayer_book&.id
  )

  if existing.nil?
    LectionaryReading.create!(reading)
    count += 1
    print "." if count % 10 == 0
  else
    skipped += 1
  end
end

puts "\n✅ Leituras do Tempo Comum criadas: #{count}"
puts "⏭️  Leituras já existentes: #{skipped}" if skipped > 0
