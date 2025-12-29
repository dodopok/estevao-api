# ================================================================================
# LEITURAS DA PÁSCOA - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Easter readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

easter_readings = [
  # --- THE GREAT VIGIL OF EASTER ---
  { date_reference: "easter_vigil", cycle: "A", service_type: "vigil", first_reading: "Genesis 1:1-2:3, Genesis 3, Genesis 7:1-5, 11-18; 8:6-20; 9:8-13, Genesis 22:1-18, Exodus 14:10-15:1, Isaiah 4:2-6, Isaiah 55:1-11, Ezekiel 36:24-28, Ezekiel 37:1-14, Daniel 3:1-28, Jonah 1:1-2:10, Zephaniah 3:12-20", psalm: "Psalm 114", second_reading: "Romans 6:3-11", gospel: "Matthew 28:1-10" },
  { date_reference: "easter_vigil", cycle: "B", service_type: "vigil", first_reading: "Genesis 1:1-2:3, Genesis 3, Genesis 7:1-5, 11-18; 8:6-20; 9:8-13, Genesis 22:1-18, Exodus 14:10-15:1, Isaiah 4:2-6, Isaiah 55:1-11, Ezekiel 36:24-28, Ezekiel 37:1-14, Daniel 3:1-28, Jonah 1:1-2:10, Zephaniah 3:12-20", psalm: "Psalm 114", second_reading: "Romans 6:3-11", gospel: "Matthew 28:1-10" },
  { date_reference: "easter_vigil", cycle: "C", service_type: "vigil", first_reading: "Genesis 1:1-2:3, Genesis 3, Genesis 7:1-5, 11-18; 8:6-20; 9:8-13, Genesis 22:1-18, Exodus 14:10-15:1, Isaiah 4:2-6, Isaiah 55:1-11, Ezekiel 36:24-28, Ezekiel 37:1-14, Daniel 3:1-28, Jonah 1:1-2:10, Zephaniah 3:12-20", psalm: "Psalm 114", second_reading: "Romans 6:3-11", gospel: "Matthew 28:1-10" },

  # --- EASTER DAY (PRINCIPAL SERVICE) ---
  { date_reference: "easter_day", cycle: "A", service_type: "eucharist", first_reading: "Acts 10:34-43 or Exodus 14:10-14, 21-31", psalm: "Psalm 118:14-17, 22-24", second_reading: "Colossians 3:1-4 or Acts 10:34-43", gospel: "John 20:1-10(11-18) or Matthew 28:1-10" },
  { date_reference: "easter_day", cycle: "B", service_type: "eucharist", first_reading: "Acts 10:34-43 or Isaiah 25:6-9", psalm: "Psalm 118:14-17, 22-24", second_reading: "Colossians 3:1-4 or Acts 10:34-43", gospel: "Mark 16:1-8" },
  { date_reference: "easter_day", cycle: "C", service_type: "eucharist", first_reading: "Acts 10:34-43 or Isaiah 51:9-11", psalm: "Psalm 118:14-17, 22-24", second_reading: "Colossians 3:1-4 or Acts 10:34-43", gospel: "Luke 24:1-12" },

  # --- MONDAY OF EASTER WEEK ---
  { date_reference: "monday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Acts 2:14, 22-32", psalm: "Psalm 16", gospel: "Matthew 28:9-15" },
  { date_reference: "monday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Acts 2:14, 22-32", psalm: "Psalm 16", gospel: "Matthew 28:9-15" },
  { date_reference: "monday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Acts 2:14, 22-32", psalm: "Psalm 16", gospel: "Matthew 28:9-15" },

  # --- TUESDAY OF EASTER WEEK ---
  { date_reference: "tuesday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Acts 2:14, 36-41", psalm: "Psalm 33:17-21", gospel: "John 20:11-18" },
  { date_reference: "tuesday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Acts 2:14, 36-41", psalm: "Psalm 33:17-21", gospel: "John 20:11-18" },
  { date_reference: "tuesday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Acts 2:14, 36-41", psalm: "Psalm 33:17-21", gospel: "John 20:11-18" },

  # --- WEDNESDAY OF EASTER WEEK ---
  { date_reference: "wednesday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Acts 3:1-10", psalm: "Psalm 105:1-8", gospel: "Luke 24:13-35" },
  { date_reference: "wednesday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Acts 3:1-10", psalm: "Psalm 105:1-8", gospel: "Luke 24:13-35" },
  { date_reference: "wednesday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Acts 3:1-10", psalm: "Psalm 105:1-8", gospel: "Luke 24:13-35" },

  # --- THURSDAY OF EASTER WEEK ---
  { date_reference: "thursday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Acts 3:11-26", psalm: "Psalm 8", gospel: "Luke 24:36-49" },
  { date_reference: "thursday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Acts 3:11-26", psalm: "Psalm 8", gospel: "Luke 24:36-49" },
  { date_reference: "thursday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Acts 3:11-26", psalm: "Psalm 8", gospel: "Luke 24:36-49" },

  # --- FRIDAY OF EASTER WEEK ---
  { date_reference: "friday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "1 Peter 1:3-9", psalm: "Psalm 116:1-9", gospel: "John 21:1-14" },
  { date_reference: "friday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "1 Peter 1:3-9", psalm: "Psalm 116:1-9", gospel: "John 21:1-14" },
  { date_reference: "friday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "1 Peter 1:3-9", psalm: "Psalm 116:1-9", gospel: "John 21:1-14" },

  # --- SATURDAY OF EASTER WEEK ---
  { date_reference: "saturday_of_easter_week", cycle: "A", service_type: "eucharist", first_reading: "Acts 4:1-22", psalm: "Psalm 118:14-18", gospel: "Mark 16:9-20" },
  { date_reference: "saturday_of_easter_week", cycle: "B", service_type: "eucharist", first_reading: "Acts 4:1-22", psalm: "Psalm 118:14-18", gospel: "Mark 16:9-20" },
  { date_reference: "saturday_of_easter_week", cycle: "C", service_type: "eucharist", first_reading: "Acts 4:1-22", psalm: "Psalm 118:14-18", gospel: "Mark 16:9-20" },

  # --- 2ND SUNDAY OF EASTER ---
  { date_reference: "2nd_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Acts 2:14a, 22-32 or Genesis 8:6-16, 9:8-16", psalm: "Psalm 111", second_reading: "1 Peter 1:3-9", gospel: "John 20:19-31" },
  { date_reference: "2nd_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Acts 3:12a, 13-15, 17-26 or Isaiah 26:1-9, 19", psalm: "Psalm 111", second_reading: "1 John 5:1-5", gospel: "John 20:19-31" },
  { date_reference: "2nd_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Acts 5:12a, 17-22, 25-29 or Job 42:1-6", psalm: "Psalm 111", second_reading: "Revelation 1:(1-8)9-19", gospel: "John 20:19-31" },

  # --- 3RD SUNDAY OF EASTER ---
  { date_reference: "3rd_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Acts 2:14a, 36-47 or Isaiah 43:1-12", psalm: "Psalm 116:11-16", second_reading: "1 Peter 1:13-25", gospel: "Luke 24:13-35" },
  { date_reference: "3rd_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Acts 4:5-14 or Micah 4:1-5", psalm: "Psalm 98 or 98:1-5", second_reading: "1 John 1:1-2:2", gospel: "Luke 24:36-49" },
  { date_reference: "3rd_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Acts 9:1-19a or Jeremiah 32:36-41", psalm: "Psalm 33 or 33:1-11", second_reading: "Revelation 5:(1-5)6-14", gospel: "John 21:1-14" },

  # --- 4TH SUNDAY OF EASTER ---
  { date_reference: "4th_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Acts 6:1-9, 7:2a, 51-60 or Nehemiah 9:(1-3)6-15", psalm: "Psalm 23", second_reading: "1 Peter 2:13-25", gospel: "John 10:1-10" },
  { date_reference: "4th_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Acts 4:(23-31)32-37 or Ezekiel 34:1-10", psalm: "Psalm 23", second_reading: "1 John 3:1-10", gospel: "John 10:11-16" },
  { date_reference: "4th_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Acts 13:14b-16, 26-39 or Numbers 27:12-23", psalm: "Psalm 100", second_reading: "Revelation 7:9-17", gospel: "John 10:22-30" },

  # --- 5TH SUNDAY OF EASTER ---
  { date_reference: "5th_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Acts 17:1-15 or Deuteronomy 6:20-25", psalm: "Psalm 66:1-11 or 66:1-8", second_reading: "1 Peter 2:1-12", gospel: "John 14:1-14" },
  { date_reference: "5th_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Acts 8:26-40 or Deuteronomy 4:32-40", psalm: "Psalm 66:1-11 or 66:1-8", second_reading: "1 John 3:(11-17)18-24", gospel: "John 14:15-21" },
  { date_reference: "5th_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Acts 13:44-52 or Leviticus 19:1-2, 9-18", psalm: "Psalm 145 or 145:1-9", second_reading: "Revelation 19:1-9", gospel: "John 13:31-35" },

  # --- 6TH SUNDAY OF EASTER ---
  { date_reference: "6th_sunday_of_easter", cycle: "A", service_type: "eucharist", first_reading: "Acts 17:(16-21)22-34 or Isaiah 41:17-20", psalm: "Psalm 148 or 148:7-14", second_reading: "1 Peter 3:8-18", gospel: "John 15:1-11" },
  { date_reference: "6th_sunday_of_easter", cycle: "B", service_type: "eucharist", first_reading: "Acts 11:19-30 or Isaiah 45:11-13, 18-19(20-25)", psalm: "Psalm 33 or 33:1-8, 18-22", second_reading: "1 John 4:7-21", gospel: "John 15:9-17" },
  { date_reference: "6th_sunday_of_easter", cycle: "C", service_type: "eucharist", first_reading: "Acts 14:8-18 or Joel 2:21-27", psalm: "Psalm 67", second_reading: "Revelation 21:1-4, 22-22:5", gospel: "John 14:21-29" },

  # --- ASCENSION DAY ---
  { date_reference: "ascension_day", cycle: "A", service_type: "eucharist", first_reading: "Acts 1:1-11", psalm: "Psalm 47 or 110:1-5", second_reading: "Ephesians 1:15-23", gospel: "Luke 24:44-53 or Mark 16:9-20" },
  { date_reference: "ascension_day", cycle: "B", service_type: "eucharist", first_reading: "Acts 1:1-11", psalm: "Psalm 47 or 110:1-5", second_reading: "Ephesians 1:15-23", gospel: "Luke 24:44-53 or Mark 16:9-20" },
  { date_reference: "ascension_day", cycle: "C", service_type: "eucharist", first_reading: "Acts 1:1-11", psalm: "Psalm 47 or 110:1-5", second_reading: "Ephesians 1:15-23", gospel: "Luke 24:44-53 or Mark 16:9-20" },

  # --- SUNDAY AFTER ASCENSION DAY ---
  { date_reference: "sunday_after_ascension", cycle: "A", service_type: "eucharist", first_reading: "Acts 1:(1-5)6-14 or Ezekiel 39:21-29", psalm: "Psalm 68:1-20 or 47", second_reading: "1 Peter 4:12-19", gospel: "John 17:1-11" },
  { date_reference: "sunday_after_ascension", cycle: "B", service_type: "eucharist", first_reading: "Acts 1:15-26 or Exodus 28:1-4, 9-10, 29-30", psalm: "Psalm 68:1-20 or 47", second_reading: "1 John 5:6-15", gospel: "John 17:11b-19" },
  { date_reference: "sunday_after_ascension", cycle: "C", service_type: "eucharist", first_reading: "Acts 16:16-34 or 1 Samuel 12:19-24", psalm: "Psalm 68:1-20 or 47", second_reading: "Revelation 22:10-21", gospel: "John 17:20-26" }
]

easter_readings.each do |reading|
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
