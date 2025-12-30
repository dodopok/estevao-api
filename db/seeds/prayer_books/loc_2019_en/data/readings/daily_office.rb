# ================================================================================
# DAILY OFFICE LECTIONARY - LOC 2019 EN (Full Year)
# ================================================================================

Rails.logger.info "📖 Loading Daily Office readings for LOC 2019 EN..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

def create_daily_reading(attrs, prayer_book_id)
  attrs[:prayer_book_id] = prayer_book_id
  attrs[:cycle] = "all" # Daily office is fixed by date

  existing = LectionaryReading.find_by(
    date_reference: attrs[:date_reference],
    service_type: attrs[:service_type],
    prayer_book_id: prayer_book_id
  )

  if existing.nil?
    LectionaryReading.create!(attrs)
  else
    existing.update!(attrs)
  end
end

# Helper to process months
def seed_month(month_name, days_count, mp_map, ep_map, prayer_book_id)
  (1..days_count).each do |day|
    date_ref = "#{month_name}_#{day}"

    if mp_map[day]
      create_daily_reading({
        date_reference: date_ref,
        service_type: 'morning_prayer',
        first_reading: mp_map[day][:first],
        first_reading_abbreviated: mp_map[day][:first_abbr],
        second_reading: mp_map[day][:second],
        psalm: mp_map[day][:psalms]
      }, prayer_book_id)
    end

    if ep_map[day]
      create_daily_reading({
        date_reference: date_ref,
        service_type: 'evening_prayer',
        first_reading: ep_map[day][:first],
        first_reading_abbreviated: ep_map[day][:first_abbr],
        second_reading: ep_map[day][:second],
        psalm: ep_map[day][:psalms]
      }, prayer_book_id)
    end
  end
end

# --- JUNE ---
june_mp = {
  1 => { first: "Deut 33", second: "Luke 17:20-end", psalms: "78:1-18" },
  2 => { first: "Deut 34", second: "Luke 18:1-30", psalms: "78:41-73" },
  3 => { first: "Josh 1", second: "Luke 18:31-19:10", psalms: "81" },
  4 => { first: "Josh 2", second: "Luke 19:11-28", psalms: "84" },
  5 => { first: "Josh 3", second: "Luke 19:29-end", psalms: "86, 87" },
  6 => { first: "Josh 4", second: "Luke 20:1-26", psalms: "89:1-18" },
  7 => { first: "Josh 5", second: "Luke 20:27-21:4", psalms: "90" },
  8 => { first: "Josh 6", second: "Luke 21:5-end", psalms: "92, 93" },
  9 => { first: "Josh 7", second: "Luke 22:1-38", psalms: "95, 96" },
  10 => { first: "Josh 8", first_abbr: "Josh 8:1-22, 30-35", second: "Luke 22:39-53", psalms: "99, 100, 101" },
  11 => { first: "Acts 4:32-37", second: "Luke 22:54-end", psalms: "103" },
  12 => { first: "Josh 9", second: "Luke 23:1-25", psalms: "105:1-22" },
  13 => { first: "Josh 10", first_abbr: "Josh 10:1-27, 40-43", second: "Luke 23:26-49", psalms: "106:1-18" },
  14 => { first: "Josh 14", first_abbr: "Josh 14:5-15", second: "Luke 23:50-24:12", psalms: "107:1-22" },
  15 => { first: "Josh 22", first_abbr: "Josh 22:7-31", second: "Luke 24:13-end", psalms: "108, 110" },
  16 => { first: "Josh 23", second: "Gal 1", psalms: "111, 112" },
  17 => { first: "Josh 24", first_abbr: "Josh 24:1-31", second: "Gal 2", psalms: "115" },
  18 => { first: "Judg 1", first_abbr: "Judg 1:1-21", second: "Gal 3", psalms: "119:1-24" },
  19 => { first: "Judg 2", first_abbr: "Judg 2:6-23", second: "Gal 4", psalms: "119:49-72" },
  20 => { first: "Judg 3", first_abbr: "Judg 3:7-30", second: "Gal 5", psalms: "119:89-104" },
  21 => { first: "Judg 4", second: "Gal 6", psalms: "119:129-152" },
  22 => { first: "Judg 5", first_abbr: "Judg 5:1-5, 19-31", second: "1 Thess 1", psalms: "118" },
  23 => { first: "Judg 6", first_abbr: "Judg 6:1, 6, 11-24, 33-40", second: "1 Thess 2:1-16", psalms: "122, 123" },
  24 => { first: "1 Thess 2:17-3 end", second: "Matt 14:1-13", psalms: "127, 128" },
  25 => { first: "Judg 7", first_abbr: "Judg 7:1-8, 16-25", second: "1 Thess 4:1-12", psalms: "132, 133" },
  26 => { first: "Judg 8", first_abbr: "Judg 8:4-23, 28", second: "1 Thess 4:13-5:11", psalms: "136" },
  27 => { first: "Judg 9", first_abbr: "Judg 9:1-6, 22-25, 43-56", second: "1 Thess 5:12-end", psalms: "139" },
  28 => { first: "Judg 10", first_abbr: "Judg 10:6-18", second: "2 Thess 1", psalms: "140" },
  29 => { first: "2 Thess 2", second: "2 Pet 3:14-end", psalms: "144" },
  30 => { first: "Judg 11", first_abbr: "Judg 11:1-11, 29-40", second: "2 Thess 3", psalms: "146" }
}

