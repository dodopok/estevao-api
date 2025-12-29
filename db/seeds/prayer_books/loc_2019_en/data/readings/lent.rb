# ================================================================================
# LEITURAS DA QUARESMA - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Lent readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

lent_readings = [
  # --- ASH WEDNESDAY ---
  { date_reference: "ash_wednesday", cycle: "A", service_type: "eucharist", first_reading: "Joel 2:1-2, 12-17 or Isaiah 58:1-12", psalm: "Psalm 103 or 103:8-14", second_reading: "2 Corinthians 5:20-6:10", gospel: "Matthew 6:1-6, 16-21" },
  { date_reference: "ash_wednesday", cycle: "B", service_type: "eucharist", first_reading: "Joel 2:1-2, 12-17 or Isaiah 58:1-12", psalm: "Psalm 103 or 103:8-14", second_reading: "2 Corinthians 5:20-6:10", gospel: "Matthew 6:1-6, 16-21" },
  { date_reference: "ash_wednesday", cycle: "C", service_type: "eucharist", first_reading: "Joel 2:1-2, 12-17 or Isaiah 58:1-12", psalm: "Psalm 103 or 103:8-14", second_reading: "2 Corinthians 5:20-6:10", gospel: "Matthew 6:1-6, 16-21" },

  # --- 1ST SUNDAY IN LENT ---
  { date_reference: "1st_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Genesis 2:4-9, 15-17, 25-3:7", psalm: "Psalm 51 or 51:1-12", second_reading: "Romans 5:12-21", gospel: "Matthew 4:1-11" },
  { date_reference: "1st_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Genesis 9:8-17", psalm: "Psalm 25 or 25:3-9", second_reading: "1 Peter 3:18-22", gospel: "Mark 1:9-13" },
  { date_reference: "1st_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Deuteronomy 26:(1-4)5-11", psalm: "Psalm 91 or 91:9-16", second_reading: "Romans 10:4-13", gospel: "Luke 4:1-13" },

  # --- 2ND SUNDAY IN LENT ---
  { date_reference: "2nd_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Genesis 12:1-9", psalm: "Psalm 33:12-21", second_reading: "Romans 4:1-5(6-12)13-17", gospel: "John 3:1-16" },
  { date_reference: "2nd_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Genesis 22:1-14", psalm: "Psalm 16 or 16:6-12", second_reading: "Romans 8:31-39", gospel: "Mark 8:31-38" },
  { date_reference: "2nd_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Genesis 15:1-18", psalm: "Psalm 27 or 27:9-17", second_reading: "Philippians 3:17-4:1", gospel: "Luke 13:(22-30)31-35" },

  # --- 3RD SUNDAY IN LENT ---
  { date_reference: "3rd_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Exodus 17:1-7", psalm: "Psalm 95", second_reading: "Romans 1:16-32", gospel: "John 4:5-26(27-38)39-42" },
  { date_reference: "3rd_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Exodus 20:1-21", psalm: "Psalm 19:7-14", second_reading: "Romans 7:12-25", gospel: "John 2:13-22" },
  { date_reference: "3rd_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Exodus 3:1-15", psalm: "Psalm 103 or 103:1-12", second_reading: "1 Corinthians 10:1-13", gospel: "Luke 13:1-9(10-17)" },

  # --- 4TH SUNDAY IN LENT ---
  { date_reference: "4th_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "1 Samuel 16:1-13", psalm: "Psalm 23", second_reading: "Ephesians 5:1-14", gospel: "John 9:1-13, 28-38(39-41)" },
  { date_reference: "4th_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "2 Chronicles 36:14-23", psalm: "Psalm 122", second_reading: "Ephesians 2:1-10", gospel: "John 6:1-15" },
  { date_reference: "4th_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Joshua (4:19-24)5:1(2-8)9-12", psalm: "Psalm 34 or 34:1-8", second_reading: "2 Corinthians 5:17-21", gospel: "Luke 15:11-32" },

  # --- 5TH SUNDAY IN LENT (PASSION SUNDAY) ---
  { date_reference: "5th_sunday_in_lent", cycle: "A", service_type: "eucharist", first_reading: "Ezekiel 37:1-14", psalm: "Psalm 130", second_reading: "Romans 6:15-23", gospel: "John 11:(1-17)18-44" },
  { date_reference: "5th_sunday_in_lent", cycle: "B", service_type: "eucharist", first_reading: "Jeremiah 31:31-34", psalm: "Psalm 51 or 51:10-15", second_reading: "Hebrew (4:14-16)5:1-10", gospel: "John 12:20-33(34-36)" },
  { date_reference: "5th_sunday_in_lent", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 43:16-21", psalm: "Psalm 126", second_reading: "Philippians 3:7-16", gospel: "Luke 20:9-19" }
]

lent_readings.each do |reading|
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
