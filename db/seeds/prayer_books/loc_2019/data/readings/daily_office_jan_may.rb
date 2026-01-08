# ================================================================================
# DAILY OFFICE LECTIONARY (JAN-MAY) - LOC 2019 (Portuguese)
# ================================================================================

Rails.logger.info "📖 Carregando leituras do Ofício Diário (Jan-Mai) para LOC 2019..."

prayer_book = PrayerBook.find_by!(code: 'loc_2019')

# Translation map
TRANSLATIONS = {
  "Gen" => "Gênesis", "Exod" => "Êxodo", "Lev" => "Levítico", "Num" => "Números", "Deut" => "Deuteronômio",
  "Josh" => "Josué", "Judg" => "Juízes", "Ruth" => "Rute",
  "1 Sam" => "1 Samuel", "2 Sam" => "2 Samuel", "1 Kings" => "1 Reis", "2 Kings" => "2 Reis",
  "1 Chron" => "1 Crônicas", "2 Chron" => "2 Crônicas", "Ezra" => "Esdras", "Neh" => "Neemias", "Esth" => "Ester",
  "Job" => "Jó", "Ps" => "Salmo", "Prov" => "Provérbios", "Eccl" => "Eclesiastes", "Song of Songs" => "Cântico dos Cânticos",
  "Isa" => "Isaías", "Jer" => "Jeremias", "Lam" => "Lamentações", "Ezek" => "Ezequiel", "Dan" => "Daniel",
  "Hos" => "Oséias", "Joel" => "Joel", "Amos" => "Amós", "Obad" => "Obadias", "Jonah" => "Jonas", "Mic" => "Miquéias",
  "Nahum" => "Naum", "Hab" => "Habacuque", "Zeph" => "Sofonias", "Hag" => "Ageu", "Zech" => "Zacarias", "Mal" => "Malaquias",
  "Matt" => "Mateus", "Mark" => "Marcos", "Luke" => "Lucas", "John" => "João", "Acts" => "Atos",
  "Rom" => "Romanos", "1 Cor" => "1 Coríntios", "2 Cor" => "2 Coríntios", "Gal" => "Gálatas", "Eph" => "Efésios",
  "Phil" => "Filipenses", "Col" => "Colossenses", "1 Thess" => "1 Tessalonicenses", "2 Thess" => "2 Tessalonicenses",
  "1 Tim" => "1 Timóteo", "2 Tim" => "2 Timóteo", "Titus" => "Tito", "Philemon" => "Filemom", "Heb" => "Hebreus",
  "Jas" => "Tiago", "1 Pet" => "1 Pedro", "2 Pet" => "2 Pedro", "1 John" => "1 João", "2 John" => "2 João", "3 John" => "3 João",
  "Jude" => "Judas", "Rev" => "Apocalipse",
  "Ecclesiasticus" => "Eclesiástico", "Wisdom" => "Sabedoria", "Tobit" => "Tobias", "Judith" => "Judite",
  "Baruch" => "Baruque", "1 Macc" => "1 Macabeus", "2 Macc" => "2 Macabeus", "Susanna" => "Susana",
  "Song" => "Cântico dos Cânticos" # Alias
}

def translate_ref(ref)
  return nil if ref.nil?
  ref.gsub(/\b(Gen|Exod|Lev|Num|Deut|Josh|Judg|Ruth|1 Sam|2 Sam|1 Kings|2 Kings|1 Chron|2 Chron|Ezra|Neh|Esth|Job|Ps|Prov|Eccl|Song of Songs|Song|Isa|Jer|Lam|Ezek|Dan|Hos|Joel|Amos|Obad|Jonah|Mic|Nahum|Hab|Zeph|Hag|Zech|Mal|Matt|Mark|Luke|John|Acts|Rom|1 Cor|2 Cor|Gal|Eph|Phil|Col|1 Thess|2 Thess|1 Tim|2 Tim|Titus|Philemon|Heb|Jas|1 Pet|2 Pet|1 John|2 John|3 John|Jude|Rev|Ecclesiasticus|Wisdom|Tobit|Judith|Baruch|1 Macc|2 Macc|Susanna)\b/) { |match| TRANSLATIONS[match] || match }
end

def create_daily_reading(attrs, prayer_book_id)
  attrs[:prayer_book_id] = prayer_book_id
  attrs[:cycle] = "all"
  
  # Translate readings
  attrs[:first_reading] = translate_ref(attrs[:first_reading])
  attrs[:first_reading_abbreviated] = translate_ref(attrs[:first_reading_abbreviated])
  attrs[:second_reading] = translate_ref(attrs[:second_reading])
  attrs[:psalm] = translate_ref(attrs[:psalm])&.gsub("Ps", "Salmo") # Ensure Psalm prefix is translated if missed or explicit

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

# --- DATA ---