june_ep = {
  1 => { first: "Ezek 6", second: "Acts 8:4-25", psalms: "78:19-40" },
  2 => { first: "Ezek 7", second: "Acts 8:26-end", psalms: "80" },
  3 => { first: "Ezek 8", second: "Acts 9:1-31", psalms: "83" },
  4 => { first: "Ezek 9", second: "Acts 9:32-end", psalms: "85" },
  5 => { first: "Ezek 10", second: "Acts 10:1-23", psalms: "88" },
  6 => { first: "Ezek 11", second: "Acts 10:24-end", psalms: "89:19-51" },
  7 => { first: "Ezek 12", second: "Acts 11:1-18", psalms: "91" },
  8 => { first: "Ezek 13", second: "Acts 11:19-end", psalms: "94" },
  9 => { first: "Ezek 14", second: "Acts 12:1-24", psalms: "97, 98" },
  10 => { first: "Ezek 15", second: "Acts 12:25-13:12", psalms: "102" },
  11 => { first: "Ezek 16", first_abbr: "Ezek 16:1-15, 33-47, 59-63", second: "Acts 13:13-43", psalms: "104" },
  12 => { first: "Ezek 17", second: "Acts 13:44-14:7", psalms: "105:23-44" },
  13 => { first: "Ezek 18", second: "Acts 14:8-end", psalms: "106:19-46" },
  14 => { first: "Ezek 33", first_abbr: "Ezek 33:1-23, 30-33", second: "Acts 15:1-21", psalms: "107:23-43" },
  15 => { first: "Ezek 34", second: "Acts 15:22-35", psalms: "109" },
  16 => { first: "Ezek 35", second: "Acts 15:36-16:5", psalms: "113, 114" },
  17 => { first: "Ezek 36", first_abbr: "Ezek 36:16-37", second: "Acts 16:6-end", psalms: "116, 117" },
  18 => { first: "Ezek 37", second: "Acts 17:1-15", psalms: "119:25-48" },
  19 => { first: "Ezek 40", first_abbr: "Ezek 40:1-5, 17-19, 35-49", second: "Acts 17:16-end", psalms: "119:73-88" },
  20 => { first: "Ezek 43", second: "Acts 18:1-23", psalms: "119:105-128" },
  21 => { first: "Ezek 47", second: "Acts 18:24-19:7", psalms: "119:153-176" },
  22 => { first: "Dan 1", second: "Acts 19:8-20", psalms: "120, 121" },
  23 => { first: "Dan 2", first_abbr: "Dan 2:1-14, 25-28, 31-45", second: "Acts 19:21-end", psalms: "124, 125, 126" },
  24 => { first: "Dan 3", second: "Acts 20:1-16", psalms: "129, 130, 131" },
  25 => { first: "Dan 4", first_abbr: "Dan 4:1-9, 19-35", second: "Acts 20:17-end", psalms: "134, 135" },
  26 => { first: "Dan 5", second: "Acts 21:1-16", psalms: "137, 138" },
  27 => { first: "Dan 6", second: "Acts 21:17-36", psalms: "141, 142" },
  28 => { first: "Dan 7", second: "Acts 21:37-22:22", psalms: "143" },
  29 => { first: "Dan 8", second: "Acts 22:23-23:11", psalms: "145" },
  30 => { first: "Dan 9", second: "Acts 23:12-end", psalms: "147" }
}

seed_month("june", 30, june_mp, june_ep, prayer_book.id)

# --- JULY ---
july_mp = {
  1 => { first: "Judg 12", second: "1 Cor 1:1-25", psalms: "148" },
  2 => { first: "Judg 13", second: "1 Cor 1:26-2:16", psalms: "1, 2" },
  3 => { first: "Judg 14", second: "1 Cor 3", psalms: "5, 6" },
  4 => { first: "Judg 15", second: "1 Cor 4:1-17", psalms: "9" },
  5 => { first: "Judg 16", second: "1 Cor 4:18-5:13", psalms: "8, 11" },
  6 => { first: "Ruth 1", second: "1 Cor 6", psalms: "12, 13, 14" },
  7 => { first: "Ruth 2", second: "1 Cor 7", psalms: "18:1-20" },
  8 => { first: "Ruth 3", second: "1 Cor 8", psalms: "19" },
  9 => { first: "Ruth 4", second: "1 Cor 9", psalms: "22" },
  10 => { first: "1 Sam 1", first_abbr: "1 Sam 1:1-20", second: "1 Cor 10", psalms: "25" },
  11 => { first: "1 Sam 2", first_abbr: "1 Sam 2:1-21", second: "1 Cor 11", psalms: "26, 28" },
  12 => { first: "1 Sam 3", second: "1 Cor 12", psalms: "29, 30" },
  13 => { first: "1 Sam 4", second: "1 Cor 13", psalms: "34" },
  14 => { first: "1 Sam 5", second: "1 Cor 14:1-19", psalms: "32, 36" },
  15 => { first: "1 Sam 6", first_abbr: "1 Sam 6:1-15", second: "1 Cor 14:20-40", psalms: "37:1-17" },
  16 => { first: "1 Sam 7", second: "1 Cor 15:1-34", psalms: "40" },
  17 => { first: "1 Sam 8", second: "1 Cor 15:35-end", psalms: "42, 43" },
  18 => { first: "1 Sam 9", second: "1 Cor 16", psalms: "45" },
  19 => { first: "1 Sam 10", second: "2 Cor 1:1-2:11", psalms: "47, 48" },
  20 => { first: "1 Sam 11", second: "2 Cor 2:12-3:18", psalms: "50" },
  21 => { first: "1 Sam 12", second: "2 Cor 4", psalms: "52, 53, 54" },
  22 => { first: "2 Cor 5", second: "Luke 7:36-8:3", psalms: "56, 57" },
  23 => { first: "1 Sam 13", second: "2 Cor 6", psalms: "59" },
  24 => { first: "1 Sam 14", first_abbr: "1 Sam 14:1-15, 20, 24-30", second: "2 Cor 7", psalms: "61, 62" },
  25 => { first: "2 Cor 8", second: "Mark 1:14-20", psalms: "68:1-18" },
  26 => { first: "1 Sam 15", second: "2 Cor 9", psalms: "69:1-18" },
  27 => { first: "1 Sam 16", second: "2 Cor 10", psalms: "66" },
  28 => { first: "1 Sam 17", first_abbr: "1 Sam 17:1-11, 26-27, 31-51", second: "2 Cor 11", psalms: "71" },
  29 => { first: "1 Sam 18", second: "2 Cor 12:1-13", psalms: "74" },
  30 => { first: "1 Sam 19", second: "2 Cor 12:14-13 end", psalms: "75, 76" },
  31 => { first: "1 Sam 20", first_abbr: "1 Sam 20:1-7, 24-42", second: "Rom 1", psalms: "78:1-18" }
}

