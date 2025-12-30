# ================================================================================
# DAILY OFFICE LECTIONARY - LOC 2019 (Full Year)
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Ofício Diário for LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

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
junho_mp = {
  1 => { first: "Deuteronômio 33", second: "Lucas 17:20-end", psalms: "78:1-18" },
  2 => { first: "Deuteronômio 34", second: "Lucas 18:1-30", psalms: "78:41-73" },
  3 => { first: "Josué 1", second: "Lucas 18:31-19:10", psalms: "81" },
  4 => { first: "Josué 2", second: "Lucas 19:11-28", psalms: "84" },
  5 => { first: "Josué 3", second: "Lucas 19:29-end", psalms: "86, 87" },
  6 => { first: "Josué 4", second: "Lucas 20:1-26", psalms: "89:1-18" },
  7 => { first: "Josué 5", second: "Lucas 20:27-21:4", psalms: "90" },
  8 => { first: "Josué 6", second: "Lucas 21:5-end", psalms: "92, 93" },
  9 => { first: "Josué 7", second: "Lucas 22:1-38", psalms: "95, 96" },
  10 => { first: "Josué 8", first_abbr: "Josué 8:1-22, 30-35", second: "Lucas 22:39-53", psalms: "99, 100, 101" },
  11 => { first: "Atos 4:32-37", second: "Lucas 22:54-end", psalms: "103" },
  12 => { first: "Josué 9", second: "Lucas 23:1-25", psalms: "105:1-22" },
  13 => { first: "Josué 10", first_abbr: "Josué 10:1-27, 40-43", second: "Lucas 23:26-49", psalms: "106:1-18" },
  14 => { first: "Josué 14", first_abbr: "Josué 14:5-15", second: "Lucas 23:50-24:12", psalms: "107:1-22" },
  15 => { first: "Josué 22", first_abbr: "Josué 22:7-31", second: "Lucas 24:13-end", psalms: "108, 110" },
  16 => { first: "Josué 23", second: "Gálatas 1", psalms: "111, 112" },
  17 => { first: "Josué 24", first_abbr: "Josué 24:1-31", second: "Gálatas 2", psalms: "115" },
  18 => { first: "Juízes 1", first_abbr: "Juízes 1:1-21", second: "Gálatas 3", psalms: "119:1-24" },
  19 => { first: "Juízes 2", first_abbr: "Juízes 2:6-23", second: "Gálatas 4", psalms: "119:49-72" },
  20 => { first: "Juízes 3", first_abbr: "Juízes 3:7-30", second: "Gálatas 5", psalms: "119:89-104" },
  21 => { first: "Juízes 4", second: "Gálatas 6", psalms: "119:129-152" },
  22 => { first: "Juízes 5", first_abbr: "Juízes 5:1-5, 19-31", second: "1 Tessalonicenses 1", psalms: "118" },
  23 => { first: "Juízes 6", first_abbr: "Juízes 6:1, 6, 11-24, 33-40", second: "1 Tessalonicenses 2:1-16", psalms: "122, 123" },
  24 => { first: "1 Tessalonicenses 2:17-3 end", second: "Mateus 14:1-13", psalms: "127, 128" },
  25 => { first: "Juízes 7", first_abbr: "Juízes 7:1-8, 16-25", second: "1 Tessalonicenses 4:1-12", psalms: "132, 133" },
  26 => { first: "Juízes 8", first_abbr: "Juízes 8:4-23, 28", second: "1 Tessalonicenses 4:13-5:11", psalms: "136" },
  27 => { first: "Juízes 9", first_abbr: "Juízes 9:1-6, 22-25, 43-56", second: "1 Tessalonicenses 5:12-end", psalms: "139" },
  28 => { first: "Juízes 10", first_abbr: "Juízes 10:6-18", second: "2 Tessalonicenses 1", psalms: "140" },
  29 => { first: "2 Tessalonicenses 2", second: "2 Pedro 3:14-end", psalms: "144" },
  30 => { first: "Juízes 11", first_abbr: "Juízes 11:1-11, 29-40", second: "2 Tessalonicenses 3", psalms: "146" }
}

junho_ep = {
  1 => { first: "Ezequiel 6", second: "Atos 8:4-25", psalms: "78:19-40" },
  2 => { first: "Ezequiel 7", second: "Atos 8:26-end", psalms: "80" },
  3 => { first: "Ezequiel 8", second: "Atos 9:1-31", psalms: "83" },
  4 => { first: "Ezequiel 9", second: "Atos 9:32-end", psalms: "85" },
  5 => { first: "Ezequiel 10", second: "Atos 10:1-23", psalms: "88" },
  6 => { first: "Ezequiel 11", second: "Atos 10:24-end", psalms: "89:19-51" },
  7 => { first: "Ezequiel 12", second: "Atos 11:1-18", psalms: "91" },
  8 => { first: "Ezequiel 13", second: "Atos 11:19-end", psalms: "94" },
  9 => { first: "Ezequiel 14", second: "Atos 12:1-24", psalms: "97, 98" },
  10 => { first: "Ezequiel 15", second: "Atos 12:25-13:12", psalms: "102" },
  11 => { first: "Ezequiel 16", first_abbr: "Ezequiel 16:1-15, 33-47, 59-63", second: "Atos 13:13-43", psalms: "104" },
  12 => { first: "Ezequiel 17", second: "Atos 13:44-14:7", psalms: "105:23-44" },
  13 => { first: "Ezequiel 18", second: "Atos 14:8-end", psalms: "106:19-46" },
  14 => { first: "Ezequiel 33", first_abbr: "Ezequiel 33:1-23, 30-33", second: "Atos 15:1-21", psalms: "107:23-43" },
  15 => { first: "Ezequiel 34", second: "Atos 15:22-35", psalms: "109" },
  16 => { first: "Ezequiel 35", second: "Atos 15:36-16:5", psalms: "113, 114" },
  17 => { first: "Ezequiel 36", first_abbr: "Ezequiel 36:16-37", second: "Atos 16:6-end", psalms: "116, 117" },
  18 => { first: "Ezequiel 37", second: "Atos 17:1-15", psalms: "119:25-48" },
  19 => { first: "Ezequiel 40", first_abbr: "Ezequiel 40:1-5, 17-19, 35-49", second: "Atos 17:16-end", psalms: "119:73-88" },
  20 => { first: "Ezequiel 43", second: "Atos 18:1-23", psalms: "119:105-128" },
  21 => { first: "Ezequiel 47", second: "Atos 18:24-19:7", psalms: "119:153-176" },
  22 => { first: "Daniel 1", second: "Atos 19:8-20", psalms: "120, 121" },
  23 => { first: "Daniel 2", first_abbr: "Daniel 2:1-14, 25-28, 31-45", second: "Atos 19:21-end", psalms: "124, 125, 126" },
  24 => { first: "Daniel 3", second: "Atos 20:1-16", psalms: "129, 130, 131" },
  25 => { first: "Daniel 4", first_abbr: "Daniel 4:1-9, 19-35", second: "Atos 20:17-end", psalms: "134, 135" },
  26 => { first: "Daniel 5", second: "Atos 21:1-16", psalms: "137, 138" },
  27 => { first: "Daniel 6", second: "Atos 21:17-36", psalms: "141, 142" },
  28 => { first: "Daniel 7", second: "Atos 21:37-22:22", psalms: "143" },
  29 => { first: "Daniel 8", second: "Atos 22:23-23:11", psalms: "145" },
  30 => { first: "Daniel 9", second: "Atos 23:12-end", psalms: "147" }
}