jan_mp = {
  1 => { first: "Gen 1", second: "John 1:1-28", psalms: "1, 2" },
  2 => { first: "Gen 2", second: "John 1:29-end", psalms: "5, 6" },
  3 => { first: "Gen 3", second: "John 2", psalms: "9" },
  4 => { first: "Gen 4", second: "John 3:1-21", psalms: "8, 11" },
  5 => { first: "Gen 5", second: "John 3:22-end", psalms: "12, 13, 14" },
  6 => { first: "Gen 6", second: "Matt 2:1-12", psalms: "96, 97" },
  7 => { first: "Gen 7", second: "John 4:1-26", psalms: "18:1-20" },
  8 => { first: "Gen 8", second: "John 4:27-end", psalms: "19" },
  9 => { first: "Gen 9", second: "John 5:1-24", psalms: "22" },
  10 => { first: "Gen 10", first_abbr: "Gen 10:1-9, 15-22, 30-32", second: "John 5:25-end", psalms: "25" },
  11 => { first: "Gen 11", first_abbr: "Gen 11:1-9, 27-32", second: "John 6:1-21", psalms: "26, 28" },
  12 => { first: "Gen 12", second: "John 6:22-40", psalms: "29, 30" },
  13 => { first: "Gen 13", second: "John 6:41-end", psalms: "34" },
  14 => { first: "Gen 14", second: "John 7:1-24", psalms: "32, 36" },
  15 => { first: "Gen 15", second: "John 7:25-52", psalms: "37:1-17" },
  16 => { first: "Gen 16", second: "John 7:53-8:30", psalms: "40" },
  17 => { first: "Gen 17", second: "John 8:31-end", psalms: "42, 43" },
  18 => { first: "Gen 18", second: "Matt 16:13-20", psalms: "45" },
  19 => { first: "Gen 19", first_abbr: "Gen 19:1-29", second: "John 9", psalms: "47, 48" },
  20 => { first: "Gen 20", second: "John 10:1-21", psalms: "50" },
  21 => { first: "Gen 21", first_abbr: "Gen 21:1-21", second: "John 10:22-end", psalms: "52, 53, 54" },
  22 => { first: "Gen 22", second: "John 11:1-44", psalms: "56, 57" },
  23 => { first: "Gen 23", second: "John 11:45-end", psalms: "59" },
  24 => { first: "Gen 24", first_abbr: "Gen 24:1-28, 53-58", second: "John 12:1-19", psalms: "61, 62" },
  25 => { first: "Acts 9:1-22", second: "John 12:20-end", psalms: "68:1-18" },
  26 => { first: "Gen 25", first_abbr: "Gen 25:7-11, 19-34", second: "John 13", psalms: "69:1-18" },
  27 => { first: "Gen 26", first_abbr: "Gen 26:1-25", second: "John 14:1-14", psalms: "66" },
  28 => { first: "Gen 27", first_abbr: "Gen 27:1-13, 18-36, 39-40", second: "John 14:15-end", psalms: "71" },
  29 => { first: "Gen 28", second: "John 15:1-17", psalms: "74" },
  30 => { first: "Gen 29", first_abbr: "Gen 29:1-28", second: "John 15:18-end", psalms: "75, 76" },
  31 => { first: "Gen 30", first_abbr: "Gen 30:1-2, 22-43", second: "John 16:1-15", psalms: "78:1-18" }
}

jan_ep = {
  1 => { first: "Gal 1", second: "Luke 2:8-21", psalms: "3, 4" },
  2 => { first: "Jer 1", second: "Gal 2", psalms: "7" },
  3 => { first: "Jer 2", first_abbr: "Jer 2:1-22", second: "Gal 3", psalms: "10" },
  4 => { first: "Jer 3", second: "Gal 4", psalms: "15, 16" },
  5 => { first: "Jer 4", second: "Gal 5", psalms: "17" },
  6 => { first: "Jer 5", second: "John 2:1-12", psalms: "67, 72" },
  7 => { first: "Jer 6", second: "Gal 6", psalms: "18:21-52" },
  8 => { first: "Jer 7", first_abbr: "Jer 7:1-28, 34", second: "1 Thess 1", psalms: "20, 21" },
  9 => { first: "Jer 8", second: "1 Thess 2:1-16", psalms: "23, 24" },
  10 => { first: "Jer 9", second: "1 Thess 2:17-3 end", psalms: "27" },
  11 => { first: "Jer 10", second: "1 Thess 4:1-12", psalms: "31" },
  12 => { first: "Jer 11", second: "1 Thess 4:13-5:11", psalms: "33" },
  13 => { first: "Jer 12", second: "1 Thess 5:12-end", psalms: "35" },
  14 => { first: "Jer 13", second: "2 Thess 1", psalms: "38" },
  15 => { first: "Jer 14", second: "2 Thess 2", psalms: "37:18-41" },
  16 => { first: "Jer 15", second: "2 Thess 3", psalms: "39, 41" },
  17 => { first: "Jer 16", second: "1 Cor 1:1-25", psalms: "44" },
  18 => { first: "Jer 17", second: "1 Cor 1:26-2 end", psalms: "46" },
  19 => { first: "Jer 18", second: "1 Cor 3", psalms: "49" },
  20 => { first: "Jer 19", second: "1 Cor 4:1-17", psalms: "51" },
  21 => { first: "Jer 20", second: "1 Cor 4:18-5 end", psalms: "55" },
  22 => { first: "Jer 21", second: "1 Cor 6", psalms: "58, 60" },
  23 => { first: "Jer 22", second: "1 Cor 7", psalms: "63, 64" },
  24 => { first: "Jer 23", first_abbr: "Jer 23:1-9, 16-18, 21-40", second: "1 Cor 8", psalms: "65, 67" },
  25 => { first: "Jer 24", second: "1 Cor 9", psalms: "68:19-36" },
  26 => { first: "Jer 25", first_abbr: "Jer 25:1-19, 26-31", second: "1 Cor 10", psalms: "69:19-37" },
  27 => { first: "Jer 26", second: "1 Cor 11", psalms: "70, 72" },
  28 => { first: "Jer 27", second: "1 Cor 12", psalms: "73" },
  29 => { first: "Jer 28", second: "1 Cor 13", psalms: "77" },
  30 => { first: "Jer 29", first_abbr: "Jer 29:1-14, 24-32", second: "1 Cor 14:1-19", psalms: "79, 82" },
  31 => { first: "Jer 30", second: "1 Cor 14:20-end", psalms: "78:19-40" }
}

