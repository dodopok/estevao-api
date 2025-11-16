# Santos Adicionais do Calendário Litúrgico Anglicano
# Este arquivo adiciona mais festas menores e comemorações

puts "🕊️  Carregando santos adicionais..."

additional_saints = [
  # Janeiro
  { name: "Santa Maria, Mãe de Deus", celebration_type: :festival, rank: 200, fixed_month: 1, fixed_day: 1, liturgical_color: "branco", description: "Theotokos" },
  { name: "Basílio Magno e Gregório Nazianzeno", celebration_type: :lesser_feast, rank: 201, fixed_month: 1, fixed_day: 2, liturgical_color: "branco", description: "Bispos e Doutores, 379 e 389" },
  { name: "Santo Antão do Egito", celebration_type: :lesser_feast, rank: 202, fixed_month: 1, fixed_day: 17, liturgical_color: "branco", description: "Abade, 356" },
  { name: "Santa Agnes", celebration_type: :lesser_feast, rank: 203, fixed_month: 1, fixed_day: 21, liturgical_color: "vermelho", description: "Mártir, 304" },
  { name: "São Francisco de Sales", celebration_type: :lesser_feast, rank: 204, fixed_month: 1, fixed_day: 24, liturgical_color: "branco", description: "Bispo e Doutor, 1622" },
  { name: "São Timóteo e São Tito", celebration_type: :lesser_feast, rank: 205, fixed_month: 1, fixed_day: 26, liturgical_color: "branco", description: "Companheiros de Paulo" },
  { name: "São João Crisóstomo", celebration_type: :lesser_feast, rank: 206, fixed_month: 1, fixed_day: 27, liturgical_color: "branco", description: "Bispo e Doutor, 407" },

  # Fevereiro
  { name: "Apresentação de Cristo no Templo", celebration_type: :principal_feast, rank: 5, fixed_month: 2, fixed_day: 2, liturgical_color: "branco", description: "Candelária" },
  { name: "Santo Ansgário", celebration_type: :lesser_feast, rank: 207, fixed_month: 2, fixed_day: 3, liturgical_color: "branco", description: "Arcebispo e Missionário, 865" },
  { name: "Os Mártires do Japão", celebration_type: :lesser_feast, rank: 208, fixed_month: 2, fixed_day: 6, liturgical_color: "vermelho", description: "1597" },
  { name: "Santa Policarpo", celebration_type: :lesser_feast, rank: 209, fixed_month: 2, fixed_day: 23, liturgical_color: "vermelho", description: "Bispo e Mártir, 156" },
  { name: "George Herbert", celebration_type: :lesser_feast, rank: 210, fixed_month: 2, fixed_day: 27, liturgical_color: "branco", description: "Sacerdote e Poeta, 1633" },

  # Março
  { name: "São Davi de Gales", celebration_type: :lesser_feast, rank: 211, fixed_month: 3, fixed_day: 1, liturgical_color: "branco", description: "Bispo, c. 601" },
  { name: "São Chad", celebration_type: :lesser_feast, rank: 212, fixed_month: 3, fixed_day: 2, liturgical_color: "branco", description: "Bispo, 672" },
  { name: "Perpétua e Felicidade", celebration_type: :lesser_feast, rank: 213, fixed_month: 3, fixed_day: 7, liturgical_color: "vermelho", description: "Mártires, 203" },
  { name: "São Cirilo de Jerusalém", celebration_type: :lesser_feast, rank: 214, fixed_month: 3, fixed_day: 18, liturgical_color: "branco", description: "Bispo e Doutor, 386" },
  { name: "São Oscar Romero", celebration_type: :lesser_feast, rank: 215, fixed_month: 3, fixed_day: 24, liturgical_color: "vermelho", description: "Bispo e Mártir, 1980" },

  # Abril
  { name: "São Francisco de Paula", celebration_type: :lesser_feast, rank: 216, fixed_month: 4, fixed_day: 2, liturgical_color: "branco", description: "Eremita, 1507" },
  { name: "Santo Anselmo", celebration_type: :lesser_feast, rank: 217, fixed_month: 4, fixed_day: 21, liturgical_color: "branco", description: "Bispo e Doutor, 1109" },
  { name: "São Fidelis de Sigmaringa", celebration_type: :lesser_feast, rank: 218, fixed_month: 4, fixed_day: 24, liturgical_color: "vermelho", description: "Sacerdote e Mártir, 1622" },
  { name: "Santa Catarina de Siena", celebration_type: :lesser_feast, rank: 219, fixed_month: 4, fixed_day: 29, liturgical_color: "branco", description: "Doutora, 1380" },
  { name: "São Pio V", celebration_type: :lesser_feast, rank: 220, fixed_month: 4, fixed_day: 30, liturgical_color: "branco", description: "Papa, 1572" },

  # Maio
  { name: "São José Operário", celebration_type: :lesser_feast, rank: 221, fixed_month: 5, fixed_day: 1, liturgical_color: "branco", description: "Patrono dos Trabalhadores" },
  { name: "Santo Atanásio", celebration_type: :lesser_feast, rank: 222, fixed_month: 5, fixed_day: 2, liturgical_color: "branco", description: "Bispo e Doutor, 373" },
  { name: "Julian of Norwich", celebration_type: :lesser_feast, rank: 223, fixed_month: 5, fixed_day: 8, liturgical_color: "branco", description: "Mística, c. 1417" },
  { name: "São Matias, Apóstolo", celebration_type: :festival, rank: 32, fixed_month: 5, fixed_day: 14, liturgical_color: "vermelho", description: "Século I" },
  { name: "Beda, o Venerável", celebration_type: :lesser_feast, rank: 224, fixed_month: 5, fixed_day: 25, liturgical_color: "branco", description: "Sacerdote e Doutor, 735" },

  # Junho
  { name: "São Justino Mártir", celebration_type: :lesser_feast, rank: 225, fixed_month: 6, fixed_day: 1, liturgical_color: "vermelho", description: "Mártir, c. 165" },
  { name: "Os Mártires de Uganda", celebration_type: :lesser_feast, rank: 226, fixed_month: 6, fixed_day: 3, liturgical_color: "vermelho", description: "Carlos Lwanga e Companheiros, 1886" },
  { name: "São Bonifácio", celebration_type: :lesser_feast, rank: 227, fixed_month: 6, fixed_day: 5, liturgical_color: "vermelho", description: "Bispo e Mártir, 754" },
  { name: "Santo Efrém da Síria", celebration_type: :lesser_feast, rank: 228, fixed_month: 6, fixed_day: 9, liturgical_color: "branco", description: "Diácono e Doutor, 373" },
  { name: "São Columba", celebration_type: :lesser_feast, rank: 229, fixed_month: 6, fixed_day: 9, liturgical_color: "branco", description: "Abade e Missionário, 597" },
  { name: "Richard of Chichester", celebration_type: :lesser_feast, rank: 230, fixed_month: 6, fixed_day: 16, liturgical_color: "branco", description: "Bispo, 1253" },
  { name: "Santo Albano", celebration_type: :lesser_feast, rank: 231, fixed_month: 6, fixed_day: 22, liturgical_color: "vermelho", description: "Primeiro Mártir da Inglaterra, c. 304" },
  { name: "São Cirilo de Alexandria", celebration_type: :lesser_feast, rank: 232, fixed_month: 6, fixed_day: 27, liturgical_color: "branco", description: "Bispo e Doutor, 444" },
  { name: "Santo Ireneu", celebration_type: :lesser_feast, rank: 233, fixed_month: 6, fixed_day: 28, liturgical_color: "vermelho", description: "Bispo e Mártir, c. 202" },

  # Julho
  { name: "São Tomás", celebration_type: :festival, rank: 51, fixed_month: 7, fixed_day: 3, liturgical_color: "vermelho", description: "Apóstolo" },
  { name: "Santa Isabel de Portugal", celebration_type: :lesser_feast, rank: 234, fixed_month: 7, fixed_day: 4, liturgical_color: "branco", description: "1336" },
  { name: "São Boaventura", celebration_type: :lesser_feast, rank: 235, fixed_month: 7, fixed_day: 15, liturgical_color: "branco", description: "Bispo e Doutor, 1274" },
  { name: "Santa Maria Madalena", celebration_type: :festival, rank: 40, fixed_month: 7, fixed_day: 22, liturgical_color: "branco", description: "Apóstola dos Apóstolos" },
  { name: "Santa Brígida da Suécia", celebration_type: :lesser_feast, rank: 236, fixed_month: 7, fixed_day: 23, liturgical_color: "branco", description: "Religiosa, 1373" },
  { name: "São Charbel Makhlouf", celebration_type: :lesser_feast, rank: 237, fixed_month: 7, fixed_day: 24, liturgical_color: "branco", description: "Sacerdote, 1898" },
  { name: "Santa Ana e São Joaquim", celebration_type: :lesser_feast, rank: 238, fixed_month: 7, fixed_day: 26, liturgical_color: "branco", description: "Pais da Virgem Maria" },
  { name: "Santa Marta", celebration_type: :lesser_feast, rank: 239, fixed_month: 7, fixed_day: 29, liturgical_color: "branco", description: "Século I" },
  { name: "Santo Inácio de Loyola", celebration_type: :lesser_feast, rank: 240, fixed_month: 7, fixed_day: 31, liturgical_color: "branco", description: "Sacerdote e Fundador, 1556" },

  # Agosto
  { name: "Santo Afonso Liguori", celebration_type: :lesser_feast, rank: 241, fixed_month: 8, fixed_day: 1, liturgical_color: "branco", description: "Bispo e Doutor, 1787" },
  { name: "São João Maria Vianney", celebration_type: :lesser_feast, rank: 242, fixed_month: 8, fixed_day: 4, liturgical_color: "branco", description: "Sacerdote, 1859" },
  { name: "Transfiguração do Senhor", celebration_type: :principal_feast, rank: 10, fixed_month: 8, fixed_day: 6, liturgical_color: "branco", description: "" },
  { name: "São Domingos", celebration_type: :lesser_feast, rank: 243, fixed_month: 8, fixed_day: 8, liturgical_color: "branco", description: "Sacerdote e Fundador, 1221" },
  { name: "Santa Clara de Assis", celebration_type: :lesser_feast, rank: 244, fixed_month: 8, fixed_day: 11, liturgical_color: "branco", description: "Virgem e Fundadora, 1253" },
  { name: "Santa Joana Francisca de Chantal", celebration_type: :lesser_feast, rank: 245, fixed_month: 8, fixed_day: 12, liturgical_color: "branco", description: "Religiosa, 1641" },
  { name: "Santa Rosa de Lima", celebration_type: :lesser_feast, rank: 246, fixed_month: 8, fixed_day: 23, liturgical_color: "branco", description: "Virgem, 1617" },
  { name: "São Bartolomeu", celebration_type: :festival, rank: 43, fixed_month: 8, fixed_day: 24, liturgical_color: "vermelho", description: "Apóstolo" },
  { name: "Santa Tereza de Calcutá", celebration_type: :lesser_feast, rank: 247, fixed_month: 8, fixed_day: 5, liturgical_color: "branco", description: "Fundadora, 1997" },

  # Setembro
  { name: "São Gregório Magno", celebration_type: :lesser_feast, rank: 109, fixed_month: 9, fixed_day: 3, liturgical_color: "branco", description: "Papa e Doutor, 604" },
  { name: "Natividade da Bem-Aventurada Virgem Maria", celebration_type: :festival, rank: 248, fixed_month: 9, fixed_day: 8, liturgical_color: "branco", description: "" },
  { name: "São Pedro Claver", celebration_type: :lesser_feast, rank: 249, fixed_month: 9, fixed_day: 9, liturgical_color: "branco", description: "Sacerdote, 1654" },
  { name: "Santa Cruz", celebration_type: :festival, rank: 44, fixed_month: 9, fixed_day: 14, liturgical_color: "vermelho", description: "Exaltação da Santa Cruz" },
  { name: "São Roberto Belarmino", celebration_type: :lesser_feast, rank: 250, fixed_month: 9, fixed_day: 17, liturgical_color: "branco", description: "Bispo e Doutor, 1621" },
  { name: "São Mateus", celebration_type: :festival, rank: 45, fixed_month: 9, fixed_day: 21, liturgical_color: "vermelho", description: "Apóstolo e Evangelista" },
  { name: "São Pio de Pietrelcina", celebration_type: :lesser_feast, rank: 251, fixed_month: 9, fixed_day: 23, liturgical_color: "branco", description: "Sacerdote, 1968" },
  { name: "São Vicente de Paulo", celebration_type: :lesser_feast, rank: 252, fixed_month: 9, fixed_day: 27, liturgical_color: "branco", description: "Sacerdote e Fundador, 1660" },
  { name: "São Miguel, Gabriel e Rafael, Arcanjos", celebration_type: :festival, rank: 46, fixed_month: 9, fixed_day: 29, liturgical_color: "branco", description: "Arcanjos" },

  # Outubro
  { name: "Santa Teresinha do Menino Jesus", celebration_type: :lesser_feast, rank: 253, fixed_month: 10, fixed_day: 1, liturgical_color: "branco", description: "Virgem e Doutora, 1897" },
  { name: "Os Santos Anjos da Guarda", celebration_type: :lesser_feast, rank: 254, fixed_month: 10, fixed_day: 2, liturgical_color: "branco", description: "" },
  { name: "São Francisco de Assis", celebration_type: :lesser_feast, rank: 105, fixed_month: 10, fixed_day: 4, liturgical_color: "branco", description: "Frade e Fundador, 1226" },
  { name: "São Bruno", celebration_type: :lesser_feast, rank: 255, fixed_month: 10, fixed_day: 6, liturgical_color: "branco", description: "Sacerdote e Fundador, 1101" },
  { name: "São João Leonardi", celebration_type: :lesser_feast, rank: 256, fixed_month: 10, fixed_day: 9, liturgical_color: "branco", description: "Sacerdote, 1609" },
  { name: "São Calisto I", celebration_type: :lesser_feast, rank: 257, fixed_month: 10, fixed_day: 14, liturgical_color: "vermelho", description: "Papa e Mártir, 222" },
  { name: "Santo Inácio de Antioquia", celebration_type: :lesser_feast, rank: 117, fixed_month: 10, fixed_day: 17, liturgical_color: "vermelho", description: "Bispo e Mártir, c. 107" },
  { name: "São Lucas", celebration_type: :festival, rank: 47, fixed_month: 10, fixed_day: 18, liturgical_color: "vermelho", description: "Evangelista" },
  { name: "São Paulo da Cruz", celebration_type: :lesser_feast, rank: 258, fixed_month: 10, fixed_day: 19, liturgical_color: "branco", description: "Sacerdote, 1775" },
  { name: "São João de Capistrano", celebration_type: :lesser_feast, rank: 259, fixed_month: 10, fixed_day: 23, liturgical_color: "branco", description: "Sacerdote, 1456" },
  { name: "Santo Antônio Maria Claret", celebration_type: :lesser_feast, rank: 260, fixed_month: 10, fixed_day: 24, liturgical_color: "branco", description: "Bispo, 1870" },
  { name: "Simão e Judas", celebration_type: :festival, rank: 49, fixed_month: 10, fixed_day: 28, liturgical_color: "vermelho", description: "Apóstolos" },

  # Novembro
  { name: "Todos os Santos", celebration_type: :principal_feast, rank: 11, fixed_month: 11, fixed_day: 1, liturgical_color: "branco", description: "" },
  { name: "Todas as Almas", celebration_type: :lesser_feast, rank: 261, fixed_month: 11, fixed_day: 2, liturgical_color: "roxo", description: "Comemoração dos Fiéis Defuntos" },
  { name: "São Martinho de Lima", celebration_type: :lesser_feast, rank: 262, fixed_month: 11, fixed_day: 3, liturgical_color: "branco", description: "Religioso, 1639" },
  { name: "São Carlos Borromeu", celebration_type: :lesser_feast, rank: 263, fixed_month: 11, fixed_day: 4, liturgical_color: "branco", description: "Bispo, 1584" },
  { name: "São Leão Magno", celebration_type: :lesser_feast, rank: 264, fixed_month: 11, fixed_day: 10, liturgical_color: "branco", description: "Papa e Doutor, 461" },
  { name: "São Martinho de Tours", celebration_type: :lesser_feast, rank: 118, fixed_month: 11, fixed_day: 11, liturgical_color: "branco", description: "Bispo, 397" },
  { name: "São Josafá", celebration_type: :lesser_feast, rank: 265, fixed_month: 11, fixed_day: 12, liturgical_color: "vermelho", description: "Bispo e Mártir, 1623" },
  { name: "Santa Isabel da Hungria", celebration_type: :lesser_feast, rank: 266, fixed_month: 11, fixed_day: 17, liturgical_color: "branco", description: "Religiosa, 1231" },
  { name: "São Clemente I", celebration_type: :lesser_feast, rank: 267, fixed_month: 11, fixed_day: 23, liturgical_color: "vermelho", description: "Papa e Mártir, 101" },
  { name: "Santa Catarina de Alexandria", celebration_type: :lesser_feast, rank: 119, fixed_month: 11, fixed_day: 25, liturgical_color: "vermelho", description: "Mártir, c. 305" },
  { name: "Santo André", celebration_type: :festival, rank: 50, fixed_month: 11, fixed_day: 30, liturgical_color: "vermelho", description: "Apóstolo" },

  # Dezembro
  { name: "Santo Ambrósio", celebration_type: :lesser_feast, rank: 101, fixed_month: 12, fixed_day: 7, liturgical_color: "branco", description: "Bispo e Doutor, 397" },
  { name: "Imaculada Conceição", celebration_type: :festival, rank: 268, fixed_month: 12, fixed_day: 8, liturgical_color: "branco", description: "" },
  { name: "São João Damasceno", celebration_type: :lesser_feast, rank: 269, fixed_month: 12, fixed_day: 4, liturgical_color: "branco", description: "Sacerdote e Doutor, 749" },
  { name: "Nossa Senhora de Guadalupe", celebration_type: :lesser_feast, rank: 270, fixed_month: 12, fixed_day: 12, liturgical_color: "branco", description: "1531" },
  { name: "Santa Lúcia", celebration_type: :lesser_feast, rank: 108, fixed_month: 12, fixed_day: 13, liturgical_color: "vermelho", description: "Mártir, 304" },
  { name: "São João da Cruz", celebration_type: :lesser_feast, rank: 271, fixed_month: 12, fixed_day: 14, liturgical_color: "branco", description: "Sacerdote e Doutor, 1591" },
  { name: "São Pedro Canísio", celebration_type: :lesser_feast, rank: 272, fixed_month: 12, fixed_day: 21, liturgical_color: "branco", description: "Sacerdote e Doutor, 1597" },
  { name: "São Tomé", celebration_type: :festival, rank: 51, fixed_month: 12, fixed_day: 21, liturgical_color: "vermelho", description: "Apóstolo" },
  { name: "Santo Estêvão", celebration_type: :festival, rank: 52, fixed_month: 12, fixed_day: 26, liturgical_color: "vermelho", description: "Diácono e Protomártir" },
  { name: "São João", celebration_type: :festival, rank: 53, fixed_month: 12, fixed_day: 27, liturgical_color: "branco", description: "Apóstolo e Evangelista" },
  { name: "Santos Inocentes", celebration_type: :festival, rank: 54, fixed_month: 12, fixed_day: 28, liturgical_color: "vermelho", description: "Mártires" },
  { name: "São Tomás Becket", celebration_type: :lesser_feast, rank: 273, fixed_month: 12, fixed_day: 29, liturgical_color: "vermelho", description: "Bispo e Mártir, 1170" },
  { name: "São Silvestre I", celebration_type: :lesser_feast, rank: 274, fixed_month: 12, fixed_day: 31, liturgical_color: "branco", description: "Papa, 335" }
]

# Criar santos adicionais
count = 0
additional_saints.each do |saint|
  # Verifica se já existe para evitar duplicatas
  unless Celebration.exists?(name: saint[:name], fixed_month: saint[:fixed_month], fixed_day: saint[:fixed_day])
    Celebration.create!(saint.merge(movable: false, can_be_transferred: false))
    count += 1
    print "." if count % 10 == 0
  end
end

puts "\n✅ #{count} santos adicionais criados com sucesso!"
puts "📊 Total de santos no banco: #{Celebration.count}"
