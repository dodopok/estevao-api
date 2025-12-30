# ================================================================================
# LEITURAS DE PENTECOSTES E TEMPO COMUM - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Pentecost & Ordinary Time readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

ordinary_readings = [
  # --- PENTECOST ---
  { date_reference: "pentecost", cycle: "A", service_type: "eucharist", first_reading: "Genesis 11:1-9 or Acts 2:1-11(12-21)", psalm: "Psalm 104:24-35", second_reading: "Acts 2:1-11(12-21) or 1 Corinthians 12:4-13", gospel: "John 14:8-17" },
  { date_reference: "pentecost", cycle: "B", service_type: "eucharist", first_reading: "Genesis 11:1-9 or Acts 2:1-11(12-21)", psalm: "Psalm 104:24-35", second_reading: "Acts 2:1-11(12-21) or 1 Corinthians 12:4-13", gospel: "John 14:8-17" },
  { date_reference: "pentecost", cycle: "C", service_type: "eucharist", first_reading: "Genesis 11:1-9 or Acts 2:1-11(12-21)", psalm: "Psalm 104:24-35", second_reading: "Acts 2:1-11(12-21) or 1 Corinthians 12:4-13", gospel: "John 14:8-17" },

  # --- TRINITY SUNDAY ---
  { date_reference: "trinity_sunday", cycle: "A", service_type: "eucharist", first_reading: "Genesis 1:1-2:3", psalm: "Psalm 150", second_reading: "2 Corinthians 13:5-14", gospel: "Matthew 28:16-20" },
  { date_reference: "trinity_sunday", cycle: "B", service_type: "eucharist", first_reading: "Exodus 3:1-6", psalm: "Psalm 93", second_reading: "Romans 8:12-17", gospel: "John 3:1-16" },
  { date_reference: "trinity_sunday", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 6:1-7", psalm: "Psalm 29", second_reading: "Revelation 4:1-11", gospel: "John 16:(5-11)12-15" },

  # --- PROPER 1 ---
  { date_reference: "proper_1", cycle: "A", service_type: "eucharist", first_reading: "Ecclesiasticus 15:11-20", psalm: "Psalm 119:1-16", second_reading: "1 Corinthians 3:1-9", gospel: "Matthew 5:21-37" },
  { date_reference: "proper_1", cycle: "B", service_type: "eucharist", first_reading: "2 Kings 5:1-15a", psalm: "Psalm 42", second_reading: "1 Corinthians 9:24-27", gospel: "Mark 1:40-45" },
  { date_reference: "proper_1", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 17:5-10", psalm: "Psalm 1", second_reading: "1 Corinthians 15:12-20", gospel: "Luke 6:17-26" },

  # --- PROPER 2 ---
  { date_reference: "proper_2", cycle: "A", service_type: "eucharist", first_reading: "Leviticus 19:1-2, 9-18", psalm: "Psalm 71 or 71:11-23", second_reading: "1 Corinthians 3:10-23", gospel: "Matthew 5:38-48" },
  { date_reference: "proper_2", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 43:18-25", psalm: "Psalm 32", second_reading: "2 Corinthians 1:18-22", gospel: "Mark 2:1-12" },
  { date_reference: "proper_2", cycle: "C", service_type: "eucharist", first_reading: "Genesis 45:3-11, 21-28", psalm: "Psalm 37:(1-7)8-17", second_reading: "1 Corinthians 15:35-49", gospel: "Luke 6:27-38" },

  # --- PROPER 3 ---
  { date_reference: "proper_3", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 49:8-18(19-23)", psalm: "Psalm 62", second_reading: "1 Corinthians 4:1-13", gospel: "Matthew 6:24-34" },
  { date_reference: "proper_3", cycle: "B", service_type: "eucharist", first_reading: "Hosea 2:14-23", psalm: "Psalm 103 or 103:1-14", second_reading: "2 Corinthians 3:4-18", gospel: "Mark 2:18-22" },
  { date_reference: "proper_3", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 7:1-15", psalm: "Psalm 92", second_reading: "1 Corinthians 15:50-58", gospel: "Luke 6:39-49" },

  # --- PROPER 4 ---
  { date_reference: "proper_4", cycle: "A", service_type: "eucharist", first_reading: "Deuteronomy 11:18-32", psalm: "Psalm 31 or 31:18-27", second_reading: "Romans 3:21-31", gospel: "Matthew 7:21-27" },
  { date_reference: "proper_4", cycle: "B", service_type: "eucharist", first_reading: "Deuteronomy 5:6-21", psalm: "Psalm 81:1-10(11-16)", second_reading: "2 Corinthians 4:1-12", gospel: "Mark 2:23-28" },
  { date_reference: "proper_4", cycle: "C", service_type: "eucharist", first_reading: "1 Kings 8:22-30, 41-43", psalm: "Psalm 96", second_reading: "Galatians 1:1-10", gospel: "Luke 7:1-10" },

  # --- PROPER 5 ---
  { date_reference: "proper_5", cycle: "A", service_type: "eucharist", first_reading: "Hosea 5:15-6:6", psalm: "Psalm 50", second_reading: "Romans 4:13-18", gospel: "Matthew 9:9-13" },
  { date_reference: "proper_5", cycle: "B", service_type: "eucharist", first_reading: "Genesis 3:1-21", psalm: "Psalm 130", second_reading: "2 Corinthians 4:13-18", gospel: "Mark 3:20-35" },
  { date_reference: "proper_5", cycle: "C", service_type: "eucharist", first_reading: "1 Kings 17:17-24", psalm: "Psalm 30", second_reading: "Galatians 1:11-24", gospel: "Luke 7:11-17" },

  # --- PROPER 6 ---
  { date_reference: "proper_6", cycle: "A", service_type: "eucharist", first_reading: "Exodus 19:1-8", psalm: "Psalm 100", second_reading: "Romans 5:1-11", gospel: "Matthew 9:35-10:15" },
  { date_reference: "proper_6", cycle: "B", service_type: "eucharist", first_reading: "Ezekiel 31:1-6(7-9)10-14", psalm: "Psalm 92", second_reading: "2 Corinthians 5:1-10", gospel: "Mark 4:26-34" },
  { date_reference: "proper_6", cycle: "C", service_type: "eucharist", first_reading: "2 Samuel 11:26-12:15", psalm: "Psalm 32:1-6(7-12)", second_reading: "Galatians 2:11-21", gospel: "Luke 7:36-8:3" },

  # --- PROPER 7 ---
  { date_reference: "proper_7", cycle: "A", service_type: "eucharist", first_reading: "Jeremiah 20:7-13", psalm: "Psalm 69:1-15(16-18)", second_reading: "Romans 5:15b-19", gospel: "Matthew 10:16-33" },
  { date_reference: "proper_7", cycle: "B", service_type: "eucharist", first_reading: "Job 38:1-11(12-15)16-18", psalm: "Psalm 107:1-3(4-22)23-32", second_reading: "2 Corinthians 5:14-21", gospel: "Mark 4:35-41(5:1-20)" },
  { date_reference: "proper_7", cycle: "C", service_type: "eucharist", first_reading: "Zechariah 12:8-10, 13:1", psalm: "Psalm 63", second_reading: "Galatians 3:23-29", gospel: "Luke 9:18-24" },

  # --- PROPER 8 ---
  { date_reference: "proper_8", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 2:10-17", psalm: "Psalm 89:1-18", second_reading: "Romans 6:1-11", gospel: "Matthew 10:34-42" },
  { date_reference: "proper_8", cycle: "B", service_type: "eucharist", first_reading: "Deuteronomy 15:7-11", psalm: "Psalm 112", second_reading: "2 Corinthians 8:1-15", gospel: "Mark 5:22-43" },
  { date_reference: "proper_8", cycle: "C", service_type: "eucharist", first_reading: "1 Kings 19:15-21", psalm: "Psalm 16", second_reading: "Galatians 5:1, 13-25", gospel: "Luke 9:51-62" },

  # --- PROPER 9 ---
  { date_reference: "proper_9", cycle: "A", service_type: "eucharist", first_reading: "Zechariah 9:9-12", psalm: "Psalm 145:1-13(14-21)", second_reading: "Romans 7:21-8:6", gospel: "Matthew 11:25-30" },
  { date_reference: "proper_9", cycle: "B", service_type: "eucharist", first_reading: "Ezekiel 2:1-7", psalm: "Psalm 123", second_reading: "2 Corinthians 12:2-10", gospel: "Mark 6:1-6" },
  { date_reference: "proper_9", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 66:10-16", psalm: "Psalm 66 or 66:1-8", second_reading: "Galatians 6:(1-5)6-18", gospel: "Luke 10:1-20" },

  # --- PROPER 10 ---
  { date_reference: "proper_10", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 55", psalm: "Psalm 65", second_reading: "Romans 8:7-17", gospel: "Matthew 13:1-9, 18-23" },
  { date_reference: "proper_10", cycle: "B", service_type: "eucharist", first_reading: "Amos 7:7-15", psalm: "Psalm 85", second_reading: "Ephesians 1:1-14(15-23)", gospel: "Mark 6:7-13" },
  { date_reference: "proper_10", cycle: "C", service_type: "eucharist", first_reading: "Deuteronomy 30:9-14", psalm: "Psalm 25:1-14(15-21)", second_reading: "Colossians 1:1-14", gospel: "Luke 10:25-37" },

  # --- PROPER 11 ---
  { date_reference: "proper_11", cycle: "A", service_type: "eucharist", first_reading: "Wisdom 12:13, 16-19", psalm: "Psalm 86", second_reading: "Romans 8:18-25", gospel: "Matthew 13:24-30, 34-43" },
  { date_reference: "proper_11", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 57:14-21", psalm: "Psalm 22:23-31", second_reading: "Ephesians 2:11-22", gospel: "Mark 6:30-44" },
  { date_reference: "proper_11", cycle: "C", service_type: "eucharist", first_reading: "Genesis 18:1-14", psalm: "Psalm 15", second_reading: "Colossians 1:21-29", gospel: "Luke 10:38-42" },

  # --- PROPER 12 ---
  { date_reference: "proper_12", cycle: "A", service_type: "eucharist", first_reading: "1 Kings 3:3-14", psalm: "Psalm 119:121-136", second_reading: "Romans 8:26-34", gospel: "Matthew 13:31-33, 44-50" },
  { date_reference: "proper_12", cycle: "B", service_type: "eucharist", first_reading: "2 Kings 2:1-15", psalm: "Psalm 114", second_reading: "Ephesians 3:(1-7)8-21", gospel: "Mark 6:45-52" },
  { date_reference: "proper_12", cycle: "C", service_type: "eucharist", first_reading: "Genesis 18:20-33", psalm: "Psalm 138", second_reading: "Colossians 2:6-15", gospel: "Luke 11:1-13" },

  # --- PROPER 13 ---
  { date_reference: "proper_13", cycle: "A", service_type: "eucharist", first_reading: "Nehemiah 9:16-21", psalm: "Psalm 78:(1-13)14-26", second_reading: "Romans 8:35-39", gospel: "Matthew 14:13-21" },
  { date_reference: "proper_13", cycle: "B", service_type: "eucharist", first_reading: "Exodus 16:2-4(5-8)9-15", psalm: "Psalm 78:(1-13)14-26", second_reading: "Ephesians 4:1-16", gospel: "John 6:24-35" },
  { date_reference: "proper_13", cycle: "C", service_type: "eucharist", first_reading: "Ecclesiastes 1:12-2:11", psalm: "Psalm 49:1-12(13-21)", second_reading: "Colossians 3:5-17", gospel: "Luke 12:13-21" },

  # --- PROPER 14 ---
  { date_reference: "proper_14", cycle: "A", service_type: "eucharist", first_reading: "Jonah 2:1-10", psalm: "Psalm 29", second_reading: "Romans 9:1-5", gospel: "Matthew 14:22-33" },
  { date_reference: "proper_14", cycle: "B", service_type: "eucharist", first_reading: "Deuteronomy 8:1-10", psalm: "Psalm 34:(1-7)8-15(16-22)", second_reading: "Ephesians 4:17-5:2", gospel: "John 6:37-51" },
  { date_reference: "proper_14", cycle: "C", service_type: "eucharist", first_reading: "Genesis 15:1-6", psalm: "Psalm 33(1-9)10-21", second_reading: "Hebrews 11:1-16", gospel: "Luke 12:32-40" },

  # --- PROPER 15 ---
  { date_reference: "proper_15", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 56:1-8", psalm: "Psalm 67", second_reading: "Romans 11:13-24", gospel: "Matthew 15:21-28" },
  { date_reference: "proper_15", cycle: "B", service_type: "eucharist", first_reading: "Proverbs 9:1-6", psalm: "Psalm 147", second_reading: "Ephesians 5:3-14", gospel: "John 6:53-59" },
  { date_reference: "proper_15", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 23:23-29", psalm: "Psalm 82", second_reading: "Hebrews 12:1-14", gospel: "Luke 12:49-56" },

  # --- PROPER 16 ---
  { date_reference: "proper_16", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 51:1-6", psalm: "Psalm 138", second_reading: "Romans 11:25-36", gospel: "Matthew 16:13-20" },
  { date_reference: "proper_16", cycle: "B", service_type: "eucharist", first_reading: "Joshua 24:1-22, 14-25", psalm: "Psalm 16", second_reading: "Ephesians 5:15-33(6:1-9)", gospel: "John 6:60-69" },
  { date_reference: "proper_16", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 28:14-22", psalm: "Psalm 46", second_reading: "Hebrews 12:(15-17)18-29", gospel: "Luke 13:22-30" },

  # --- PROPER 17 ---
  { date_reference: "proper_17", cycle: "A", service_type: "eucharist", first_reading: "Jeremiah 15:15-21", psalm: "Psalm 26", second_reading: "Romans 12:1-8", gospel: "Matthew 16:21-27" },
  { date_reference: "proper_17", cycle: "B", service_type: "eucharist", first_reading: "Deuteronomy 4:1-9", psalm: "Psalm 15", second_reading: "Ephesians 6:10-20", gospel: "Mark 7:1-23" },
  { date_reference: "proper_17", cycle: "C", service_type: "eucharist", first_reading: "Ecclesiasticus 10:7-18", psalm: "Psalm 112", second_reading: "Hebrews 13:1-8", gospel: "Luke 14:1, 7-14" },

  # --- PROPER 18 ---
  { date_reference: "proper_18", cycle: "A", service_type: "eucharist", first_reading: "Ezekiel 33:1-11", psalm: "Psalm 119:33-48", second_reading: "Romans 12:9-21", gospel: "Matthew 18:15-20" },
  { date_reference: "proper_18", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 35:4-7a", psalm: "Psalm 146", second_reading: "James 1:17-27", gospel: "Mark 7:31-37" },
  { date_reference: "proper_18", cycle: "C", service_type: "eucharist", first_reading: "Deuteronomy 30:15-20", psalm: "Psalm 1", second_reading: "Philemon (1-3)4-21(22-25)", gospel: "Luke 14:25-33" },

  # --- PROPER 19 ---
  { date_reference: "proper_19", cycle: "A", service_type: "eucharist", first_reading: "Ecclesiasticus 27:30-28:7", psalm: "Psalm 103 or 103:1-14", second_reading: "Romans 14:5-12", gospel: "Matthew 18:21-35" },
  { date_reference: "proper_19", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 50:4-9", psalm: "Psalm 116:1-9(10-16)", second_reading: "James 2:1-18", gospel: "Mark 9:14-29" },
  { date_reference: "proper_19", cycle: "C", service_type: "eucharist", first_reading: "Exodus 32:1, 7-14", psalm: "Psalm 51:1-17", second_reading: "1 Timothy 1:12-17", gospel: "Luke 15:1-10" },

  # --- PROPER 20 ---
  { date_reference: "proper_20", cycle: "A", service_type: "eucharist", first_reading: "Jonah 3:10-4:11", psalm: "Psalm 145:(1-13)14-21", second_reading: "Philippians 1:21-27", gospel: "Matthew 20:1-16" },
  { date_reference: "proper_20", cycle: "B", service_type: "eucharist", first_reading: "Wisdom 1:16-2:1, 12-22", psalm: "Psalm 54", second_reading: "James 3:16-4:6", gospel: "Mark 9:30-37" },
  { date_reference: "proper_20", cycle: "C", service_type: "eucharist", first_reading: "Amos 8:4-12", psalm: "Psalm 138", second_reading: "1 Timothy 2:1-7(8-15)", gospel: "Luke 16:1-13" },

  # --- PROPER 21 ---
  { date_reference: "proper_21", cycle: "A", service_type: "eucharist", first_reading: "Ezekiel 18:1-4, 25-32", psalm: "Psalm 25:1-14(15-21)", second_reading: "Philippians 2:1-13", gospel: "Matthew 21:28-32" },
  { date_reference: "proper_21", cycle: "B", service_type: "eucharist", first_reading: "Numbers 11:4-6, 10-17, 24-29", psalm: "Psalm 19:(1-6)7-14", second_reading: "James 4:7-12(13-5:6)", gospel: "Mark 9:38-48" },
  { date_reference: "proper_21", cycle: "C", service_type: "eucharist", first_reading: "Amos 6:1-7", psalm: "Psalm 146", second_reading: "1 Timothy 6:11-19", gospel: "Luke 16:19-31" },

  # --- PROPER 22 ---
  { date_reference: "proper_22", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 5:1-7", psalm: "Psalm 80:(1-6)7-19", second_reading: "Philippians 3:14-21", gospel: "Matthew 21:33-44" },
  { date_reference: "proper_22", cycle: "B", service_type: "eucharist", first_reading: "Genesis 2:18-24", psalm: "Psalm 8", second_reading: "Hebrews 2:(1-8)9-18", gospel: "Mark 10:2-16" },
  { date_reference: "proper_22", cycle: "C", service_type: "eucharist", first_reading: "Habakkuk 1:1-13, 2:1-4", psalm: "Psalm 37:1-17", second_reading: "2 Timothy 1:1-14", gospel: "Luke 17:5-10" },

  # --- PROPER 23 ---
  { date_reference: "proper_23", cycle: "A", service_type: "eucharist", first_reading: "Isaiah 25:1-9", psalm: "Psalm 23", second_reading: "Philippians 4:4-13", gospel: "Matthew 22:1-14" },
  { date_reference: "proper_23", cycle: "B", service_type: "eucharist", first_reading: "Amos 5:6-15", psalm: "Psalm 90:1-12(13-17)", second_reading: "Hebrews 3:1-6", gospel: "Mark 10:17-31" },
  { date_reference: "proper_23", cycle: "C", service_type: "eucharist", first_reading: "Ruth 1:1-19a", psalm: "Psalm 113", second_reading: "2 Timothy 2:1-15", gospel: "Luke 17:11-19" },

  # --- PROPER 24 ---
  { date_reference: "proper_24", cycle: "A", service_type: "eucharist", first_reading: "Malachi 3:6-12", psalm: "Psalm 96", second_reading: "1 Thessalonians 1:1-10", gospel: "Matthew 22:15-22" },
  { date_reference: "proper_24", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 53:4-12", psalm: "Psalm 91", second_reading: "Hebrews 4:12-16", gospel: "Mark 10:35-45" },
  { date_reference: "proper_24", cycle: "C", service_type: "eucharist", first_reading: "Genesis 32:3-8, 22-30", psalm: "Psalm 121", second_reading: "2 Timothy 3:14-4:5", gospel: "Luke 18:1-8" },

  # --- PROPER 25 ---
  { date_reference: "proper_25", cycle: "A", service_type: "eucharist", first_reading: "Exodus 22:21-27", psalm: "Psalm 1", second_reading: "1 Thessalonians 2:1-8", gospel: "Matthew 22:34-46" },
  { date_reference: "proper_25", cycle: "B", service_type: "eucharist", first_reading: "Isaiah 59:9-20", psalm: "Psalm 13", second_reading: "Hebrews 5:11-6:12", gospel: "Mark 10:46-52" },
  { date_reference: "proper_25", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 14:(1-6)7-10, 19-22", psalm: "Psalm 84", second_reading: "2 Timothy 4:6-18", gospel: "Luke 18:9-14" },

  # --- PROPER 26 ---
  { date_reference: "proper_26", cycle: "A", service_type: "eucharist", first_reading: "Micah 3:5-12", psalm: "Psalm 43", second_reading: "1 Thessalonians 2:9-20", gospel: "Matthew 23:1-12" },
  { date_reference: "proper_26", cycle: "B", service_type: "eucharist", first_reading: "Deuteronomy 6:1-9", psalm: "Psalm 119:1-16", second_reading: "Hebrews 7:23-28", gospel: "Mark 12:28-34" },
  { date_reference: "proper_26", cycle: "C", service_type: "eucharist", first_reading: "Isaiah 1:10-20", psalm: "Psalm 32", second_reading: "2 Thessalonians 1:1-12", gospel: "Luke 19:1-10" },

  # --- PROPER 27 ---
  { date_reference: "proper_27", cycle: "A", service_type: "eucharist", first_reading: "Amos 5:18-24", psalm: "Psalm 70", second_reading: "1 Thessalonians 4:13-18", gospel: "Matthew 25:1-13" },
  { date_reference: "proper_27", cycle: "B", service_type: "eucharist", first_reading: "1 Kings 17:8-16", psalm: "Psalm 146", second_reading: "Hebrews 9:24-28", gospel: "Mark 12:38-44" },
  { date_reference: "proper_27", cycle: "C", service_type: "eucharist", first_reading: "Job 19:23-27a", psalm: "Psalm 17", second_reading: "2 Thessalonians 2:13-3:5", gospel: "Luke 20:27-38" },

  # --- PROPER 28 ---
  { date_reference: "proper_28", cycle: "A", service_type: "eucharist", first_reading: "Zephaniah 1:7, 12-18", psalm: "Psalm 90:1-12(13-17)", second_reading: "1 Thessalonians 5:1-10", gospel: "Matthew 25:14-30" },
  { date_reference: "proper_28", cycle: "B", service_type: "eucharist", first_reading: "Daniel 12:1-4a(4b-13)", psalm: "Psalm 16", second_reading: "Hebrews 10:31-39", gospel: "Mark 13:14-23" },
  { date_reference: "proper_28", cycle: "C", service_type: "eucharist", first_reading: "Malachi 3:13-4:6", psalm: "Psalm 98", second_reading: "2 Thessalonians 3:6-16", gospel: "Luke 21:5-19" },

  # --- PROPER 29 (CHRIST THE KING) ---
  { date_reference: "christ_the_king", cycle: "A", service_type: "eucharist", first_reading: "Ezekiel 34:11-20", psalm: "Psalm 95", second_reading: "1 Corinthians 15:20-28", gospel: "Matthew 25:31-46" },
  { date_reference: "christ_the_king", cycle: "B", service_type: "eucharist", first_reading: "Daniel 7:9-14", psalm: "Psalm 93", second_reading: "Revelation 1:1-8", gospel: "John 18:33-37" },
  { date_reference: "christ_the_king", cycle: "C", service_type: "eucharist", first_reading: "Jeremiah 23:1-6", psalm: "Psalm 46", second_reading: "Colossians 1:11-20", gospel: "Luke 23:35-43" }
]

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
  else
    existing.update!(reading)
  end
end