feb_mp = {
  1 => { first: "Gen 31", first_abbr: "Gen 31:1-3, 17-45", second: "John 16:16-end", psalms: "78:41-73" },
  2 => { first: "Gen 32", first_abbr: "Gen 32:1-13, 21-32", second: "Luke 2:22-40", psalms: "24, 81" },
  3 => { first: "Gen 33", second: "John 17", psalms: "83" },
  4 => { first: "Gen 34", second: "John 18:1-27", psalms: "86, 87" },
  5 => { first: "Gen 35", second: "John 18:28-end", psalms: "89:1-18" },
  6 => { first: "Gen 36", first_abbr: "Gen 36:1-8", second: "John 19:1-37", psalms: "90" },
  7 => { first: "Gen 37", first_abbr: "Gen 37:3-8, 12-36", second: "John 19:38-end", psalms: "92, 93" },
  8 => { first: "Gen 38", first_abbr: "Gen 38:1-26", second: "John 20", psalms: "95, 96" },
  9 => { first: "Gen 39", second: "John 21", psalms: "99, 100, 101" },
  10 => { first: "Gen 40", second: "Matt 1:1-17", psalms: "103" },
  11 => { first: "Gen 41", first_abbr: "Gen 41:1-15, 25-40", second: "Matt 1:18-end", psalms: "105:1-22" },
  12 => { first: "Gen 42", first_abbr: "Gen 42:1-28", second: "Matt 2", psalms: "106:1-18" },
  13 => { first: "Gen 43", first_abbr: "Gen 43:1-10, 15-34", second: "Matt 3", psalms: "107:1-22" },
  14 => { first: "Gen 44", first_abbr: "Gen 44:1-20, 30-34", second: "Matt 4", psalms: "108, 110" },
  15 => { first: "Gen 45", second: "Matt 5:1-20", psalms: "111, 112" },
  16 => { first: "Gen 46", first_abbr: "Gen 46:1-7, 28-34", second: "Matt 5:21-48", psalms: "115" },
  17 => { first: "Gen 47", first_abbr: "Gen 47:1-15, 23-31", second: "Matt 6:1-18", psalms: "119:1-24" },
  18 => { first: "Gen 48", second: "Matt 6:19-end", psalms: "119:49-72" },
  19 => { first: "Gen 49", second: "Matt 7", psalms: "119:89-104" },
  20 => { first: "Gen 50", second: "Matt 8:1-17", psalms: "119:129-152" },
  21 => { first: "Exod 1", second: "Matt 8:18-end", psalms: "118" },
  22 => { first: "Exod 2", second: "Matt 9:1-17", psalms: "122, 123" },
  23 => { first: "Exod 3", second: "Matt 9:18-34", psalms: "127, 128" },
  24 => { first: "Acts 1:15-26", second: "Matt 9:35-10:23", psalms: "132, 133" },
  25 => { first: "Exod 4", second: "Matt 10:24-end", psalms: "136" },
  26 => { first: "Exod 5", second: "Matt 11", psalms: "139" },
  27 => { first: "Exod 6", first_abbr: "Exod 6:1-13", second: "Matt 12:1-21", psalms: "140" },
  28 => { first: "Exod 7", second: "Matt 12:22-end", psalms: "144" },
  29 => { first: "2 Kings 2", second: "Luke 24:44-53", psalms: "90" }
}