seed_month("junho", 30, junho_mp, junho_ep, prayer_book.id)

# --- JULY ---
julho_mp = {
  1 => { first: "Juízes 12", second: "1 Coríntios 1:1-25", psalms: "148" },
  2 => { first: "Juízes 13", second: "1 Coríntios 1:26-2:16", psalms: "1, 2" },
  3 => { first: "Juízes 14", second: "1 Coríntios 3", psalms: "5, 6" },
  4 => { first: "Juízes 15", second: "1 Coríntios 4:1-17", psalms: "9" },
  5 => { first: "Juízes 16", second: "1 Coríntios 4:18-5:13", psalms: "8, 11" },
  6 => { first: "Rute 1", second: "1 Coríntios 6", psalms: "12, 13, 14" },
  7 => { first: "Rute 2", second: "1 Coríntios 7", psalms: "18:1-20" },
  8 => { first: "Rute 3", second: "1 Coríntios 8", psalms: "19" },
  9 => { first: "Rute 4", second: "1 Coríntios 9", psalms: "22" },
  10 => { first: "1 Samuel 1", first_abbr: "1 Samuel 1:1-20", second: "1 Coríntios 10", psalms: "25" },
  11 => { first: "1 Samuel 2", first_abbr: "1 Samuel 2:1-21", second: "1 Coríntios 11", psalms: "26, 28" },
  12 => { first: "1 Samuel 3", second: "1 Coríntios 12", psalms: "29, 30" },
  13 => { first: "1 Samuel 4", second: "1 Coríntios 13", psalms: "34" },
  14 => { first: "1 Samuel 5", second: "1 Coríntios 14:1-19", psalms: "32, 36" },
  15 => { first: "1 Samuel 6", first_abbr: "1 Samuel 6:1-15", second: "1 Coríntios 14:20-40", psalms: "37:1-17" },
  16 => { first: "1 Samuel 7", second: "1 Coríntios 15:1-34", psalms: "40" },
  17 => { first: "1 Samuel 8", second: "1 Coríntios 15:35-end", psalms: "42, 43" },
  18 => { first: "1 Samuel 9", second: "1 Coríntios 16", psalms: "45" },
  19 => { first: "1 Samuel 10", second: "2 Coríntios 1:1-2:11", psalms: "47, 48" },
  20 => { first: "1 Samuel 11", second: "2 Coríntios 2:12-3:18", psalms: "50" },
  21 => { first: "1 Samuel 12", second: "2 Coríntios 4", psalms: "52, 53, 54" },
  22 => { first: "2 Coríntios 5", second: "Lucas 7:36-8:3", psalms: "56, 57" },
  23 => { first: "1 Samuel 13", second: "2 Coríntios 6", psalms: "59" },
  24 => { first: "1 Samuel 14", first_abbr: "1 Samuel 14:1-15, 20, 24-30", second: "2 Coríntios 7", psalms: "61, 62" },
  25 => { first: "2 Coríntios 8", second: "Marcos 1:14-20", psalms: "68:1-18" },
  26 => { first: "1 Samuel 15", second: "2 Coríntios 9", psalms: "69:1-18" },
  27 => { first: "1 Samuel 16", second: "2 Coríntios 10", psalms: "66" },
  28 => { first: "1 Samuel 17", first_abbr: "1 Samuel 17:1-11, 26-27, 31-51", second: "2 Coríntios 11", psalms: "71" },
  29 => { first: "1 Samuel 18", second: "2 Coríntios 12:1-13", psalms: "74" },
  30 => { first: "1 Samuel 19", second: "2 Coríntios 12:14-13 end", psalms: "75, 76" },
  31 => { first: "1 Samuel 20", first_abbr: "1 Samuel 20:1-7, 24-42", second: "Romanos 1", psalms: "78:1-18" }
}

