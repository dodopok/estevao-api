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
  { name: "Dia Mundial da Paz", fixed_month: 1, fixed_day: 1, description: "Dia Mundial da Paz" , post_slug: "celebration-dia-mundial-da-paz" },
  { name: "Primeira Confissão de Fé Reformada das Américas", fixed_month: 1, fixed_day: 5, description: "Rio de Janeiro, 1558" , post_slug: "celebration-primeira-confissao-de-fe-reformada-das-americas" },
  { name: "Dia da Liberdade de Culto no Brasil", fixed_month: 1, fixed_day: 7, description: "1890" , post_slug: "celebration-dia-da-liberdade-de-culto-no-brasil" },
  { name: "Batismo de nosso Senhor Jesus Cristo", fixed_month: 1, fixed_day: 9, description: "Ou no 1º Domingo após a Epifania", movable: true, calculation_rule: "first_sunday_after_epiphany" , post_slug: "celebration-batismo-de-nosso-senhor-jesus-cristo" },
  { name: "William Laud", fixed_month: 1, fixed_day: 10, description: "Arcebispo de Cantuária, 1645" , post_slug: "celebration-william-laud" },
  { name: "Dia dos Trinta e Nove Artigos de Religião", fixed_month: 1, fixed_day: 10, description: "1562" , post_slug: "celebration-dia-dos-trinta-e-nove-artigos-de-religiao" },
  { name: "Hilário", fixed_month: 1, fixed_day: 13, description: "Bispo de Poitiers, 367" , post_slug: "celebration-hilario" },
  { name: "Antão", fixed_month: 1, fixed_day: 17, description: "Abade do Egito, 356" , post_slug: "celebration-antao" },
  { name: "Confissão do apóstolo Pedro", fixed_month: 1, fixed_day: 18, description: "Confissão de São Pedro" , post_slug: "celebration-confissao-do-apostolo-pedro" },
  { name: "Fabiano", fixed_month: 1, fixed_day: 20, description: "Bispo de Roma e mártir, 250" , post_slug: "celebration-fabiano" },
  { name: "Inês", fixed_month: 1, fixed_day: 21, description: "Mártir em Roma, 304" , post_slug: "celebration-ines" },
  { name: "Vicente", fixed_month: 1, fixed_day: 22, description: "Diácono de Saragoça e mártir, 304" , post_slug: "celebration-vicente" },
  { name: "Conversão do apóstolo Paulo", fixed_month: 1, fixed_day: 25, description: "Conversão de São Paulo" , post_slug: "celebration-conversao-do-apostolo-paulo" },
  { name: "Timóteo e Tito", fixed_month: 1, fixed_day: 26, description: "Companheiros do apóstolo Paulo" , post_slug: "celebration-timoteo-e-tito" },
  { name: "João Crisóstomo", fixed_month: 1, fixed_day: 27, description: "Bispo de Constantinopla, 407" , post_slug: "celebration-joao-crisostomo" },
  { name: "Tomás de Aquino", fixed_month: 1, fixed_day: 28, description: "Presbítero e frade, 1274" , post_slug: "celebration-tomas-de-aquino" },
  { name: "Lídia, Dorcas e Febe", fixed_month: 1, fixed_day: 29, description: "Cooperadoras dos apóstolos" , post_slug: "celebration-lidia-dorcas-e-febe" },

  # ================================================================================
  # FEVEREIRO
  # ================================================================================
  { name: "Brígida", fixed_month: 2, fixed_day: 1, description: "Abadessa de Kildare, 523" , post_slug: "celebration-brigida" },
  { name: "Brás", fixed_month: 2, fixed_day: 3, description: "Bispo de Sebaste, Armênia, e mártir, século IV" , post_slug: "celebration-bras" },
  { name: "Cornélio, o centurião", fixed_month: 2, fixed_day: 4, description: "Centurião convertido" , post_slug: "celebration-cornelio-o-centuriao" },
  { name: "Os mártires do Japão", fixed_month: 2, fixed_day: 5, description: "1597" , post_slug: "celebration-os-martires-do-japao" },
  { name: "Martírio de John Hooper", fixed_month: 2, fixed_day: 9, description: "Bispo de Worcester e Glaucester, colaborador do Livro de Oração Comum, 1555" , post_slug: "celebration-martirio-de-john-hooper" },
  { name: "Martírio dos reformados franceses Jean de Bourdel, Mathieu Verneuil e Pierre de Bourdon", fixed_month: 2, fixed_day: 9, description: "Baía de Guanabara, 1558" , post_slug: "celebration-martirio-dos-reformados-franceses-jean-de-bourdel-mathieu-verneuil-e-pierre-de-bourdon" },
  { name: "Escolástica", fixed_month: 2, fixed_day: 10, description: "Irmã de Bento de Núrsia, 547" , post_slug: "celebration-escolastica" },
  { name: "Cirilo e Metódio", fixed_month: 2, fixed_day: 14, description: "Monge, 869, e Bispo, 885, missionários entre os eslavos" , post_slug: "celebration-cirilo-e-metodio" },
  { name: "Policarpo", fixed_month: 2, fixed_day: 23, description: "Bispo de Esmirna e mártir, 156" , post_slug: "celebration-policarpo" },

  # ================================================================================
  # MARÇO
  # ================================================================================
  { name: "Davi", fixed_month: 3, fixed_day: 1, description: "Bispo de Menevia, Gália, 544" , post_slug: "celebration-davi" },
  { name: "Chad", fixed_month: 3, fixed_day: 2, description: "Bispo de Lichfield, 672" , post_slug: "celebration-chad" },
  { name: "João e Carlos Wesley", fixed_month: 3, fixed_day: 3, description: "Presbíteros, 1791, 1788" , post_slug: "celebration-joao-e-carlos-wesley" },
  { name: "Perpétua, Felicidade e seus companheiros", fixed_month: 3, fixed_day: 7, description: "Mártires em Cartago, 203" , post_slug: "celebration-perpetua-felicidade-e-seus-companheiros" },
  { name: "Fundação da Sociedade Bíblica Britânica e Estrangeira", fixed_month: 3, fixed_day: 7, description: "1804" , post_slug: "celebration-fundacao-da-sociedade-biblica-britanica-e-estrangeira" },
  { name: "Dia Internacional da Mulher", fixed_month: 3, fixed_day: 8, description: "Dia Internacional da Mulher" , post_slug: "celebration-dia-internacional-da-mulher" },
  { name: "Gregório", fixed_month: 3, fixed_day: 9, description: "Bispo de Nissa, 394" , post_slug: "celebration-gregorio" },
  { name: "Celebração do Primeiro Culto Protestante no Brasil", fixed_month: 3, fixed_day: 10, description: "Rev. Pierre Richier, calvinista francês, Rio de Janeiro, 1557" , post_slug: "celebration-celebracao-do-primeiro-culto-protestante-no-brasil" },
  { name: "Gregório Magno", fixed_month: 3, fixed_day: 12, description: "Bispo de Roma, 604" , post_slug: "celebration-gregorio-magno" },
  { name: "Patrício", fixed_month: 3, fixed_day: 17, description: "Bispo e missionário da Irlanda, 461" , post_slug: "celebration-patricio" },
  { name: "Cirilo de Jerusalém", fixed_month: 3, fixed_day: 18, description: "Bispo de Jerusalém, 386" , post_slug: "celebration-cirilo-de-jerusalem" },
  { name: "Cuthbert", fixed_month: 3, fixed_day: 20, description: "Bispo e missionário de Lindisfarne, 687" , post_slug: "celebration-cuthbert" },
  { name: "Thomas Cranmer", fixed_month: 3, fixed_day: 21, description: "Arcebispo de Cantuária, 1556" , post_slug: "celebration-thomas-cranmer" },
  { name: "Jonathan Edwards", fixed_month: 3, fixed_day: 24, description: "Missionário na Nova Inglaterra, 1758" , post_slug: "celebration-jonathan-edwards" },
  { name: "Dia do Episcopado", fixed_month: 3, fixed_day: 30, description: "Dia do Episcopado" , post_slug: "celebration-dia-do-episcopado" },

  # ================================================================================
  # ABRIL
  # ================================================================================
  { name: "Isidoro", fixed_month: 4, fixed_day: 4, description: "Bispo de Sevilha, 636" , post_slug: "celebration-isidoro" },
  { name: "O Concílio de Trento decreta como Canônicos os Livros Apócrifos", fixed_month: 4, fixed_day: 8, description: "1546" , post_slug: "celebration-o-concilio-de-trento-decreta-como-canonicos-os-livros-apocrifos" },
  { name: "Dietrich Bonhoeffer", fixed_month: 4, fixed_day: 10, description: "Teólogo e mártir na Alemanha, 1945" , post_slug: "celebration-dietrich-bonhoeffer" },
  { name: "Felipe Melanchthon", fixed_month: 4, fixed_day: 19, description: "1560" , post_slug: "celebration-felipe-melanchthon" },
  { name: "Dia do Índio", fixed_month: 4, fixed_day: 19, description: "Dia do Índio" , post_slug: "celebration-dia-do-indio" },
  { name: "Origem do termo 'Protestante'", fixed_month: 4, fixed_day: 20, description: "1529" , post_slug: "celebration-origem-do-termo-protestante" },
  { name: "Anselmo", fixed_month: 4, fixed_day: 21, description: "Arcebispo de Cantuária, 1109" , post_slug: "celebration-anselmo" },
  { name: "Descobrimento do Brasil", fixed_month: 4, fixed_day: 22, description: "1500, Dia da Comunidade Luso-Brasileira, 1967" , post_slug: "celebration-descobrimento-do-brasil" },
  { name: "Jorge", fixed_month: 4, fixed_day: 23, description: "Mártir, século IV" , post_slug: "celebration-jorge" },
  { name: "Marcos, evangelista", fixed_month: 4, fixed_day: 25, description: "Marcos, evangelista" , post_slug: "celebration-marcos-evangelista" },

  # ================================================================================
  # MAIO
  # ================================================================================
  { name: "Felipe e Tiago, apóstolos", fixed_month: 5, fixed_day: 1, description: "Dia do Trabalho" , post_slug: "celebration-felipe-e-tiago-apostolos" },
  { name: "Atanásio", fixed_month: 5, fixed_day: 2, description: "Bispo de Alexandria, 373" , post_slug: "celebration-atanasio" },
  { name: "Mônica", fixed_month: 5, fixed_day: 4, description: "Mãe de Agostinho de Hipona, 387" , post_slug: "celebration-monica" },
  { name: "Gregório Nazianzeno", fixed_month: 5, fixed_day: 9, description: "Bispo de Constantinopla, 389" , post_slug: "celebration-gregorio-nazianzeno" },
  { name: "Simão de Cirene", fixed_month: 5, fixed_day: 12, description: "O que ajudou o Senhor a carregar a cruz" , post_slug: "celebration-simao-de-cirene" },
  { name: "Abolição da Escravatura no Brasil", fixed_month: 5, fixed_day: 13, description: "1888" , post_slug: "celebration-abolicao-da-escravatura-no-brasil" },
  { name: "São Matias, Apóstolo", fixed_month: 5, fixed_day: 14, description: "Matias, apóstolo" , post_slug: "celebration-sao-matias-apostolo" },
  { name: "Dia Internacional da Família", fixed_month: 5, fixed_day: 15, description: "Dia Internacional da Família" , post_slug: "celebration-dia-internacional-da-familia" },
  { name: "Brendan", fixed_month: 5, fixed_day: 16, description: "Missionário na Irlanda, 577" , post_slug: "celebration-brendan" },
  { name: "Alcuíno de York", fixed_month: 5, fixed_day: 20, description: "Abade de Tours, 804" , post_slug: "celebration-alcuino-de-york" },
  { name: "Criação da Diocese do Recife", fixed_month: 5, fixed_day: 20, description: "1976" , post_slug: "celebration-criacao-da-diocese-do-recife" },
  { name: "Beda, o venerável", fixed_month: 5, fixed_day: 25, description: "Presbítero e monge, 735" , post_slug: "celebration-beda-o-veneravel" },
  { name: "Agostinho de Cantuária", fixed_month: 5, fixed_day: 26, description: "Primeiro arcebispo de Cantuária, 605" , post_slug: "celebration-agostinho-de-cantuaria" },
  { name: "João Calvino", fixed_month: 5, fixed_day: 27, description: "1564" , post_slug: "celebration-joao-calvino" },
  { name: "Jerônimo de Praga", fixed_month: 5, fixed_day: 30, description: "Reformador da Igreja da Boêmia, 1430" , post_slug: "celebration-jeronimo-de-praga" },

  # ================================================================================
  # JUNHO
  # ================================================================================
  { name: "Justino", fixed_month: 6, fixed_day: 1, description: "Mártir em Roma, 167" , post_slug: "celebration-justino" },
  { name: "James Watson Morris", fixed_month: 6, fixed_day: 2, description: "Pioneiro anglicano no Brasil, m. 31/3/1954" , post_slug: "celebration-james-watson-morris" },
  { name: "Lucien Lee Kinsolving", fixed_month: 6, fixed_day: 3, description: "Pioneiro anglicano no Brasil, bispo, m. 18/12/1929" , post_slug: "celebration-lucien-lee-kinsolving" },
  { name: "Bonifácio", fixed_month: 6, fixed_day: 5, description: "Bispo missionário na Alemanha e mártir, 754" , post_slug: "celebration-bonifacio" },
  { name: "Dia Internacional do Meio Ambiente", fixed_month: 6, fixed_day: 5, description: "Dia Internacional do Meio Ambiente" , post_slug: "celebration-dia-internacional-do-meio-ambiente" },
  { name: "Norberto", fixed_month: 6, fixed_day: 6, description: "Bispo de Magdeburgo, Alemanha, 1134" , post_slug: "celebration-norberto" },
  { name: "Columba", fixed_month: 6, fixed_day: 9, description: "Abade de Iona, 597" , post_slug: "celebration-columba" },
  { name: "Primeira Edição do Livro de Oração Comum (LOC)", fixed_month: 6, fixed_day: 9, description: "1549" , post_slug: "celebration-primeira-edicao-do-livro-de-oracao-comum-loc" },
  { name: "Efrém", fixed_month: 6, fixed_day: 10, description: "Diácono de Edessa, na Síria, 373" , post_slug: "celebration-efrem" },
  { name: "Barnabé, apóstolo", fixed_month: 6, fixed_day: 11, description: "Barnabé, apóstolo" , post_slug: "celebration-barnabe-apostolo" },
  { name: "Basílio Magno", fixed_month: 6, fixed_day: 14, description: "Bispo de Cesaréia, 379" , post_slug: "celebration-basilio-magno" },
  { name: "Excomunhão de Martinho Lutero", fixed_month: 6, fixed_day: 16, description: "1520" , post_slug: "celebration-excomunhao-de-martinho-lutero" },
  { name: "Romualdo", fixed_month: 6, fixed_day: 19, description: "Abade, 1027" , post_slug: "celebration-romualdo" },
  { name: "Albano", fixed_month: 6, fixed_day: 22, description: "Primeiro mártir da Grã-Bretanha, 304" , post_slug: "celebration-albano" },
  { name: "Natividade de João Batista", fixed_month: 6, fixed_day: 24, description: "Natividade de São João Batista" , post_slug: "celebration-natividade-de-joao-batista" },
  { name: "Confissão de Augsburgo", fixed_month: 6, fixed_day: 25, description: "1530" , post_slug: "celebration-confissao-de-augsburgo" },
  { name: "Cirilo de Alexandria", fixed_month: 6, fixed_day: 27, description: "Bispo de Alexandria, 444" , post_slug: "celebration-cirilo-de-alexandria" },
  { name: "Irineu", fixed_month: 6, fixed_day: 28, description: "Bispo de Lion, 202" , post_slug: "celebration-irineu" },
  { name: "Sagração de Egmont Machado Krischke", fixed_month: 6, fixed_day: 28, description: "Primeiro Primaz Anglicano do Brasil, 1971" , post_slug: "celebration-sagracao-de-egmont-machado-krischke" },
  { name: "Pedro e Paulo, apóstolos", fixed_month: 6, fixed_day: 29, description: "Pedro e Paulo, apóstolos" , post_slug: "celebration-pedro-e-paulo-apostolos" },

  # ================================================================================
  # JULHO
  # ================================================================================
  { name: "São Tomé, apóstolo", fixed_month: 7, fixed_day: 3, description: "Tomé, apóstolo" , post_slug: "celebration-sao-tome-apostolo" },
  { name: "João Huss", fixed_month: 7, fixed_day: 6, description: "Precursor da Reforma, 1415" , post_slug: "celebration-joao-huss" },
  { name: "Áquila e Priscila", fixed_month: 7, fixed_day: 8, description: "Cooperadores do apóstolo Paulo" , post_slug: "celebration-aquila-e-priscila" },
  { name: "Bento de Núrsia", fixed_month: 7, fixed_day: 11, description: "Abade de Montecassino, 540" , post_slug: "celebration-bento-de-nursia" },
  { name: "Silas", fixed_month: 7, fixed_day: 13, description: "Companheiro do apóstolo Paulo" , post_slug: "celebration-silas" },
  { name: "Richard Holden", fixed_month: 7, fixed_day: 17, description: "Tradutor do primeiro Livro de Oração Comum em português, 1876" , post_slug: "celebration-richard-holden" },
  { name: "Maria Madalena", fixed_month: 7, fixed_day: 22, description: "Maria Madalena" , post_slug: "celebration-maria-madalena" },
  { name: "Thomas a Kempis", fixed_month: 7, fixed_day: 24, description: "Presbítero, 1471" , post_slug: "celebration-thomas-a-kempis" },
  { name: "Tiago, apóstolo", fixed_month: 7, fixed_day: 25, description: "Tiago, apóstolo" , post_slug: "celebration-tiago-apostolo" },
  { name: "Marta, Maria e Lázaro de Betânia", fixed_month: 7, fixed_day: 29, description: "Amigos de Jesus" , post_slug: "celebration-marta-maria-e-lazaro-de-betania" },
  { name: "Pedro Crisólogo", fixed_month: 7, fixed_day: 30, description: "Bispo de Ravena, Itália, 450" , post_slug: "celebration-pedro-crisologo" },
  { name: "José de Arimatéia", fixed_month: 7, fixed_day: 31, description: "Discípulo de Jesus" , post_slug: "celebration-jose-de-arimateia" },

  # ================================================================================
  # AGOSTO
  # ================================================================================
  { name: "Eusébio", fixed_month: 8, fixed_day: 2, description: "Bispo de Vercelli, 371" , post_slug: "celebration-eusebio" },
  { name: "Nicodemos", fixed_month: 8, fixed_day: 3, description: "Discípulo de Jesus" , post_slug: "celebration-nicodemos" },
  { name: "Oswald de Nortúmbria", fixed_month: 8, fixed_day: 5, description: "Mártir, 642" , post_slug: "celebration-oswald-de-nortumbria" },
  { name: "João Ferreira de Almeida", fixed_month: 8, fixed_day: 6, description: "Primeiro tradutor protestante da Bíblia em português, 1691" , post_slug: "celebration-joao-ferreira-de-almeida" },
  { name: "Sisto", fixed_month: 8, fixed_day: 7, description: "Bispo de Roma, e seus companheiros, mártires, 258" , post_slug: "celebration-sisto" },
  { name: "Domingos", fixed_month: 8, fixed_day: 8, description: "Presbítero e frade, 1221" , post_slug: "celebration-domingos" },
  { name: "Lourenço", fixed_month: 8, fixed_day: 10, description: "Diácono e mártir em Roma, 258" , post_slug: "celebration-lourenco" },
  { name: "Destruição de Jerusalém", fixed_month: 8, fixed_day: 10, description: "70 d.C." , post_slug: "celebration-destruicao-de-jerusalem" },
  { name: "Hipólito e Ponciano", fixed_month: 8, fixed_day: 12, description: "Bispos e mártires, 235" , post_slug: "celebration-hipolito-e-ponciano" },
  { name: "Dia da Escola Bíblica Dominical", fixed_month: 8, fixed_day: 19, description: "Dia da Escola Bíblica Dominical" , post_slug: "celebration-dia-da-escola-biblica-dominical" },
  { name: "Publicação das Institutas da Religião Cristã", fixed_month: 8, fixed_day: 23, description: "João Calvino, 1535" , post_slug: "celebration-publicacao-das-institutas-da-religiao-crista" },
  { name: "Bartolomeu, apóstolo", fixed_month: 8, fixed_day: 24, description: "Bartolomeu, apóstolo" , post_slug: "celebration-bartolomeu-apostolo" },
  { name: "Agostinho de Hipona", fixed_month: 8, fixed_day: 28, description: "Bispo de Hipona, 430" , post_slug: "celebration-agostinho-de-hipona" },
  { name: "Aidan", fixed_month: 8, fixed_day: 31, description: "Abade e bispo de Lindisfarne, 651" , post_slug: "celebration-aidan" },

  # ================================================================================
  # SETEMBRO
  # ================================================================================
  { name: "Mártires da Nova Guiné", fixed_month: 9, fixed_day: 2, description: "1942" , post_slug: "celebration-martires-da-nova-guine" },
  { name: "Dia da Pátria (Independência do Brasil)", fixed_month: 9, fixed_day: 7, description: "Independência do Brasil" , post_slug: "celebration-dia-da-patria-independencia-do-brasil" },
  { name: "Cipriano", fixed_month: 9, fixed_day: 13, description: "Bispo e mártir de Cartago, 258" , post_slug: "celebration-cipriano" },
  { name: "Ninian", fixed_month: 9, fixed_day: 16, description: "Bispo missionário na Escócia, 430" , post_slug: "celebration-ninian" },
  { name: "Teodoro de Tarso", fixed_month: 9, fixed_day: 19, description: "Arcebispo de Cantuária, 690" , post_slug: "celebration-teodoro-de-tarso" },
  { name: "John Coleridge Patteson", fixed_month: 9, fixed_day: 20, description: "Bispo da Melanésia, e seus companheiros, mártires, 1871" , post_slug: "celebration-john-coleridge-patteson" },
  { name: "Mateus, apóstolo e evangelista", fixed_month: 9, fixed_day: 21, description: "Mateus, apóstolo e evangelista" , post_slug: "celebration-mateus-apostolo-e-evangelista" },
  { name: "Sérgio", fixed_month: 9, fixed_day: 25, description: "Abade da SS. Trindade, Moscou, 1392" , post_slug: "celebration-sergio" },
  { name: "Jerônimo", fixed_month: 9, fixed_day: 30, description: "Presbítero e monge em Belém, 420" , post_slug: "celebration-jeronimo" },

  # ================================================================================
  # OUTUBRO
  # ================================================================================
  { name: "Francisco de Assis", fixed_month: 10, fixed_day: 4, description: "Frade, 1226" , post_slug: "celebration-francisco-de-assis" },
  { name: "William Tyndale", fixed_month: 10, fixed_day: 6, description: "Presbítero e mártir, 1536" , post_slug: "celebration-william-tyndale" },
  { name: "Thomas More", fixed_month: 10, fixed_day: 6, description: "Mártir, 1535" , post_slug: "celebration-thomas-more" },
  { name: "John Fisher", fixed_month: 10, fixed_day: 6, description: "Bispo e mártir, 1535" , post_slug: "celebration-john-fisher" },
  { name: "Dionísio", fixed_month: 10, fixed_day: 9, description: "Primeiro bispo de Paris, e seus companheiros, mártires, século III" , post_slug: "celebration-dionisio" },
  { name: "Paulino", fixed_month: 10, fixed_day: 10, description: "Primeiro arcebispo de York, 644" , post_slug: "celebration-paulino" },
  { name: "Felipe, diácono e evangelista", fixed_month: 10, fixed_day: 11, description: "Felipe, diácono e evangelista" , post_slug: "celebration-felipe-diacono-e-evangelista" },
  { name: "Huldereich Zwinglio", fixed_month: 10, fixed_day: 11, description: "Presbítero e reformador suíço, 1531" , post_slug: "celebration-huldereich-zwinglio" },
  { name: "Wilfrido", fixed_month: 10, fixed_day: 12, description: "Arcebispo de York, 709" , post_slug: "celebration-wilfrido" },
  { name: "Hugh Latimer e Nicolas Ridley", fixed_month: 10, fixed_day: 16, description: "Bispos e mártires, 1555" , post_slug: "celebration-hugh-latimer-e-nicolas-ridley" },
  { name: "Inácio", fixed_month: 10, fixed_day: 17, description: "Bispo de Antioquia e mártir, 107" , post_slug: "celebration-inacio" },
  { name: "Lucas, evangelista", fixed_month: 10, fixed_day: 18, description: "Lucas, evangelista" , post_slug: "celebration-lucas-evangelista" },
  { name: "Simão e Judas, apóstolos", fixed_month: 10, fixed_day: 28, description: "Simão e Judas, apóstolos" , post_slug: "celebration-simao-e-judas-apostolos" },
  { name: "Reforma Protestante", fixed_month: 10, fixed_day: 31, description: "1517" , post_slug: "celebration-reforma-protestante" },

  # ================================================================================
  # NOVEMBRO
  # ================================================================================
  { name: "Fiéis falecidos", fixed_month: 11, fixed_day: 2, description: "Comemoração dos fiéis falecidos" , post_slug: "celebration-fieis-falecidos" },
  { name: "Illtyd", fixed_month: 11, fixed_day: 6, description: "Abade de Glamorgan, século V" , post_slug: "celebration-illtyd" },
  { name: "Martinho Lutero", fixed_month: 11, fixed_day: 11, description: "Nascido em 1483" , post_slug: "celebration-martinho-lutero" },
  { name: "Martinho", fixed_month: 11, fixed_day: 11, description: "Bispo de Tours, 397" , post_slug: "celebration-martinho" },
  { name: "Hilda", fixed_month: 11, fixed_day: 18, description: "Abadessa de Whitby, 680" , post_slug: "celebration-hilda" },
  { name: "Clemente", fixed_month: 11, fixed_day: 23, description: "Bispo de Roma, 100, e Columbano, abade de Bóbio, Itália, 615" , post_slug: "celebration-clemente" },
  { name: "André, apóstolo", fixed_month: 11, fixed_day: 30, description: "André, apóstolo" , post_slug: "celebration-andre-apostolo" },

  # ================================================================================
  # DEZEMBRO
  # ================================================================================
  { name: "João Damasceno", fixed_month: 12, fixed_day: 4, description: "Presbítero, 760" , post_slug: "celebration-joao-damasceno" },
  { name: "Confissão de Westminster", fixed_month: 12, fixed_day: 4, description: "1646" , post_slug: "celebration-confissao-de-westminster" },
  { name: "Clemente de Alexandria", fixed_month: 12, fixed_day: 5, description: "Presbítero, 210" , post_slug: "celebration-clemente-de-alexandria" },
  { name: "Nicolau de Mira", fixed_month: 12, fixed_day: 6, description: "Turquia, 342" , post_slug: "celebration-nicolau-de-mira" },
  { name: "Ambrósio", fixed_month: 12, fixed_day: 7, description: "Bispo de Milão, 397" , post_slug: "celebration-ambrosio" },
  { name: "João da Cruz", fixed_month: 12, fixed_day: 14, description: "Monge, 1591" , post_slug: "celebration-joao-da-cruz" },
  { name: "Estevão", fixed_month: 12, fixed_day: 26, description: "Diácono e mártir" , post_slug: "celebration-estevao" },
  { name: "João, apóstolo e evangelista", fixed_month: 12, fixed_day: 27, description: "João, apóstolo e evangelista" , post_slug: "celebration-joao-apostolo-e-evangelista" },
  { name: "Thomas Becket", fixed_month: 12, fixed_day: 29, description: "Arcebispo de Cantuária e mártir, 1170" , post_slug: "celebration-thomas-becket" },
  { name: "Silvestre", fixed_month: 12, fixed_day: 31, description: "Bispo de Roma, 335" , post_slug: "celebration-silvestre" },
  { name: "John Wycliff", fixed_month: 12, fixed_day: 31, description: "Precursor da Reforma, 1384" , post_slug: "celebration-john-wycliff" }
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
