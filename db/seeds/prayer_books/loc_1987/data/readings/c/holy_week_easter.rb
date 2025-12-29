# ================================================================================
# LEITURAS - SEMANA SANTA E PÁSCOA - LOC 1987 - ANO C
# ================================================================================

Rails.logger.info "📖 Carregando leituras da Semana Santa e Páscoa (LOC 1987) - Ano C..."

prayer_book = PrayerBook.find_by!(code: 'loc_1987')

holy_week = [
  {
    date_reference: "palm_sunday_palms",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Lucas 19:29-40",
    psalm: "118:19-29",
    second_reading: nil,
    gospel: "Lucas 19:29-40"
  },
  {
    date_reference: "palm_sunday_word",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 45:21-25 ou Isaías 52:13-53:12",
    psalm: "22:1-21 ou 22:1-11",
    second_reading: "Filipenses 2:5-11",
    gospel: "Lucas (22:39-71)23:1-49(50-56)"
  },
  {
    date_reference: "monday_holy_week",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 42:1-9",
    psalm: "36:5-10",
    second_reading: "Hebreus 11:39-12:3",
    gospel: "João 12:1-11 ou Marcos 14:3-9"
  },
  {
    date_reference: "tuesday_holy_week",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 49:1-6",
    psalm: "71:1-12",
    second_reading: "I Coríntios 1:18-31",
    gospel: "João 12:37-38,42-50 ou Marcos 11:15-19"
  },
  {
    date_reference: "wednesday_holy_week",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 50:4-9a",
    psalm: "69:7-15,22-23",
    second_reading: "Hebreus 9:11-15,24-28",
    gospel: "João 13:21-35 ou Mateus 26:1-5,14-25"
  },
  {
    date_reference: "maundy_thursday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Êxodo 12:1-14a",
    psalm: "78:14-20,23-25",
    second_reading: "I Coríntios 11:23-26(27-32)",
    gospel: "João 13:1-15 ou Lucas 22:14-30"
  },
  {
    date_reference: "good_friday",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Isaías 52:13-53:12 ou Gênesis 22:1-18 ou Sabedoria 2:1,12-24",
    psalm: "22:1-21 ou 22:1-11 ou 40:1-14 ou 69:1-23",
    second_reading: "Hebreus 10:1-25",
    gospel: "João (18:1-40)19:1-37"
  },
  {
    date_reference: "holy_saturday",
    cycle: "C",
    service_type: "morning_prayer",
    first_reading: "Jó 14:1-14",
    psalm: "130 ou 31:1-5",
    second_reading: "I Pedro 4:1-8",
    gospel: "Mateus 27:57-66 ou João 19:38-42"
  },
  {
    date_reference: "easter_first_office",
    cycle: "C",
    service_type: "morning_prayer",
    first_reading: "Ezequiel 36:24-28 ou Ezequiel 37:1-14 ou Sofonias 3:12-20",
    psalm: "114",
    second_reading: "Romanos 6:3-11",
    gospel: "Mateus 28:1-10"
  },
  {
    date_reference: "easter_principal_office",
    cycle: "C",
    service_type: "eucharist",
    first_reading: "Atos 10:34-43 ou Isaías 51:9-11",
    psalm: "118:14-29 ou 118:14-17,22-24",
    second_reading: "Colossenses 3:1-4 ou Atos 10:34-43",
    gospel: "Lucas 24:1-10"
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

Rails.logger.info "\n✅ #{count} leituras da Semana Santa/Páscoa (Ano C) criadas"
Rails.logger.info "⏭️  #{skipped} já existiam." if skipped > 0