julho_ep = {
  1 => { first: "Daniel 10", second: "Atos 24:1-23", psalms: "149, 150" },
  2 => { first: "Daniel 11", first_abbr: "Daniel 11:1-19", second: "Atos 24:24-25:12", psalms: "3, 4" },
  3 => { first: "Daniel 12", second: "Atos 25:13-end", psalms: "7" },
  4 => { first: "Susanna", second: "Atos 26", psalms: "10" },
  5 => { first: "Ester 1", second: "Atos 27", psalms: "15, 16" },
  6 => { first: "Ester 2", second: "Atos 28:1-15", psalms: "17" },
  7 => { first: "Ester 3", second: "Atos 28:16-end", psalms: "18:21-52" },
  8 => { first: "Ester 4", second: "Philemon", psalms: "20, 21" },
  9 => { first: "Ester 5", second: "1 Timóteo 1:1-17", psalms: "23, 24" },
  10 => { first: "Ester 6", second: "1 Timóteo 1:18-2 end", psalms: "27" },
  11 => { first: "Ester 7", second: "1 Timóteo 3", psalms: "31" },
  12 => { first: "Ester 8", second: "1 Timóteo 4", psalms: "33" },
  13 => { first: "Ester 9 & 10", second: "1 Timóteo 5", psalms: "35" },
  14 => { first: "Esdras 1", second: "1 Timóteo 6", psalms: "38" },
  15 => { first: "Esdras 3", second: "Tito 1", psalms: "37:18-41" },
  16 => { first: "Esdras 4", second: "Tito 2", psalms: "39, 41" },
  17 => { first: "Esdras 5", second: "Tito 3", psalms: "44" },
  18 => { first: "Esdras 6", second: "2 Timóteo 1", psalms: "46" },
  19 => { first: "Esdras 7", second: "2 Timóteo 2", psalms: "49" },
  20 => { first: "Esdras 8", first_abbr: "Esdras 8:21-36", second: "2 Timóteo 3", psalms: "51" },
  21 => { first: "Esdras 9", second: "2 Timóteo 4", psalms: "55" },
  22 => { first: "Esdras 10", first_abbr: "Esdras 10:1-16", second: "João 1:1-28", psalms: "58, 60" },
  23 => { first: "Neemias 1", second: "João 1:29-end", psalms: "63, 64" },
  24 => { first: "Neemias 2", second: "João 2", psalms: "65, 67" },
  25 => { first: "Neemias 3", first_abbr: "Neemias 3:1-15", second: "João 3:1-21", psalms: "68:19-36" },
  26 => { first: "Neemias 4", second: "João 3:22-end", psalms: "69:19-37" },
  27 => { first: "Neemias 5", second: "João 4:1-26", psalms: "70, 72" },
  28 => { first: "Neemias 6", second: "João 4:27-end", psalms: "73" },
  29 => { first: "Neemias 8", second: "João 5:1-24", psalms: "77" },
  30 => { first: "Neemias 9", first_abbr: "Neemias 9:1-15, 26-38", second: "João 5:25-end", psalms: "79, 82" },
  31 => { first: "Neemias 10", first_abbr: "Neemias 10:28-39", second: "João 6:1-21", psalms: "78:19-40" }
}

seed_month("julho", 31, julho_mp, julho_ep, prayer_book.id)

# --- AUGUST ---
aug_mp = {
  1 => { first: "1 Samuel 21", second: "Romanos 2", psalms: "78:41-73" },
  2 => { first: "1 Samuel 22", second: "Romanos 3", psalms: "81" },
  3 => { first: "1 Samuel 23", second: "Romanos 4", psalms: "84" },
  4 => { first: "1 Samuel 24", second: "Romanos 5", psalms: "86, 87" },
  5 => { first: "1 Samuel 25", first_abbr: "1 Samuel 25:1-19, 23-25, 32-42", second: "Romanos 6", psalms: "89:1-18" },
  6 => { first: "Romanos 7", second: "Marcos 9:2-10", psalms: "27" },
  7 => { first: "1 Samuel 26", second: "Romanos 8:1-17", psalms: "90" },
  8 => { first: "1 Samuel 27", second: "Romanos 8:18-end", psalms: "92, 93" },
  9 => { first: "1 Samuel 28", second: "Romanos 9", psalms: "95, 96" },
  10 => { first: "1 Samuel 29", second: "Romanos 10", psalms: "99, 100, 101" },
  11 => { first: "1 Samuel 30", first_abbr: "1 Samuel 30:1-25", second: "Romanos 11", psalms: "103" },
  12 => { first: "1 Samuel 31", second: "Romanos 12", psalms: "105:1-22" },
  13 => { first: "2 Samuel 1", second: "Romanos 13", psalms: "106:1-18" },
  14 => { first: "2 Samuel 2", first_abbr: "2 Samuel 2:1-17, 26-31", second: "Romanos 14", psalms: "107:1-22" },
  15 => { first: "2 Samuel 3", first_abbr: "2 Samuel 3:6-11, 17-39", second: "Lucas 1:26-38", psalms: "108, 110" },
  16 => { first: "2 Samuel 4", second: "Romanos 15", psalms: "111, 112" },
  17 => { first: "2 Samuel 5", second: "Romanos 16", psalms: "115" },
  18 => { first: "2 Samuel 6", second: "Filipenses 1:1-11", psalms: "119:1-24" },
  19 => { first: "2 Samuel 7", second: "Filipenses 1:12-end", psalms: "119:49-72" },
  20 => { first: "2 Samuel 8", second: "Filipenses 2:1-11", psalms: "119:89-104" },
  21 => { first: "2 Samuel 9", second: "Filipenses 2:12-end", psalms: "119:129-152" },
  22 => { first: "2 Samuel 10", second: "Filipenses 3", psalms: "118" },
  23 => { first: "2 Samuel 11", second: "Filipenses 4", psalms: "122, 123" },
  24 => { first: "Colossenses 1:1-20", second: "Lucas 6:12-16", psalms: "127, 128" },
  25 => { first: "2 Samuel 12", first_abbr: "2 Samuel 12:1-25", second: "Colossenses 1:21-2:7", psalms: "132, 133" },
  26 => { first: "2 Samuel 13", first_abbr: "2 Samuel 13:1-29, 38-39", second: "Colossenses 2:8-19", psalms: "136" },
  27 => { first: "2 Samuel 14", first_abbr: "2 Samuel 14:1-21, 28", second: "Colossenses 2:20-3:11", psalms: "139" },
  28 => { first: "2 Samuel 15", first_abbr: "2 Samuel 15:1-18, 23-25, 32-34", second: "Colossenses 3:12-end", psalms: "140" },
  29 => { first: "2 Samuel 16", second: "Colossenses 4", psalms: "144" },
  30 => { first: "2 Samuel 17", first_abbr: "2 Samuel 17:1-23", second: "Philemon", psalms: "146" },
  31 => { first: "2 Samuel 18", first_abbr: "2 Samuel 18:1-15, 19-33", second: "Efésios 1:1-14", psalms: "148" }
}

