# ================================================================================
# LEITURAS DOS DIAS SANTOS E FESTAS MAIORES - LOCB 2008
# ================================================================================

puts "📖 Criando Leituras dos Dias Santos e Festas Maiores - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

holy_days_readings = [
  # ================================================================================
  # JANEIRO
  # ================================================================================
  {
    date_reference: "holy_name",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 9:2-7",
    psalm: "Sl 8",
    second_reading: "At 4:8-12",
    gospel: "Lc 2:15-21"
  },
  {
    date_reference: "conversion_of_paul",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "At 26:9-23",
    psalm: "Sl 67",
    second_reading: "Gl 1:11-24",
    gospel: "Mc 10:46-52"
  },

  # ================================================================================
  # FEVEREIRO
  # ================================================================================
  {
    date_reference: "presentation",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Ml 3:1-4",
    psalm: "Sl 24",
    second_reading: "Hb 2:14-18",
    gospel: "Lc 2:22-40"
  },

  # ================================================================================
  # MARÇO
  # ================================================================================
  {
    date_reference: "john_charles_wesley",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êx 3:1-15",
    psalm: "Sl 31",
    second_reading: "Cl 3:12-17",
    gospel: "Mt 12:46-50"
  },
  {
    date_reference: "joseph",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Dt 33:13-16",
    psalm: "Sl 89:2-9",
    second_reading: "Fl 4:5-8",
    gospel: "Mt 13:53-58"
  },
  {
    date_reference: "thomas_cranmer",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êx 3:1-15",
    psalm: "Sl 31",
    second_reading: "Cl 3:12-17",
    gospel: "Mt 12:46-50"
  },
  {
    date_reference: "annunciation",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 7:10-14",
    psalm: "Sl 113",
    second_reading: "Rm 5:12-17",
    gospel: "Lc 1:26-38"
  },

  # ================================================================================
  # ABRIL
  # ================================================================================
  {
    date_reference: "mark",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 52:7-10",
    psalm: "Sl 119:9-16",
    second_reading: "Ef 4:7-16",
    gospel: "Mc 1:1-15"
  },

  # ================================================================================
  # MAIO
  # ================================================================================
  {
    date_reference: "philip_and_james",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Pr 4:10-18",
    psalm: "Sl 84",
    second_reading: "1 Co 12:4-13",
    gospel: "Jo 14:1-14"
  },
  {
    date_reference: "matthias",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 22:15-22",
    psalm: "Sl 16",
    second_reading: "At 1:15-26",
    gospel: "Jo 13:12-30"
  },
  {
    date_reference: "visitation",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Sf 3:14-18a",
    psalm: "Sl 113",
    second_reading: "Ef 5:18b-20",
    gospel: "Lc 1:39-49"
  },

  # ================================================================================
  # JUNHO
  # ================================================================================
  {
    date_reference: "barnabas",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 29:11-16",
    psalm: "Sl 112",
    second_reading: "At 11:19-30",
    gospel: "Jo 15:12-17"
  },
  {
    date_reference: "nativity_of_john_the_baptist",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 40:1-11",
    psalm: "Sl 119:161-168",
    second_reading: "At 13:16-25",
    gospel: "Lc 1:57-66,80"
  },
  {
    date_reference: "peter_and_paul",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jn 3",
    psalm: "Sl 34:2-10",
    second_reading: "2 Tm 4:1-8",
    gospel: "Mt 16:13-19"
  },

  # ================================================================================
  # JULHO
  # ================================================================================
  {
    date_reference: "thomas",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 42:1-6",
    psalm: "Sl 126",
    second_reading: "Hb 10:35-11:1",
    gospel: "Jo 20:24-29"
  },
  {
    date_reference: "mary_magdalene",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Ct 3:1-4a",
    psalm: "Sl 63:2-10",
    second_reading: "2 Co 5:14-17",
    gospel: "Jo 20:1-18"
  },
  {
    date_reference: "james_the_apostle",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jr 45",
    psalm: "Sl 15",
    second_reading: "At 11:27-12:3",
    gospel: "Mc 10:35-45"
  },

  # ================================================================================
  # AGOSTO
  # ================================================================================
  {
    date_reference: "transfiguration",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êx 34:29-35",
    psalm: "Sl 99",
    second_reading: "2 Co 3:4-18",
    gospel: "Lc 9:28-36"
  },
  {
    date_reference: "bartholomew",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Gn 28:10-17",
    psalm: "Sl 103:1b-8",
    second_reading: "At 5:12-16",
    gospel: "Jo 1:43-51"
  },

  # ================================================================================
  # SETEMBRO
  # ================================================================================
  {
    date_reference: "blessed_virgin_mary",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Gn 3:8-15",
    psalm: "Sl 113",
    second_reading: "Gl 4:4-7",
    gospel: "Lc 11:27-28 ou Lc 1:39-49"
  },
  {
    date_reference: "matthew",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Pr 3:9-18",
    psalm: "Sl 19",
    second_reading: "2 Tm 3:14-17",
    gospel: "Mt 9:9-13"
  },
  {
    date_reference: "michael_and_all_angels",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jó 38:1-7",
    psalm: "Sl 148:1-6",
    second_reading: "Ap 12:7-12",
    gospel: "Mt 18:1-10"
  },

  # ================================================================================
  # OUTUBRO
  # ================================================================================
  {
    date_reference: "luke",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 61:1-6",
    psalm: "Sl 147:1-7",
    second_reading: "At 1:1-8",
    gospel: "Lc 10:1-9"
  },
  {
    date_reference: "simon_and_jude",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 28:9-16",
    psalm: "Sl 119:89-96",
    second_reading: "Ap 21:9-14",
    gospel: "Lc 6:12-23"
  },
  {
    date_reference: "reformation_day",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êx 3:1-15",
    psalm: "Sl 31",
    second_reading: "Cl 3:12-17",
    gospel: "Mt 12:46-50"
  },

  # ================================================================================
  # NOVEMBRO
  # ================================================================================
  {
    date_reference: "all_saints",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jr 31:31-34",
    psalm: "Sl 150",
    second_reading: "Ap 7:2-4,9-14",
    gospel: "Mt 5:1-12"
  },
  {
    date_reference: "andrew",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Zc 8:20-23",
    psalm: "Sl 47",
    second_reading: "Rm 10:8b-18",
    gospel: "Jo 1:35-42"
  },

  # ================================================================================
  # DEZEMBRO
  # ================================================================================
  {
    date_reference: "stephen",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "2 Cr 24:17-22",
    psalm: "Sl 31:2-6",
    second_reading: "At 6:8-10; 7:54-60",
    gospel: "Mt 10:17-22"
  },
  {
    date_reference: "john_evangelist",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Is 6:1-8",
    psalm: "Sl 97",
    second_reading: "1 Jo 1",
    gospel: "Jo 21:20-24"
  },
  {
    date_reference: "holy_innocents",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Jr 31:15-17",
    psalm: "Sl 124",
    second_reading: "1 Pe 4:12-16",
    gospel: "Mt 2:13-18"
  },
  {
    date_reference: "john_wycliff",
    cycle: "all",
    service_type: "eucharist",
    first_reading: "Êx 3:1-15",
    psalm: "Sl 31",
    second_reading: "Cl 3:12-17",
    gospel: "Mt 12:46-50"
  }
]

# Criar leituras
count = 0
skipped = 0

holy_days_readings.each do |reading|
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
  else
    skipped += 1
  end
end

puts "✅ Leituras dos Dias Santos criadas: #{count}"
puts "⏭️  Leituras já existentes: #{skipped}" if skipped > 0
