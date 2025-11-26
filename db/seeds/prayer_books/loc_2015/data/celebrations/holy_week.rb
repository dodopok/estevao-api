# Celebrações da Semana Santa
# Complementa com celebrações da Semana Santa que não estão no seeds principal

puts "✝️  Carregando celebrações da Semana Santa..."

prayer_book = PrayerBook.find_by_code('loc_2015')

holy_week_celebrations = [
  {
    name: "Segunda-feira Santa",
    latin_name: "Feria Secunda Maioris Hebdomadae",
    celebration_type: :lesser_feast,
    rank: 190,
    movable: true,
    calculation_rule: "easter_minus_6_days",
    liturgical_color: "roxo",
    can_be_transferred: false,
    description: "Segunda-feira da Semana Santa"
  },
  {
    name: "Terça-feira Santa",
    latin_name: "Feria Tertia Maioris Hebdomadae",
    celebration_type: :lesser_feast,
    rank: 191,
    movable: true,
    calculation_rule: "easter_minus_5_days",
    liturgical_color: "roxo",
    can_be_transferred: false,
    description: "Terça-feira da Semana Santa"
  },
  {
    name: "Quarta-feira Santa",
    latin_name: "Feria Quarta Maioris Hebdomadae",
    celebration_type: :lesser_feast,
    rank: 192,
    movable: true,
    calculation_rule: "easter_minus_4_days",
    liturgical_color: "roxo",
    can_be_transferred: false,
    description: "Quarta-feira da Semana Santa"
  },
  {
    name: "Sábado Santo",
    latin_name: "Sabbatum Sanctum",
    celebration_type: :major_holy_day,
    rank: 23,
    movable: true,
    calculation_rule: "easter_minus_1_day",
    liturgical_color: "preto",
    can_be_transferred: false,
    description: "Sábado Santo - Cristo no Túmulo"
  },
  {
    name: "Vigília Pascal",
    latin_name: "Vigilia Paschalis",
    celebration_type: :principal_feast,
    rank: 1,  # Mesma importância da Páscoa
    movable: true,
    calculation_rule: "easter_minus_1_day",
    liturgical_color: "branco",
    can_be_transferred: false,
    description: "Vigília Pascal - A Mãe de Todas as Vigílias"
  }
]

count = 0
skipped = 0

holy_week_celebrations.each do |celebration|
  existing = Celebration.find_by(
    name: celebration[:name],
    movable: celebration[:movable],
    calculation_rule: celebration[:calculation_rule]
  )

  if existing.nil?
    Celebration.create!(celebration.merge(prayer_book_id: prayer_book.id))
    count += 1
    print "." if count % 5 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} celebrações da Semana Santa adicionadas!"
puts "⏭️  #{skipped} celebrações já existiam no banco de dados." if skipped > 0
