# ================================================================================
# LEITURAS - SEMANA SANTA E PÁSCOA - LOC 1987 - ANO A
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Semana Santa e Páscoa (LOC 1987) - Ano A..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

holy_week = [
  {
    date_reference: "palm_sunday_palms",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Mateus 21:1-11",
    psalm: "118:19-29",
    second_reading: nil,
    gospel: "Mateus 21:1-11"
  },
  {
    "date_reference": "palm_sunday",
    "cycle": "A",
    "service_type": "eucharist",
    "first_reading": "Isaías 45:21-25 ou Isaías 52:13-53:12",
    "psalm": "22:1-21 ou 22:1-11",
    "second_reading": "Filipenses 2:5-11",
    "gospel": "Mateus (26:36-75)27:1-54(55-66)"
  },
  {
    date_reference: "monday_holy_week",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "36:5-10",
    second_reading: "Hebreus 11:39-12:3",
    gospel: "João 12:1-11 ou Marcos 14:3-9"
  },
  {
    date_reference: "tuesday_holy_week",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 49:1-6",
    psalm: "71:1-12",
    second_reading: "I Coríntios 1:18-31",
    gospel: "João 12:37-38,42-50 ou Marcos 1:15-19"
  },
  {
    date_reference: "wednesday_holy_week",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 50:4-9a",
    psalm: "69:7-15,22-23",
    second_reading: "Hebreus 9:11-15,24-28",
    gospel: "João 13:21-35 ou Mateus 26:1-5,14-25"
  },
  {
    date_reference: "maundy_thursday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Êxodo 12:1-14a",
    psalm: "78:14-20,23-25",
    second_reading: "I Coríntios 11:23-26(27-32)",
    gospel: "João 13:1-15 ou Lucas 22:14-30"
  },
  {
    date_reference: "good_friday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Isaías 52:13—53:12 ou Gênesis 22:1-18",
    psalm: "22:1-21 ou 22:1-11 ou 40:1-11 ou 69:1-23",
    second_reading: "Hebreus 10:1-25",
    gospel: "João (18:1-40)19:1-37"
  },
  {
    date_reference: "holy_saturday",
    cycle: "A",
    service_type: "morning_prayer",
    first_reading: "Jo 14:1-14",
    psalm: "130 ou 31:1-5",
    second_reading: "I Pedro 4:1-8",
    gospel: "Mateus 27:57-66 ou João 19:38-42"
  },
  {
    date_reference: "easter_first_office",
    cycle: "A",
    service_type: "morning_prayer",
    first_reading: "Gênesis 1:1-2:2 ou Gênesis 1:1-2 ou Gênesis 7:1-5,11-18;8:6-18;9:8-13",
    psalm: "114",
    second_reading: "Romanos 6:3-11",
    gospel: "Mateus 28:1-10"
  },
  {
    date_reference: "easter_sunday",
    cycle: "A",
    service_type: "eucharist",
    first_reading: "Atos 10:34-43 ou Atos 10:34-43",
    psalm: "118:14-29 ou 118:14-17,22-24",
    second_reading: "Colossenses 3:1-4 ou Atos 10:34-43",
    gospel: "João 20:1-10(11-18) ou Mateus 28:1-10"
  }
]

# create
count = 0
skipped = 0
holy_week.each do |r|
  r[:prayer_book_id] = prayer_book.id
  existing = LectionaryReading.find_by(date_reference: r[:date_reference], cycle: r[:cycle], service_type: r[:service_type], prayer_book_id: prayer_book.id)
  if existing.nil?
    LectionaryReading.create!(r)
    count += 1
  else
    skipped += 1
  end
end

Rails.logger.info "\n✅ #{count} leituras da Semana Santa/Páscoa criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
