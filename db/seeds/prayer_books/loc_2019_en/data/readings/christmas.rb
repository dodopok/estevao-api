# ================================================================================
# LEITURAS DE NATAL E EPIFANIA - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Christmas & Epiphany readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

christmas_readings = [
  # --- CHRISTMAS DAY I ---
  { date_reference: "christmas_day_1", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 9:1-7", psalm: "Psalm 96", second_reading: "Titus 2:11-14", gospel: "Luke 2:1-14(15-20)" },
  { date_reference: "christmas_day_1", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 9:1-7", psalm: "Psalm 96", second_reading: "Titus 2:11-14", gospel: "Luke 2:1-14(15-20)" },
  { date_reference: "christmas_day_1", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 9:1-7", psalm: "Psalm 96", second_reading: "Titus 2:11-14", gospel: "Luke 2:1-14(15-20)" },

  # --- CHRISTMAS DAY II ---
  { date_reference: "christmas_day_2", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 62:6-12", psalm: "Psalm 97", second_reading: "Titus 3:4-7", gospel: "Luke 2:(1-14)15-20" },
  { date_reference: "christmas_day_2", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 62:6-12", psalm: "Psalm 97", second_reading: "Titus 3:4-7", gospel: "Luke 2:(1-14)15-20" },
  { date_reference: "christmas_day_2", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 62:6-12", psalm: "Psalm 97", second_reading: "Titus 3:4-7", gospel: "Luke 2:(1-14)15-20" },

  # --- CHRISTMAS DAY III ---
  { date_reference: "christmas_day_3", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 52:7-12", psalm: "Psalm 98", second_reading: "Hebrews 1:1-12", gospel: "John 1:1-18" },
  { date_reference: "christmas_day_3", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 52:7-12", psalm: "Psalm 98", second_reading: "Hebrews 1:1-12", gospel: "John 1:1-18" },
  { date_reference: "christmas_day_3", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 52:7-12", psalm: "Psalm 98", second_reading: "Hebrews 1:1-12", gospel: "John 1:1-18" },

  # --- 1ST SUNDAY OF CHRISTMAS ---
  { date_reference: "1st_sunday_after_christmas", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 61:10-62:5", psalm: "Psalm 147:12-20", second_reading: "Galatians 3:23-4:7", gospel: "John 1:1-18" },
  { date_reference: "1st_sunday_after_christmas", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 61:10-62:5", psalm: "Psalm 147:12-20", second_reading: "Galatians 3:23-4:7", gospel: "John 1:1-18" },
  { date_reference: "1st_sunday_after_christmas", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 61:10-62:5", psalm: "Psalm 147:12-20", second_reading: "Galatians 3:23-4:7", gospel: "John 1:1-18" },

  # --- THE CIRCUMCISION & HOLY NAME ---
  { date_reference: "the_circumcision_and_holy_name", cycle: "A", service_type: "eucharist", first_reading: "Exodus 34:1-9", psalm: "Psalm 8", second_reading: "Romans 1:1-7", gospel: "Luke 2:15-21" },
  { date_reference: "the_circumcision_and_holy_name", cycle: "B", service_type: "eucharist", first_reading: "Exodus 34:1-9", psalm: "Psalm 8", second_reading: "Romans 1:1-7", gospel: "Luke 2:15-21" },
  { date_reference: "the_circumcision_and_holy_name", cycle: "C", service_type: "eucharist", first_reading: "Exodus 34:1-9", psalm: "Psalm 8", second_reading: "Romans 1:1-7", gospel: "Luke 2:15-21" },

  # --- 2ND SUNDAY OF CHRISTMAS ---
  { date_reference: "2nd_sunday_after_christmas", cycle: "A", service_type: "eucharist", first_reading: "Jeremiah 31:7-14", psalm: "Psalm 84", second_reading: "Ephesians 1:3-14", gospel: "Luke 2:41-52 or Matthew 2:1-12" },
  { date_reference: "2nd_sunday_after_christmas", cycle: "B", service_type: "eucharist", first_reading: "Jeremiah 31:7-14", psalm: "Psalm 84", second_reading: "Ephesians 1:3-14", gospel: "Matthew 2:13-23 or Matthew 2:1-12" },
  { date_reference: "2nd_sunday_after_christmas", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 31:7-14", psalm: "Psalm 84", second_reading: "Ephesians 1:3-14", gospel: "Luke 2:22-40 or Matthew 2:1-12" },

  # --- THE EPIPHANY ---
  { date_reference: "the_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 60:1-9", psalm: "Psalm 72 or 72:1-11", second_reading: "Ephesians 3:1-13", gospel: "Matthew 2:1-12" },
  { date_reference: "the_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 60:1-9", psalm: "Psalm 72 or 72:1-11", second_reading: "Ephesians 3:1-13", gospel: "Matthew 2:1-12" },
  { date_reference: "the_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 60:1-9", psalm: "Psalm 72 or 72:1-11", second_reading: "Ephesians 3:1-13", gospel: "Matthew 2:1-12" }
]

christmas_readings.each do |reading|
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