july_ep = {
  1 => { first: "Dan 10", second: "Acts 24:1-23", psalms: "149, 150" },
  2 => { first: "Dan 11", first_abbr: "Dan 11:1-19", second: "Acts 24:24-25:12", psalms: "3, 4" },
  3 => { first: "Dan 12", second: "Acts 25:13-end", psalms: "7" },
  4 => { first: "Susanna", second: "Acts 26", psalms: "10" },
  5 => { first: "Esth 1", second: "Acts 27", psalms: "15, 16" },
  6 => { first: "Esth 2", second: "Acts 28:1-15", psalms: "17" },
  7 => { first: "Esth 3", second: "Acts 28:16-end", psalms: "18:21-52" },
  8 => { first: "Esth 4", second: "Philemon", psalms: "20, 21" },
  9 => { first: "Esth 5", second: "1 Tim 1:1-17", psalms: "23, 24" },
  10 => { first: "Esth 6", second: "1 Tim 1:18-2 end", psalms: "27" },
  11 => { first: "Esth 7", second: "1 Tim 3", psalms: "31" },
  12 => { first: "Esth 8", second: "1 Tim 4", psalms: "33" },
  13 => { first: "Esth 9 & 10", second: "1 Tim 5", psalms: "35" },
  14 => { first: "Ezra 1", second: "1 Tim 6", psalms: "38" },
  15 => { first: "Ezra 3", second: "Titus 1", psalms: "37:18-41" },
  16 => { first: "Ezra 4", second: "Titus 2", psalms: "39, 41" },
  17 => { first: "Ezra 5", second: "Titus 3", psalms: "44" },
  18 => { first: "Ezra 6", second: "2 Tim 1", psalms: "46" },
  19 => { first: "Ezra 7", second: "2 Tim 2", psalms: "49" },
  20 => { first: "Ezra 8", first_abbr: "Ezra 8:21-36", second: "2 Tim 3", psalms: "51" },
  21 => { first: "Ezra 9", second: "2 Tim 4", psalms: "55" },
  22 => { first: "Ezra 10", first_abbr: "Ezra 10:1-16", second: "John 1:1-28", psalms: "58, 60" },
  23 => { first: "Neh 1", second: "John 1:29-end", psalms: "63, 64" },
  24 => { first: "Neh 2", second: "John 2", psalms: "65, 67" },
  25 => { first: "Neh 3", first_abbr: "Neh 3:1-15", second: "John 3:1-21", psalms: "68:19-36" },
  26 => { first: "Neh 4", second: "John 3:22-end", psalms: "69:19-37" },
  27 => { first: "Neh 5", second: "John 4:1-26", psalms: "70, 72" },
  28 => { first: "Neh 6", second: "John 4:27-end", psalms: "73" },
  29 => { first: "Neh 8", second: "John 5:1-24", psalms: "77" },
  30 => { first: "Neh 9", first_abbr: "Neh 9:1-15, 26-38", second: "John 5:25-end", psalms: "79, 82" },
  31 => { first: "Neh 10", first_abbr: "Neh 10:28-39", second: "John 6:1-21", psalms: "78:19-40" }
}

seed_month("july", 31, july_mp, july_ep, prayer_book.id)

# --- AUGUST ---
aug_mp = {
  1 => { first: "1 Sam 21", second: "Rom 2", psalms: "78:41-73" },
  2 => { first: "1 Sam 22", second: "Rom 3", psalms: "81" },
  3 => { first: "1 Sam 23", second: "Rom 4", psalms: "84" },
  4 => { first: "1 Sam 24", second: "Rom 5", psalms: "86, 87" },
  5 => { first: "1 Sam 25", first_abbr: "1 Sam 25:1-19, 23-25, 32-42", second: "Rom 6", psalms: "89:1-18" },
  6 => { first: "Rom 7", second: "Mark 9:2-10", psalms: "27" },
  7 => { first: "1 Sam 26", second: "Rom 8:1-17", psalms: "90" },
  8 => { first: "1 Sam 27", second: "Rom 8:18-end", psalms: "92, 93" },
  9 => { first: "1 Sam 28", second: "Rom 9", psalms: "95, 96" },
  10 => { first: "1 Sam 29", second: "Rom 10", psalms: "99, 100, 101" },
  11 => { first: "1 Sam 30", first_abbr: "1 Sam 30:1-25", second: "Rom 11", psalms: "103" },
  12 => { first: "1 Sam 31", second: "Rom 12", psalms: "105:1-22" },
  13 => { first: "2 Sam 1", second: "Rom 13", psalms: "106:1-18" },
  14 => { first: "2 Sam 2", first_abbr: "2 Sam 2:1-17, 26-31", second: "Rom 14", psalms: "107:1-22" },
  15 => { first: "2 Sam 3", first_abbr: "2 Sam 3:6-11, 17-39", second: "Luke 1:26-38", psalms: "108, 110" },
  16 => { first: "2 Sam 4", second: "Rom 15", psalms: "111, 112" },
  17 => { first: "2 Sam 5", second: "Rom 16", psalms: "115" },
  18 => { first: "2 Sam 6", second: "Phil 1:1-11", psalms: "119:1-24" },
  19 => { first: "2 Sam 7", second: "Phil 1:12-end", psalms: "119:49-72" },
  20 => { first: "2 Sam 8", second: "Phil 2:1-11", psalms: "119:89-104" },
  21 => { first: "2 Sam 9", second: "Phil 2:12-end", psalms: "119:129-152" },
  22 => { first: "2 Sam 10", second: "Phil 3", psalms: "118" },
  23 => { first: "2 Sam 11", second: "Phil 4", psalms: "122, 123" },
  24 => { first: "Col 1:1-20", second: "Luke 6:12-16", psalms: "127, 128" },
  25 => { first: "2 Sam 12", first_abbr: "2 Sam 12:1-25", second: "Col 1:21-2:7", psalms: "132, 133" },
  26 => { first: "2 Sam 13", first_abbr: "2 Sam 13:1-29, 38-39", second: "Col 2:8-19", psalms: "136" },
  27 => { first: "2 Sam 14", first_abbr: "2 Sam 14:1-21, 28", second: "Col 2:20-3:11", psalms: "139" },
  28 => { first: "2 Sam 15", first_abbr: "2 Sam 15:1-18, 23-25, 32-34", second: "Col 3:12-end", psalms: "140" },
  29 => { first: "2 Sam 16", second: "Col 4", psalms: "144" },
  30 => { first: "2 Sam 17", first_abbr: "2 Sam 17:1-23", second: "Philemon", psalms: "146" },
  31 => { first: "2 Sam 18", first_abbr: "2 Sam 18:1-15, 19-33", second: "Eph 1:1-14", psalms: "148" }
}

