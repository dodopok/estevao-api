# ================================================================================
# LEITURAS DA SEMANA SANTA - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Holy Week readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

holy_week_readings = [
  # --- PALM SUNDAY ---
  { date_reference: "palm_sunday", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 52:13-53:12", psalm: "Psalm 22:1-21 or Psalm 22:1-11", second_reading: "Philippians 2:5-11", gospel: "Matthew (26:36-75)27:1-54(55-66)" },
  { date_reference: "palm_sunday", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 52:13-53:12", psalm: "Psalm 22:1-11 or Psalm 22:1-21", second_reading: "Philippians 2:5-11", gospel: "Mark (14:32-72)15:1-39(40-47)" },
  { date_reference: "palm_sunday", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 52:13-53:12", psalm: "Psalm 22:1-11 or Psalm 22:1-21", second_reading: "Philippians 2:5-11", gospel: "Luke (22:39-71)23:1-49(50-56)" },

  # --- MONDAY OF HOLY WEEK ---
  { date_reference: "monday_of_holy_week", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 42:1-9", psalm: "Psalm 36:5-10", second_reading: "Hebrews 11:39-12:3", gospel: "John 12:1-11 or Mark 14:3-9" },
  { date_reference: "monday_of_holy_week", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 42:1-9", psalm: "Psalm 36:5-10", second_reading: "Hebrews 11:39-12:3", gospel: "John 12:1-11 or Mark 14:3-9" },
  { date_reference: "monday_of_holy_week", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 42:1-9", psalm: "Psalm 36:5-10", second_reading: "Hebrews 11:39-12:3", gospel: "John 12:1-11 or Mark 14:3-9" },

  # --- TUESDAY OF HOLY WEEK ---
  { date_reference: "tuesday_of_holy_week", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 49:1-6", psalm: "Psalm 71:1-11", second_reading: "1 Corinthians 1:18-31", gospel: "John 12:37-38, 42-50 or Mark 11:15-19" },
  { date_reference: "tuesday_of_holy_week", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 49:1-6", psalm: "Psalm 71:1-11", second_reading: "1 Corinthians 1:18-31", gospel: "John 12:37-38, 42-50 or Mark 11:15-19" },
  { date_reference: "tuesday_of_holy_week", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 49:1-6", psalm: "Psalm 71:1-11", second_reading: "1 Corinthians 1:18-31", gospel: "John 12:37-38, 42-50 or Mark 11:15-19" },

  # --- WEDNESDAY OF HOLY WEEK ---
  { date_reference: "wednesday_of_holy_week", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 50:4-9", psalm: "Psalm 69:6-14, 21-22", second_reading: "Hebrews 9:11-28", gospel: "Matthew 26:1-5, 14-25" },
  { date_reference: "wednesday_of_holy_week", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 50:4-9", psalm: "Psalm 69:6-14, 21-22", second_reading: "Hebrews 9:11-28", gospel: "Matthew 26:1-5, 14-25" },
  { date_reference: "wednesday_of_holy_week", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 50:4-9", psalm: "Psalm 69:6-14, 21-22", second_reading: "Hebrews 9:11-28", gospel: "Matthew 26:1-5, 14-25" },

  # --- MAUNDY THURSDAY ---
  { date_reference: "maundy_thursday", cycle: "A", service_type: "eucharist", first_reading: "Exodus 12:1-14", psalm: "Psalm 78:15-26", second_reading: "1 Corinthians 11:23-26(27-34)", gospel: "John 13:1-15 or Luke 22:14-30" },
  { date_reference: "maundy_thursday", cycle: "B", service_type: "eucharist", first_reading: "Exodus 12:1-14", psalm: "Psalm 78:15-26", second_reading: "1 Corinthians 11:23-26(27-34)", gospel: "John 13:1-15 or Luke 22:14-30" },
  { date_reference: "maundy_thursday", cycle: "C", service_type: "eucharist", first_reading: "Exodus 12:1-14", psalm: "Psalm 78:15-26", second_reading: "1 Corinthians 11:23-26(27-34)", gospel: "John 13:1-15 or Luke 22:14-30" },

  # --- GOOD FRIDAY ---
  { date_reference: "good_friday", cycle: "A", service_type: "eucharist", first_reading: "Genesis 22:1-18 or Isaiah 52:13-53:12", psalm: "Psalm 22:1-11(12-21) or Psalm 40:1-16 or Psalm 69:1-22", second_reading: "Hebrews 10:1-25", gospel: "John (18:1-40)19:1-37" },
  { date_reference: "good_friday", cycle: "B", service_type: "eucharist", first_reading: "Genesis 22:1-18 or Isaiah 52:13-53:12", psalm: "Psalm 22:1-11(12-21) or Psalm 40:1-16 or Psalm 69:1-22", second_reading: "Hebrews 10:1-25", gospel: "John (18:1-40)19:1-37" },
  { date_reference: "good_friday", cycle: "C", service_type: "eucharist", first_reading: "Genesis 22:1-18 or Isaiah 52:13-53:12", psalm: "Psalm 22:1-11(12-21) or Psalm 40:1-16 or Psalm 69:1-22", second_reading: "Hebrews 10:1-25", gospel: "John (18:1-40)19:1-37" },

  # --- HOLY SATURDAY ---
  { date_reference: "holy_saturday", cycle: "A", service_type: "eucharist", first_reading: "Job 14:1-17", psalm: "Psalm 130 or 31:1-6", second_reading: "1 Peter 4:1-8", gospel: "Matthew 27:57-66 or John 19:38-42" },
  { date_reference: "holy_saturday", cycle: "B", service_type: "eucharist", first_reading: "Job 14:1-17", psalm: "Psalm 130 or 31:1-6", second_reading: "1 Peter 4:1-8", gospel: "Matthew 27:57-66 or John 19:38-42" },
  { date_reference: "holy_saturday", cycle: "C", service_type: "eucharist", first_reading: "Job 14:1-17", psalm: "Psalm 130 or 31:1-6", second_reading: "1 Peter 4:1-8", gospel: "Matthew 27:57-66 or John 19:38-42" }
]

holy_week_readings.each do |reading|
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