aug_ep = {
  1 => { first: "Neemias 12", first_abbr: "Neemias 12:27-47", second: "João 6:22-40", psalms: "80" },
  2 => { first: "Neemias 13", first_abbr: "Neemias 13:1-22, 30-31", second: "João 6:41-end", psalms: "83" },
  3 => { first: "Oséias 1", second: "João 7:1-24", psalms: "85" },
  4 => { first: "Oséias 2", second: "João 7:25-52", psalms: "88" },
  5 => { first: "Oséias 3", second: "João 7:53-8:30", psalms: "89:19-51" },
  6 => { first: "Oséias 4", second: "João 8:31-end", psalms: "80" },
  7 => { first: "Oséias 5", second: "João 9", psalms: "91" },
  8 => { first: "Oséias 6", second: "João 10:1-21", psalms: "94" },
  9 => { first: "Oséias 7", second: "João 10:22-end", psalms: "97, 98" },
  10 => { first: "Oséias 8", second: "João 11:1-44", psalms: "102" },
  11 => { first: "Oséias 9", second: "João 11:45-end", psalms: "104" },
  12 => { first: "Oséias 10", second: "João 12:1-19", psalms: "105:23-44" },
  13 => { first: "Oséias 11", second: "João 12:20-end", psalms: "106:19-46" },
  14 => { first: "Oséias 12", second: "João 13", psalms: "107:23-43" },
  15 => { first: "Oséias 13", second: "João 14:1-14", psalms: "109" },
  16 => { first: "Oséias 14", second: "João 14:15-end", psalms: "113, 114" },
  17 => { first: "Joel 1", second: "João 15:1-17", psalms: "116, 117" },
  18 => { first: "Joel 2", first_abbr: "Joel 2:1-17, 28-32", second: "João 15:18-end", psalms: "119:25-48" },
  19 => { first: "Joel 3", second: "João 16:1-15", psalms: "119:73-88" },
  20 => { first: "Amós 1", second: "João 16:16-end", psalms: "119:105-128" },
  21 => { first: "Amós 2", second: "João 17", psalms: "119:153-176" },
  22 => { first: "Amós 3", second: "João 18:1-27", psalms: "120, 121" },
  23 => { first: "Amós 4", second: "João 18:28-end", psalms: "124, 125, 126" },
  24 => { first: "Amós 5", second: "João 19:1-37", psalms: "129, 130, 131" },
  25 => { first: "Amós 6", second: "João 19:38-end", psalms: "134, 135" },
  26 => { first: "Amós 7", second: "João 20", psalms: "137, 138" },
  27 => { first: "Amós 8", second: "João 21", psalms: "141, 142" },
  28 => { first: "Amós 9", second: "Mateus 1:1-17", psalms: "143" },
  29 => { first: "Obadiah", second: "Mateus 1:18-end", psalms: "145" },
  30 => { first: "Jonas 1", second: "Mateus 2", psalms: "147" },
  31 => { first: "Jonas 2", second: "Mateus 3", psalms: "149, 150" }
}

seed_month("agosto", 31, aug_mp, aug_ep, prayer_book.id)

# --- SEPTEMBER ---
sep_mp = {
  1 => { first: "2 Samuel 19", first_abbr: "2 Samuel 19:1-30", second: "Efésios 1:15-end", psalms: "1, 2" },
  2 => { first: "2 Samuel 20", second: "Efésios 2:1-10", psalms: "5, 6" },
  3 => { first: "2 Samuel 21", second: "Efésios 2:11-end", psalms: "9" },
  4 => { first: "2 Samuel 22", first_abbr: "2 Samuel 22:1-7, 14-20, 32-51", second: "Efésios 3", psalms: "8, 11" },
  5 => { first: "2 Samuel 23", first_abbr: "2 Samuel 23:1-23", second: "Efésios 4:1-16", psalms: "12, 13, 14" },
  6 => { first: "2 Samuel 24", second: "Efésios 4:17-end", psalms: "18:1-20" },
  7 => { first: "1 Crônicas 22", second: "Efésios 5:1-17", psalms: "19" },
  8 => { first: "1 Reis 1", first_abbr: "1 Reis 1:1-18, 29-40", second: "Efésios 5:18-end", psalms: "22" },
  9 => { first: "1 Crônicas 28", second: "Efésios 6", psalms: "25" },
  10 => { first: "1 Reis 2", first_abbr: "1 Reis 2:1-25", second: "Hebreus 1", psalms: "26, 28" },
  11 => { first: "1 Reis 3", second: "Hebreus 2", psalms: "29, 30" },
  12 => { first: "1 Reis 4", first_abbr: "1 Reis 4:1-6, 20-34", second: "Hebreus 3", psalms: "34" },
  13 => { first: "1 Reis 5", second: "Hebreus 4:1-13", psalms: "32, 36" },
  14 => { first: "Hebreus 4:14-5:10", second: "João 12:23-33", psalms: "37:1-17" },
  15 => { first: "1 Reis 6", first_abbr: "1 Reis 6:1-7, 11-30, 37-38", second: "Hebreus 5:11-6 end", psalms: "40" },
  16 => { first: "1 Reis 7", first_abbr: "1 Reis 7:1-14, 40-44, 47-51", second: "Hebreus 7", psalms: "42, 43" },
  17 => { first: "1 Reis 8", first_abbr: "1 Reis 8:1-11, 22-30, 54-63", second: "Hebreus 8", psalms: "45" },
  18 => { first: "1 Reis 9", first_abbr: "1 Reis 9:1-9, 15-28", second: "Hebreus 9:1-14", psalms: "47, 48" },
  19 => { first: "1 Reis 10", first_abbr: "1 Reis 10:1-13, 23-29", second: "Hebreus 9:15-end", psalms: "50" },
  20 => { first: "1 Reis 11", first_abbr: "1 Reis 11:1-14, 23-33, 41-43", second: "Hebreus 10:1-18", psalms: "52, 53, 54" },
  21 => { first: "Hebreus 10:19-end", second: "Mateus 9:9-13", psalms: "56, 57" },
  22 => { first: "1 Reis 12", first_abbr: "1 Reis 12:1-20, 25-30", second: "Hebreus 11", psalms: "59" },
  23 => { first: "1 Reis 13", first_abbr: "1 Reis 13:1-25, 33-34", second: "Hebreus 12:1-17", psalms: "61, 62" },
  24 => { first: "1 Reis 14", second: "Hebreus 12:18-end", psalms: "68:1-18" },
  25 => { first: "2 Crônicas 12", second: "Hebreus 13", psalms: "69:1-18" },
  26 => { first: "2 Crônicas 13", second: "Tiago 1", psalms: "66" },
  27 => { first: "2 Crônicas 14", second: "Tiago 2:1-13", psalms: "71" },
  28 => { first: "2 Crônicas 15", second: "Tiago 2:14-end", psalms: "74" },
  29 => { first: "Apocalipse 12:7-12", second: "Tiago 3", psalms: "75, 76" },
  30 => { first: "2 Crônicas 16", second: "Tiago 4", psalms: "78:1-18" }
}