aug_ep = {
  1 => { first: "Neh 12", first_abbr: "Neh 12:27-47", second: "John 6:22-40", psalms: "80" },
  2 => { first: "Neh 13", first_abbr: "Neh 13:1-22, 30-31", second: "John 6:41-end", psalms: "83" },
  3 => { first: "Hos 1", second: "John 7:1-24", psalms: "85" },
  4 => { first: "Hos 2", second: "John 7:25-52", psalms: "88" },
  5 => { first: "Hos 3", second: "John 7:53-8:30", psalms: "89:19-51" },
  6 => { first: "Hos 4", second: "John 8:31-end", psalms: "80" },
  7 => { first: "Hos 5", second: "John 9", psalms: "91" },
  8 => { first: "Hos 6", second: "John 10:1-21", psalms: "94" },
  9 => { first: "Hos 7", second: "John 10:22-end", psalms: "97, 98" },
  10 => { first: "Hos 8", second: "John 11:1-44", psalms: "102" },
  11 => { first: "Hos 9", second: "John 11:45-end", psalms: "104" },
  12 => { first: "Hos 10", second: "John 12:1-19", psalms: "105:23-44" },
  13 => { first: "Hos 11", second: "John 12:20-end", psalms: "106:19-46" },
  14 => { first: "Hos 12", second: "John 13", psalms: "107:23-43" },
  15 => { first: "Hos 13", second: "John 14:1-14", psalms: "109" },
  16 => { first: "Hos 14", second: "John 14:15-end", psalms: "113, 114" },
  17 => { first: "Joel 1", second: "John 15:1-17", psalms: "116, 117" },
  18 => { first: "Joel 2", first_abbr: "Joel 2:1-17, 28-32", second: "John 15:18-end", psalms: "119:25-48" },
  19 => { first: "Joel 3", second: "John 16:1-15", psalms: "119:73-88" },
  20 => { first: "Amos 1", second: "John 16:16-end", psalms: "119:105-128" },
  21 => { first: "Amos 2", second: "John 17", psalms: "119:153-176" },
  22 => { first: "Amos 3", second: "John 18:1-27", psalms: "120, 121" },
  23 => { first: "Amos 4", second: "John 18:28-end", psalms: "124, 125, 126" },
  24 => { first: "Amos 5", second: "John 19:1-37", psalms: "129, 130, 131" },
  25 => { first: "Amos 6", second: "John 19:38-end", psalms: "134, 135" },
  26 => { first: "Amos 7", second: "John 20", psalms: "137, 138" },
  27 => { first: "Amos 8", second: "John 21", psalms: "141, 142" },
  28 => { first: "Amos 9", second: "Matt 1:1-17", psalms: "143" },
  29 => { first: "Obadiah", second: "Matt 1:18-end", psalms: "145" },
  30 => { first: "Jonah 1", second: "Matt 2", psalms: "147" },
  31 => { first: "Jonah 2", second: "Matt 3", psalms: "149, 150" }
}

seed_month("august", 31, aug_mp, aug_ep, prayer_book.id)

# --- SEPTEMBER ---
sep_mp = {
  1 => { first: "2 Sam 19", first_abbr: "2 Sam 19:1-30", second: "Eph 1:15-end", psalms: "1, 2" },
  2 => { first: "2 Sam 20", second: "Eph 2:1-10", psalms: "5, 6" },
  3 => { first: "2 Sam 21", second: "Eph 2:11-end", psalms: "9" },
  4 => { first: "2 Sam 22", first_abbr: "2 Sam 22:1-7, 14-20, 32-51", second: "Eph 3", psalms: "8, 11" },
  5 => { first: "2 Sam 23", first_abbr: "2 Sam 23:1-23", second: "Eph 4:1-16", psalms: "12, 13, 14" },
  6 => { first: "2 Sam 24", second: "Eph 4:17-end", psalms: "18:1-20" },
  7 => { first: "1 Chron 22", second: "Eph 5:1-17", psalms: "19" },
  8 => { first: "1 Kings 1", first_abbr: "1 Kings 1:1-18, 29-40", second: "Eph 5:18-end", psalms: "22" },
  9 => { first: "1 Chron 28", second: "Eph 6", psalms: "25" },
  10 => { first: "1 Kings 2", first_abbr: "1 Kings 2:1-25", second: "Heb 1", psalms: "26, 28" },
  11 => { first: "1 Kings 3", second: "Heb 2", psalms: "29, 30" },
  12 => { first: "1 Kings 4", first_abbr: "1 Kings 4:1-6, 20-34", second: "Heb 3", psalms: "34" },
  13 => { first: "1 Kings 5", second: "Heb 4:1-13", psalms: "32, 36" },
  14 => { first: "Heb 4:14-5:10", second: "John 12:23-33", psalms: "37:1-17" },
  15 => { first: "1 Kings 6", first_abbr: "1 Kings 6:1-7, 11-30, 37-38", second: "Heb 5:11-6 end", psalms: "40" },
  16 => { first: "1 Kings 7", first_abbr: "1 Kings 7:1-14, 40-44, 47-51", second: "Heb 7", psalms: "42, 43" },
  17 => { first: "1 Kings 8", first_abbr: "1 Kings 8:1-11, 22-30, 54-63", second: "Heb 8", psalms: "45" },
  18 => { first: "1 Kings 9", first_abbr: "1 Kings 9:1-9, 15-28", second: "Heb 9:1-14", psalms: "47, 48" },
  19 => { first: "1 Kings 10", first_abbr: "1 Kings 10:1-13, 23-29", second: "Heb 9:15-end", psalms: "50" },
  20 => { first: "1 Kings 11", first_abbr: "1 Kings 11:1-14, 23-33, 41-43", second: "Heb 10:1-18", psalms: "52, 53, 54" },
  21 => { first: "Heb 10:19-end", second: "Matt 9:9-13", psalms: "56, 57" },
  22 => { first: "1 Kings 12", first_abbr: "1 Kings 12:1-20, 25-30", second: "Heb 11", psalms: "59" },
  23 => { first: "1 Kings 13", first_abbr: "1 Kings 13:1-25, 33-34", second: "Heb 12:1-17", psalms: "61, 62" },
  24 => { first: "1 Kings 14", second: "Heb 12:18-end", psalms: "68:1-18" },
  25 => { first: "2 Chron 12", second: "Heb 13", psalms: "69:1-18" },
  26 => { first: "2 Chron 13", second: "Jas 1", psalms: "66" },
  27 => { first: "2 Chron 14", second: "Jas 2:1-13", psalms: "71" },
  28 => { first: "2 Chron 15", second: "Jas 2:14-end", psalms: "74" },
  29 => { first: "Rev 12:7-12", second: "Jas 3", psalms: "75, 76" },
  30 => { first: "2 Chron 16", second: "Jas 4", psalms: "78:1-18" }
}

