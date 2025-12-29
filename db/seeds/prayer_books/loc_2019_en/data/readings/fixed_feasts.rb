# ================================================================================
# LEITURAS DE DIAS SANTOS E COMEMORAÇÕES - LOC 2019 EN
# ================================================================================

Rails.logger.info "📖 Loading Holy Days and Special readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')
celebrations = Celebration.where(prayer_book: prayer_book)

def create_reading(attrs, prayer_book_id)
  attrs[:prayer_book_id] = prayer_book_id
  attrs[:cycle] ||= "all" # Dias fixos geralmente servem para todos os ciclos
  
  existing = LectionaryReading.find_by(
    date_reference: attrs[:date_reference],
    celebration_id: attrs[:celebration_id],
    cycle: attrs[:cycle],
    service_type: attrs[:service_type],
    prayer_book_id: prayer_book_id
  )

  if existing.nil?
    LectionaryReading.create!(attrs)
  else
    existing.update!(attrs)
  end
end

# --- HOLY DAYS (Vincular por celebration_id) ---
holy_days_readings = [
  ['Andrew the Apostle', "Deuteronomy 30:11-14", "Psalm 19 or 19:1-6", "Romans 10:8b-18", "Matthew 4:18-22"],
  ['Thomas the Apostle', "Habakkuk 2:1-4", "Psalm 126", "Hebrews 10:35-11:1", "John 20:19-29"],
  ['Stephen, Deacon and Martyr', "Jeremiah 26:1-9(10-11)12-15", "Psalm 31:1-6(7-27)", "Acts 6:8-7:2a, 51-60", "Matthew 23:29-39"],
  ['John, Apostle and Evangelist', "Exodus 33:18-23", "Psalm 92:1-4(5-10)11-14", "1 John 1", "John 21:9-25 or John 1:1-18"],
  ['The Holy Innocents', "Jeremiah 31:15-17", "Psalm 124", "Revelation 21:1-7", "Matthew 2:13-18"],
  ['The Circumcision and Holy Name of Our Lord Jesus Christ', "Exodus 34:1-9", "Psalm 8", "Romans 1:1-7", "Luke 2:15-21"],
  ['Confession of Peter the Apostle', "Acts 4:8-13", "Psalm 23", "1 Peter 5:1-11", "Matthew 16:13-19"],
  ['Conversion of Paul the Apostle', "Acts 26:9-21", "Psalm 67", "Galatians 1:11-24", "Matthew 10:16-25"],
  ['The Presentation of Our Lord Jesus Christ in the Temple', "Malachi 3:1-4", "Psalm 84", "Hebrews 2:14-18", "Luke 2:22-40"],
  ['Matthias the Apostle', "Acts 1:15-26", "Psalm 15", "Philippians 3:12-21", "John 15:1-16"],
  ['Joseph, Husband of the Virgin Mary and Guardian of Jesus', "2 Samuel 7:4, 8-16", "Psalm 89:1-4(5-18)19-29", "Romans 4:13-18", "Luke 2:41-52"],
  ['The Annunciation of our Lord Jesus Christ to the Virgin Mary', "Isaiah 7:10-14", "Psalm 40:1-13 or Magnificat", "Hebrews 10:5-10", "Luke 1:26-38"],
  ['Mark the Evangelist', "Isaiah 52:7-10", "Psalm 2", "Ephesians 4:7-8, 11-16", "Mark 16:15-20"],
  ['Philip and James, Apostles', "Isaiah 30:18-21", "Psalm 119:33-40", "2 Corinthians 4:1-7", "John 14:6-14"],
  ['The Visitation of the Virgin Mary to Elizabeth and Zechariah', "Zephaniah 3:14-18", "Psalm 113 or Ecce Deus", "Colossians 3:12-17", "Luke 1:39-56"],
  ['Barnabas the Apostle', "Isaiah 42:5-12", "Psalm 112", "Acts 11:19-30, 13:1-3", "Matthew 10:7-16"],
  ['The Nativity of John the Baptist', "Isaiah 40:1-11", "Psalm 85:7-13", "Acts 13:14b-26", "Luke 1:57-80"],
  ['Peter and Paul, Apostles', "Ezekiel 34:11-16", "Psalm 87", "2 Timothy 4:1-8", "John 21:15-19"],
  ['Mary Magdalene', "Judges 4:4-10 or Judith 9:1, 11-14", "Psalm 42:1-7(8-15)", "2 Corinthians 5:14-20a", "John 20:11-18"],
  ['James the Elder, Apostle', "Jeremiah 45:1-5", "Psalm 7:1-11(12-18)", "Acts 11:27-12:3", "Matthew 20:20-28"],
  ['The Transfiguration of Our Lord Jesus Christ', "Exodus 34:29-35", "Psalm 99", "2 Peter 1:13-21", "Luke 9:28-36"],
  ['The Virgin Mary, Mother of Our Lord Jesus Christ', "Isaiah 61:10-11", "Psalm 34", "Galatians 4:4-7", "Luke 1:46-55"],
  ['Bartholomew the Apostle', "Deuteronomy 18:15-18", "Psalm 91", "1 Corinthians 4:9-16", "Luke 22:24-30"],
  ['Holy Cross Day', "Isaiah 45:21-25", "Psalm 98", "Philippians 2:5-11", "John 12:31-36a"],
  ['Matthew, Apostle and Evangelist', "Proverbs 3:1-12", "Psalm 119:33-40", "2 Timothy 3:1-17", "Matthew 9:9-13"],
  ['Holy Michael and All Angels', "Genesis 28:10-17", "Psalm 103", "Revelation 12:7-12", "John 1:47-51"],
  ['Luke the Evangelist and Companion of Paul', "Ecclesiasticus 38:1-14", "Psalm 147:1-11", "2 Timothy 4:1-13", "Luke 4:14-21"],
  ['James of Jerusalem, Bishop and Martyr', "Acts 15:12-22a", "Psalm 1", "1 Corinthians 15:1-11", "Matthew 13:54-58"],
  ['Simon and Jude, Apostles', "Deuteronomy 32:1-4", "Psalm 119:89-96", "Ephesians 2:13-22", "John 15:17-27"],
  ["All Saints' Day", "Ecclesiasticus 44:1-14 or Revelation 7:9-17", "Psalm 149", "Revelation 7:9-17 or Ephesians 1:(11-14)15-23", "Matthew 5:1-12 or Luke 6:20-26(27-36)"]
]