feb_ep = {
  1 => { first: "Jer 31", first_abbr: "Jer 31:1-17, 27-37", second: "1 Cor 15:1-34", psalms: "80" },
  2 => { first: "Jer 32", first_abbr: "Jer 32:1-15, 36-44", second: "1 Cor 15:35-end", psalms: "84" },
  3 => { first: "Jer 33", second: "1 Cor 16", psalms: "85" },
  4 => { first: "Jer 34", second: "2 Cor 1:1-2:11", psalms: "88" },
  5 => { first: "Jer 35", second: "2 Cor 2:12-3 end", psalms: "89:19-51" },
  6 => { first: "Jer 36", first_abbr: "Jer 36:1-10, 19-32", second: "2 Cor 4", psalms: "91" },
  7 => { first: "Jer 37", second: "2 Cor 5", psalms: "94" },
  8 => { first: "Jer 38", second: "2 Cor 6", psalms: "97, 98" },
  9 => { first: "Jer 39", second: "2 Cor 7", psalms: "102" },
  10 => { first: "Jer 40", second: "2 Cor 8", psalms: "104" },
  11 => { first: "Jer 41", second: "2 Cor 9", psalms: "105:23-44" },
  12 => { first: "Jer 42", second: "2 Cor 10", psalms: "106:19-46" },
  13 => { first: "Jer 43", second: "2 Cor 11", psalms: "107:23-43" },
  14 => { first: "Jer 44", first_abbr: "Jer 44:1-19, 24-30", second: "2 Cor 12:1-13", psalms: "109" },
  15 => { first: "Jer 45", second: "2 Cor 12:14-13 end", psalms: "113, 114" },
  16 => { first: "Jer 46", second: "Rom 1", psalms: "116, 117" },
  17 => { first: "Jer 47", second: "Rom 2", psalms: "119:25-48" },
  18 => { first: "Jer 48", first_abbr: "Jer 48:1-20, 40-47", second: "Rom 3", psalms: "119:73-88" },
  19 => { first: "Jer 49", first_abbr: "Jer 49:1-13, 23-39", second: "Rom 4", psalms: "119:105-128" },
  20 => { first: "Jer 50", first_abbr: "Jer 50:1-20, 33-40", second: "Rom 5", psalms: "119:153-176" },
  21 => { first: "Jer 51", first_abbr: "Jer 51:6-10, 45-64", second: "Rom 6", psalms: "120, 121" },
  22 => { first: "Jer 52", first_abbr: "Jer 52:1-27, 31-34", second: "Rom 7", psalms: "124, 125, 126" },
  23 => { first: "Baruch 4", first_abbr: "Baruch 4:5-13, 21-37", second: "Rom 8:1-17", psalms: "129, 130, 131" },
  24 => { first: "Baruch 5", second: "Rom 8:18-end", psalms: "134, 135" },
  25 => { first: "Lam 1", first_abbr: "Lam 1:1-12, 17-22", second: "Rom 9", psalms: "137, 138" },
  26 => { first: "Lam 2", first_abbr: "Lam 2:1-18", second: "Rom 10", psalms: "141, 142" },
  27 => { first: "Lam 3", first_abbr: "Lam 3:1-9, 19-33, 52-66", second: "Rom 11", psalms: "143" },
  28 => { first: "Lam 4", second: "Rom 12", psalms: "145" },
  29 => { first: "Joel 2", first_abbr: "Joel 2:1-2, 12-32", second: "2 Pet 3", psalms: "104" }
}

mar_mp = {
  1 => { first: "Exod 8", second: "Matt 13:1-23", psalms: "146" },
  2 => { first: "Exod 9", first_abbr: "Exod 9:1-29, 33-34", second: "Matt 13:24-43", psalms: "148" },
  3 => { first: "Exod 10", second: "Matt 13:44-end", psalms: "1, 2" },
  4 => { first: "Exod 11", second: "Matt 14", psalms: "5, 6" },
  5 => { first: "Exod 12", first_abbr: "Exod 12:1-20, 28-36", second: "Matt 15:1-28", psalms: "9" },
  6 => { first: "Exod 13", second: "Matt 15:29-16:12", psalms: "8, 11" },
  7 => { first: "Exod 14", first_abbr: "Exod 14:5-31", second: "Matt 16:13-end", psalms: "12, 13, 14" },
  8 => { first: "Exod 15", second: "Matt 17:1-23", psalms: "18:1-20" },
  9 => { first: "Exod 16", first_abbr: "Exod 16:1-7, 11-33", second: "Matt 17:24-18:14", psalms: "19" },
  10 => { first: "Exod 17", second: "Matt 18:15-end", psalms: "22" },
  11 => { first: "Exod 18", second: "Matt 19:1-15", psalms: "25" },
  12 => { first: "Exod 19", second: "Matt 19:16-20:16", psalms: "26, 28" },
  13 => { first: "Exod 20", second: "Matt 20:17-end", psalms: "29, 30" },
  14 => { first: "Exod 21", first_abbr: "Exod 21:1-19, 22-29", second: "Matt 21:1-22", psalms: "34" },
  15 => { first: "Exod 22", second: "Matt 21:23-end", psalms: "32, 36" },
  16 => { first: "Exod 23", first_abbr: "Exod 23:1-13, 18-30", second: "Matt 22:1-33", psalms: "37:1-17" },
  17 => { first: "Exod 24", second: "Matt 22:34-23:12", psalms: "40" },
  18 => { first: "Exod 25", first_abbr: "Exod 25:1-23, 31-40", second: "Matt 23:13-end", psalms: "42, 43" },
  19 => { first: "Exod 26", first_abbr: "Exod 26:1-10, 15-16, 29-37", second: "Matt 24:1-28", psalms: "45" },
  20 => { first: "Exod 27", second: "Matt 24:29-end", psalms: "47, 48" },
  21 => { first: "Exod 28", first_abbr: "Exod 28:1-6, 15-21, 29-43", second: "Matt 25:1-30", psalms: "50" },
  22 => { first: "Exod 29", first_abbr: "Exod 29:1-18, 35-46", second: "Matt 25:31-end", psalms: "52, 53, 54" },
  23 => { first: "Exod 30", first_abbr: "Exod 30:1-3, 7-33", second: "Matt 26:1-30", psalms: "56, 57" },
  24 => { first: "Exod 31", second: "Matt 26:31-56", psalms: "59" },
  25 => { first: "Exod 32", first_abbr: "Exod 32:1-29", second: "Luke 1:26-38", psalms: "113, 138" },
  26 => { first: "Exod 33", second: "Matt 26:57-end", psalms: "61, 62" },
  27 => { first: "Exod 34", first_abbr: "Exod 34:1-17, 27-35", second: "Matt 27:1-26", psalms: "68:1-18" },
  28 => { first: "Exod 35", first_abbr: "Exod 35:1-10, 20-35", second: "Matt 27:27-56", psalms: "69:1-18" },
  29 => { first: "Exod 36", first_abbr: "Exod 36:1-10, 18-20, 31-38", second: "Matt 27:57-28 end", psalms: "66" },
  30 => { first: "Exod 37", first_abbr: "Exod 37:1-11, 16-29", second: "Mark 1:1-13", psalms: "71" },
  31 => { first: "Exod 38", first_abbr: "Exod 38:1-23", second: "Mark 1:14-31", psalms: "74" }
}