sep_ep = {
  1 => { first: "Jonas 3", second: "Mateus 4", psalms: "3, 4" },
  2 => { first: "Jonas 4", second: "Mateus 5:1-20", psalms: "7" },
  3 => { first: "Miquéias 1", second: "Mateus 5:21-48", psalms: "10" },
  4 => { first: "Miquéias 2", second: "Mateus 6:1-18", psalms: "15, 16" },
  5 => { first: "Miquéias 3", second: "Mateus 6:19-end", psalms: "17" },
  6 => { first: "Miquéias 4", second: "Mateus 7", psalms: "18:21-52" },
  7 => { first: "Miquéias 5", second: "Mateus 8:1-17", psalms: "20, 21" },
  8 => { first: "Miquéias 6", second: "Mateus 8:18-end", psalms: "23, 24" },
  9 => { first: "Miquéias 7", second: "Mateus 9:1-17", psalms: "27" },
  10 => { first: "Naum 1", second: "Mateus 9:18-34", psalms: "31" },
  11 => { first: "Naum 2", second: "Mateus 9:35-10:23", psalms: "33" },
  12 => { first: "Naum 3", second: "Mateus 10:24-end", psalms: "35" },
  13 => { first: "Habacuque 1", second: "Mateus 11", psalms: "38" },
  14 => { first: "Habacuque 2", second: "Mateus 12:1-21", psalms: "37:18-41" },
  15 => { first: "Habacuque 3", second: "Mateus 12:22-end", psalms: "39, 41" },
  16 => { first: "Sofonias 1", second: "Mateus 13:1-23", psalms: "44" },
  17 => { first: "Sofonias 2", second: "Mateus 13:24-43", psalms: "46" },
  18 => { first: "Sofonias 3", second: "Mateus 13:44-end", psalms: "49" },
  19 => { first: "Ageu 1", second: "Mateus 14", psalms: "51" },
  20 => { first: "Ageu 2", second: "Mateus 15:1-28", psalms: "55" },
  21 => { first: "Zacarias 1", second: "Mateus 15:29-16:12", psalms: "58, 60" },
  22 => { first: "Zacarias 2", second: "Mateus 16:13-end", psalms: "63, 64" },
  23 => { first: "Zacarias 3", second: "Mateus 17:1-23", psalms: "65, 67" },
  24 => { first: "Zacarias 4", second: "Mateus 17:24-18:14", psalms: "68:19-36" },
  25 => { first: "Zacarias 5", second: "Mateus 18:15-end", psalms: "69:19-37" },
  26 => { first: "Zacarias 6", second: "Mateus 19:1-15", psalms: "70, 72" },
  27 => { first: "Zacarias 7", second: "Mateus 19:16-20:16", psalms: "73" },
  28 => { first: "Zacarias 8", second: "Mateus 20:17-end", psalms: "77" },
  29 => { first: "Zacarias 9", second: "Mateus 21:1-22", psalms: "79, 82" },
  30 => { first: "Zacarias 10", second: "Mateus 21:23-end", psalms: "78:19-40" }
}

seed_month("setembro", 30, sep_mp, sep_ep, prayer_book.id)

# --- OCTOBER ---
oct_mp = {
  1 => { first: "1 Reis 15", first_abbr: "1 Reis 15:1-30", second: "Tiago 5", psalms: "78:41-73" },
  2 => { first: "1 Reis 16", first_abbr: "1 Reis 16:1-4, 8-19, 23-34", second: "1 Pedro 1:1-21", psalms: "81" },
  3 => { first: "1 Reis 17", second: "1 Pedro 1:22-2:10", psalms: "84" },
  4 => { first: "1 Reis 18", first_abbr: "1 Reis 18:1-8, 17-46", second: "1 Pedro 2:11-3:7", psalms: "86, 87" },
  5 => { first: "1 Reis 19", second: "1 Pedro 3:8-4:6", psalms: "89:1-18" },
  6 => { first: "1 Reis 20", first_abbr: "1 Reis 20:1, 13, 21-43", second: "1 Pedro 4:7-end", psalms: "90" },
  7 => { first: "1 Reis 21", second: "1 Pedro 5", psalms: "92, 93" },
  8 => { first: "1 Reis 22", first_abbr: "1 Reis 22:1-23, 29-38", second: "2 Pedro 1", psalms: "95, 96" },
  9 => { first: "2 Crônicas 20", second: "2 Pedro 2", psalms: "99, 100, 101" },
  10 => { first: "2 Reis 1", second: "2 Pedro 3", psalms: "103" },
  11 => { first: "2 Reis 2", second: "Jude", psalms: "105:1-22" },
  12 => { first: "2 Reis 3", second: "1 João 1:1-2:6", psalms: "106:1-18" },
  13 => { first: "2 Reis 4", first_abbr: "2 Reis 4:8-37", second: "1 João 2:7-end", psalms: "107:1-22" },
  14 => { first: "2 Reis 5", second: "1 João 3:1-10", psalms: "108, 110" },
  15 => { first: "2 Reis 6", first_abbr: "2 Reis 6:1-24", second: "1 João 3:11-4:6", psalms: "111, 112" },
  16 => { first: "2 Reis 7", second: "1 João 4:7-end", psalms: "115" },
  17 => { first: "2 Reis 8", first_abbr: "2 Reis 8:1-19, 25-27", second: "1 João 5", psalms: "119:1-24" },
  18 => { first: "2 John", second: "Lucas 1:1-4", psalms: "119:49-72" },
  19 => { first: "2 Reis 9", first_abbr: "2 Reis 9:1-26, 30-37", second: "3 John", psalms: "119:89-104" },
  20 => { first: "2 Reis 10", first_abbr: "2 Reis 10:1-11, 18-31", second: "Atos 1:1-14", psalms: "119:129-152" },
  21 => { first: "2 Reis 11", second: "Atos 1:15-end", psalms: "118" },
  22 => { first: "2 Reis 12", second: "Atos 2:1-21", psalms: "122, 123" },
  23 => { first: "Atos 2:22-end", second: "Tiago 1", psalms: "127, 128" },
  24 => { first: "2 Reis 13", second: "Atos 3:1-4:4", psalms: "132, 133" },
  25 => { first: "2 Reis 14", second: "Atos 4:5-31", psalms: "136" },
  26 => { first: "2 Crônicas 26", second: "Atos 4:32-5:11", psalms: "139" },
  27 => { first: "2 Reis 15", first_abbr: "2 Reis 15:1-29", second: "Atos 5:12-end", psalms: "140" },
  28 => { first: "Atos 6:1-7:16", second: "João 14:15-31", psalms: "144" },
  29 => { first: "2 Reis 16", second: "Atos 7:17-34", psalms: "146" },
  30 => { first: "2 Reis 17", first_abbr: "2 Reis 17:1-28, 41", second: "Atos 7:35-8:3", psalms: "148" },
  31 => { first: "2 Crônicas 28", second: "Atos 8:4-25", psalms: "2" }
}

