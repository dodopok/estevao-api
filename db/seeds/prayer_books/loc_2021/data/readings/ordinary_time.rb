# ================================================================================
# LEITURAS DO TEMPO COMUM - LOC 2021 IAB
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Tempo Comum (LOC 2021 IAB)..."

prayer_book = PrayerBook.find_by!(code: 'loc_2021')

ordinary_readings = [
  # ----------------------------------------------------------------------------
  # PRÓPRIO 1 (Entre 8 e 14 de Maio)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_1",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30.15-20",
    psalm: "Salmo 119.1-8",
    second_reading: "1 Coríntios 3.1-9",
    gospel: "Mateus 5.21-37"
  },
  {
    date_reference: "proper_1",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Reis 5.1-14",
    psalm: "Salmo 30",
    second_reading: "1 Coríntios 9.24-27",
    gospel: "Marcos 1.40-45"
  },
  {
    date_reference: "proper_1",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 17.5-10",
    psalm: "Salmo 1",
    second_reading: "1 Coríntios 15.12-20",
    gospel: "Lucas 6.17-26"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 2 (Entre 15 e 21 de Maio)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_2",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Levítico 19.1-2, 9-18",
    psalm: "Salmo 119.33-40",
    second_reading: "1 Coríntios 3.10-23",
    gospel: "Mateus 5.38-48"
  },
  {
    date_reference: "proper_2",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 43.18-25",
    psalm: "Salmo 41",
    second_reading: "2 Coríntios 1.18-22",
    gospel: "Marcos 2.1-12"
  },
  {
    date_reference: "proper_2",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 45.3-11, 15",
    psalm: "Salmo 37.1-11, 39-40",
    second_reading: "1 Coríntios 15.35-50",
    gospel: "Lucas 6.27-38"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 3 (Entre 22 e 28 de Maio)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_3",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 49.8-16a",
    psalm: "Salmo 131",
    second_reading: "1 Coríntios 4.1-5",
    gospel: "Mateus 6.24-34"
  },
  {
    date_reference: "proper_3",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Oseias 2.14-20",
    psalm: "Salmo 103.1-13, 22",
    second_reading: "2 Coríntios 3.1-6",
    gospel: "Marcos 2.13-22"
  },
  {
    date_reference: "proper_3",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 55.10-13",
    psalm: "Salmo 92.1-15",
    second_reading: "1 Coríntios 15.51-58",
    gospel: "Lucas 6.39-49"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 4 (29 de Maio e 4 de Junho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_4",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Deuteronômio 11.18-21, 26-28",
    psalm: "Salmo 31.1-5, 19-24",
    second_reading: "Romanos 1.16-17; 3.22-31",
    gospel: "Mateus 7.21-29"
  },
  {
    date_reference: "proper_4",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 5.12-15",
    psalm: "Salmo 81.1-10",
    second_reading: "2 Coríntios 4.5-12",
    gospel: "Marcos 2.23-3.6"
  },
  {
    date_reference: "proper_4",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Reis 8.22-23, 41-43",
    psalm: "Salmo 96.1-9",
    second_reading: "Gálatas 1.1-12",
    gospel: "Lucas 7.1-10"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 5 (Entre 5 e 11 de Junho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_5",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Oseias 5.15-6.6",
    psalm: "Salmo 50.7-15",
    second_reading: "Romanos 4.13-25",
    gospel: "Mateus 9.9-13, 18-26"
  },
  {
    date_reference: "proper_5",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 3.8-15",
    psalm: "Salmo 130",
    second_reading: "2 Coríntios 4.13-5.1",
    gospel: "Marcos 3.20-35"
  },
  {
    date_reference: "proper_5",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Reis 17.17-24",
    psalm: "Salmo 30",
    second_reading: "Gálatas 1.11-24",
    gospel: "Lucas 7.11-17"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 6 (Entre 12 e 18 de Junho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_6",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 19.2-8a",
    psalm: "Salmo 100",
    second_reading: "Romanos 5.1-8",
    gospel: "Mateus 9.35-10.8 (9-23)"
  },
  {
    date_reference: "proper_6",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ezequiel 17.22-24",
    psalm: "Salmo 92.1-4, 11-14",
    second_reading: "2 Coríntios 5.6-17",
    gospel: "Marcos 4.26-34"
  },
  {
    date_reference: "proper_6",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Samuel 11.26-12.15",
    psalm: "Salmo 32",
    second_reading: "Gálatas 2.15-21",
    gospel: "Lucas 7.36-8.3"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 7 (Entre 19 e 25 de Junho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_7",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jeremias 20.7-13",
    psalm: "Salmo 69.8-20",
    second_reading: "Romanos 6.1b-11",
    gospel: "Mateus 10.24-39"
  },
  {
    date_reference: "proper_7",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jó 38.1-11",
    psalm: "Salmo 107.1-3, 23-32",
    second_reading: "2 Coríntios 6.1-13",
    gospel: "Marcos 4.35-41"
  },
  {
    date_reference: "proper_7",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 65.1-9",
    psalm: "Salmo 22.18-27",
    second_reading: "Gálatas 3.23-29",
    gospel: "Lucas 8.26-39"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 8 (Entre 26 de Junho e 2 de Julho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_8",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jeremias 28.5-9",
    psalm: "Salmo 89.1-4, 15-18",
    second_reading: "Romanos 6.12-23",
    gospel: "Mateus 10.40-42"
  },
  {
    date_reference: "proper_8",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Lamentações 3.22-33",
    psalm: "Salmo 30",
    second_reading: "2 Coríntios 8.7-15",
    gospel: "Marcos 5.21-43"
  },
  {
    date_reference: "proper_8",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "1 Reis 19.15-21",
    psalm: "Salmo 16",
    second_reading: "Gálatas 5.1, 13-25",
    gospel: "Lucas 9.51-62"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 9 (Entre 3 e 9 de Julho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_9",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Zacarias 9.9-12",
    psalm: "Salmo 145.8-15",
    second_reading: "Romanos 7.15-25a",
    gospel: "Mateus 11.16-19, 25-30"
  },
  {
    date_reference: "proper_9",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Ezequiel 2.1-5",
    psalm: "Salmo 123",
    second_reading: "2 Coríntios 12.2-10",
    gospel: "Marcos 6.1-13"
  },
  {
    date_reference: "proper_9",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 66.10-14",
    psalm: "Salmo 66.1-8",
    second_reading: "Gálatas 6.(1-6) 7-16",
    gospel: "Lucas 10.1-11, 16-20"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 10 (Entre 10 e 16 de Julho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_10",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 55.10-13",
    psalm: "Salmo 65.(1-8) 9-13",
    second_reading: "Romanos 8.1-11",
    gospel: "Mateus 13.1-9, 18-23"
  },
  {
    date_reference: "proper_10",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amós 7.7-15",
    psalm: "Salmo 85.8-13",
    second_reading: "Efésios 1.3-14",
    gospel: "Marcos 6.14-29"
  },
  {
    date_reference: "proper_10",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30.9-14",
    psalm: "Salmo 25.1-9",
    second_reading: "Colossenses 1.1-14",
    gospel: "Lucas 10.25-37"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 11 (Entre 17 e 23 de Julho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_11",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 44.6-8",
    psalm: "Salmo 86.11-17",
    second_reading: "Romanos 8.12-25",
    gospel: "Mateus 13.24-30, 36-43"
  },
  {
    date_reference: "proper_11",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 23.1-6",
    psalm: "Salmo 23",
    second_reading: "Efésios 2.11-22",
    gospel: "Marcos 6.30-34, 53-56"
  },
  {
    date_reference: "proper_11",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 18.1-10a",
    psalm: "Salmo 15",
    second_reading: "Colossenses 1.15-28",
    gospel: "Lucas 10.38-42"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 12 (Entre 24 e 30 de Julho)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_12",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "1 Reis 3.5-12",
    psalm: "Salmo 119.129-136",
    second_reading: "Romanos 8.26-39",
    gospel: "Mateus 13.31-33, 44-52"
  },
  {
    date_reference: "proper_12",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "2 Reis 4.42-44",
    psalm: "Salmo 145.10-19",
    second_reading: "Efésios 3.14-21",
    gospel: "João 6.1-21"
  },
  {
    date_reference: "proper_12",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 18.20-32",
    psalm: "Salmo 138",
    second_reading: "Colossenses 2.6-19",
    gospel: "Lucas 11.1-13"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 13 (Entre 31 de Julho e 6 de Agosto)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_13",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 55.1-5",
    psalm: "Salmo 145.8-9, 15-21",
    second_reading: "Romanos 9.1-5",
    gospel: "Mateus 14.13-21"
  },
  {
    date_reference: "proper_13",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Êxodo 16.2-4, 9-15",
    psalm: "Salmo 78.23-29",
    second_reading: "Efésios 4.1-16",
    gospel: "João 6.24-35"
  },
  {
    date_reference: "proper_13",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Eclesiastes 1.2, 12-14; 2.18-23",
    psalm: "Salmo 43",
    second_reading: "Colossenses 3.1-11",
    gospel: "Lucas 12.13-21"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 14 (Entre 7 e 13 de Agosto)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_14",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "1 Reis 19.9-18",
    psalm: "Salmo 85.8-13",
    second_reading: "Romanos 10.5-15",
    gospel: "Mateus 14.22-33"
  },
  {
    date_reference: "proper_14",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Reis 19.4-8",
    psalm: "Salmo 34.1-8",
    second_reading: "Efésios 4.25-5.2",
    gospel: "João 6.35, 41-51"
  },
  {
    date_reference: "proper_14",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 15.1-6",
    psalm: "Salmo 33.12-22",
    second_reading: "Hebreus 11.1-3, 8-16",
    gospel: "Lucas 12.32-40"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 15 (Entre 14 e 20 de Agosto)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_15",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 56.1, 6-8",
    psalm: "Salmo 67",
    second_reading: "Romanos 11.1-2a, 29-32",
    gospel: "Mateus 15.10-28"
  },
  {
    date_reference: "proper_15",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Provérbios 9.1-6",
    psalm: "Salmo 34.9-14",
    second_reading: "Efésios 5.15-20",
    gospel: "João 6.51-58"
  },
  {
    date_reference: "proper_15",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 23.23-29",
    psalm: "Salmo 82",
    second_reading: "Hebreus 11.29-12.2",
    gospel: "Lucas 12.49-56"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 16 (Entre 21 e 27 de Agosto)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_16",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 51.1-6",
    psalm: "Salmo 138",
    second_reading: "Romanos 12.1-8",
    gospel: "Mateus 16.13-20"
  },
  {
    date_reference: "proper_16",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Josué 24.1-2a, 14-18",
    psalm: "Salmo 34.15-22",
    second_reading: "Efésios 6.10-20",
    gospel: "João 6.56-69"
  },
  {
    date_reference: "proper_16",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 58.9b-14",
    psalm: "Salmo 103.1-8",
    second_reading: "Hebreus 12.18-29",
    gospel: "Lucas 13.10-17"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 17 (Entre 28 de Agosto e 3 de Setembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_17",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jeremias 15.15-21",
    psalm: "Salmo 26.1-8",
    second_reading: "Romanos 12.9-21",
    gospel: "Mateus 16.21-28"
  },
  {
    date_reference: "proper_17",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 4.1-2, 6-9",
    psalm: "Salmo 15",
    second_reading: "Tiago 1.17-27",
    gospel: "Marcos 7.1-8, 14-15, 21-23"
  },
  {
    date_reference: "proper_17",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Provérbios 25.6-7a",
    psalm: "Salmo 112",
    second_reading: "Hebreus 13.1-8, 15-16",
    gospel: "Lucas 14.1, 7-14"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 18 (Entre 4 e 10 de Setembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_18",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 33.7-11",
    psalm: "Salmo 119.33-40",
    second_reading: "Romanos 13.8-14",
    gospel: "Mateus 18.15-20"
  },
  {
    date_reference: "proper_18",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 35.4-7a",
    psalm: "Salmo 146",
    second_reading: "Tiago 2.1-10 (11-13) 14-17",
    gospel: "Marcos 7.24-37"
  },
  {
    date_reference: "proper_18",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Deuteronômio 30.15-20",
    psalm: "Salmo 1",
    second_reading: "Filêmon 1-21",
    gospel: "Lucas 14.25-33"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 19 (Entre 11 e 17 de Setembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_19",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Gênesis 50.15-21",
    psalm: "Salmo 103.(1-7) 8-13",
    second_reading: "Romanos 14.1-12",
    gospel: "Mateus 18.21-35"
  },
  {
    date_reference: "proper_19",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 50.4-9a",
    psalm: "Salmo 116.1-8",
    second_reading: "Tiago 3.1-12",
    gospel: "Marcos 8.27-38"
  },
  {
    date_reference: "proper_19",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 32.7-14",
    psalm: "Salmo 51.1-11",
    second_reading: "1 Timóteo 1.12-17",
    gospel: "Lucas 15.1-10"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 20 (Entre 18 e 24 de Setembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_20",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Jonas 3.10-4.11",
    psalm: "Salmo 145.1-8",
    second_reading: "Filipenses 1.21-30",
    gospel: "Mateus 20.1-16"
  },
  {
    date_reference: "proper_20",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 11.18-20",
    psalm: "Salmo 54",
    second_reading: "Tiago 3.13-4.3, 7-8a",
    gospel: "Marcos 9.30-37"
  },
  {
    date_reference: "proper_20",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amós 8.4-7",
    psalm: "Salmo 113",
    second_reading: "1 Timóteo 2.1-7",
    gospel: "Lucas 16.1-13"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 21 (Entre 25 de Setembro e 1 de Outubro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_21",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 18.1-4, 25-32",
    psalm: "Salmo 25.1-8",
    second_reading: "Filipenses 2.1-13",
    gospel: "Mateus 21.23-32"
  },
  {
    date_reference: "proper_21",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Números 11.4-6, 10-16, 24-29",
    psalm: "Salmo 19.7-14",
    second_reading: "Tiago 5.13-20",
    gospel: "Marcos 9.38-50"
  },
  {
    date_reference: "proper_21",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Amós 6.1a, 4-7",
    psalm: "Salmo 146",
    second_reading: "1 Timóteo 6.6-19",
    gospel: "Lucas 16.19-31"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 22 (Entre 2 e 8 de Outubro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_22",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 5.1-7",
    psalm: "Salmo 80.7-14",
    second_reading: "Filipenses 3.4b-14",
    gospel: "Mateus 21.33-46"
  },
  {
    date_reference: "proper_22",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Gênesis 2.18-24",
    psalm: "Salmo 8",
    second_reading: "Hebreus 1.1-4; 2.5-12",
    gospel: "Marcos 10.2-12"
  },
  {
    date_reference: "proper_22",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Habacuque 1.1-4; 2.1-4",
    psalm: "Salmo 37.1-10",
    second_reading: "2 Timóteo 1.1-14",
    gospel: "Lucas 17.5-10"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 23 (Entre 9 e 15 de Outubro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_23",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 25.1-9",
    psalm: "Salmo 23",
    second_reading: "Filipenses 4.1-9",
    gospel: "Mateus 22.1-14"
  },
  {
    date_reference: "proper_23",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Amós 5.6-7, 10-15",
    psalm: "Salmo 90.12-17",
    second_reading: "Hebreus 4.12-16",
    gospel: "Marcos 10.17-31"
  },
  {
    date_reference: "proper_23",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "2 Reis 5.1-3, 7-15c",
    psalm: "Salmo 111",
    second_reading: "2 Timóteo 2.8-15",
    gospel: "Lucas 17.11-19"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 24 (Entre 16 e 22 de Outubro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_24",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 45.1-7",
    psalm: "Salmo 96.1-9 (10-13)",
    second_reading: "1 Tessalonicenses 1.1-10",
    gospel: "Mateus 22.15-22"
  },
  {
    date_reference: "proper_24",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Isaías 53.4-12",
    psalm: "Salmo 91.9-16",
    second_reading: "Hebreus 5.1-10",
    gospel: "Marcos 10.35-45"
  },
  {
    date_reference: "proper_24",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Gênesis 32.22-31",
    psalm: "Salmo 121",
    second_reading: "2 Timóteo 3.14-4.5",
    gospel: "Lucas 18.1-8"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 25 (Entre 23 e 29 de Outubro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_25",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Levítico 19.1-2, 15-18",
    psalm: "Salmo 1",
    second_reading: "1 Tessalonicenses 2.1-8",
    gospel: "Mateus 22.34-46"
  },
  {
    date_reference: "proper_25",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Jeremias 31.7-9",
    psalm: "Salmo 126",
    second_reading: "Hebreus 7.23-28",
    gospel: "Marcos 10.46-52"
  },
  {
    date_reference: "proper_25",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 14.7-10, 19-22",
    psalm: "Salmo 84.1-6",
    second_reading: "2 Timóteo 4.6-8, 16-18",
    gospel: "Lucas 18.9-14"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 26 (Entre 30 de Outubro e 5 de Novembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_26",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Miqueias 3.5-12",
    psalm: "Salmo 43",
    second_reading: "1 Tessalonicenses 2.9-13",
    gospel: "Mateus 23.1-12"
  },
  {
    date_reference: "proper_26",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Deuteronômio 6.1-9",
    psalm: "Salmo 119.1-8",
    second_reading: "Hebreus 9.11-14",
    gospel: "Marcos 12.28-34"
  },
  {
    date_reference: "proper_26",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 1.10-18",
    psalm: "Salmo 32.1-8",
    second_reading: "2 Tessalonicenses 1.1-4, 11-12",
    gospel: "Lucas 19.1-10"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 27 (Entre 6 e 12 de Novembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_27",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Amós 5.18-24",
    psalm: "Salmo 70",
    second_reading: "1 Tessalonicenses 4.13-18",
    gospel: "Mateus 25.1-13"
  },
  {
    date_reference: "proper_27",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "1 Reis 17.8-16",
    psalm: "Salmo 146",
    second_reading: "Hebreus 9.24-28",
    gospel: "Marcos 12.38-44"
  },
  {
    date_reference: "proper_27",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jó 19.23-27a",
    psalm: "Salmo 17.1-9",
    second_reading: "2 Tessalonicenses 2.1-5, 13-17",
    gospel: "Lucas 20.27-38"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 28 (Entre 13 e 19 de Novembro)
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_28",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Juízes 4.1-7",
    psalm: "Salmo 90.1-8 (9-10) 12",
    second_reading: "1 Tessalonicenses 5.1-11",
    gospel: "Mateus 25.14-30"
  },
  {
    date_reference: "proper_28",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Daniel 12.1-3",
    psalm: "Salmo 16",
    second_reading: "Hebreus 10.11-14 (15-18) 19-25",
    gospel: "Marcos 13.1-8"
  },
  {
    date_reference: "proper_28",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Malaquias 4.1-2a",
    psalm: "Salmo 98",
    second_reading: "2 Tessalonicenses 3.6-13",
    gospel: "Lucas 21.5-19"
  },

  # ----------------------------------------------------------------------------
  # PRÓPRIO 29 (Entre 20 e 26 de Novembro) - CRISTO REI
  # ----------------------------------------------------------------------------
  {
    date_reference: "proper_29",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Ezequiel 34.11-16, 20-24",
    psalm: "Salmo 95.1-7a",
    second_reading: "Efésios 1.15-23",
    gospel: "Mateus 25.31-46"
  },
  {
    date_reference: "proper_29",
    cycle: "B",
    service_type: "eucharist",
    first_reading: "Daniel 7.9-10, 13-14",
    psalm: "Salmo 93",
    second_reading: "Apocalipse 1.4b-8",
    gospel: "João 18.33-37"
  },
  {
    date_reference: "proper_29",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Jeremias 23.1-6",
    psalm: "Salmo 46",
    second_reading: "Colossenses 1.11-20",
    gospel: "Lucas 23.33-43"
  }
]

count = 0
skipped = 0

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
    count += 1
  else
    existing.update!(reading)
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras do Tempo Comum criadas!"
Rails.logger.info "⏭️  #{skipped} atualizadas/existiam." if skipped > 0