holy_days_readings.each do |name, first, psalm, second, gospel|
  c = celebrations.find_by(name: name)
  if c
    create_reading({ celebration_id: c.id, date_reference: name.parameterize.underscore, service_type: 'eucharist', first_reading: first, psalm: psalm, second_reading: second, gospel: gospel }, prayer_book.id)
  else
    Rails.logger.warn "⚠️  Celebration not found for reading: #{name}"
  end
end

# --- EMBER, ROGATION & NATIONAL DAYS ---
special_readings = [
  ['ember_days_1', "all", "eucharist", "Numbers 11:16-17, 24-29", "Psalm 99", "1 Corinthians 3:5-11", "John 4:31-38"],
  ['ember_days_2', "all", "eucharist", "1 Samuel 3:1-10", "Psalm 63:1-8", "Ephesians 4:11-16", "Matthew 9:35-38"],
  ['rogation_days_1', "all", "eucharist", "Deuteronomy 11:10-15", "Psalm 147", "Romans 8:18-25", "Mark 4:26-32"],
  ['rogation_days_2', "all", "eucharist", "Ecclesiasticus 38:27-32", "Psalm 107:1-9", "1 Corinthians 3:10-14", "Matthew 6:19-24"],
  ['thanksgiving_day', "all", "eucharist", "Deuteronomy 8", "Psalm 65:1-8(9-14)", "James 1:17-27", "Matthew 6:25-33"],
  ['canada_day', "all", "eucharist", "Deuteronomy 6:1-15", "Psalm 145", "1 Peter 2:1-6", "Matthew 22:16-21 or Matthew 25:14-30"],
  ['independence_day', "all", "eucharist", "Deuteronomy 10:17-21", "Psalm 145", "Hebrews 11:8-16", "Matthew 5:43-48"],
  ['memorial_day', "all", "eucharist", "Wisdom 3:1-9", "Psalm 121", "Revelation 7:9-17", "John 11:21-27 or John 15:12-17"]
]

special_readings.each do |ref, cycle, service, first, psalm, second, gospel|
  create_reading({ date_reference: ref, cycle: cycle, service_type: service, first_reading: first, psalm: psalm, second_reading: second, gospel: gospel }, prayer_book.id)
end

# --- COMMON OF THE COMMEMORATIONS ---
commons_readings = [
  ['common_martyrs', "Jeremiah 15:15-21", "Psalm 34", "Revelation 7:9-17", "Luke 12:4-12"],
  ['common_missionaries', "Isaiah 49:1-7", "Psalm 98", "Romans 10:11-18", "Luke 5:1-11"],
  ['common_pastors', "Isaiah 6:1-8", "Psalm 71:17-24", "1 Peter 5:1-11 or Acts 20:24-35", "Matthew 24:42-50"],
  ['common_teachers', "Proverbs 3:13-26", "Psalm 119:89-106", "1 John 1:1-10", "Matthew 13:47-52"],
  ['common_religious', "Lamentations 3:22-33", "Psalm 1", "Hebrews 4:1-13 or Acts 2:42-47", "Mark 10:23-31"],
  ['common_ecumenists', "Ezekiel 34:11-16", "Psalm 133", "Ephesians 3:14-21", "John 17:10-26"],
  ['common_reformers', "Jeremiah 1:4-10", "Psalm 46", "1 Corinthians 3:10-23", "Matthew 5:13-20"],
  ['common_renewers', "Exodus 3:7-12", "Psalm 145:1-13", "Romans 12:9-21", "Luke 6:20-38"],
  ['common_any_1', "Micah 6:6-8", "Psalm 1", "1 Corinthians 1:18-31", "John 3:16-21"],
  ['common_any_2', "Wisdom 3:1-9", "Psalm 15", "Philippians 4:4-9", "Luke 6:17-23"]
]

commons_readings.each do |ref, first, psalm, second, gospel|
  create_reading({ date_reference: ref, service_type: 'eucharist', first_reading: first, psalm: psalm, second_reading: second, gospel: gospel }, prayer_book.id)
end

Rails.logger.info "✅ Holy Days and Commons readings loaded!"