sep_ep = {
  1 => { first: "Jonah 3", second: "Matt 4", psalms: "3, 4" },
  2 => { first: "Jonah 4", second: "Matt 5:1-20", psalms: "7" },
  3 => { first: "Mic 1", second: "Matt 5:21-48", psalms: "10" },
  4 => { first: "Mic 2", second: "Matt 6:1-18", psalms: "15, 16" },
  5 => { first: "Mic 3", second: "Matt 6:19-end", psalms: "17" },
  6 => { first: "Mic 4", second: "Matt 7", psalms: "18:21-52" },
  7 => { first: "Mic 5", second: "Matt 8:1-17", psalms: "20, 21" },
  8 => { first: "Mic 6", second: "Matt 8:18-end", psalms: "23, 24" },
  9 => { first: "Mic 7", second: "Matt 9:1-17", psalms: "27" },
  10 => { first: "Nahum 1", second: "Matt 9:18-34", psalms: "31" },
  11 => { first: "Nahum 2", second: "Matt 9:35-10:23", psalms: "33" },
  12 => { first: "Nahum 3", second: "Matt 10:24-end", psalms: "35" },
  13 => { first: "Hab 1", second: "Matt 11", psalms: "38" },
  14 => { first: "Hab 2", second: "Matt 12:1-21", psalms: "37:18-41" },
  15 => { first: "Hab 3", second: "Matt 12:22-end", psalms: "39, 41" },
  16 => { first: "Zeph 1", second: "Matt 13:1-23", psalms: "44" },
  17 => { first: "Zeph 2", second: "Matt 13:24-43", psalms: "46" },
  18 => { first: "Zeph 3", second: "Matt 13:44-end", psalms: "49" },
  19 => { first: "Hag 1", second: "Matt 14", psalms: "51" },
  20 => { first: "Hag 2", second: "Matt 15:1-28", psalms: "55" },
  21 => { first: "Zech 1", second: "Matt 15:29-16:12", psalms: "58, 60" },
  22 => { first: "Zech 2", second: "Matt 16:13-end", psalms: "63, 64" },
  23 => { first: "Zech 3", second: "Matt 17:1-23", psalms: "65, 67" },
  24 => { first: "Zech 4", second: "Matt 17:24-18:14", psalms: "68:19-36" },
  25 => { first: "Zech 5", second: "Matt 18:15-end", psalms: "69:19-37" },
  26 => { first: "Zech 6", second: "Matt 19:1-15", psalms: "70, 72" },
  27 => { first: "Zech 7", second: "Matt 19:16-20:16", psalms: "73" },
  28 => { first: "Zech 8", second: "Matt 20:17-end", psalms: "77" },
  29 => { first: "Zech 9", second: "Matt 21:1-22", psalms: "79, 82" },
  30 => { first: "Zech 10", second: "Matt 21:23-end", psalms: "78:19-40" }
}

seed_month("september", 30, sep_mp, sep_ep, prayer_book.id)

# --- OCTOBER ---
oct_mp = {
  1 => { first: "1 Kings 15", first_abbr: "1 Kings 15:1-30", second: "Jas 5", psalms: "78:41-73" },
  2 => { first: "1 Kings 16", first_abbr: "1 Kings 16:1-4, 8-19, 23-34", second: "1 Pet 1:1-21", psalms: "81" },
  3 => { first: "1 Kings 17", second: "1 Pet 1:22-2:10", psalms: "84" },
  4 => { first: "1 Kings 18", first_abbr: "1 Kings 18:1-8, 17-46", second: "1 Pet 2:11-3:7", psalms: "86, 87" },
  5 => { first: "1 Kings 19", second: "1 Pet 3:8-4:6", psalms: "89:1-18" },
  6 => { first: "1 Kings 20", first_abbr: "1 Kings 20:1, 13, 21-43", second: "1 Pet 4:7-end", psalms: "90" },
  7 => { first: "1 Kings 21", second: "1 Pet 5", psalms: "92, 93" },
  8 => { first: "1 Kings 22", first_abbr: "1 Kings 22:1-23, 29-38", second: "2 Pet 1", psalms: "95, 96" },
  9 => { first: "2 Chron 20", second: "2 Pet 2", psalms: "99, 100, 101" },
  10 => { first: "2 Kings 1", second: "2 Pet 3", psalms: "103" },
  11 => { first: "2 Kings 2", second: "Jude", psalms: "105:1-22" },
  12 => { first: "2 Kings 3", second: "1 John 1:1-2:6", psalms: "106:1-18" },
  13 => { first: "2 Kings 4", first_abbr: "2 Kings 4:8-37", second: "1 John 2:7-end", psalms: "107:1-22" },
  14 => { first: "2 Kings 5", second: "1 John 3:1-10", psalms: "108, 110" },
  15 => { first: "2 Kings 6", first_abbr: "2 Kings 6:1-24", second: "1 John 3:11-4:6", psalms: "111, 112" },
  16 => { first: "2 Kings 7", second: "1 John 4:7-end", psalms: "115" },
  17 => { first: "2 Kings 8", first_abbr: "2 Kings 8:1-19, 25-27", second: "1 John 5", psalms: "119:1-24" },
  18 => { first: "2 John", second: "Luke 1:1-4", psalms: "119:49-72" },
  19 => { first: "2 Kings 9", first_abbr: "2 Kings 9:1-26, 30-37", second: "3 John", psalms: "119:89-104" },
  20 => { first: "2 Kings 10", first_abbr: "2 Kings 10:1-11, 18-31", second: "Acts 1:1-14", psalms: "119:129-152" },
  21 => { first: "2 Kings 11", second: "Acts 1:15-end", psalms: "118" },
  22 => { first: "2 Kings 12", second: "Acts 2:1-21", psalms: "122, 123" },
  23 => { first: "Acts 2:22-end", second: "James 1", psalms: "127, 128" },
  24 => { first: "2 Kings 13", second: "Acts 3:1-4:4", psalms: "132, 133" },
  25 => { first: "2 Kings 14", second: "Acts 4:5-31", psalms: "136" },
  26 => { first: "2 Chron 26", second: "Acts 4:32-5:11", psalms: "139" },
  27 => { first: "2 Kings 15", first_abbr: "2 Kings 15:1-29", second: "Acts 5:12-end", psalms: "140" },
  28 => { first: "Acts 6:1-7:16", second: "John 14:15-31", psalms: "144" },
  29 => { first: "2 Kings 16", second: "Acts 7:17-34", psalms: "146" },
  30 => { first: "2 Kings 17", first_abbr: "2 Kings 17:1-28, 41", second: "Acts 7:35-8:3", psalms: "148" },
  31 => { first: "2 Chron 28", second: "Acts 8:4-25", psalms: "2" }
}

