# ================================================================================
# FESTAS MENORES (20 celebrações - Rank 100-119)
# Santos, doutores da Igreja e outras comemorações
# ================================================================================

puts "🕊️  Criando Festas Menores..."

prayer_book = PrayerBook.find_by_code('loc_2015')

lesser_feasts = [
  { name: "Santo Agostinho de Cantuária", celebration_type: :lesser_feast, rank: 100, fixed_month: 5, fixed_day: 26, liturgical_color: "branco", description: "Bispo, 605" },
  { name: "Santo Ambrósio de Milão", celebration_type: :lesser_feast, rank: 101, fixed_month: 12, fixed_day: 7, liturgical_color: "branco", description: "Bispo e Doutor, 397" },
  { name: "Santa Mônica", celebration_type: :lesser_feast, rank: 102, fixed_month: 8, fixed_day: 27, liturgical_color: "branco", description: "Mãe de Agostinho, 387" },
  { name: "Santo Agostinho de Hipona", celebration_type: :lesser_feast, rank: 103, fixed_month: 8, fixed_day: 28, liturgical_color: "branco", description: "Bispo e Doutor, 430" },
  { name: "São Jerônimo", celebration_type: :lesser_feast, rank: 104, fixed_month: 9, fixed_day: 30, liturgical_color: "branco", description: "Sacerdote e Doutor, 420" },
  { name: "São Francisco de Assis", celebration_type: :lesser_feast, rank: 105, fixed_month: 10, fixed_day: 4, liturgical_color: "branco", description: "Frade e Fundador, 1226" },
  { name: "Santa Teresa de Ávila", celebration_type: :lesser_feast, rank: 106, fixed_month: 10, fixed_day: 15, liturgical_color: "branco", description: "Mística e Doutora, 1582" },
  { name: "São Nicolau de Mira", celebration_type: :lesser_feast, rank: 107, fixed_month: 12, fixed_day: 6, liturgical_color: "branco", description: "Bispo, c. 342" },
  { name: "Santa Lúcia", celebration_type: :lesser_feast, rank: 108, fixed_month: 12, fixed_day: 13, liturgical_color: "vermelho", description: "Mártir, 304" },
  { name: "São Gregório Magno", celebration_type: :lesser_feast, rank: 109, fixed_month: 3, fixed_day: 12, liturgical_color: "branco", description: "Bispo e Doutor, 604" },
  { name: "São Patrício", celebration_type: :lesser_feast, rank: 110, fixed_month: 3, fixed_day: 17, liturgical_color: "branco", description: "Bispo e Missionário, c. 461" },
  { name: "São Jorge", celebration_type: :lesser_feast, rank: 111, fixed_month: 4, fixed_day: 23, liturgical_color: "vermelho", description: "Mártir, c. 303" },
  { name: "São Bento de Núrsia", celebration_type: :lesser_feast, rank: 112, fixed_month: 7, fixed_day: 11, liturgical_color: "branco", description: "Abade e Fundador, c. 550" },
  { name: "Santa Maria Madalena de Pazzi", celebration_type: :lesser_feast, rank: 113, fixed_month: 5, fixed_day: 25, liturgical_color: "branco", description: "Mística, 1607" },
  { name: "São Tomás de Aquino", celebration_type: :lesser_feast, rank: 114, fixed_month: 1, fixed_day: 28, liturgical_color: "branco", description: "Sacerdote e Doutor, 1274" },
  { name: "Santa Escolástica", celebration_type: :lesser_feast, rank: 115, fixed_month: 2, fixed_day: 10, liturgical_color: "branco", description: "Monja, c. 543" },
  { name: "São Valentim", celebration_type: :lesser_feast, rank: 116, fixed_month: 2, fixed_day: 14, liturgical_color: "vermelho", description: "Mártir, c. 269" },
  { name: "São Inácio de Antioquia", celebration_type: :lesser_feast, rank: 117, fixed_month: 10, fixed_day: 17, liturgical_color: "vermelho", description: "Bispo e Mártir, c. 107" },
  { name: "São Martinho de Tours", celebration_type: :lesser_feast, rank: 118, fixed_month: 11, fixed_day: 11, liturgical_color: "branco", description: "Bispo, 397" },
  { name: "Santa Catarina de Alexandria", celebration_type: :lesser_feast, rank: 119, fixed_month: 11, fixed_day: 25, liturgical_color: "vermelho", description: "Mártir, c. 305" }
]

lesser_feasts.each do |feast|
  Celebration.create!(feast.merge(prayer_book_id: prayer_book&.id, movable: false, can_be_transferred: false))
  puts "  ✓ #{feast[:name]}"
end