mar_ep = {
  1 => { first: "Lam 5", second: "Rom 13", psalms: "147" },
  2 => { first: "Prov 1", second: "Rom 14", psalms: "149, 150" },
  3 => { first: "Prov 2", second: "Rom 15", psalms: "3, 4" },
  4 => { first: "Prov 3", first_abbr: "Prov 3:1-27", second: "Rom 16", psalms: "7" },
  5 => { first: "Prov 4", second: "Phil 1:1-11", psalms: "10" },
  6 => { first: "Prov 5", second: "Phil 1:12-end", psalms: "15, 16" },
  7 => { first: "Prov 6", first_abbr: "Prov 6:1-11, 20-35", second: "Phil 2:1-11", psalms: "17" },
  8 => { first: "Prov 7", second: "Phil 2:12-end", psalms: "18:21-52" },
  9 => { first: "Prov 8", second: "Phil 3", psalms: "20, 21" },
  10 => { first: "Prov 9", second: "Phil 4", psalms: "23, 24" },
  11 => { first: "Prov 10", second: "Col 1:1-20", psalms: "27" },
  12 => { first: "Prov 11", second: "Col 1:21-2:7", psalms: "31" },
  13 => { first: "Prov 12", second: "Col 2:8-19", psalms: "33" },
  14 => { first: "Prov 13", second: "Col 2:20-3:11", psalms: "35" },
  15 => { first: "Prov 14", second: "Col 3:12-end", psalms: "38" },
  16 => { first: "Prov 15", second: "Col 4", psalms: "37:18-41" },
  17 => { first: "Prov 16", second: "Philemon", psalms: "39, 41" },
  18 => { first: "Prov 17", second: "Eph 1:1-14", psalms: "44" },
  19 => { first: "Eph 1:15-end", second: "Matt 1:18-end", psalms: "46" },
  20 => { first: "Prov 18", second: "Eph 2:1-10", psalms: "49" },
  21 => { first: "Prov 19", second: "Eph 2:11-end", psalms: "51" },
  22 => { first: "Prov 20", second: "Eph 3", psalms: "55" },
  23 => { first: "Prov 21", second: "Eph 4:1-16", psalms: "58, 60" },
  24 => { first: "Prov 22", second: "Eph 4:17-end", psalms: "63, 64" },
  25 => { first: "Prov 23", second: "Eph 5:1-17", psalms: "131, 132" },
  26 => { first: "Prov 24", first_abbr: "Prov 24:1-14, 23-34", second: "Eph 5:18-end", psalms: "65, 67" },
  27 => { first: "Prov 25", second: "Eph 6:1-9", psalms: "68:19-36" },
  28 => { first: "Prov 26", second: "Eph 6:10-end", psalms: "69:19-37" },
  29 => { first: "Prov 27", second: "1 Tim 1:1-17", psalms: "70, 72" },
  30 => { first: "Prov 28", second: "1 Tim 1:18-2 end", psalms: "73" },
  31 => { first: "Prov 29", second: "1 Tim 3", psalms: "77" }
}

