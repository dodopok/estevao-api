# Santos Adicionais da Tradição Anglicana/Episcopal
# Complementa com santos importantes da história da igreja e reforma anglicana

puts "🕊️  Carregando santos da tradição anglicana..."

anglican_saints = [
  # Janeiro
  { name: "Basílio Magno e Gregório de Nazianzo", celebration_type: :lesser_feast, rank: 200, fixed_month: 1, fixed_day: 2, liturgical_color: "branco", description: "Bispos e Doutores, 379 e 389" },
  { name: "Santo Hilário de Poitiers", celebration_type: :lesser_feast, rank: 201, fixed_month: 1, fixed_day: 13, liturgical_color: "branco", description: "Bispo e Doutor, 367" },
  { name: "Santo Antão do Egito", celebration_type: :lesser_feast, rank: 202, fixed_month: 1, fixed_day: 17, liturgical_color: "branco", description: "Abade, 356" },
  { name: "Santa Agnes", celebration_type: :lesser_feast, rank: 203, fixed_month: 1, fixed_day: 21, liturgical_color: "vermelho", description: "Mártir, 304" },
  { name: "Phillips Brooks", celebration_type: :lesser_feast, rank: 204, fixed_month: 1, fixed_day: 23, liturgical_color: "branco", description: "Bispo, 1893" },
  { name: "Timothy e Titus", celebration_type: :lesser_feast, rank: 205, fixed_month: 1, fixed_day: 26, liturgical_color: "branco", description: "Companheiros de Paulo" },

  # Fevereiro
  { name: "Santa Brígida da Irlanda", celebration_type: :lesser_feast, rank: 206, fixed_month: 2, fixed_day: 1, liturgical_color: "branco", description: "Abadessa, 523" },
  { name: "Anskar", celebration_type: :lesser_feast, rank: 207, fixed_month: 2, fixed_day: 3, liturgical_color: "branco", description: "Arcebispo e Missionário, 865" },
  { name: "Santo Cirilo e São Metódio", celebration_type: :lesser_feast, rank: 208, fixed_month: 2, fixed_day: 14, liturgical_color: "branco", description: "Missionários aos Eslavos, 869, 885" },
  { name: "Santo Policarpo", celebration_type: :lesser_feast, rank: 209, fixed_month: 2, fixed_day: 23, liturgical_color: "vermelho", description: "Bispo e Mártir, 156" },

  # Março
  { name: "São David da Gales", celebration_type: :lesser_feast, rank: 210, fixed_month: 3, fixed_day: 1, liturgical_color: "branco", description: "Bispo, c. 544" },
  { name: "São Perpétua e Santa Felicidade", celebration_type: :lesser_feast, rank: 211, fixed_month: 3, fixed_day: 7, liturgical_color: "vermelho", description: "Mártires, 203" },
  { name: "Santo Cirilo de Jerusalém", celebration_type: :lesser_feast, rank: 212, fixed_month: 3, fixed_day: 18, liturgical_color: "branco", description: "Bispo e Doutor, 386" },
  { name: "Thomas Cranmer", celebration_type: :lesser_feast, rank: 213, fixed_month: 3, fixed_day: 21, liturgical_color: "vermelho", description: "Arcebispo e Mártir, 1556" },
  { name: "São João Damasceno", celebration_type: :lesser_feast, rank: 214, fixed_month: 3, fixed_day: 27, liturgical_color: "branco", description: "Sacerdote e Monge, c. 749" },

  # Abril
  { name: "Frederick Denison Maurice", celebration_type: :lesser_feast, rank: 215, fixed_month: 4, fixed_day: 1, liturgical_color: "branco", description: "Sacerdote, 1872" },
  { name: "Santo Anselmo", celebration_type: :lesser_feast, rank: 216, fixed_month: 4, fixed_day: 21, liturgical_color: "branco", description: "Arcebispo e Doutor, 1109" },

  # Maio
  { name: "Santo Atanásio", celebration_type: :lesser_feast, rank: 217, fixed_month: 5, fixed_day: 2, liturgical_color: "branco", description: "Bispo e Doutor, 373" },
  { name: "Julian of Norwich", celebration_type: :lesser_feast, rank: 218, fixed_month: 5, fixed_day: 8, liturgical_color: "branco", description: "Mística, c. 1417" },
  { name: "Dunstan", celebration_type: :lesser_feast, rank: 219, fixed_month: 5, fixed_day: 19, liturgical_color: "branco", description: "Arcebispo, 988" },
  { name: "Beda, o Venerável", celebration_type: :lesser_feast, rank: 220, fixed_month: 5, fixed_day: 25, liturgical_color: "branco", description: "Sacerdote e Doutor, 735" },
  { name: "João e Carlos Wesley", celebration_type: :lesser_feast, rank: 221, fixed_month: 5, fixed_day: 24, liturgical_color: "branco", description: "Sacerdotes, 1791, 1788" },
  { name: "Joana d'Arc", celebration_type: :lesser_feast, rank: 222, fixed_month: 5, fixed_day: 30, liturgical_color: "vermelho", description: "Mística e Soldado, 1431" },

  # Junho
  { name: "Justin Mártir", celebration_type: :lesser_feast, rank: 223, fixed_month: 6, fixed_day: 1, liturgical_color: "vermelho", description: "Mártir, c. 167" },
  { name: "Boniface", celebration_type: :lesser_feast, rank: 224, fixed_month: 6, fixed_day: 5, liturgical_color: "vermelho", description: "Arcebispo e Mártir, 754" },
  { name: "Columba", celebration_type: :lesser_feast, rank: 225, fixed_month: 6, fixed_day: 9, liturgical_color: "branco", description: "Abade, 597" },
  { name: "São Basílio Magno", celebration_type: :lesser_feast, rank: 226, fixed_month: 6, fixed_day: 14, liturgical_color: "branco", description: "Bispo e Doutor, 379" },
  { name: "Joseph Butler", celebration_type: :lesser_feast, rank: 227, fixed_month: 6, fixed_day: 16, liturgical_color: "branco", description: "Bispo, 1752" },
  { name: "São Cipriano", celebration_type: :lesser_feast, rank: 228, fixed_month: 6, fixed_day: 26, liturgical_color: "vermelho", description: "Bispo e Mártir, 258" },
  { name: "Santo Irineu", celebration_type: :lesser_feast, rank: 229, fixed_month: 6, fixed_day: 28, liturgical_color: "vermelho", description: "Bispo e Mártir, c. 202" },

  # Julho
  { name: "Thomas More e John Fisher", celebration_type: :lesser_feast, rank: 230, fixed_month: 7, fixed_day: 6, liturgical_color: "vermelho", description: "Mártires, 1535" },
  { name: "Benedict of Nursia", celebration_type: :lesser_feast, rank: 231, fixed_month: 7, fixed_day: 11, liturgical_color: "branco", description: "Abade, c. 547" },
  { name: "William Wilberforce", celebration_type: :lesser_feast, rank: 232, fixed_month: 7, fixed_day: 30, liturgical_color: "branco", description: "Reformador Social, 1833" },

  # Agosto
  { name: "Dominic", celebration_type: :lesser_feast, rank: 233, fixed_month: 8, fixed_day: 8, liturgical_color: "branco", description: "Frade, 1221" },
  { name: "Clare of Assisi", celebration_type: :lesser_feast, rank: 234, fixed_month: 8, fixed_day: 11, liturgical_color: "branco", description: "Monja, 1253" },
  { name: "Bernard", celebration_type: :lesser_feast, rank: 235, fixed_month: 8, fixed_day: 20, liturgical_color: "branco", description: "Abade, 1153" },
  { name: "Aidan", celebration_type: :lesser_feast, rank: 236, fixed_month: 8, fixed_day: 31, liturgical_color: "branco", description: "Bispo e Missionário, 651" },

  # Setembro
  { name: "Gregory the Great", celebration_type: :lesser_feast, rank: 237, fixed_month: 9, fixed_day: 3, liturgical_color: "branco", description: "Bispo e Doutor, 604" },
  { name: "John Chrysostom", celebration_type: :lesser_feast, rank: 238, fixed_month: 9, fixed_day: 13, liturgical_color: "branco", description: "Bispo e Doutor, 407" },
  { name: "Cyprian of Carthage", celebration_type: :lesser_feast, rank: 239, fixed_month: 9, fixed_day: 16, liturgical_color: "vermelho", description: "Bispo e Mártir, 258" },
  { name: "Hildegard", celebration_type: :lesser_feast, rank: 240, fixed_month: 9, fixed_day: 17, liturgical_color: "branco", description: "Abadessa, 1179" },
  { name: "Lancelot Andrewes", celebration_type: :lesser_feast, rank: 241, fixed_month: 9, fixed_day: 25, liturgical_color: "branco", description: "Bispo, 1626" },

  # Outubro
  { name: "Remigius", celebration_type: :lesser_feast, rank: 242, fixed_month: 10, fixed_day: 1, liturgical_color: "branco", description: "Bispo, c. 530" },
  { name: "William Tyndale", celebration_type: :lesser_feast, rank: 243, fixed_month: 10, fixed_day: 6, liturgical_color: "vermelho", description: "Sacerdote e Mártir, 1536" },
  { name: "Teresa of Avila", celebration_type: :lesser_feast, rank: 244, fixed_month: 10, fixed_day: 15, liturgical_color: "branco", description: "Monja e Doutora, 1582" },
  { name: "Hugh Latimer, Nicholas Ridley e Thomas Cranmer", celebration_type: :lesser_feast, rank: 245, fixed_month: 10, fixed_day: 16, liturgical_color: "vermelho", description: "Bispos e Mártires, 1555, 1556" },
  { name: "Henry Martyn", celebration_type: :lesser_feast, rank: 246, fixed_month: 10, fixed_day: 19, liturgical_color: "branco", description: "Sacerdote e Missionário, 1812" },

  # Novembro
  { name: "Richard Hooker", celebration_type: :lesser_feast, rank: 247, fixed_month: 11, fixed_day: 3, liturgical_color: "branco", description: "Sacerdote, 1600" },
  { name: "Charles Simeon", celebration_type: :lesser_feast, rank: 248, fixed_month: 11, fixed_day: 12, liturgical_color: "branco", description: "Sacerdote, 1836" },
  { name: "Margaret of Scotland", celebration_type: :lesser_feast, rank: 249, fixed_month: 11, fixed_day: 16, liturgical_color: "branco", description: "Rainha, 1093" },
  { name: "Elizabeth of Hungary", celebration_type: :lesser_feast, rank: 250, fixed_month: 11, fixed_day: 17, liturgical_color: "branco", description: "Rainha e Missionária, 1231" },
  { name: "Hilda of Whitby", celebration_type: :lesser_feast, rank: 251, fixed_month: 11, fixed_day: 18, liturgical_color: "branco", description: "Abadessa, 680" },
  { name: "Clemente de Roma", celebration_type: :lesser_feast, rank: 252, fixed_month: 11, fixed_day: 23, liturgical_color: "vermelho", description: "Bispo e Mártir, c. 100" },
  { name: "Catherine of Alexandria", celebration_type: :lesser_feast, rank: 253, fixed_month: 11, fixed_day: 25, liturgical_color: "vermelho", description: "Mártir, c. 305" },
  { name: "Kamehameha e Emma", celebration_type: :lesser_feast, rank: 254, fixed_month: 11, fixed_day: 28, liturgical_color: "branco", description: "Rei e Rainha do Havaí, 1864, 1885" },

  # Dezembro
  { name: "Nicholas Ferrar", celebration_type: :lesser_feast, rank: 255, fixed_month: 12, fixed_day: 1, liturgical_color: "branco", description: "Diácono, 1637" },
  { name: "John of Damascus", celebration_type: :lesser_feast, rank: 256, fixed_month: 12, fixed_day: 4, liturgical_color: "branco", description: "Sacerdote e Monge, c. 749" },
  { name: "Conception da Bem-Aventurada Virgem Maria", celebration_type: :lesser_feast, rank: 257, fixed_month: 12, fixed_day: 8, liturgical_color: "branco", description: "Imaculada Conceição" },
  { name: "Thomas Merton", celebration_type: :lesser_feast, rank: 258, fixed_month: 12, fixed_day: 10, liturgical_color: "branco", description: "Monge e Escritor, 1968" },
  { name: "Samuel Johnson", celebration_type: :lesser_feast, rank: 259, fixed_month: 12, fixed_day: 13, liturgical_color: "branco", description: "Moralista, 1784" },
  { name: "John of the Cross", celebration_type: :lesser_feast, rank: 260, fixed_month: 12, fixed_day: 14, liturgical_color: "branco", description: "Frade e Místico, 1591" },
  { name: "Stephen Harding", celebration_type: :lesser_feast, rank: 261, fixed_month: 12, fixed_day: 17, liturgical_color: "branco", description: "Abade, 1134" }
]

# Verificar se o santo já existe antes de criar
count = 0
skipped = 0

anglican_saints.each do |saint|
  existing = Celebration.find_by(
    name: saint[:name],
    fixed_month: saint[:fixed_month],
    fixed_day: saint[:fixed_day]
  )

  if existing.nil?
    Celebration.create!(saint.merge(movable: false, can_be_transferred: false))
    count += 1
    print "." if count % 10 == 0
  else
    skipped += 1
  end
end

puts "\n✅ #{count} santos anglicanos adicionados!"
puts "⏭️  #{skipped} santos já existiam no banco de dados." if skipped > 0