oct_ep = {
  1 => { first: "Zech 11", second: "Matt 22:1-33", psalms: "80" },
  2 => { first: "Zech 12", second: "Matt 22:34-23:12", psalms: "83" },
  3 => { first: "Zech 13", second: "Matt 23:13-end", psalms: "85" },
  4 => { first: "Zech 14", second: "Matt 24:1-28", psalms: "88" },
  5 => { first: "Mal 1", second: "Matt 24:29-end", psalms: "89:19-51" },
  6 => { first: "Mal 2", second: "Matt 25:1-30", psalms: "91" },
  7 => { first: "Mal 3", second: "Matt 25:31-end", psalms: "94" },
  8 => { first: "Mal 4", second: "Matt 26:1-30", psalms: "97, 98" },
  9 => { first: "1 Macc 1", first_abbr: "1 Macc 1:1-15, 20-25, 41-64", second: "Matt 26:31-56", psalms: "102" },
  10 => { first: "1 Macc 2", first_abbr: "1 Macc 2:1-28", second: "Matt 26:57-end", psalms: "104" },
  11 => { first: "2 Macc 6", second: "Matt 27:1-26", psalms: "105:23-44" },
  12 => { first: "2 Macc 7", second: "Matt 27:27-56", psalms: "106:19-46" },
  13 => { first: "2 Macc 8", first_abbr: "2 Macc 8:1-29", second: "Matt 27:57-28 end", psalms: "107:23-43" },
  14 => { first: "2 Macc 10", first_abbr: "2 Macc 10:1-8, 24-38", second: "Mark 1:1-13", psalms: "109" },
  15 => { first: "1 Macc 7", first_abbr: "1 Macc 7:1-6, 23-50", second: "Mark 1:14-31", psalms: "113, 114" },
  16 => { first: "1 Macc 9", first_abbr: "1 Macc 9:1-31", second: "Mark 1:32-end", psalms: "116, 117" },
  17 => { first: "1 Macc 13", first_abbr: "1 Macc 13:1-30, 41-42", second: "Mark 2:1-22", psalms: "119:25-48" },
  18 => { first: "1 Macc 14", first_abbr: "1 Macc 14:4-18, 35-43", second: "Mark 2:23-3:12", psalms: "119:73-88" },
  19 => { first: "Isa 1", second: "Mark 3:13-end", psalms: "119:105-128" },
  20 => { first: "Isa 2", second: "Mark 4:1-34", psalms: "119:153-176" },
  21 => { first: "Isa 3", second: "Mark 4:35-5:20", psalms: "120, 121" },
  22 => { first: "Isa 4", second: "Mark 5:21-end", psalms: "124, 125, 126" },
  23 => { first: "Isa 5", second: "Mark 6:1-29", psalms: "129, 130, 131" },
  24 => { first: "Isa 6", second: "Mark 6:30-end", psalms: "134, 135" },
  25 => { first: "Isa 7", second: "Mark 7:1-23", psalms: "137, 138" },
  26 => { first: "Isa 8", second: "Mark 7:24-8:10", psalms: "141, 142" },
  27 => { first: "Isa 9", second: "Mark 8:11-end", psalms: "143" },
  28 => { first: "Isa 10", second: "Mark 9:1-29", psalms: "145" },
  29 => { first: "Isa 11", second: "Mark 9:30-end", psalms: "147" },
  30 => { first: "Isa 12", second: "Mark 10:1-31", psalms: "149, 150" },
  31 => { first: "Isa 13", second: "Mark 10:32-end", psalms: "3, 4" }
}

seed_month("october", 31, oct_mp, oct_ep, prayer_book.id)