apr_mp = {
  1 => { first: "Exod 39", first_abbr: "Exod 39:1-14, 27-43", second: "Mark 1:32-end", psalms: "75, 76" },
  2 => { first: "Exod 40", first_abbr: "Exod 40:1-2, 16-38", second: "Mark 2:1-22", psalms: "78:1-18" },
  3 => { first: "Lev 1", second: "Mark 2:23-3:12", psalms: "78:41-73" },
  4 => { first: "Lev 8", first_abbr: "Lev 8:1-24, 30-36", second: "Mark 3:13-end", psalms: "81" },
  5 => { first: "Lev 10", second: "Mark 4:1-34", psalms: "84" },
  6 => { first: "Lev 16", first_abbr: "Lev 16:1-22, 29-34", second: "Mark 4:35-5:20", psalms: "86, 87" },
  7 => { first: "Lev 17", second: "Mark 5:21-end", psalms: "89:1-18" },
  8 => { first: "Lev 18", second: "Mark 6:1-29", psalms: "90" },
  9 => { first: "Lev 19", first_abbr: "Lev 19:1-2, 9-37", second: "Mark 6:30-end", psalms: "92, 93" },
  10 => { first: "Lev 20", second: "Mark 7:1-23", psalms: "95, 96" },
  11 => { first: "Lev 23", first_abbr: "Lev 23:9-32, 39-43", second: "Mark 7:24-8:10", psalms: "99, 100, 101" },
  12 => { first: "Lev 26", first_abbr: "Lev 26:3-20, 38-46", second: "Mark 8:11-end", psalms: "103" },
  13 => { first: "Num 6", second: "Mark 9:1-29", psalms: "105:1-22" },
  14 => { first: "Num 8", first_abbr: "Num 8:5-26", second: "Mark 9:30-end", psalms: "106:1-18" },
  15 => { first: "Num 11", first_abbr: "Num 11:4-6, 10-33", second: "Mark 10:1-31", psalms: "107:1-22" },
  16 => { first: "Num 12", second: "Mark 10:32-end", psalms: "108, 110" },
  17 => { first: "Num 13", first_abbr: "Num 13:1-3, 17-33", second: "Mark 11:1-26", psalms: "111, 112" },
  18 => { first: "Num 14", first_abbr: "Num 14:1-31", second: "Mark 11:27-12:12", psalms: "115" },
  19 => { first: "Num 15", first_abbr: "Num 15:22-41", second: "Mark 12:13-34", psalms: "119:1-24" },
  20 => { first: "Num 16", first_abbr: "Num 16:1-11, 20-38", second: "Mark 12:35-13:13", psalms: "119:49-72" },
  21 => { first: "Num 17", second: "Mark 13:14-end", psalms: "119:89-104" },
  22 => { first: "Num 18", first_abbr: "Num 18:1-24", second: "Mark 14:1-25", psalms: "119:129-152" },
  23 => { first: "Num 20", second: "Mark 14:26-52", psalms: "118" },
  24 => { first: "Num 21", first_abbr: "Num 21:4-9, 21-35", second: "Mark 14:53-end", psalms: "122, 123" },
  25 => { first: "Acts 12:11-25", second: "Mark 15", psalms: "127, 128" },
  26 => { first: "Num 22", first_abbr: "Num 22:1-35", second: "Mark 16", psalms: "132, 133" },
  27 => { first: "Num 23", first_abbr: "Num 23:1-26", second: "Luke 1:1-23", psalms: "136" },
  28 => { first: "Num 24", second: "Luke 1:24-56", psalms: "139" },
  29 => { first: "Num 25", second: "Luke 1:57-end", psalms: "140" },
  30 => { first: "Deut 1", first_abbr: "Deut 1:1-21, 26-33", second: "Luke 2:1-21", psalms: "144" }
}

apr_ep = {
  1 => { first: "Prov 30", first_abbr: "Prov 30:1-9, 15-33", second: "1 Tim 4", psalms: "79, 82" },
  2 => { first: "Prov 31", second: "1 Tim 5", psalms: "78:19-40" },
  3 => { first: "Job 1", second: "1 Tim 6", psalms: "80" },
  4 => { first: "Job 2", second: "Titus 1", psalms: "83" },
  5 => { first: "Job 3", second: "Titus 2", psalms: "85" },
  6 => { first: "Job 4", second: "Titus 3", psalms: "88" },
  7 => { first: "Job 5", second: "2 Tim 1", psalms: "89:19-51" },
  8 => { first: "Job 6", second: "2 Tim 2", psalms: "91" },
  9 => { first: "Job 7", second: "2 Tim 3", psalms: "94" },
  10 => { first: "Job 8", second: "2 Tim 4", psalms: "97, 98" },
  11 => { first: "Job 9", second: "Heb 1", psalms: "102" },
  12 => { first: "Job 10", second: "Heb 2", psalms: "104" },
  13 => { first: "Job 11", second: "Heb 3", psalms: "105:23-44" },
  14 => { first: "Job 12", second: "Heb 4:1-13", psalms: "106:19-46" },
  15 => { first: "Job 13", second: "Heb 4:14-5:10", psalms: "107:23-43" },
  16 => { first: "Job 14", second: "Heb 5:11-6 end", psalms: "109" },
  17 => { first: "Job 15", second: "Heb 7", psalms: "113, 114" },
  18 => { first: "Job 16", second: "Heb 8", psalms: "116, 117" },
  19 => { first: "Job 17", second: "Heb 9:1-14", psalms: "119:25-48" },
  20 => { first: "Job 18", second: "Heb 9:15-end", psalms: "119:73-88" },
  21 => { first: "Job 19", second: "Heb 10:1-18", psalms: "119:105-128" },
  22 => { first: "Job 20", second: "Heb 10:19-end", psalms: "119:153-176" },
  23 => { first: "Job 21", second: "Heb 11", psalms: "120, 121" },
  24 => { first: "Job 22", second: "Heb 12:1-17", psalms: "124, 125, 126" },
  25 => { first: "Job 23", second: "Heb 12:18-end", psalms: "129, 130, 131" },
  26 => { first: "Job 24", second: "Heb 13", psalms: "134, 135" },
  27 => { first: "Job 25 & 26", second: "Jas 1", psalms: "137, 138" },
  28 => { first: "Job 27", second: "Jas 2:1-13", psalms: "141, 142" },
  29 => { first: "Job 28", second: "Jas 2:14-end", psalms: "143" },
  30 => { first: "Job 29", second: "Jas 3", psalms: "145" }
}