oct_ep = {
  1 => { first: "Zacarias 11", second: "Mateus 22:1-33", psalms: "80" },
  2 => { first: "Zacarias 12", second: "Mateus 22:34-23:12", psalms: "83" },
  3 => { first: "Zacarias 13", second: "Mateus 23:13-end", psalms: "85" },
  4 => { first: "Zacarias 14", second: "Mateus 24:1-28", psalms: "88" },
  5 => { first: "Malaquias 1", second: "Mateus 24:29-end", psalms: "89:19-51" },
  6 => { first: "Malaquias 2", second: "Mateus 25:1-30", psalms: "91" },
  7 => { first: "Malaquias 3", second: "Mateus 25:31-end", psalms: "94" },
  8 => { first: "Malaquias 4", second: "Mateus 26:1-30", psalms: "97, 98" },
  9 => { first: "1 Macabeus 1", first_abbr: "1 Macabeus 1:1-15, 20-25, 41-64", second: "Mateus 26:31-56", psalms: "102" },
  10 => { first: "1 Macabeus 2", first_abbr: "1 Macabeus 2:1-28", second: "Mateus 26:57-end", psalms: "104" },
  11 => { first: "2 Macabeus 6", second: "Mateus 27:1-26", psalms: "105:23-44" },
  12 => { first: "2 Macabeus 7", second: "Mateus 27:27-56", psalms: "106:19-46" },
  13 => { first: "2 Macabeus 8", first_abbr: "2 Macabeus 8:1-29", second: "Mateus 27:57-28 end", psalms: "107:23-43" },
  14 => { first: "2 Macabeus 10", first_abbr: "2 Macabeus 10:1-8, 24-38", second: "Marcos 1:1-13", psalms: "109" },
  15 => { first: "1 Macabeus 7", first_abbr: "1 Macabeus 7:1-6, 23-50", second: "Marcos 1:14-31", psalms: "113, 114" },
  16 => { first: "1 Macabeus 9", first_abbr: "1 Macabeus 9:1-31", second: "Marcos 1:32-end", psalms: "116, 117" },
  17 => { first: "1 Macabeus 13", first_abbr: "1 Macabeus 13:1-30, 41-42", second: "Marcos 2:1-22", psalms: "119:25-48" },
  18 => { first: "1 Macabeus 14", first_abbr: "1 Macabeus 14:4-18, 35-43", second: "Marcos 2:23-3:12", psalms: "119:73-88" },
  19 => { first: "Isaías 1", second: "Marcos 3:13-end", psalms: "119:105-128" },
  20 => { first: "Isaías 2", second: "Marcos 4:1-34", psalms: "119:153-176" },
  21 => { first: "Isaías 3", second: "Marcos 4:35-5:20", psalms: "120, 121" },
  22 => { first: "Isaías 4", second: "Marcos 5:21-end", psalms: "124, 125, 126" },
  23 => { first: "Isaías 5", second: "Marcos 6:1-29", psalms: "129, 130, 131" },
  24 => { first: "Isaías 6", second: "Marcos 6:30-end", psalms: "134, 135" },
  25 => { first: "Isaías 7", second: "Marcos 7:1-23", psalms: "137, 138" },
  26 => { first: "Isaías 8", second: "Marcos 7:24-8:10", psalms: "141, 142" },
  27 => { first: "Isaías 9", second: "Marcos 8:11-end", psalms: "143" },
  28 => { first: "Isaías 10", second: "Marcos 9:1-29", psalms: "145" },
  29 => { first: "Isaías 11", second: "Marcos 9:30-end", psalms: "147" },
  30 => { first: "Isaías 12", second: "Marcos 10:1-31", psalms: "149, 150" },
  31 => { first: "Isaías 13", second: "Marcos 10:32-end", psalms: "3, 4" }
}

seed_month("outubro", 31, oct_mp, oct_ep, prayer_book.id)