# --- NOVEMBER ---
nov_mp = {
  1 => { first: "Heb 11:32-12:2", second: "Acts 8:26-end", psalms: "1, 15" },
  2 => { first: "2 Chron 29", first_abbr: "2 Chron 29:1-11, 20-30, 35-36", second: "Acts 9:1-31", psalms: "5, 6" },
  3 => { first: "2 Chron 30", first_abbr: "2 Chron 30:1-22, 26-27", second: "Acts 9:32-end", psalms: "9" },
  4 => { first: "2 Kings 18", first_abbr: "2 Kings 18:1-13, 17-30, 35-37", second: "Acts 10:1-23", psalms: "8, 11" },
  5 => { first: "2 Kings 19", first_abbr: "2 Kings 19:1-20, 29-31, 35-37", second: "Acts 10:24-end", psalms: "12, 13, 14" },
  6 => { first: "2 Kings 20", second: "Acts 11:1-18", psalms: "18:1-20" },
  7 => { first: "2 Chron 33", second: "Acts 11:19-end", psalms: "19" },
  8 => { first: "2 Kings 21", second: "Acts 12:1-24", psalms: "22" },
  9 => { first: "2 Kings 22", second: "Acts 12:25-13:12", psalms: "25" },
  10 => { first: "2 Kings 23", first_abbr: "2 Kings 23:1-20, 26-30", second: "Acts 13:13-43", psalms: "26, 28" },
  11 => { first: "2 Kings 24", second: "Acts 13:44-14:7", psalms: "29, 30" },
  12 => { first: "2 Kings 25", first_abbr: "2 Kings 25:1-22, 25-30", second: "Acts 14:8-end", psalms: "34" },
  13 => { first: "Judith 4", second: "Acts 15:1-21", psalms: "32, 36" },
  14 => { first: "Judith 8", second: "Acts 15:22-35", psalms: "37:1-17" },
  15 => { first: "Judith 9", second: "Acts 15:36-16:5", psalms: "40" },
  16 => { first: "Judith 10", second: "Acts 16:6-end", psalms: "42, 43" },
  17 => { first: "Judith 11", second: "Acts 17:1-15", psalms: "45" },
  18 => { first: "Judith 12", second: "Acts 17:16-end", psalms: "47, 48" },
  19 => { first: "Judith 13", second: "Acts 18:1-23", psalms: "50" },
  20 => { first: "Judith 14", second: "Acts 18:24-19:7", psalms: "52, 53, 54" },
  21 => { first: "Judith 15", second: "Acts 19:8-20", psalms: "56, 57" },
  22 => { first: "Judith 16", second: "Acts 19:21-end", psalms: "59" },
  23 => { first: "Ecclesiasticus 1", second: "Acts 20:1-16", psalms: "61, 62" },
  24 => { first: "Ecclesiasticus 2", second: "Acts 20:17-end", psalms: "68:1-18" },
  25 => { first: "Ecclesiasticus 4", first_abbr: "Ecclesiasticus 4:1-19", second: "Acts 21:1-16", psalms: "69:1-18" },
  26 => { first: "Ecclesiasticus 6", first_abbr: "Ecclesiasticus 6:5-31", second: "Acts 21:17-36", psalms: "66" },
  27 => { first: "Ecclesiasticus 7", first_abbr: "Ecclesiasticus 7:1-21, 27-36", second: "Acts 21:37-22:22", psalms: "71" },
  28 => { first: "Ecclesiasticus 9", second: "Acts 22:23-23:11", psalms: "74" },
  29 => { first: "Ecclesiasticus 10", first_abbr: "Ecclesiasticus 10:1-24", second: "Acts 23:12-end", psalms: "75, 76" },
  30 => { first: "Ecclesiasticus 11", first_abbr: "Ecclesiasticus 11:1-9, 18-28", second: "John 1:35-42", psalms: "78:1-18" }
}

nov_ep = {
  1 => { first: "Isa 14", second: "Rev 19:1-16", psalms: "34" },
  2 => { first: "Isa 15", second: "Mark 11:1-26", psalms: "7" },
  3 => { first: "Isa 16", second: "Mark 11:27-12:12", psalms: "10" },
  4 => { first: "Isa 17", second: "Mark 12:13-34", psalms: "15, 16" },
  5 => { first: "Isa 18", second: "Mark 12:35-13:13", psalms: "17" },
  6 => { first: "Isa 19", second: "Mark 13:14-end", psalms: "18:21-52" },
  7 => { first: "Isa 20", second: "Mark 14:1-25", psalms: "20, 21" },
  8 => { first: "Isa 21", second: "Mark 14:26-52", psalms: "23, 24" },
  9 => { first: "Isa 22", second: "Mark 14:53-end", psalms: "27" },
  10 => { first: "Isa 23", second: "Mark 15", psalms: "31" },
  11 => { first: "Isa 24", second: "Mark 16", psalms: "33" },
  12 => { first: "Isa 25", second: "Luke 1:1-23", psalms: "35" },
  13 => { first: "Isa 26", second: "Luke 1:24-56", psalms: "38" },
  14 => { first: "Isa 27", second: "Luke 1:57-end", psalms: "37:18-41" },
  15 => { first: "Isa 28", second: "Luke 2:1-21", psalms: "39, 41" },
  16 => { first: "Isa 29", second: "Luke 2:22-end", psalms: "44" },
  17 => { first: "Isa 30", second: "Luke 3:1-22", psalms: "46" },
  18 => { first: "Isa 31", second: "Luke 3:23-end", psalms: "49" },
  19 => { first: "Isa 32", second: "Luke 4:1-30", psalms: "51" },
  20 => { first: "Isa 33", second: "Luke 4:31-end", psalms: "55" },
  21 => { first: "Isa 34", second: "Luke 5:1-16", psalms: "58, 60" },
  22 => { first: "Isa 35", second: "Luke 5:17-end", psalms: "63, 64" },
  23 => { first: "Isa 36", second: "Luke 6:1-19", psalms: "65, 67" },
  24 => { first: "Isa 37", second: "Luke 6:20-38", psalms: "68:19-36" },
  25 => { first: "Isa 38", second: "Luke 6:39-7:10", psalms: "69:19-37" },
  26 => { first: "Isa 39", second: "Luke 7:11-35", psalms: "70, 72" },
  27 => { first: "Isa 40", second: "Luke 7:36-end", psalms: "73" },
  28 => { first: "Isa 41", second: "Luke 8:1-21", psalms: "77" },
  29 => { first: "Isa 42", second: "Luke 8:22-end", psalms: "79, 82" },
  30 => { first: "Isa 43", second: "Luke 9:1-17", psalms: "78:19-40" }
}

seed_month("november", 30, nov_mp, nov_ep, prayer_book.id)

