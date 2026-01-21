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
  { name: "Dia Mundial da Paz", fixed_month: 1, fixed_day: 1, description: "Dia Mundial da Paz", person_type: "event", gender: "neutral" },
  { name: "Primeira Confissão de Fé Reformada das Américas", fixed_month: 1, fixed_day: 5, description: "Rio de Janeiro, 1558", person_type: "event", gender: "neutral" },
  { name: "Dia da Liberdade de Culto no Brasil", fixed_month: 1, fixed_day: 7, description: "1890", person_type: "event", gender: "neutral" },
  { name: "Batismo de nosso Senhor Jesus Cristo", fixed_month: 1, fixed_day: 9, description: "Ou no 1º Domingo após a Epifania", movable: true, calculation_rule: "first_sunday_after_epiphany", person_type: "event", gender: "neutral" },
  { name: "William Laud", fixed_month: 1, fixed_day: 10, description: "Arcebispo de Cantuária, 1645", person_type: "singular", gender: "masculine" },
  { name: "Dia dos Trinta e Nove Artigos de Religião", fixed_month: 1, fixed_day: 10, description: "1562", person_type: "event", gender: "neutral" },
  { name: "Hilário", fixed_month: 1, fixed_day: 13, description: "Bispo de Poitiers, 367", person_type: "singular", gender: "masculine" },
  { name: "Antão", fixed_month: 1, fixed_day: 17, description: "Abade do Egito, 356", person_type: "singular", gender: "masculine" },
  { name: "Confissão do apóstolo Pedro", fixed_month: 1, fixed_day: 18, description: "Confissão de São Pedro", person_type: "event", gender: "neutral" },
  { name: "Fabiano", fixed_month: 1, fixed_day: 20, description: "Bispo de Roma e mártir, 250", person_type: "singular", gender: "masculine" },
  { name: "Inês", fixed_month: 1, fixed_day: 21, description: "Mártir em Roma, 304", person_type: "singular", gender: "feminine" },
  { name: "Vicente", fixed_month: 1, fixed_day: 22, description: "Diácono de Saragoça e mártir, 304", person_type: "singular", gender: "masculine" },
  { name: "Conversão do apóstolo Paulo", fixed_month: 1, fixed_day: 25, description: "Conversão de São Paulo", person_type: "event", gender: "neutral" },
  { name: "Timóteo e Tito", fixed_month: 1, fixed_day: 26, description: "Companheiros do apóstolo Paulo", person_type: "plural", gender: "masculine" },
  { name: "João Crisóstomo", fixed_month: 1, fixed_day: 27, description: "Bispo de Constantinopla, 407", person_type: "singular", gender: "masculine" },
  { name: "Tomás de Aquino", fixed_month: 1, fixed_day: 28, description: "Presbítero e frade, 1274", person_type: "singular", gender: "masculine" },
  { name: "Lídia, Dorcas e Febe", fixed_month: 1, fixed_day: 29, description: "Cooperadoras dos apóstolos", person_type: "plural", gender: "feminine" },

  # ================================================================================
  # FEVEREIRO
  # ================================================================================
  { name: "Brígida", fixed_month: 2, fixed_day: 1, description: "Abadessa de Kildare, 523", person_type: "singular", gender: "feminine" },
  { name: "Brás", fixed_month: 2, fixed_day: 3, description: "Bispo de Sebaste, Armênia, e mártir, século IV", person_type: "singular", gender: "masculine" },
  { name: "Cornélio, o centurião", fixed_month: 2, fixed_day: 4, description: "Centurião convertido", person_type: "singular", gender: "masculine" },
  { name: "Os mártires do Japão", fixed_month: 2, fixed_day: 5, description: "1597", person_type: "plural", gender: "masculine" },
  { name: "Martírio de John Hooper", fixed_month: 2, fixed_day: 9, description: "Bispo de Worcester e Glaucester, colaborador do Livro de Oração Comum, 1555", person_type: "event", gender: "neutral" },
  { name: "Martírio dos reformados franceses Jean de Bourdel, Mathieu Verneuil e Pierre de Bourdon", fixed_month: 2, fixed_day: 9, description: "Baía de Guanabara, 1558", person_type: "event", gender: "neutral" },
  { name: "Escolástica", fixed_month: 2, fixed_day: 10, description: "Irmã de Bento de Núrsia, 547", person_type: "singular", gender: "feminine" },
  { name: "Cirilo e Metódio", fixed_month: 2, fixed_day: 14, description: "Monge, 869, e Bispo, 885, missionários entre os eslavos", person_type: "plural", gender: "masculine" },
  { name: "Policarpo", fixed_month: 2, fixed_day: 23, description: "Bispo de Esmirna e mártir, 156", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # MARÇO
  # ================================================================================
  { name: "Davi", fixed_month: 3, fixed_day: 1, description: "Bispo de Menevia, Gália, 544", person_type: "singular", gender: "masculine" },
  { name: "Chad", fixed_month: 3, fixed_day: 2, description: "Bispo de Lichfield, 672", person_type: "singular", gender: "masculine" },
  { name: "João e Carlos Wesley", fixed_month: 3, fixed_day: 3, description: "Presbíteros, 1791, 1788", person_type: "plural", gender: "masculine" },
  { name: "Perpétua, Felicidade e seus companheiros", fixed_month: 3, fixed_day: 7, description: "Mártires em Cartago, 203", person_type: "plural", gender: "mixed" },
  { name: "Fundação da Sociedade Bíblica Britânica e Estrangeira", fixed_month: 3, fixed_day: 7, description: "1804", person_type: "event", gender: "neutral" },
  { name: "Dia Internacional da Mulher", fixed_month: 3, fixed_day: 8, description: "Dia Internacional da Mulher", person_type: "event", gender: "neutral" },
  { name: "Gregório", fixed_month: 3, fixed_day: 9, description: "Bispo de Nissa, 394", person_type: "singular", gender: "masculine" },
  { name: "Celebração do Primeiro Culto Protestante no Brasil", fixed_month: 3, fixed_day: 10, description: "Rev. Pierre Richier, calvinista francês, Rio de Janeiro, 1557", person_type: "event", gender: "neutral" },
  { name: "Gregório Magno", fixed_month: 3, fixed_day: 12, description: "Bispo de Roma, 604", person_type: "singular", gender: "masculine" },
  { name: "Patrício", fixed_month: 3, fixed_day: 17, description: "Bispo e missionário da Irlanda, 461", person_type: "singular", gender: "masculine" },
  { name: "Cirilo de Jerusalém", fixed_month: 3, fixed_day: 18, description: "Bispo de Jerusalém, 386", person_type: "singular", gender: "masculine" },
  { name: "Cuthbert", fixed_month: 3, fixed_day: 20, description: "Bispo e missionário de Lindisfarne, 687", person_type: "singular", gender: "masculine" },
  { name: "Thomas Cranmer", fixed_month: 3, fixed_day: 21, description: "Arcebispo de Cantuária, 1556", person_type: "singular", gender: "masculine" },
  { name: "Jonathan Edwards", fixed_month: 3, fixed_day: 24, description: "Missionário na Nova Inglaterra, 1758", person_type: "singular", gender: "masculine" },
  { name: "Dia do Episcopado", fixed_month: 3, fixed_day: 30, description: "Dia do Episcopado", person_type: "event", gender: "neutral" },

  # ================================================================================
  # ABRIL
  # ================================================================================
  { name: "Isidoro", fixed_month: 4, fixed_day: 4, description: "Bispo de Sevilha, 636", person_type: "singular", gender: "masculine" },
  { name: "O Concílio de Trento decreta como Canônicos os Livros Apócrifos", fixed_month: 4, fixed_day: 8, description: "1546", person_type: "event", gender: "neutral" },
  { name: "Dietrich Bonhoeffer", fixed_month: 4, fixed_day: 10, description: "Teólogo e mártir na Alemanha, 1945", person_type: "singular", gender: "masculine" },
  { name: "Felipe Melanchthon", fixed_month: 4, fixed_day: 19, description: "1560", person_type: "singular", gender: "masculine" },
  { name: "Dia do Índio", fixed_month: 4, fixed_day: 19, description: "Dia do Índio", person_type: "event", gender: "neutral" },
  { name: "Origem do termo 'Protestante'", fixed_month: 4, fixed_day: 20, description: "1529", person_type: "event", gender: "neutral" },
  { name: "Anselmo", fixed_month: 4, fixed_day: 21, description: "Arcebispo de Cantuária, 1109", person_type: "singular", gender: "masculine" },
  { name: "Descobrimento do Brasil", fixed_month: 4, fixed_day: 22, description: "1500, Dia da Comunidade Luso-Brasileira, 1967", person_type: "event", gender: "neutral" },
  { name: "Jorge", fixed_month: 4, fixed_day: 23, description: "Mártir, século IV", person_type: "singular", gender: "masculine" },
  { name: "Marcos, evangelista", fixed_month: 4, fixed_day: 25, description: "Marcos, evangelista", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # MAIO
  # ================================================================================
  { name: "Felipe e Tiago, apóstolos", fixed_month: 5, fixed_day: 1, description: "Dia do Trabalho", person_type: "plural", gender: "masculine" },
  { name: "Atanásio", fixed_month: 5, fixed_day: 2, description: "Bispo de Alexandria, 373", person_type: "singular", gender: "masculine" },
  { name: "Mônica", fixed_month: 5, fixed_day: 4, description: "Mãe de Agostinho de Hipona, 387", person_type: "singular", gender: "feminine" },
  { name: "Gregório Nazianzeno", fixed_month: 5, fixed_day: 9, description: "Bispo de Constantinopla, 389", person_type: "singular", gender: "masculine" },
  { name: "Simão de Cirene", fixed_month: 5, fixed_day: 12, description: "O que ajudou o Senhor a carregar a cruz", person_type: "singular", gender: "masculine" },
  { name: "Abolição da Escravatura no Brasil", fixed_month: 5, fixed_day: 13, description: "1888", person_type: "event", gender: "neutral" },
  { name: "São Matias, Apóstolo", fixed_month: 5, fixed_day: 14, description: "Matias, apóstolo", person_type: "singular", gender: "masculine" },
  { name: "Dia Internacional da Família", fixed_month: 5, fixed_day: 15, description: "Dia Internacional da Família", person_type: "event", gender: "neutral" },
  { name: "Brendan", fixed_month: 5, fixed_day: 16, description: "Missionário na Irlanda, 577", person_type: "singular", gender: "masculine" },
  { name: "Alcuíno de York", fixed_month: 5, fixed_day: 20, description: "Abade de Tours, 804", person_type: "singular", gender: "masculine" },
  { name: "Criação da Diocese do Recife", fixed_month: 5, fixed_day: 20, description: "1976", person_type: "event", gender: "neutral" },
  { name: "Beda, o venerável", fixed_month: 5, fixed_day: 25, description: "Presbítero e monge, 735", person_type: "singular", gender: "masculine" },
  { name: "Agostinho de Cantuária", fixed_month: 5, fixed_day: 26, description: "Primeiro arcebispo de Cantuária, 605", person_type: "singular", gender: "masculine" },
  { name: "João Calvino", fixed_month: 5, fixed_day: 27, description: "1564", person_type: "singular", gender: "masculine" },
  { name: "Jerônimo de Praga", fixed_month: 5, fixed_day: 30, description: "Reformador da Igreja da Boêmia, 1430", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # JUNHO
  # ================================================================================
  { name: "Justino", fixed_month: 6, fixed_day: 1, description: "Mártir em Roma, 167", person_type: "singular", gender: "masculine" },
  { name: "James Watson Morris", fixed_month: 6, fixed_day: 2, description: "Pioneiro anglicano no Brasil, m. 31/3/1954", person_type: "singular", gender: "masculine" },
  { name: "Lucien Lee Kinsolving", fixed_month: 6, fixed_day: 3, description: "Pioneiro anglicano no Brasil, bispo, m. 18/12/1929", person_type: "singular", gender: "masculine" },
  { name: "Bonifácio", fixed_month: 6, fixed_day: 5, description: "Bispo missionário na Alemanha e mártir, 754", person_type: "singular", gender: "masculine" },
  { name: "Dia Internacional do Meio Ambiente", fixed_month: 6, fixed_day: 5, description: "Dia Internacional do Meio Ambiente", person_type: "event", gender: "neutral" },
  { name: "Norberto", fixed_month: 6, fixed_day: 6, description: "Bispo de Magdeburgo, Alemanha, 1134", person_type: "singular", gender: "masculine" },
  { name: "Columba", fixed_month: 6, fixed_day: 9, description: "Abade de Iona, 597", person_type: "singular", gender: "masculine" },
  { name: "Primeira Edição do Livro de Oração Comum (LOC)", fixed_month: 6, fixed_day: 9, description: "1549", person_type: "event", gender: "neutral" },
  { name: "Efrém", fixed_month: 6, fixed_day: 10, description: "Diácono de Edessa, na Síria, 373", person_type: "singular", gender: "masculine" },
  { name: "Barnabé, apóstolo", fixed_month: 6, fixed_day: 11, description: "Barnabé, apóstolo", person_type: "singular", gender: "masculine" },
  { name: "Basílio Magno", fixed_month: 6, fixed_day: 14, description: "Bispo de Cesaréia, 379", person_type: "singular", gender: "masculine" },
  { name: "Excomunhão de Martinho Lutero", fixed_month: 6, fixed_day: 16, description: "1520", person_type: "event", gender: "neutral" },
  { name: "Romualdo", fixed_month: 6, fixed_day: 19, description: "Abade, 1027", person_type: "singular", gender: "masculine" },
  { name: "Albano", fixed_month: 6, fixed_day: 22, description: "Primeiro mártir da Grã-Bretanha, 304", person_type: "singular", gender: "masculine" },
  { name: "Natividade de João Batista", fixed_month: 6, fixed_day: 24, description: "Natividade de São João Batista", person_type: "event", gender: "neutral" },
  { name: "Confissão de Augsburgo", fixed_month: 6, fixed_day: 25, description: "1530", person_type: "event", gender: "neutral" },
  { name: "Cirilo de Alexandria", fixed_month: 6, fixed_day: 27, description: "Bispo de Alexandria, 444", person_type: "singular", gender: "masculine" },
  { name: "Irineu", fixed_month: 6, fixed_day: 28, description: "Bispo de Lion, 202", person_type: "singular", gender: "masculine" },
  { name: "Sagração de Egmont Machado Krischke", fixed_month: 6, fixed_day: 28, description: "Primeiro Primaz Anglicano do Brasil, 1971", person_type: "event", gender: "neutral" },
  { name: "Pedro e Paulo, apóstolos", fixed_month: 6, fixed_day: 29, description: "Pedro e Paulo, apóstolos", person_type: "plural", gender: "masculine" },

  # ================================================================================
  # JULHO
  # ================================================================================
  { name: "São Tomé, apóstolo", fixed_month: 7, fixed_day: 3, description: "Tomé, apóstolo", person_type: "singular", gender: "masculine" },
  { name: "João Huss", fixed_month: 7, fixed_day: 6, description: "Precursor da Reforma, 1415", person_type: "singular", gender: "masculine" },
  { name: "Áquila e Priscila", fixed_month: 7, fixed_day: 8, description: "Cooperadores do apóstolo Paulo", person_type: "plural", gender: "mixed" },
  { name: "Bento de Núrsia", fixed_month: 7, fixed_day: 11, description: "Abade de Montecassino, 540", person_type: "singular", gender: "masculine" },
  { name: "Silas", fixed_month: 7, fixed_day: 13, description: "Companheiro do apóstolo Paulo", person_type: "singular", gender: "masculine" },
  { name: "Richard Holden", fixed_month: 7, fixed_day: 17, description: "Tradutor do primeiro Livro de Oração Comum em português, 1876", person_type: "singular", gender: "masculine" },
  { name: "Maria Madalena", fixed_month: 7, fixed_day: 22, description: "Maria Madalena", person_type: "singular", gender: "feminine" },
  { name: "Thomas a Kempis", fixed_month: 7, fixed_day: 24, description: "Presbítero, 1471", person_type: "singular", gender: "masculine" },
  { name: "Tiago, apóstolo", fixed_month: 7, fixed_day: 25, description: "Tiago, apóstolo", person_type: "singular", gender: "masculine" },
  { name: "Marta, Maria e Lázaro de Betânia", fixed_month: 7, fixed_day: 29, description: "Amigos de Jesus", person_type: "plural", gender: "mixed" },
  { name: "Pedro Crisólogo", fixed_month: 7, fixed_day: 30, description: "Bispo de Ravena, Itália, 450", person_type: "singular", gender: "masculine" },
  { name: "José de Arimatéia", fixed_month: 7, fixed_day: 31, description: "Discípulo de Jesus", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # AGOSTO
  # ================================================================================
  { name: "Eusébio", fixed_month: 8, fixed_day: 2, description: "Bispo de Vercelli, 371", person_type: "singular", gender: "masculine" },
  { name: "Nicodemos", fixed_month: 8, fixed_day: 3, description: "Discípulo de Jesus", person_type: "singular", gender: "masculine" },
  { name: "Oswald de Nortúmbria", fixed_month: 8, fixed_day: 5, description: "Mártir, 642", person_type: "singular", gender: "masculine" },
  { name: "João Ferreira de Almeida", fixed_month: 8, fixed_day: 6, description: "Primeiro tradutor protestante da Bíblia em português, 1691", person_type: "singular", gender: "masculine" },
  { name: "Sisto", fixed_month: 8, fixed_day: 7, description: "Bispo de Roma, e seus companheiros, mártires, 258", person_type: "plural", gender: "masculine" },
  { name: "Domingos", fixed_month: 8, fixed_day: 8, description: "Presbítero e frade, 1221", person_type: "singular", gender: "masculine" },
  { name: "Lourenço", fixed_month: 8, fixed_day: 10, description: "Diácono e mártir em Roma, 258", person_type: "singular", gender: "masculine" },
  { name: "Destruição de Jerusalém", fixed_month: 8, fixed_day: 10, description: "70 d.C.", person_type: "event", gender: "neutral" },
  { name: "Hipólito e Ponciano", fixed_month: 8, fixed_day: 12, description: "Bispos e mártires, 235", person_type: "plural", gender: "masculine" },
  { name: "Dia da Escola Bíblica Dominical", fixed_month: 8, fixed_day: 19, description: "Dia da Escola Bíblica Dominical", person_type: "event", gender: "neutral" },
  { name: "Publicação das Institutas da Religião Cristã", fixed_month: 8, fixed_day: 23, description: "João Calvino, 1535", person_type: "event", gender: "neutral" },
  { name: "Bartolomeu, apóstolo", fixed_month: 8, fixed_day: 24, description: "Bartolomeu, apóstolo", person_type: "singular", gender: "masculine" },
  { name: "Agostinho de Hipona", fixed_month: 8, fixed_day: 28, description: "Bispo de Hipona, 430", person_type: "singular", gender: "masculine" },
  { name: "Aidan", fixed_month: 8, fixed_day: 31, description: "Abade e bispo de Lindisfarne, 651", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # SETEMBRO
  # ================================================================================
  { name: "Mártires da Nova Guiné", fixed_month: 9, fixed_day: 2, description: "1942", person_type: "plural", gender: "masculine" },
  { name: "Dia da Pátria (Independência do Brasil)", fixed_month: 9, fixed_day: 7, description: "Independência do Brasil", person_type: "event", gender: "neutral" },
  { name: "Cipriano", fixed_month: 9, fixed_day: 13, description: "Bispo e mártir de Cartago, 258", person_type: "singular", gender: "masculine" },
  { name: "Ninian", fixed_month: 9, fixed_day: 16, description: "Bispo missionário na Escócia, 430", person_type: "singular", gender: "masculine" },
  { name: "Teodoro de Tarso", fixed_month: 9, fixed_day: 19, description: "Arcebispo de Cantuária, 690", person_type: "singular", gender: "masculine" },
  { name: "John Coleridge Patteson", fixed_month: 9, fixed_day: 20, description: "Bispo da Melanésia, e seus companheiros, mártires, 1871", person_type: "plural", gender: "masculine" },
  { name: "Mateus, apóstolo e evangelista", fixed_month: 9, fixed_day: 21, description: "Mateus, apóstolo e evangelista", person_type: "singular", gender: "masculine" },
  { name: "Sérgio", fixed_month: 9, fixed_day: 25, description: "Abade da SS. Trindade, Moscou, 1392", person_type: "singular", gender: "masculine" },
  { name: "Jerônimo", fixed_month: 9, fixed_day: 30, description: "Presbítero e monge em Belém, 420", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # OUTUBRO
  # ================================================================================
  { name: "Francisco de Assis", fixed_month: 10, fixed_day: 4, description: "Frade, 1226", person_type: "singular", gender: "masculine" },
  { name: "William Tyndale", fixed_month: 10, fixed_day: 6, description: "Presbítero e mártir, 1536", person_type: "singular", gender: "masculine" },
  { name: "Thomas More", fixed_month: 10, fixed_day: 6, description: "Mártir, 1535", person_type: "singular", gender: "masculine" },
  { name: "John Fisher", fixed_month: 10, fixed_day: 6, description: "Bispo e mártir, 1535", person_type: "singular", gender: "masculine" },
  { name: "Dionísio", fixed_month: 10, fixed_day: 9, description: "Primeiro bispo de Paris, e seus companheiros, mártires, século III", person_type: "plural", gender: "masculine" },
  { name: "Paulino", fixed_month: 10, fixed_day: 10, description: "Primeiro arcebispo de York, 644", person_type: "singular", gender: "masculine" },
  { name: "Felipe, diácono e evangelista", fixed_month: 10, fixed_day: 11, description: "Felipe, diácono e evangelista", person_type: "singular", gender: "masculine" },
  { name: "Huldereich Zwinglio", fixed_month: 10, fixed_day: 11, description: "Presbítero e reformador suíço, 1531", person_type: "singular", gender: "masculine" },
  { name: "Wilfrido", fixed_month: 10, fixed_day: 12, description: "Arcebispo de York, 709", person_type: "singular", gender: "masculine" },
  { name: "Hugh Latimer e Nicolas Ridley", fixed_month: 10, fixed_day: 16, description: "Bispos e mártires, 1555", person_type: "plural", gender: "masculine" },
  { name: "Inácio", fixed_month: 10, fixed_day: 17, description: "Bispo de Antioquia e mártir, 107", person_type: "singular", gender: "masculine" },
  { name: "Lucas, evangelista", fixed_month: 10, fixed_day: 18, description: "Lucas, evangelista", person_type: "singular", gender: "masculine" },
  { name: "Simão e Judas, apóstolos", fixed_month: 10, fixed_day: 28, description: "Simão e Judas, apóstolos", person_type: "plural", gender: "masculine" },
  { name: "Reforma Protestante", fixed_month: 10, fixed_day: 31, description: "1517", person_type: "event", gender: "neutral" },

  # ================================================================================
  # NOVEMBRO
  # ================================================================================
  { name: "Fiéis falecidos", fixed_month: 11, fixed_day: 2, description: "Comemoração dos fiéis falecidos", person_type: "plural", gender: "masculine" },
  { name: "Illtyd", fixed_month: 11, fixed_day: 6, description: "Abade de Glamorgan, século V", person_type: "singular", gender: "masculine" },
  { name: "Martinho Lutero", fixed_month: 11, fixed_day: 11, description: "Nascido em 1483", person_type: "singular", gender: "masculine" },
  { name: "Martinho", fixed_month: 11, fixed_day: 11, description: "Bispo de Tours, 397", person_type: "singular", gender: "masculine" },
  { name: "Hilda", fixed_month: 11, fixed_day: 18, description: "Abadessa de Whitby, 680", person_type: "singular", gender: "feminine" },
  { name: "Clemente", fixed_month: 11, fixed_day: 23, description: "Bispo de Roma, 100, e Columbano, abade de Bóbio, Itália, 615", person_type: "plural", gender: "masculine" },
  { name: "André, apóstolo", fixed_month: 11, fixed_day: 30, description: "André, apóstolo", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # DEZEMBRO
  # ================================================================================
  { name: "João Damasceno", fixed_month: 12, fixed_day: 4, description: "Presbítero, 760", person_type: "singular", gender: "masculine" },
  { name: "Confissão de Westminster", fixed_month: 12, fixed_day: 4, description: "1646", person_type: "event", gender: "neutral" },
  { name: "Clemente de Alexandria", fixed_month: 12, fixed_day: 5, description: "Presbítero, 210", person_type: "singular", gender: "masculine" },
  { name: "Nicolau de Mira", fixed_month: 12, fixed_day: 6, description: "Turquia, 342", person_type: "singular", gender: "masculine" },
  { name: "Ambrósio", fixed_month: 12, fixed_day: 7, description: "Bispo de Milão, 397", person_type: "singular", gender: "masculine" },
  { name: "João da Cruz", fixed_month: 12, fixed_day: 14, description: "Monge, 1591", person_type: "singular", gender: "masculine" },
  { name: "Estevão", fixed_month: 12, fixed_day: 26, description: "Diácono e mártir", person_type: "singular", gender: "masculine" },
  { name: "João, apóstolo e evangelista", fixed_month: 12, fixed_day: 27, description: "João, apóstolo e evangelista", person_type: "singular", gender: "masculine" },
  { name: "Thomas Becket", fixed_month: 12, fixed_day: 29, description: "Arcebispo de Cantuária e mártir, 1170", person_type: "singular", gender: "masculine" },
  { name: "Silvestre", fixed_month: 12, fixed_day: 31, description: "Bispo de Roma, 335", person_type: "singular", gender: "masculine" },
  { name: "John Wycliff", fixed_month: 12, fixed_day: 31, description: "Precursor da Reforma, 1384", person_type: "singular", gender: "masculine" }
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
    person_type: comm[:person_type],
    gender: comm[:gender],
    prayer_book_id: prayer_book&.id
  }

  Celebration.create!(data)
  Rails.logger.info "  ✓ #{comm[:fixed_month]}/#{comm[:fixed_day]} - #{comm[:name]}"
end

Rails.logger.info "  📅 Total: #{commemorations.count} comemorações criadas"