may_mp = {
  1 => { first: "Deut 2", first_abbr: "Deut 2:1-9, 14-19, 24-37", second: "Luke 2:22-end", psalms: "146" },
  2 => { first: "Deut 3", second: "Luke 3:1-22", psalms: "148" },
  3 => { first: "Deut 4", first_abbr: "Deut 4:1-18, 24-40", second: "Luke 3:23-end", psalms: "1, 2" },
  4 => { first: "Deut 5", second: "Luke 4:1-30", psalms: "5, 6" },
  5 => { first: "Deut 6", second: "Luke 4:31-end", psalms: "9" },
  6 => { first: "Deut 7", second: "Luke 5:1-16", psalms: "8, 11" },
  7 => { first: "Deut 8", second: "Luke 5:17-end", psalms: "12, 13, 14" },
  8 => { first: "Deut 9", second: "Luke 6:1-19", psalms: "18:1-20" },
  9 => { first: "Deut 10", second: "Luke 6:20-38", psalms: "19" },
  10 => { first: "Deut 11", second: "Luke 6:39-7:10", psalms: "22" },
  11 => { first: "Deut 12", second: "Luke 7:11-35", psalms: "25" },
  12 => { first: "Deut 13", second: "Luke 7:36-end", psalms: "26, 28" },
  13 => { first: "Deut 14", second: "Luke 8:1-21", psalms: "29, 30" },
  14 => { first: "Deut 15", second: "Luke 8:22-end", psalms: "34" },
  15 => { first: "Deut 16", second: "Luke 9:1-17", psalms: "32, 36" },
  16 => { first: "Deut 17", second: "Luke 9:18-50", psalms: "37:1-17" },
  17 => { first: "Deut 18", second: "Luke 9:51-end", psalms: "40" },
  18 => { first: "Deut 19", second: "Luke 10:1-24", psalms: "42, 43" },
  19 => { first: "Deut 20", second: "Luke 10:25-end", psalms: "45" },
  20 => { first: "Deut 21", second: "Luke 11:1-28", psalms: "47, 48" },
  21 => { first: "Deut 22", second: "Luke 11:29-end", psalms: "50" },
  22 => { first: "Deut 23", second: "Luke 12:1-34", psalms: "52, 53, 54" },
  23 => { first: "Deut 24", second: "Luke 12:35-53", psalms: "56, 57" },
  24 => { first: "Deut 25", second: "Luke 12:54-13:9", psalms: "59" },
  25 => { first: "Deut 26", second: "Luke 13:10-end", psalms: "61, 62" },
  26 => { first: "Deut 27", second: "Luke 14:1-24", psalms: "68:1-18" },
  27 => { first: "Deut 28", first_abbr: "Deut 28:1-25, 64-68", second: "Luke 14:25-15:10", psalms: "69:1-18" },
  28 => { first: "Deut 29", second: "Luke 15:11-end", psalms: "66" },
  29 => { first: "Deut 30", second: "Luke 16", psalms: "71" },
  30 => { first: "Deut 31", second: "Luke 17:1-19", psalms: "74" },
  31 => { first: "Deut 32", first_abbr: "Deut 32:1-10, 15-22, 39-52", second: "Luke 1:39-56", psalms: "75, 76" }
}

