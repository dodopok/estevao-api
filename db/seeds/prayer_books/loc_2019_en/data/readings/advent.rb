# ================================================================================
# LEITURAS DO ADVENTO - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Advent readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

advent_readings = [
  # --- 1ST SUNDAY IN ADVENT ---
  { date_reference: "1st_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 2:1-5", psalm: "Psalm 122", second_reading: "Romans 13:8-14", gospel: "Matthew 24:29-44" },
  { date_reference: "1st_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 64:1-9a", psalm: "Psalm 80 or 80:1-7", second_reading: "1 Corinthians 1:1-9", gospel: "Mark 13:24-37" },
  { date_reference: "1st_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Zechariah 14:(1-2)3-9", psalm: "Psalm 50 or 50:1-6", second_reading: "1 Thessalonians 3:6-13", gospel: "Luke 21:25-33" },

  # --- 2ND SUNDAY IN ADVENT ---
  { date_reference: "2nd_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 11:1-10", psalm: "Psalm 72:1-15(16-19)", second_reading: "Romans 15:1-13", gospel: "Matthew 3:1-12" },
  { date_reference: "2nd_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 40:1-11", psalm: "Psalm 85", second_reading: "2 Peter 3:8-18", gospel: "Mark 1:1-8" },
  { date_reference: "2nd_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Malachi 3:1-5", psalm: "Psalm 126", second_reading: "1 Corinthians 4:(1-7)8-21", gospel: "Luke 3:1-6" },

  # --- 3RD SUNDAY IN ADVENT ---
  { date_reference: "3rd_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 35:1-10", psalm: "Psalm 146", second_reading: "James 5:7-20", gospel: "Matthew 11:2-19" },
  { date_reference: "3rd_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 65:17-25", psalm: "Psalm 126", second_reading: "1 Thessalonians 5:12-28", gospel: "John 3:22-30 or John 1:19-28" },
  { date_reference: "3rd_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Zephaniah 3:14-20", psalm: "Psalm 85", second_reading: "Philippians 4:4-9", gospel: "Luke 3:7-20" },

  # --- 4TH SUNDAY IN ADVENT ---
  { date_reference: "4th_sunday_of_advent", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 7:10-17", psalm: "Psalm 24", second_reading: "Romans 1:1-7", gospel: "Matthew 1:18-25" },
  { date_reference: "4th_sunday_of_advent", cycle: "B", service_type: "eucharist", first_reading: "2 Samuel 7:1-17", psalm: "Psalm 132:(1-7) 8-19", second_reading: "Romans 16:25-27", gospel: "Luke 1:26-38" },
  { date_reference: "4th_sunday_of_advent", cycle: "C", service_type: "eucharist", first_reading: "Micah 5:2-5a", psalm: "Psalm 80:1-7", second_reading: "Hebrew 10:1-10", gospel: "Luke 1:39-56" }
]

advent_readings.each do |reading|
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