# --- NOVEMBER ---
nov_mp = {
  1 => { first: "Hebreus 11:32-12:2", second: "Atos 8:26-end", psalms: "1, 15" },
  2 => { first: "2 Crônicas 29", first_abbr: "2 Crônicas 29:1-11, 20-30, 35-36", second: "Atos 9:1-31", psalms: "5, 6" },
  3 => { first: "2 Crônicas 30", first_abbr: "2 Crônicas 30:1-22, 26-27", second: "Atos 9:32-end", psalms: "9" },
  4 => { first: "2 Reis 18", first_abbr: "2 Reis 18:1-13, 17-30, 35-37", second: "Atos 10:1-23", psalms: "8, 11" },
  5 => { first: "2 Reis 19", first_abbr: "2 Reis 19:1-20, 29-31, 35-37", second: "Atos 10:24-end", psalms: "12, 13, 14" },
  6 => { first: "2 Reis 20", second: "Atos 11:1-18", psalms: "18:1-20" },
  7 => { first: "2 Crônicas 33", second: "Atos 11:19-end", psalms: "19" },
  8 => { first: "2 Reis 21", second: "Atos 12:1-24", psalms: "22" },
  9 => { first: "2 Reis 22", second: "Atos 12:25-13:12", psalms: "25" },
  10 => { first: "2 Reis 23", first_abbr: "2 Reis 23:1-20, 26-30", second: "Atos 13:13-43", psalms: "26, 28" },
  11 => { first: "2 Reis 24", second: "Atos 13:44-14:7", psalms: "29, 30" },
  12 => { first: "2 Reis 25", first_abbr: "2 Reis 25:1-22, 25-30", second: "Atos 14:8-end", psalms: "34" },
  13 => { first: "Judite 4", second: "Atos 15:1-21", psalms: "32, 36" },
  14 => { first: "Judite 8", second: "Atos 15:22-35", psalms: "37:1-17" },
  15 => { first: "Judite 9", second: "Atos 15:36-16:5", psalms: "40" },
  16 => { first: "Judite 10", second: "Atos 16:6-end", psalms: "42, 43" },
  17 => { first: "Judite 11", second: "Atos 17:1-15", psalms: "45" },
  18 => { first: "Judite 12", second: "Atos 17:16-end", psalms: "47, 48" },
  19 => { first: "Judite 13", second: "Atos 18:1-23", psalms: "50" },
  20 => { first: "Judite 14", second: "Atos 18:24-19:7", psalms: "52, 53, 54" },
  21 => { first: "Judite 15", second: "Atos 19:8-20", psalms: "56, 57" },
  22 => { first: "Judite 16", second: "Atos 19:21-end", psalms: "59" },
  23 => { first: "Eclesiástico 1", second: "Atos 20:1-16", psalms: "61, 62" },
  24 => { first: "Eclesiástico 2", second: "Atos 20:17-end", psalms: "68:1-18" },
  25 => { first: "Eclesiástico 4", first_abbr: "Eclesiástico 4:1-19", second: "Atos 21:1-16", psalms: "69:1-18" },
  26 => { first: "Eclesiástico 6", first_abbr: "Eclesiástico 6:5-31", second: "Atos 21:17-36", psalms: "66" },
  27 => { first: "Eclesiástico 7", first_abbr: "Eclesiástico 7:1-21, 27-36", second: "Atos 21:37-22:22", psalms: "71" },
  28 => { first: "Eclesiástico 9", second: "Atos 22:23-23:11", psalms: "74" },
  29 => { first: "Eclesiástico 10", first_abbr: "Eclesiástico 10:1-24", second: "Atos 23:12-end", psalms: "75, 76" },
  30 => { first: "Eclesiástico 11", first_abbr: "Eclesiástico 11:1-9, 18-28", second: "João 1:35-42", psalms: "78:1-18" }
}

nov_ep = {
  1 => { first: "Isaías 14", second: "Apocalipse 19:1-16", psalms: "34" },
  2 => { first: "Isaías 15", second: "Marcos 11:1-26", psalms: "7" },
  3 => { first: "Isaías 16", second: "Marcos 11:27-12:12", psalms: "10" },
  4 => { first: "Isaías 17", second: "Marcos 12:13-34", psalms: "15, 16" },
  5 => { first: "Isaías 18", second: "Marcos 12:35-13:13", psalms: "17" },
  6 => { first: "Isaías 19", second: "Marcos 13:14-end", psalms: "18:21-52" },
  7 => { first: "Isaías 20", second: "Marcos 14:1-25", psalms: "20, 21" },
  8 => { first: "Isaías 21", second: "Marcos 14:26-52", psalms: "23, 24" },
  9 => { first: "Isaías 22", second: "Marcos 14:53-end", psalms: "27" },
  10 => { first: "Isaías 23", second: "Marcos 15", psalms: "31" },
  11 => { first: "Isaías 24", second: "Marcos 16", psalms: "33" },
  12 => { first: "Isaías 25", second: "Lucas 1:1-23", psalms: "35" },
  13 => { first: "Isaías 26", second: "Lucas 1:24-56", psalms: "38" },
  14 => { first: "Isaías 27", second: "Lucas 1:57-end", psalms: "37:18-41" },
  15 => { first: "Isaías 28", second: "Lucas 2:1-21", psalms: "39, 41" },
  16 => { first: "Isaías 29", second: "Lucas 2:22-end", psalms: "44" },
  17 => { first: "Isaías 30", second: "Lucas 3:1-22", psalms: "46" },
  18 => { first: "Isaías 31", second: "Lucas 3:23-end", psalms: "49" },
  19 => { first: "Isaías 32", second: "Lucas 4:1-30", psalms: "51" },
  20 => { first: "Isaías 33", second: "Lucas 4:31-end", psalms: "55" },
  21 => { first: "Isaías 34", second: "Lucas 5:1-16", psalms: "58, 60" },
  22 => { first: "Isaías 35", second: "Lucas 5:17-end", psalms: "63, 64" },
  23 => { first: "Isaías 36", second: "Lucas 6:1-19", psalms: "65, 67" },
  24 => { first: "Isaías 37", second: "Lucas 6:20-38", psalms: "68:19-36" },
  25 => { first: "Isaías 38", second: "Lucas 6:39-7:10", psalms: "69:19-37" },
  26 => { first: "Isaías 39", second: "Lucas 7:11-35", psalms: "70, 72" },
  27 => { first: "Isaías 40", second: "Lucas 7:36-end", psalms: "73" },
  28 => { first: "Isaías 41", second: "Lucas 8:1-21", psalms: "77" },
  29 => { first: "Isaías 42", second: "Lucas 8:22-end", psalms: "79, 82" },
  30 => { first: "Isaías 43", second: "Lucas 9:1-17", psalms: "78:19-40" }
}

seed_month("novembro", 30, nov_mp, nov_ep, prayer_book.id)

