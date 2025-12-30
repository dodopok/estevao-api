# ================================================================================
# LEITURAS DA EPIFANIA - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Epiphany readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

epiphany_readings = [
  # --- 1ST SUNDAY OF EPIPHANY (BAPTISM OF OUR LORD) ---
  { date_reference: "1st_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 42:1-9", psalm: "Psalm 89:1-29 or 89:20-29", second_reading: "Acts 10:34-38", gospel: "Matthew 3:13-17" },
  { date_reference: "1st_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 42:1-9", psalm: "Psalm 89:1-29 or 89:20-29", second_reading: "Acts 10:34-38", gospel: "Mark 1:7-11" },
  { date_reference: "1st_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 42:1-9", psalm: "Psalm 89:1-29 or 89:20-29", second_reading: "Acts 10:34-38", gospel: "Luke 3:15-22" },

  # --- 2ND SUNDAY OF EPIPHANY ---
  { date_reference: "2nd_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Exodus 12:21-28", psalm: "Psalm 40:1-11", second_reading: "1 Corinthians 1:1-9", gospel: "John 1:29-42" },
  { date_reference: "2nd_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "1 Samuel 3:1-20", psalm: "Psalm 63:1-9(10-12)", second_reading: "1 Corinthians 6:9-20", gospel: "John 1:43-51" },
  { date_reference: "2nd_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 62:1-5", psalm: "Psalm 96", second_reading: "1 Corinthians 12:1-11", gospel: "John 2:1-11" },

  # --- 3RD SUNDAY OF EPIPHANY ---
  { date_reference: "3rd_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Amos 3:1-11", psalm: "Psalm 139:1-18", second_reading: "1 Corinthians 1:10-17", gospel: "Matthew 4:12-22" },
  { date_reference: "3rd_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Jeremiah 3:19-4:4", psalm: "Psalm 130", second_reading: "1 Corinthians 7:17-24", gospel: "Mark 1:14-20" },
  { date_reference: "3rd_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Nehemiah 8:1-12", psalm: "Psalm 113", second_reading: "1 Corinthians 12:12-27", gospel: "Luke 4:14-21" },

  # --- 4TH SUNDAY OF EPIPHANY ---
  { date_reference: "4th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Micah 6:1-8", psalm: "Psalm 37:1-11", second_reading: "1 Corinthians 1:18-31", gospel: "Matthew 5:1-12" },
  { date_reference: "4th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Deuteronomy 18:15-22", psalm: "Psalm 111", second_reading: "1 Corinthians 8:1-13", gospel: "Mark 1:21-28" },
  { date_reference: "4th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 1:4-10", psalm: "Psalm 71:11-20", second_reading: "1 Corinthians 14:12-25", gospel: "Luke 4:21-32" },

  # --- PRESENTATION OF CHRIST IN THE TEMPLE (FEB 2) ---
  { date_reference: "presentation_of_christ_in_the_temple", cycle: "A", service_type: "eucharist", first_reading: "Malachi 3:1-4", psalm: "Psalm 84", second_reading: "Hebrews 2:14-18", gospel: "Luke 2:22-40" },
  { date_reference: "presentation_of_christ_in_the_temple", cycle: "B", service_type: "eucharist", first_reading: "Malachi 3:1-4", psalm: "Psalm 84", second_reading: "Hebrews 2:14-18", gospel: "Luke 2:22-40" },
  { date_reference: "presentation_of_christ_in_the_temple", cycle: "C", service_type: "eucharist", first_reading: "Malachi 3:1-4", psalm: "Psalm 84", second_reading: "Hebrews 2:14-18", gospel: "Luke 2:22-40" },

  # --- 5TH SUNDAY OF EPIPHANY ---
  { date_reference: "5th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "2 Kings 22:8-20", psalm: "Psalm 27", second_reading: "1 Corinthians 2:1-16", gospel: "Matthew 5:13-20" },
  { date_reference: "5th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "2 Kings 4:8-21(22-31)32-37", psalm: "Psalm 142", second_reading: "1 Corinthians 9:16-23", gospel: "Mark 1:29-39" },
  { date_reference: "5th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Judges 6:11-24", psalm: "Psalm 85", second_reading: "1 Corinthians 15:1-11", gospel: "Luke 5:1-11" },

  # --- 6TH SUNDAY OF EPIPHANY ---
  { date_reference: "6th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Ecclesiasticus 15:11-20", psalm: "Psalm 119:(1-8)9-16", second_reading: "1 Corinthians 3:1-9", gospel: "Matthew 5:21-37" },
  { date_reference: "6th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "2 Kings 5:1-15a", psalm: "Psalm 42:1-7(8-15)", second_reading: "1 Corinthians 9:24-27", gospel: "Mark 1:40-45" },
  { date_reference: "6th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 17:5-10", psalm: "Psalm 1", second_reading: "1 Corinthians 15:12-20", gospel: "Luke 6:17-26" },

  # --- 7TH SUNDAY OF EPIPHANY ---
  { date_reference: "7th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Leviticus 19:1-2, 9-18", psalm: "Psalm 71 or 71:11-23", second_reading: "1 Corinthians 3:10-23", gospel: "Matthew 5:38-48" },
  { date_reference: "7th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 43:18-25", psalm: "Psalm 32", second_reading: "2 Corinthians 1:18-22", gospel: "Mark 2:1-12" },
  { date_reference: "7th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Genesis 45:3-11, 21-28", psalm: "Psalm 37:(1-7)8-17", second_reading: "1 Corinthians 15:35-49", gospel: "Luke 6:27-38" },

  # --- 8TH SUNDAY OF EPIPHANY ---
  { date_reference: "8th_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 49:8-18(19-23)", psalm: "Psalm 62", second_reading: "1 Corinthians 4:1-13", gospel: "Matthew 6:24-34" },
  { date_reference: "8th_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "Hosea 2:14-23", psalm: "Psalm 103 or 103:1-14", second_reading: "2 Corinthians 3:4-18", gospel: "Mark 2:18-22" },
  { date_reference: "8th_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 7:1-15", psalm: "Psalm 92", second_reading: "1 Corinthians 15:50-58", gospel: "Luke 6:39-49" },

  # --- WORLD MISSION SUNDAY ---
  { date_reference: "world_mission_sunday", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 49:1-7", psalm: "Psalm 67", second_reading: "Acts 1:1-8", gospel: "Matthew 9:35-38" },
  { date_reference: "world_mission_sunday", cycle: "B", service_type: "eucharist", first_reading: "Genesis 12:1-3", psalm: "Psalm 86:8-13", second_reading: "Revelation 7:9-17", gospel: "Matthew 28:16-20" },
  { date_reference: "world_mission_sunday", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 61:1-4", psalm: "Psalm 96", second_reading: "Romans 10:9-17", gospel: "John 20:19-31" },

  # --- LAST SUNDAY OF EPIPHANY (TRANSFIGURATION) ---
  { date_reference: "last_sunday_after_epiphany", cycle: "A", service_type: "eucharist", first_reading: "Exodus 24:12-18", psalm: "Psalm 99", second_reading: "Philippians 3:7-14", gospel: "Matthew 17:1-9" },
  { date_reference: "last_sunday_after_epiphany", cycle: "B", service_type: "eucharist", first_reading: "1 Kings 19:9-18", psalm: "Psalm 27", second_reading: "2 Peter 1:13-21", gospel: "Mark 9:2-9" },
  { date_reference: "last_sunday_after_epiphany", cycle: "C", service_type: "eucharist", first_reading: "Exodus 34:29-35", psalm: "Psalm 99", second_reading: "1 Corinthians 12:27-13:13", gospel: "Luke 9:28-36" }
]

epiphany_readings.each do |reading|
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
