# ================================================================================
# COMEMORAÇÕES - LOCB 2008 (Dias de Observância Opcional)
# Santos, mártires, reformadores, datas históricas
# Organizadas por mês
# ================================================================================

Rails.logger.info "📅 Criando Comemorações - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

commemorations = [
  # ================================================================================
  # JANEIRO
  # ================================================================================
  { name: "Dia Mundial da Paz", fixed_month: 1, fixed_day: 1, description: "Dia Mundial da Paz" },
  { name: "Primeira Confissão de Fé Reformada das Américas", fixed_month: 1, fixed_day: 5, description: "Rio de Janeiro, 1558" },
  { name: "Dia da Liberdade de Culto no Brasil", fixed_month: 1, fixed_day: 7, description: "1890" },
  { name: "Batismo de nosso Senhor Jesus Cristo", fixed_month: 1, fixed_day: 9, description: "Ou no 1º Domingo após a Epifania", movable: true, calculation_rule: "first_sunday_after_epiphany" },
  { name: "William Laud", fixed_month: 1, fixed_day: 10, description: "Arcebispo de Cantuária, 1645" },
  { name: "Dia dos Trinta e Nove Artigos de Religião", fixed_month: 1, fixed_day: 10, description: "1562" },
  { name: "Hilário", fixed_month: 1, fixed_day: 13, description: "Bispo de Poitiers, 367" },
  { name: "Antão", fixed_month: 1, fixed_day: 17, description: "Abade do Egito, 356" },
  { name: "Confissão do apóstolo Pedro", fixed_month: 1, fixed_day: 18, description: "Confissão de São Pedro" },
  { name: "Fabiano", fixed_month: 1, fixed_day: 20, description: "Bispo de Roma e mártir, 250" },
  { name: "Inês", fixed_month: 1, fixed_day: 21, description: "Mártir em Roma, 304" },
  { name: "Vicente", fixed_month: 1, fixed_day: 22, description: "Diácono de Saragoça e mártir, 304" },
  { name: "Conversão do apóstolo Paulo", fixed_month: 1, fixed_day: 25, description: "Conversão de São Paulo" },
  { name: "Timóteo e Tito", fixed_month: 1, fixed_day: 26, description: "Companheiros do apóstolo Paulo" },
  { name: "João Crisóstomo", fixed_month: 1, fixed_day: 27, description: "Bispo de Constantinopla, 407" },
  { name: "Tomás de Aquino", fixed_month: 1, fixed_day: 28, description: "Presbítero e frade, 1274" },
  { name: "Lídia, Dorcas e Febe", fixed_month: 1, fixed_day: 29, description: "Cooperadoras dos apóstolos" },

  # ================================================================================
  # FEVEREIRO
  # ================================================================================
  { name: "Brígida", fixed_month: 2, fixed_day: 1, description: "Abadessa de Kildare, 523" },
  { name: "Brás", fixed_month: 2, fixed_day: 3, description: "Bispo de Sebaste, Armênia, e mártir, século IV" },
  { name: "Cornélio, o centurião", fixed_month: 2, fixed_day: 4, description: "Centurião convertido" },
  { name: "Os mártires do Japão", fixed_month: 2, fixed_day: 5, description: "1597" },
  { name: "Martírio de John Hooper", fixed_month: 2, fixed_day: 9, description: "Bispo de Worcester e Glaucester, colaborador do Livro de Oração Comum, 1555" },
  { name: "Martírio dos reformados franceses Jean de Bourdel, Mathieu Verneuil e Pierre de Bourdon", fixed_month: 2, fixed_day: 9, description: "Baía de Guanabara, 1558" },
  { name: "Escolástica", fixed_month: 2, fixed_day: 10, description: "Irmã de Bento de Núrsia, 547" },
  { name: "Cirilo e Metódio", fixed_month: 2, fixed_day: 14, description: "Monge, 869, e Bispo, 885, missionários entre os eslavos" },
  { name: "Policarpo", fixed_month: 2, fixed_day: 23, description: "Bispo de Esmirna e mártir, 156" },

  # ================================================================================
  # MARÇO
  # ================================================================================
  { name: "Davi", fixed_month: 3, fixed_day: 1, description: "Bispo de Menevia, Gália, 544" },
  { name: "Chad", fixed_month: 3, fixed_day: 2, description: "Bispo de Lichfield, 672" },
  { name: "João e Carlos Wesley", fixed_month: 3, fixed_day: 3, description: "Presbíteros, 1791, 1788" },
  { name: "Perpétua, Felicidade e seus companheiros", fixed_month: 3, fixed_day: 7, description: "Mártires em Cartago, 203" },
  { name: "Fundação da Sociedade Bíblica Britânica e Estrangeira", fixed_month: 3, fixed_day: 7, description: "1804" },
  { name: "Dia Internacional da Mulher", fixed_month: 3, fixed_day: 8, description: "Dia Internacional da Mulher" },
  { name: "Gregório", fixed_month: 3, fixed_day: 9, description: "Bispo de Nissa, 394" },
  { name: "Celebração do Primeiro Culto Protestante no Brasil", fixed_month: 3, fixed_day: 10, description: "Rev. Pierre Richier, calvinista francês, Rio de Janeiro, 1557" },
  { name: "Gregório Magno", fixed_month: 3, fixed_day: 12, description: "Bispo de Roma, 604" },
  { name: "Patrício", fixed_month: 3, fixed_day: 17, description: "Bispo e missionário da Irlanda, 461" },
  { name: "Cirilo", fixed_month: 3, fixed_day: 18, description: "Bispo de Jerusalém, 386" },
  { name: "Cuthbert", fixed_month: 3, fixed_day: 20, description: "Bispo e missionário de Lindisfarne, 687" },
  { name: "Thomas Cranmer", fixed_month: 3, fixed_day: 21, description: "Arcebispo de Cantuária, 1556" },
  { name: "Jonathan Edwards", fixed_month: 3, fixed_day: 24, description: "Missionário na Nova Inglaterra, 1758" },
  { name: "Dia do Episcopado", fixed_month: 3, fixed_day: 30, description: "Dia do Episcopado" },

  # ================================================================================
  # ABRIL
  # ================================================================================
  { name: "Isidoro", fixed_month: 4, fixed_day: 4, description: "Bispo de Sevilha, 636" },
  { name: "O Concílio de Trento decreta como Canônicos os Livros Apócrifos", fixed_month: 4, fixed_day: 8, description: "1546" },
  { name: "Dietrich Bonhoeffer", fixed_month: 4, fixed_day: 10, description: "Teólogo e mártir na Alemanha, 1945" },
  { name: "Felipe Melanchthon", fixed_month: 4, fixed_day: 19, description: "1560" },
  { name: "Dia do Índio", fixed_month: 4, fixed_day: 19, description: "Dia do Índio" },
  { name: "Origem do termo 'Protestante'", fixed_month: 4, fixed_day: 20, description: "1529" },
  { name: "Anselmo", fixed_month: 4, fixed_day: 21, description: "Arcebispo de Cantuária, 1109" },
  { name: "Descobrimento do Brasil", fixed_month: 4, fixed_day: 22, description: "1500, Dia da Comunidade Luso-Brasileira, 1967" },
  { name: "Jorge", fixed_month: 4, fixed_day: 23, description: "Mártir, século IV" },
  { name: "Marcos, evangelista", fixed_month: 4, fixed_day: 25, description: "Marcos, evangelista" },

  # ================================================================================
  # MAIO
  # ================================================================================
  { name: "Felipe e Tiago, apóstolos", fixed_month: 5, fixed_day: 1, description: "Dia do Trabalho" },
  { name: "Atanásio", fixed_month: 5, fixed_day: 2, description: "Bispo de Alexandria, 373" },
  { name: "Mônica", fixed_month: 5, fixed_day: 4, description: "Mãe de Agostinho de Hipona, 387" },
  { name: "Gregório Nazianzeno", fixed_month: 5, fixed_day: 9, description: "Bispo de Constantinopla, 389" },
  { name: "Simão de Cirene", fixed_month: 5, fixed_day: 12, description: "O que ajudou o Senhor a carregar a cruz" },
  { name: "Abolição da Escravatura no Brasil", fixed_month: 5, fixed_day: 13, description: "1888" },
  { name: "São Matias, Apóstolo", fixed_month: 5, fixed_day: 14, description: "Matias, apóstolo" },
  { name: "Dia Internacional da Família", fixed_month: 5, fixed_day: 15, description: "Dia Internacional da Família" },
  { name: "Brendan", fixed_month: 5, fixed_day: 16, description: "Missionário na Irlanda, 577" },
  { name: "Alcuíno de York", fixed_month: 5, fixed_day: 20, description: "Abade de Tours, 804" },
  { name: "Criação da Diocese do Recife", fixed_month: 5, fixed_day: 20, description: "1976" },
  { name: "Beda, o venerável", fixed_month: 5, fixed_day: 25, description: "Presbítero e monge, 735" },
  { name: "Agostinho", fixed_month: 5, fixed_day: 26, description: "Primeiro arcebispo de Cantuária, 605" },
  { name: "João Calvino", fixed_month: 5, fixed_day: 27, description: "1564" },
  { name: "Jerônimo de Praga", fixed_month: 5, fixed_day: 30, description: "Reformador da Igreja da Boêmia, 1430" },

  # ================================================================================
  # JUNHO
  # ================================================================================
  { name: "Justino", fixed_month: 6, fixed_day: 1, description: "Mártir em Roma, 167" },
  { name: "James Watson Morris", fixed_month: 6, fixed_day: 2, description: "Pioneiro anglicano no Brasil, m. 31/3/1954" },
  { name: "Lucien Lee Kinsolving", fixed_month: 6, fixed_day: 3, description: "Pioneiro anglicano no Brasil, bispo, m. 18/12/1929" },
  { name: "Bonifácio", fixed_month: 6, fixed_day: 5, description: "Bispo missionário na Alemanha e mártir, 754" },
  { name: "Dia Internacional do Meio Ambiente", fixed_month: 6, fixed_day: 5, description: "Dia Internacional do Meio Ambiente" },
  { name: "Norberto", fixed_month: 6, fixed_day: 6, description: "Bispo de Magdeburgo, Alemanha, 1134" },
  { name: "Columba", fixed_month: 6, fixed_day: 9, description: "Abade de Iona, 597" },
  { name: "Primeira Edição do Livro de Oração Comum (LOC)", fixed_month: 6, fixed_day: 9, description: "1549" },
  { name: "Efrém", fixed_month: 6, fixed_day: 10, description: "Diácono de Edessa, na Síria, 373" },
  { name: "Barnabé, apóstolo", fixed_month: 6, fixed_day: 11, description: "Barnabé, apóstolo" },
  { name: "Basílio Magno", fixed_month: 6, fixed_day: 14, description: "Bispo de Cesaréia, 379" },
  { name: "Excomunhão de Martinho Lutero", fixed_month: 6, fixed_day: 16, description: "1520" },
  { name: "Romualdo", fixed_month: 6, fixed_day: 19, description: "Abade, 1027" },
  { name: "Albano", fixed_month: 6, fixed_day: 22, description: "Primeiro mártir da Grã-Bretanha, 304" },
  { name: "Natividade de João Batista", fixed_month: 6, fixed_day: 24, description: "Natividade de São João Batista" },
  { name: "Confissão de Augsburgo", fixed_month: 6, fixed_day: 25, description: "1530" },
  { name: "Cirilo", fixed_month: 6, fixed_day: 27, description: "Bispo de Alexandria, 444" },
  { name: "Irineu", fixed_month: 6, fixed_day: 28, description: "Bispo de Lion, 202" },
  { name: "Sagração de Egmont Machado Krischke", fixed_month: 6, fixed_day: 28, description: "Primeiro Primaz Anglicano do Brasil, 1971" },
  { name: "Pedro e Paulo, apóstolos", fixed_month: 6, fixed_day: 29, description: "Pedro e Paulo, apóstolos" },

  # ================================================================================
  # JULHO
  # ================================================================================
  { name: "São Tomé, apóstolo", fixed_month: 7, fixed_day: 3, description: "Tomé, apóstolo" },
  { name: "João Huss", fixed_month: 7, fixed_day: 6, description: "Precursor da Reforma, 1415" },
  { name: "Áquila e Priscila", fixed_month: 7, fixed_day: 8, description: "Cooperadores do apóstolo Paulo" },
  { name: "Bento de Núrsia", fixed_month: 7, fixed_day: 11, description: "Abade de Montecassino, 540" },
  { name: "Silas", fixed_month: 7, fixed_day: 13, description: "Companheiro do apóstolo Paulo" },
  { name: "Richard Holden", fixed_month: 7, fixed_day: 17, description: "Tradutor do primeiro Livro de Oração Comum em português, 1876" },
  { name: "Maria Madalena", fixed_month: 7, fixed_day: 22, description: "Maria Madalena" },
  { name: "Thomas a Kempis", fixed_month: 7, fixed_day: 24, description: "Presbítero, 1471" },
  { name: "Tiago, apóstolo", fixed_month: 7, fixed_day: 25, description: "Tiago, apóstolo" },
  { name: "Marta, Maria e Lázaro de Betânia", fixed_month: 7, fixed_day: 29, description: "Amigos de Jesus" },
  { name: "Pedro Crisólogo", fixed_month: 7, fixed_day: 30, description: "Bispo de Ravena, Itália, 450" },
  { name: "José de Arimatéia", fixed_month: 7, fixed_day: 31, description: "Discípulo de Jesus" },

  # ================================================================================
  # AGOSTO
  # ================================================================================
  { name: "Eusébio", fixed_month: 8, fixed_day: 2, description: "Bispo de Vercelli, 371" },
  { name: "Nicodemos", fixed_month: 8, fixed_day: 3, description: "Discípulo de Jesus" },
  { name: "Oswald de Nortúmbria", fixed_month: 8, fixed_day: 5, description: "Mártir, 642" },
  { name: "João Ferreira de Almeida", fixed_month: 8, fixed_day: 6, description: "Primeiro tradutor protestante da Bíblia em português, 1691" },
  { name: "Sisto", fixed_month: 8, fixed_day: 7, description: "Bispo de Roma, e seus companheiros, mártires, 258" },
  { name: "Domingos", fixed_month: 8, fixed_day: 8, description: "Presbítero e frade, 1221" },
  { name: "Lourenço", fixed_month: 8, fixed_day: 10, description: "Diácono e mártir em Roma, 258" },
  { name: "Destruição de Jerusalém", fixed_month: 8, fixed_day: 10, description: "70 d.C." },
  { name: "Hipólito e Ponciano", fixed_month: 8, fixed_day: 12, description: "Bispos e mártires, 235" },
  { name: "Dia da Escola Bíblica Dominical", fixed_month: 8, fixed_day: 19, description: "Dia da Escola Bíblica Dominical" },
  { name: "Publicação das Institutas da Religião Cristã", fixed_month: 8, fixed_day: 23, description: "João Calvino, 1535" },
  { name: "Bartolomeu, apóstolo", fixed_month: 8, fixed_day: 24, description: "Bartolomeu, apóstolo" },
  { name: "Agostinho", fixed_month: 8, fixed_day: 28, description: "Bispo de Hipona, 430" },
  { name: "Aidan", fixed_month: 8, fixed_day: 31, description: "Abade e bispo de Lindisfarne, 651" },

  # ================================================================================
  # SETEMBRO
  # ================================================================================
  { name: "Mártires da Nova Guiné", fixed_month: 9, fixed_day: 2, description: "1942" },
  { name: "Dia da Pátria (Independência do Brasil)", fixed_month: 9, fixed_day: 7, description: "Independência do Brasil" },
  { name: "Cipriano", fixed_month: 9, fixed_day: 13, description: "Bispo e mártir de Cartago, 258" },
  { name: "Ninian", fixed_month: 9, fixed_day: 16, description: "Bispo missionário na Escócia, 430" },
  { name: "Teodoro de Tarso", fixed_month: 9, fixed_day: 19, description: "Arcebispo de Cantuária, 690" },
  { name: "John Coleridge Patteson", fixed_month: 9, fixed_day: 20, description: "Bispo da Melanésia, e seus companheiros, mártires, 1871" },
  { name: "Mateus, apóstolo e evangelista", fixed_month: 9, fixed_day: 21, description: "Mateus, apóstolo e evangelista" },
  { name: "Sérgio", fixed_month: 9, fixed_day: 25, description: "Abade da SS. Trindade, Moscou, 1392" },
  { name: "Jerônimo", fixed_month: 9, fixed_day: 30, description: "Presbítero e monge em Belém, 420" },

  # ================================================================================
  # OUTUBRO
  # ================================================================================
  { name: "Francisco de Assis", fixed_month: 10, fixed_day: 4, description: "Frade, 1226" },
  { name: "William Tyndale", fixed_month: 10, fixed_day: 6, description: "Presbítero e mártir, 1536" },
  { name: "Thomas More", fixed_month: 10, fixed_day: 6, description: "Mártir, 1535" },
  { name: "John Fisher", fixed_month: 10, fixed_day: 6, description: "Bispo e mártir, 1535" },
  { name: "Dionísio", fixed_month: 10, fixed_day: 9, description: "Primeiro bispo de Paris, e seus companheiros, mártires, século III" },
  { name: "Paulino", fixed_month: 10, fixed_day: 10, description: "Primeiro arcebispo de York, 644" },
  { name: "Felipe, diácono e evangelista", fixed_month: 10, fixed_day: 11, description: "Felipe, diácono e evangelista" },
  { name: "Huldereich Zwinglio", fixed_month: 10, fixed_day: 11, description: "Presbítero e reformador suíço, 1531" },
  { name: "Wilfrido", fixed_month: 10, fixed_day: 12, description: "Arcebispo de York, 709" },
  { name: "Hugh Latimer e Nicolas Ridley", fixed_month: 10, fixed_day: 16, description: "Bispos e mártires, 1555" },
  { name: "Inácio", fixed_month: 10, fixed_day: 17, description: "Bispo de Antioquia e mártir, 107" },
  { name: "Lucas, evangelista", fixed_month: 10, fixed_day: 18, description: "Lucas, evangelista" },
  { name: "Simão e Judas, apóstolos", fixed_month: 10, fixed_day: 28, description: "Simão e Judas, apóstolos" },
  { name: "Reforma Protestante", fixed_month: 10, fixed_day: 31, description: "1517" },

  # ================================================================================
  # NOVEMBRO
  # ================================================================================
  { name: "Fiéis falecidos", fixed_month: 11, fixed_day: 2, description: "Comemoração dos fiéis falecidos" },
  { name: "Illtyd", fixed_month: 11, fixed_day: 6, description: "Abade de Glamorgan, século V" },
  { name: "Martinho Lutero", fixed_month: 11, fixed_day: 11, description: "Nascido em 1483" },
  { name: "Martinho", fixed_month: 11, fixed_day: 11, description: "Bispo de Tours, 397" },
  { name: "Hilda", fixed_month: 11, fixed_day: 18, description: "Abadessa de Whitby, 680" },
  { name: "Clemente", fixed_month: 11, fixed_day: 23, description: "Bispo de Roma, 100, e Columbano, abade de Bóbio, Itália, 615" },
  { name: "André, apóstolo", fixed_month: 11, fixed_day: 30, description: "André, apóstolo" },

  # ================================================================================
  # DEZEMBRO
  # ================================================================================
  { name: "João Damasceno", fixed_month: 12, fixed_day: 4, description: "Presbítero, 760" },
  { name: "Confissão de Westminster", fixed_month: 12, fixed_day: 4, description: "1646" },
  { name: "Clemente de Alexandria", fixed_month: 12, fixed_day: 5, description: "Presbítero, 210" },
  { name: "Nicolau de Mira", fixed_month: 12, fixed_day: 6, description: "Turquia, 342" },
  { name: "Ambrósio", fixed_month: 12, fixed_day: 7, description: "Bispo de Milão, 397" },
  { name: "João da Cruz", fixed_month: 12, fixed_day: 14, description: "Monge, 1591" },
  { name: "Estevão", fixed_month: 12, fixed_day: 26, description: "Diácono e mártir" },
  { name: "João, apóstolo e evangelista", fixed_month: 12, fixed_day: 27, description: "João, apóstolo e evangelista" },
  { name: "Thomas Becket", fixed_month: 12, fixed_day: 29, description: "Arcebispo de Cantuária e mártir, 1170" },
  { name: "Silvestre", fixed_month: 12, fixed_day: 31, description: "Bispo de Roma, 335" },
  { name: "John Wycliff", fixed_month: 12, fixed_day: 31, description: "Precursor da Reforma, 1384" }
]

commemorations.each do |comm|
  data = {
    name: comm[:name],
    celebration_type: :commemoration,
    rank: 100,
    fixed_month: comm[:fixed_month],
    fixed_day: comm[:fixed_day],
    movable: comm[:movable] || false,
    calculation_rule: comm[:calculation_rule],
    liturgical_color: "branco",
    can_be_transferred: false,
    description: comm[:description],
    prayer_book_id: prayer_book&.id
  }

  Celebration.create!(data)
  Rails.logger.info "  ✓ #{comm[:fixed_month]}/#{comm[:fixed_day]} - #{comm[:name]}"
end

Rails.logger.info "  📅 Total: #{commemorations.count} comemorações criadas"