# --- DECEMBER ---
dec_mp = {
  1 => { first: "Ecclesiasticus 14", second: "Acts 24:1-23", psalms: "78:41-73" },
  2 => { first: "Ecclesiasticus 17", second: "Acts 24:24-25:12", psalms: "81" },
  3 => { first: "Ecclesiasticus 18", first_abbr: "Ecclesiasticus 18:1-26, 30-33", second: "Acts 25:13-end", psalms: "84" },
  4 => { first: "Ecclesiasticus 21", second: "Acts 26", psalms: "86, 87" },
  5 => { first: "Ecclesiasticus 34", second: "Acts 27", psalms: "89:1-18" },
  6 => { first: "Ecclesiasticus 38", first_abbr: "Ecclesiasticus 38:1-15, 24-34", second: "Acts 28:1-15", psalms: "90" },
  7 => { first: "Ecclesiasticus 39", first_abbr: "Ecclesiasticus 39:1-11, 16-35", second: "Acts 28:16-end", psalms: "92, 93" },
  8 => { first: "Ecclesiasticus 44", second: "Rev 1", psalms: "95, 96" },
  9 => { first: "Ecclesiasticus 45", second: "Rev 2:1-17", psalms: "99, 100, 101" },
  10 => { first: "Ecclesiasticus 46", second: "Rev 2:18-3:6", psalms: "103" },
  11 => { first: "Ecclesiasticus 47", second: "Rev 3:7-end", psalms: "105:1-22" },
  12 => { first: "Ecclesiasticus 48", second: "Rev 4", psalms: "106:1-18" },
  13 => { first: "Ecclesiasticus 49", second: "Rev 5", psalms: "107:1-22" },
  14 => { first: "Ecclesiasticus 50", second: "Rev 6", psalms: "108, 110" },
  15 => { first: "Ecclesiasticus 51", second: "Rev 7", psalms: "111, 112" },
  16 => { first: "Wisdom 1", second: "Rev 8", psalms: "115" },
  17 => { first: "Wisdom 2", second: "Rev 9", psalms: "119:1-24" },
  18 => { first: "Wisdom 3", second: "Rev 10", psalms: "119:49-72" },
  19 => { first: "Wisdom 4", second: "Rev 11", psalms: "119:89-104" },
  20 => { first: "Wisdom 5", second: "Rev 12", psalms: "119:129-152" },
  21 => { first: "Rev 13", second: "John 14:1-7", psalms: "118" },
  22 => { first: "Wisdom 6", second: "Rev 14", psalms: "122, 123" },
  23 => { first: "Wisdom 7", second: "Rev 15", psalms: "127, 128" },
  24 => { first: "Wisdom 8", second: "Rev 16", psalms: "132, 133" },
  25 => { first: "Isaiah 9:1-7", second: "Rev 17", psalms: "19 or 45" },
  26 => { first: "Acts 6:8-7:6, 17-41, 44-60", second: "Rev 18", psalms: "136" },
  27 => { first: "Rev 19", second: "John 21:9-25", psalms: "139" },
  28 => { first: "Jer 31:1-17", second: "Rev 20", psalms: "140" },
  29 => { first: "Wisdom 9", second: "Rev 21:1-14", psalms: "144" },
  30 => { first: "Wisdom 10", second: "Rev 21:15-22:5", psalms: "146" },
  31 => { first: "Wisdom 11", second: "Rev 22:6-end", psalms: "148" }
}

dec_ep = {
  1 => { first: "Isa 44", second: "Luke 9:18-50", psalms: "80" },
  2 => { first: "Isa 45", second: "Luke 9:51-end", psalms: "83" },
  3 => { first: "Isa 46", second: "Luke 10:1-24", psalms: "85" },
  4 => { first: "Isa 47", second: "Luke 10:25-end", psalms: "88" },
  5 => { first: "Isa 48", second: "Luke 11:1-28", psalms: "89:19-51" },
  6 => { first: "Isa 49", second: "Luke 11:29-end", psalms: "91" },
  7 => { first: "Isa 50", second: "Luke 12:1-34", psalms: "94" },
  8 => { first: "Isa 51", second: "Luke 12:35-53", psalms: "97, 98" },
  9 => { first: "Isa 52", second: "Luke 12:54-13:9", psalms: "102" },
  10 => { first: "Isa 53", second: "Luke 13:10-end", psalms: "104" },
  11 => { first: "Isa 54", second: "Luke 14:1-24", psalms: "105:23-44" },
  12 => { first: "Isa 55", second: "Luke 14:25-15:10", psalms: "106:19-46" },
  13 => { first: "Isa 56", second: "Luke 15:11-end", psalms: "107:23-43" },
  14 => { first: "Isa 57", second: "Luke 16", psalms: "109" },
  15 => { first: "Isa 58", second: "Luke 17:1-19", psalms: "113, 114" },
  16 => { first: "Isa 59", second: "Luke 17:20-end", psalms: "116, 117" },
  17 => { first: "Isa 60", second: "Luke 18:1-30", psalms: "119:25-48" },
  18 => { first: "Isa 61", second: "Luke 18:31-19:10", psalms: "119:73-88" },
  19 => { first: "Isa 62", second: "Luke 19:11-28", psalms: "119:105-128" },
  20 => { first: "Isa 63", second: "Luke 19:29-end", psalms: "119:153-176" },
  21 => { first: "Isa 64", second: "Luke 20:1-26", psalms: "120, 121" },
  22 => { first: "Isa 65", second: "Luke 20:27-21:4", psalms: "124, 125, 126" },
  23 => { first: "Isa 66", second: "Luke 21:5-end", psalms: "129, 130, 131" },
  24 => { first: "Song of Songs 1", second: "Luke 22:1-38", psalms: "134, 135" },
  25 => { first: "Song of Songs 2", second: "Luke 2:1-14", psalms: "85, 110" },
  26 => { first: "Song of Songs 3", second: "Luke 22:39-53", psalms: "137, 138" },
  27 => { first: "Song of Songs 4", second: "Luke 22:54-end", psalms: "141, 142" },
  28 => { first: "Song of Songs 5", second: "Luke 23:1-25", psalms: "143" },
  29 => { first: "Song of Songs 6", second: "Luke 23:26-49", psalms: "145" },
  30 => { first: "Song of Songs 7", second: "Luke 23:50-24:12", psalms: "147" },
  31 => { first: "Song of Songs 8", second: "Luke 24:13-end", psalms: "149, 150" }
}

seed_month("december", 31, dec_mp, dec_ep, prayer_book.id)

Rails.logger.info "✅ Daily Office readings (Full Year) loaded!"
