# ================================================================================
# FESTIVAIS (25 celebrações - Rank 30-54)
# Apóstolos, Evangelistas e dias santos de alta importância
# ================================================================================

puts "🎉 Criando Festivais..."

prayer_book = PrayerBook.find_by!(code: 'loc_2015')

festivals = [
  { prayer_book_id: prayer_book&.id, name: "Confissão de São Pedro", celebration_type: :festival, rank: 30, fixed_month: 1, fixed_day: 18, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "Conversão de São Paulo", celebration_type: :festival, rank: 31, fixed_month: 1, fixed_day: 25, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "São Matias", celebration_type: :festival, rank: 32, fixed_month: 2, fixed_day: 24, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "São José", celebration_type: :festival, rank: 33, fixed_month: 3, fixed_day: 19, liturgical_color: "branco", can_be_transferred: true },
  { prayer_book_id: prayer_book&.id, name: "São Marcos Evangelista", celebration_type: :festival, rank: 34, fixed_month: 4, fixed_day: 25, liturgical_color: "vermelho", can_be_transferred: true },
  { prayer_book_id: prayer_book&.id, name: "São Filipe e São Tiago", celebration_type: :festival, rank: 35, fixed_month: 5, fixed_day: 1, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Visitação da Bem-Aventurada Virgem Maria", celebration_type: :festival, rank: 36, fixed_month: 5, fixed_day: 31, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "São Barnabé", celebration_type: :festival, rank: 37, fixed_month: 6, fixed_day: 11, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Natividade de São João Batista", celebration_type: :festival, rank: 38, fixed_month: 6, fixed_day: 24, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "São Pedro e São Paulo", celebration_type: :festival, rank: 39, fixed_month: 6, fixed_day: 29, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Santa Maria Madalena", celebration_type: :festival, rank: 40, fixed_month: 7, fixed_day: 22, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "São Tiago", celebration_type: :festival, rank: 41, fixed_month: 7, fixed_day: 25, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Bem-Aventurada Virgem Maria", celebration_type: :festival, rank: 42, fixed_month: 8, fixed_day: 15, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "São Bartolomeu", celebration_type: :festival, rank: 43, fixed_month: 8, fixed_day: 24, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Santa Cruz", celebration_type: :festival, rank: 44, fixed_month: 9, fixed_day: 14, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Mateus, Apóstolo e Evangelista", celebration_type: :festival, rank: 45, fixed_month: 9, fixed_day: 21, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Arcanjo Miguel e Todos os Anjos", celebration_type: :festival, rank: 46, fixed_month: 9, fixed_day: 29, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "Lucas, Evangelista", celebration_type: :festival, rank: 47, fixed_month: 10, fixed_day: 18, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Tiago de Jerusalém", celebration_type: :festival, rank: 48, fixed_month: 10, fixed_day: 23, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Simão e Judas, Apóstolos", celebration_type: :festival, rank: 49, fixed_month: 10, fixed_day: 28, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "André, Apóstolo", celebration_type: :festival, rank: 50, fixed_month: 11, fixed_day: 30, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "São Tomé", celebration_type: :festival, rank: 51, fixed_month: 12, fixed_day: 21, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "Estêvão, Diácono e Protomártir", celebration_type: :festival, rank: 52, fixed_month: 12, fixed_day: 26, liturgical_color: "vermelho" },
  { prayer_book_id: prayer_book&.id, name: "João, Apóstolo e Evangelista", celebration_type: :festival, rank: 53, fixed_month: 12, fixed_day: 27, liturgical_color: "branco" },
  { prayer_book_id: prayer_book&.id, name: "Santos Inocentes", celebration_type: :festival, rank: 54, fixed_month: 12, fixed_day: 28, liturgical_color: "vermelho" }
]

festivals.each do |festival|
  Celebration.create!(festival.merge(prayer_book_id: prayer_book&.id, movable: false, can_be_transferred: true))
  puts "  ✓ #{festival[:name]}"
end