may_ep = {
  1 => { first: "Jas 4", second: "John 1:43-end", psalms: "147" },
  2 => { first: "Job 30", second: "Jas 5", psalms: "149, 150" },
  3 => { first: "Job 31", first_abbr: "Job 31:1-23, 35-40", second: "1 Pet 1:1-21", psalms: "3, 4" },
  4 => { first: "Job 32", second: "1 Pet 1:22-2:10", psalms: "7" },
  5 => { first: "Job 33", second: "1 Pet 2:11-3:7", psalms: "10" },
  6 => { first: "Job 34", first_abbr: "Job 34:1-15, 21-28, 31-37", second: "1 Pet 3:8-4:6", psalms: "15, 16" },
  7 => { first: "Job 35", second: "1 Pet 4:7-end", psalms: "17" },
  8 => { first: "Job 36", second: "1 Pet 5", psalms: "18:21-52" },
  9 => { first: "Job 37", second: "2 Pet 1", psalms: "20, 21" },
  10 => { first: "Job 38", first_abbr: "Job 38:1-27, 31-33", second: "2 Pet 2", psalms: "23, 24" },
  11 => { first: "Job 39", second: "2 Pet 3", psalms: "27" },
  12 => { first: "Job 40", second: "Jude", psalms: "31" },
  13 => { first: "Job 41", second: "1 John 1:1-2:6", psalms: "33" },
  14 => { first: "Job 42", second: "1 John 2:7-end", psalms: "35" },
  15 => { first: "Eccl 1", second: "1 John 3:1-10", psalms: "38" },
  16 => { first: "Eccl 2", second: "1 John 3:11-4:6", psalms: "37:18-41" },
  17 => { first: "Eccl 3", second: "1 John 4:7-end", psalms: "39, 41" },
  18 => { first: "Eccl 4", second: "1 John 5", psalms: "44" },
  19 => { first: "Eccl 5", second: "2 John", psalms: "46" },
  20 => { first: "Eccl 6", second: "3 John", psalms: "49" },
  21 => { first: "Eccl 7", second: "Acts 1:1-14", psalms: "51" },
  22 => { first: "Eccl 8", second: "Acts 1:15-end", psalms: "55" },
  23 => { first: "Eccl 9", second: "Acts 2:1-21", psalms: "58, 60" },
  24 => { first: "Eccl 10", second: "Acts 2:22-end", psalms: "63, 64" },
  25 => { first: "Eccl 11", second: "Acts 3:1-4:4", psalms: "65, 67" },
  26 => { first: "Eccl 12", second: "Acts 4:5-31", psalms: "68:19-36" },
  27 => { first: "Ezek 1", second: "Acts 4:32-5:11", psalms: "69:19-37" },
  28 => { first: "Ezek 2", second: "Acts 5:12-end", psalms: "70, 72" },
  29 => { first: "Ezek 3", second: "Acts 6:1-7:16", psalms: "73" },
  30 => { first: "Ezek 4", second: "Acts 7:17-34", psalms: "77" },
  31 => { first: "Ezek 5", second: "Acts 7:35-8:3", psalms: "79, 82" }
}

seed_month("janeiro", 31, jan_mp, jan_ep, prayer_book.id)
seed_month("fevereiro", 29, feb_mp, feb_ep, prayer_book.id)
seed_month("marco", 31, mar_mp, mar_ep, prayer_book.id)
seed_month("abril", 30, apr_mp, apr_ep, prayer_book.id)
seed_month("maio", 31, may_mp, may_ep, prayer_book.id)

# --- PROPER DAILY OFFICE READINGS ---

# Maundy Thursday
create_daily_reading({ date_reference: "maundy_thursday", service_type: 'morning_prayer', psalm: "41", first_reading: "Dan 9", second_reading: "John 13:1-20" }, prayer_book.id)
create_daily_reading({ date_reference: "maundy_thursday", service_type: 'evening_prayer', psalm: "142, 143", first_reading: "1 Cor 10:1-22", second_reading: "John 13:21-38" }, prayer_book.id)

# Good Friday
create_daily_reading({ date_reference: "good_friday", service_type: 'morning_prayer', psalm: "40", first_reading: "Lam 3:1-36", second_reading: "John 18" }, prayer_book.id)
create_daily_reading({ date_reference: "good_friday", service_type: 'evening_prayer', psalm: "102", first_reading: "1 Pet 2:11-25", second_reading: "Luke 23:18-49" }, prayer_book.id)

# Holy Saturday
create_daily_reading({ date_reference: "holy_saturday", service_type: 'morning_prayer', psalm: "88", first_reading: "Lam 3:37-58", second_reading: "Heb 4" }, prayer_book.id)
create_daily_reading({ date_reference: "holy_saturday", service_type: 'evening_prayer', psalm: "91", first_reading: "1 Pet 4:1-8", second_reading: "Luke 23:50-56" }, prayer_book.id)

# Easter Day
create_daily_reading({ date_reference: "easter_day", service_type: 'morning_prayer', psalm: "118", first_reading: "Exod 15", second_reading: "Acts 2:22-32" }, prayer_book.id)
create_daily_reading({ date_reference: "easter_day", service_type: 'evening_prayer', psalm: "111, 113, 114", first_reading: "Rom 6", second_reading: "Luke 24:13-43" }, prayer_book.id)

# Ascension
create_daily_reading({ date_reference: "ascension_day", service_type: 'morning_prayer', psalm: "8, 47", first_reading: "2 Kings 2", second_reading: "Eph 4:1-17" }, prayer_book.id)
create_daily_reading({ date_reference: "ascension_day", service_type: 'evening_prayer', psalm: "21, 24", first_reading: "Heb 8", second_reading: "Luke 24:44-53" }, prayer_book.id)

# Pentecost
create_daily_reading({ date_reference: "pentecost", service_type: 'morning_prayer', psalm: "48", first_reading: "Isa 11", second_reading: "John 16:1-15" }, prayer_book.id)
create_daily_reading({ date_reference: "pentecost", service_type: 'evening_prayer', psalm: "145", first_reading: "Acts 2", second_reading: "Acts 10:34-end" }, prayer_book.id)

Rails.logger.info "✅ Leituras do Ofício Diário (Jan-Mai) carregadas para LOC 2019!"