# --- DECEMBER ---
dec_mp = {
  1 => { first: "Eclesiástico 14", second: "Atos 24:1-23", psalms: "78:41-73" },
  2 => { first: "Eclesiástico 17", second: "Atos 24:24-25:12", psalms: "81" },
  3 => { first: "Eclesiástico 18", first_abbr: "Eclesiástico 18:1-26, 30-33", second: "Atos 25:13-end", psalms: "84" },
  4 => { first: "Eclesiástico 21", second: "Atos 26", psalms: "86, 87" },
  5 => { first: "Eclesiástico 34", second: "Atos 27", psalms: "89:1-18" },
  6 => { first: "Eclesiástico 38", first_abbr: "Eclesiástico 38:1-15, 24-34", second: "Atos 28:1-15", psalms: "90" },
  7 => { first: "Eclesiástico 39", first_abbr: "Eclesiástico 39:1-11, 16-35", second: "Atos 28:16-end", psalms: "92, 93" },
  8 => { first: "Eclesiástico 44", second: "Apocalipse 1", psalms: "95, 96" },
  9 => { first: "Eclesiástico 45", second: "Apocalipse 2:1-17", psalms: "99, 100, 101" },
  10 => { first: "Eclesiástico 46", second: "Apocalipse 2:18-3:6", psalms: "103" },
  11 => { first: "Eclesiástico 47", second: "Apocalipse 3:7-end", psalms: "105:1-22" },
  12 => { first: "Eclesiástico 48", second: "Apocalipse 4", psalms: "106:1-18" },
  13 => { first: "Eclesiástico 49", second: "Apocalipse 5", psalms: "107:1-22" },
  14 => { first: "Eclesiástico 50", second: "Apocalipse 6", psalms: "108, 110" },
  15 => { first: "Eclesiástico 51", second: "Apocalipse 7", psalms: "111, 112" },
  16 => { first: "Sabedoria 1", second: "Apocalipse 8", psalms: "115" },
  17 => { first: "Sabedoria 2", second: "Apocalipse 9", psalms: "119:1-24" },
  18 => { first: "Sabedoria 3", second: "Apocalipse 10", psalms: "119:49-72" },
  19 => { first: "Sabedoria 4", second: "Apocalipse 11", psalms: "119:89-104" },
  20 => { first: "Sabedoria 5", second: "Apocalipse 12", psalms: "119:129-152" },
  21 => { first: "Apocalipse 13", second: "João 14:1-7", psalms: "118" },
  22 => { first: "Sabedoria 6", second: "Apocalipse 14", psalms: "122, 123" },
  23 => { first: "Sabedoria 7", second: "Apocalipse 15", psalms: "127, 128" },
  24 => { first: "Sabedoria 8", second: "Apocalipse 16", psalms: "132, 133" },
  25 => { first: "Isaías 9:1-7", second: "Apocalipse 17", psalms: "19 ou 45" },
  26 => { first: "Atos 6:8-7:6, 17-41, 44-60", second: "Apocalipse 18", psalms: "136" },
  27 => { first: "Apocalipse 19", second: "João 21:9-25", psalms: "139" },
  28 => { first: "Jeremias 31:1-17", second: "Apocalipse 20", psalms: "140" },
  29 => { first: "Sabedoria 9", second: "Apocalipse 21:1-14", psalms: "144" },
  30 => { first: "Sabedoria 10", second: "Apocalipse 21:15-22:5", psalms: "146" },
  31 => { first: "Sabedoria 11", second: "Apocalipse 22:6-end", psalms: "148" }
}

dec_ep = {
  1 => { first: "Isaías 44", second: "Lucas 9:18-50", psalms: "80" },
  2 => { first: "Isaías 45", second: "Lucas 9:51-end", psalms: "83" },
  3 => { first: "Isaías 46", second: "Lucas 10:1-24", psalms: "85" },
  4 => { first: "Isaías 47", second: "Lucas 10:25-end", psalms: "88" },
  5 => { first: "Isaías 48", second: "Lucas 11:1-28", psalms: "89:19-51" },
  6 => { first: "Isaías 49", second: "Lucas 11:29-end", psalms: "91" },
  7 => { first: "Isaías 50", second: "Lucas 12:1-34", psalms: "94" },
  8 => { first: "Isaías 51", second: "Lucas 12:35-53", psalms: "97, 98" },
  9 => { first: "Isaías 52", second: "Lucas 12:54-13:9", psalms: "102" },
  10 => { first: "Isaías 53", second: "Lucas 13:10-end", psalms: "104" },
  11 => { first: "Isaías 54", second: "Lucas 14:1-24", psalms: "105:23-44" },
  12 => { first: "Isaías 55", second: "Lucas 14:25-15:10", psalms: "106:19-46" },
  13 => { first: "Isaías 56", second: "Lucas 15:11-end", psalms: "107:23-43" },
  14 => { first: "Isaías 57", second: "Lucas 16", psalms: "109" },
  15 => { first: "Isaías 58", second: "Lucas 17:1-19", psalms: "113, 114" },
  16 => { first: "Isaías 59", second: "Lucas 17:20-end", psalms: "116, 117" },
  17 => { first: "Isaías 60", second: "Lucas 18:1-30", psalms: "119:25-48" },
  18 => { first: "Isaías 61", second: "Lucas 18:31-19:10", psalms: "119:73-88" },
  19 => { first: "Isaías 62", second: "Lucas 19:11-28", psalms: "119:105-128" },
  20 => { first: "Isaías 63", second: "Lucas 19:29-end", psalms: "119:153-176" },
  21 => { first: "Isaías 64", second: "Lucas 20:1-26", psalms: "120, 121" },
  22 => { first: "Isaías 65", second: "Lucas 20:27-21:4", psalms: "124, 125, 126" },
  23 => { first: "Isaías 66", second: "Lucas 21:5-end", psalms: "129, 130, 131" },
  24 => { first: "Cântico dos Cânticos 1", second: "Lucas 22:1-38", psalms: "134, 135" },
  25 => { first: "Cântico dos Cânticos 2", second: "Lucas 2:1-14", psalms: "85, 110" },
  26 => { first: "Cântico dos Cânticos 3", second: "Lucas 22:39-53", psalms: "137, 138" },
  27 => { first: "Cântico dos Cânticos 4", second: "Lucas 22:54-end", psalms: "141, 142" },
  28 => { first: "Cântico dos Cânticos 5", second: "Lucas 23:1-25", psalms: "143" },
  29 => { first: "Cântico dos Cânticos 6", second: "Lucas 23:26-49", psalms: "145" },
  30 => { first: "Cântico dos Cânticos 7", second: "Lucas 23:50-24:12", psalms: "147" },
  31 => { first: "Cântico dos Cânticos 8", second: "Lucas 24:13-end", psalms: "149, 150" }
}

seed_month("dezembro", 31, dec_mp, dec_ep, prayer_book.id)

Rails.logger.info "✅ Daily Office readings (Full Year) loaded!"
