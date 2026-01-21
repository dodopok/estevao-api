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
  { name: "Dia Mundial da Paz", fixed_month: 1, fixed_day: 1, description: "Dia Mundial da Paz", post_slug: "celebration-peace", person_type: "event", gender: "neutral" },
  { name: "Primeira Confissão de Fé Reformada das Américas", fixed_month: 1, fixed_day: 5, description: "Rio de Janeiro, 1558", post_slug: "celebration-primeira-confissao-reformada-americas", person_type: "event", gender: "neutral" },
  { name: "Dia da Liberdade de Culto no Brasil", fixed_month: 1, fixed_day: 7, description: "1890", post_slug: "celebration-liberdade-de-culto-no-brasil", person_type: "event", gender: "neutral" },
  { name: "Batismo de nosso Senhor Jesus Cristo", fixed_month: 1, fixed_day: 9, description: "Ou no 1º Domingo após a Epifania", movable: true, calculation_rule: "first_sunday_after_epiphany", post_slug: "celebration-baptism-of-christ", person_type: "event", gender: "neutral" },
  { name: "William Laud", fixed_month: 1, fixed_day: 10, description: "Arcebispo de Cantuária, 1645", post_slug: "celebration-william-laud", person_type: "singular", gender: "masculine" },
  { name: "Dia dos Trinta e Nove Artigos de Religião", fixed_month: 1, fixed_day: 10, description: "1562", post_slug: "celebration-thirty-nine-articles", person_type: "event", gender: "neutral" },
  { name: "Hilário", fixed_month: 1, fixed_day: 13, description: "Bispo de Poitiers, 367", post_slug: "celebration-hilary-of-poitiers", person_type: "singular", gender: "masculine" },
  { name: "Antão", fixed_month: 1, fixed_day: 17, description: "Abade do Egito, 356", post_slug: "celebration-anthony-of-egypt", person_type: "singular", gender: "masculine" },
  { name: "Confissão do apóstolo Pedro", fixed_month: 1, fixed_day: 18, description: "Confissão de São Pedro", post_slug: "celebration-confession-of-peter", person_type: "event", gender: "neutral" },
  { name: "Fabiano", fixed_month: 1, fixed_day: 20, description: "Bispo de Roma e mártir, 250", post_slug: "celebration-fabian", person_type: "singular", gender: "masculine" },
  { name: "Inês", fixed_month: 1, fixed_day: 21, description: "Mártir em Roma, 304", post_slug: "celebration-ines", person_type: "singular", gender: "feminine" },
  { name: "Vicente", fixed_month: 1, fixed_day: 22, description: "Diácono de Saragoça e mártir, 304", post_slug: "celebration-vincent-of-saragossa", person_type: "singular", gender: "masculine" },
  { name: "Conversão do apóstolo Paulo", fixed_month: 1, fixed_day: 25, description: "Conversão de São Paulo", post_slug: "celebration-conversion-of-paul", person_type: "event", gender: "neutral" },
  { name: "Timóteo e Tito", fixed_month: 1, fixed_day: 26, description: "Companheiros do apóstolo Paulo", post_slug: "celebration-timothy-and-titus", person_type: "plural", gender: "masculine" },
  { name: "João Crisóstomo", fixed_month: 1, fixed_day: 27, description: "Bispo de Constantinopla, 407", post_slug: "celebration-john-chrysostom", person_type: "singular", gender: "masculine" },
  { name: "Tomás de Aquino", fixed_month: 1, fixed_day: 28, description: "Presbítero e frade, 1274", post_slug: "celebration-thomas-aquinas", person_type: "singular", gender: "masculine" },
  { name: "Lídia, Dorcas e Febe", fixed_month: 1, fixed_day: 29, description: "Cooperadoras dos apóstolos", post_slug: "celebration-lydia-dorcas-and-phoebe", person_type: "plural", gender: "feminine" },

  # ================================================================================
  # FEVEREIRO
  # ================================================================================
  { name: "Brígida", fixed_month: 2, fixed_day: 1, description: "Abadessa de Kildare, 523", post_slug: "celebration-brigid-of-kildare", person_type: "singular", gender: "feminine" },
  { name: "Brás", fixed_month: 2, fixed_day: 3, description: "Bispo de Sebaste, Armênia, e mártir, século IV", post_slug: "celebration-bras", person_type: "singular", gender: "masculine" },
  { name: "Cornélio, o centurião", fixed_month: 2, fixed_day: 4, description: "Centurião convertido", post_slug: "celebration-cornelius-the-centurion", person_type: "singular", gender: "masculine" },
  { name: "Os mártires do Japão", fixed_month: 2, fixed_day: 5, description: "1597", post_slug: "celebration-martyrs-of-japan", person_type: "plural", gender: "masculine" },
  { name: "Martírio de John Hooper", fixed_month: 2, fixed_day: 9, description: "Bispo de Worcester e Glaucester, colaborador do Livro de Oração Comum, 1555", post_slug: "celebration-john-hooper", person_type: "singular", gender: "masculine" },
  { name: "Martírio dos reformados franceses Jean de Bourdel, Mathieu Verneuil e Pierre de Bourdon", fixed_month: 2, fixed_day: 9, description: "Baía de Guanabara, 1558", post_slug: "celebration-martyrs-of-guanabara", person_type: "event", gender: "neutral" },
  { name: "Escolástica", fixed_month: 2, fixed_day: 10, description: "Irmã de Bento de Núrsia, 547", post_slug: "celebration-scholastica", person_type: "singular", gender: "feminine" },
  { name: "Cirilo e Metódio", fixed_month: 2, fixed_day: 14, description: "Monge, 869, e Bispo, 885, missionários entre os eslavos", post_slug: "celebration-cyril-and-methodius", person_type: "plural", gender: "masculine" },
  { name: "Policarpo", fixed_month: 2, fixed_day: 23, description: "Bispo de Esmirna e mártir, 156", post_slug: "celebration-policarpus", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # MARÇO
  # ================================================================================
  { name: "Davi", fixed_month: 3, fixed_day: 1, description: "Bispo de Menevia, Gália, 544", post_slug: "celebration-david-of-wales", person_type: "singular", gender: "masculine" },
  { name: "Chad", fixed_month: 3, fixed_day: 2, description: "Bispo de Lichfield, 672", post_slug: "celebration-chad-of-lichfield", person_type: "singular", gender: "masculine" },
  { name: "João e Carlos Wesley", fixed_month: 3, fixed_day: 3, description: "Presbíteros, 1791, 1788", post_slug: "celebration-john-and-charles-wesley", person_type: "plural", gender: "masculine" },
  { name: "Perpétua, Felicidade e seus companheiros", fixed_month: 3, fixed_day: 7, description: "Mártires em Cartago, 203", post_slug: "celebration-perpetua-and-her-companions", person_type: "plural", gender: "mixed" },
  { name: "Fundação da Sociedade Bíblica Britânica e Estrangeira", fixed_month: 3, fixed_day: 7, description: "1804", post_slug: "celebration-british-bible-society", person_type: "event", gender: "neutral" },
  { name: "Dia Internacional da Mulher", fixed_month: 3, fixed_day: 8, description: "Dia Internacional da Mulher", post_slug: "celebration-womens-day", person_type: "event", gender: "neutral" },
  { name: "Gregório", fixed_month: 3, fixed_day: 9, description: "Bispo de Nissa, 394", post_slug: "celebration-gregory-of-nyssa", person_type: "singular", gender: "masculine" },
  { name: "Celebração do Primeiro Culto Protestante no Brasil", fixed_month: 3, fixed_day: 10, description: "Rev. Pierre Richier, calvinista francês, Rio de Janeiro, 1557", post_slug: "celebration-first-protestant-service-brazil", person_type: "event", gender: "neutral" },
  { name: "Gregório Magno", fixed_month: 3, fixed_day: 12, description: "Bispo de Roma, 604", post_slug: "celebration-gregory-the-great", person_type: "singular", gender: "masculine" },
  { name: "Patrício", fixed_month: 3, fixed_day: 17, description: "Bispo e missionário da Irlanda, 461", post_slug: "celebration-patrick", person_type: "singular", gender: "masculine" },
  { name: "Cirilo de Jerusalém", fixed_month: 3, fixed_day: 18, description: "Bispo de Jerusalém, 386", post_slug: "celebration-cyril", person_type: "singular", gender: "masculine" },
  { name: "Cuthbert", fixed_month: 3, fixed_day: 20, description: "Bispo e missionário de Lindisfarne, 687", post_slug: "celebration-cuthbert-of-lindisfarne", person_type: "singular", gender: "masculine" },
  { name: "Thomas Cranmer", fixed_month: 3, fixed_day: 21, description: "Arcebispo de Cantuária, 1556", post_slug: "celebration-thomas-cranmer", person_type: "singular", gender: "masculine" },
  { name: "Jonathan Edwards", fixed_month: 3, fixed_day: 24, description: "Missionário na Nova Inglaterra, 1758", post_slug: "celebration-jonathan-edwards", person_type: "singular", gender: "masculine" },
  { name: "Dia do Episcopado", fixed_month: 3, fixed_day: 30, description: "Dia do Episcopado", post_slug: "celebration-episcopacy", person_type: "event", gender: "neutral" },

  # ================================================================================
  # ABRIL
  # ================================================================================
  { name: "Isidoro", fixed_month: 4, fixed_day: 4, description: "Bispo de Sevilha, 636", post_slug: "celebration-isidoro", person_type: "singular", gender: "masculine" },
  { name: "O Concílio de Trento decreta como Canônicos os Livros Apócrifos", fixed_month: 4, fixed_day: 8, description: "1546", post_slug: "celebration-council-of-trent", person_type: "event", gender: "neutral" },
  { name: "Dietrich Bonhoeffer", fixed_month: 4, fixed_day: 10, description: "Teólogo e mártir na Alemanha, 1945", post_slug: "celebration-dietrich-bonhoeffer", person_type: "singular", gender: "masculine" },
  { name: "Felipe Melanchthon", fixed_month: 4, fixed_day: 19, description: "1560", post_slug: "celebration-philipp-melanchthon", person_type: "singular", gender: "masculine" },
  { name: "Dia do Índio", fixed_month: 4, fixed_day: 19, description: "Dia do Índio", post_slug: "celebration-indio", person_type: "event", gender: "neutral" },
  { name: "Origem do termo 'Protestante'", fixed_month: 4, fixed_day: 20, description: "1529", post_slug: "celebration-origem-do-termo-protestante", person_type: "event", gender: "neutral" },
  { name: "Anselmo", fixed_month: 4, fixed_day: 21, description: "Arcebispo de Cantuária, 1109", post_slug: "celebration-anselm-of-canterbury", person_type: "singular", gender: "masculine" },
  { name: "Descobrimento do Brasil", fixed_month: 4, fixed_day: 22, description: "1500, Dia da Comunidade Luso-Brasileira, 1967", post_slug: "celebration-descobrimento-do-brasil", person_type: "event", gender: "neutral" },
  { name: "Jorge", fixed_month: 4, fixed_day: 23, description: "Mártir, século IV", post_slug: "celebration-george", person_type: "singular", gender: "masculine" },
  { name: "Marcos, evangelista", fixed_month: 4, fixed_day: 25, description: "Marcos, evangelista", post_slug: "celebration-mark-the-evangelist", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # MAIO
  # ================================================================================
  { name: "Felipe e Tiago, apóstolos", fixed_month: 5, fixed_day: 1, description: "Dia do Trabalho", post_slug: "celebration-philip-and-james-apostles", person_type: "plural", gender: "masculine" },
  { name: "Atanásio", fixed_month: 5, fixed_day: 2, description: "Bispo de Alexandria, 373", post_slug: "celebration-atanasius", person_type: "singular", gender: "masculine" },
  { name: "Mônica", fixed_month: 5, fixed_day: 4, description: "Mãe de Agostinho de Hipona, 387", post_slug: "celebration-monica", person_type: "singular", gender: "feminine" },
  { name: "Gregório Nazianzeno", fixed_month: 5, fixed_day: 9, description: "Bispo de Constantinopla, 389", post_slug: "celebration-gregory-of-nazianzus", person_type: "singular", gender: "masculine" },
  { name: "Simão de Cirene", fixed_month: 5, fixed_day: 12, description: "O que ajudou o Senhor a carregar a cruz", post_slug: "celebration-simon-of-cyrene", person_type: "singular", gender: "masculine" },
  { name: "Abolição da Escravatura no Brasil", fixed_month: 5, fixed_day: 13, description: "1888", post_slug: "celebration-abolition-brazil", person_type: "event", gender: "neutral" },
  { name: "São Matias, Apóstolo", fixed_month: 5, fixed_day: 14, description: "Matias, apóstolo", post_slug: "celebration-matthias-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Dia Internacional da Família", fixed_month: 5, fixed_day: 15, description: "Dia Internacional da Família", post_slug: "celebration-family-day", person_type: "event", gender: "neutral" },
  { name: "Brendan", fixed_month: 5, fixed_day: 16, description: "Missionário na Irlanda, 577", post_slug: "celebration-brendan", person_type: "singular", gender: "masculine" },
  { name: "Alcuíno de York", fixed_month: 5, fixed_day: 20, description: "Abade de Tours, 804", post_slug: "celebration-alcuin", person_type: "singular", gender: "masculine" },
  { name: "Criação da Diocese do Recife", fixed_month: 5, fixed_day: 20, description: "1976", post_slug: "celebration-criacao-da-diocese-do-recife", person_type: "event", gender: "neutral" },
  { name: "Beda, o venerável", fixed_month: 5, fixed_day: 25, description: "Presbítero e monge, 735", post_slug: "celebration-bede", person_type: "singular", gender: "masculine" },
  { name: "Agostinho de Cantuária", fixed_month: 5, fixed_day: 26, description: "Primeiro arcebispo de Cantuária, 605", post_slug: "celebration-augustine-of-canterbury", person_type: "singular", gender: "masculine" },
  { name: "João Calvino", fixed_month: 5, fixed_day: 27, description: "1564", post_slug: "celebration-john-calvin", person_type: "singular", gender: "masculine" },
  { name: "Jerônimo de Praga", fixed_month: 5, fixed_day: 30, description: "Reformador da Igreja da Boêmia, 1430", post_slug: "celebration-jeronimus-of-prague", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # JUNHO
  # ================================================================================
  { name: "Justino", fixed_month: 6, fixed_day: 1, description: "Mártir em Roma, 167", post_slug: "celebration-justin-of-rome", person_type: "singular", gender: "masculine" },
  { name: "James Watson Morris", fixed_month: 6, fixed_day: 2, description: "Pioneiro anglicano no Brasil, m. 31/3/1954", post_slug: "celebration-james-watson-morris", person_type: "singular", gender: "masculine" },
  { name: "Lucien Lee Kinsolving", fixed_month: 6, fixed_day: 3, description: "Pioneiro anglicano no Brasil, bispo, m. 18/12/1929", post_slug: "celebration-lucien-lee-kinsolving", person_type: "singular", gender: "masculine" },
  { name: "Bonifácio", fixed_month: 6, fixed_day: 5, description: "Bispo missionário na Alemanha e mártir, 754", post_slug: "celebration-boniface", person_type: "singular", gender: "masculine" },
  { name: "Dia Internacional do Meio Ambiente", fixed_month: 6, fixed_day: 5, description: "Dia Internacional do Meio Ambiente", post_slug: "celebration-environment", person_type: "event", gender: "neutral" },
  { name: "Norberto", fixed_month: 6, fixed_day: 6, description: "Bispo de Magdeburgo, Alemanha, 1134", post_slug: "celebration-norberto", person_type: "singular", gender: "masculine" },
  { name: "Columba", fixed_month: 6, fixed_day: 9, description: "Abade de Iona, 597", post_slug: "celebration-columba", person_type: "singular", gender: "masculine" },
  { name: "Primeira Edição do Livro de Oração Comum (LOC)", fixed_month: 6, fixed_day: 9, description: "1549", post_slug: "celebration-first-edition-bcp", person_type: "event", gender: "neutral" },
  { name: "Efrém", fixed_month: 6, fixed_day: 10, description: "Diácono de Edessa, na Síria, 373", post_slug: "celebration-efrem", person_type: "singular", gender: "masculine" },
  { name: "Barnabé, apóstolo", fixed_month: 6, fixed_day: 11, description: "Barnabé, apóstolo", post_slug: "celebration-barnabas-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Basílio Magno", fixed_month: 6, fixed_day: 14, description: "Bispo de Cesaréia, 379", post_slug: "celebration-basil-the-great", person_type: "singular", gender: "masculine" },
  { name: "Excomunhão de Martinho Lutero", fixed_month: 6, fixed_day: 16, description: "1520", post_slug: "celebration-excommunication-of-martin-luther", person_type: "event", gender: "neutral" },
  { name: "Romualdo", fixed_month: 6, fixed_day: 19, description: "Abade, 1027", post_slug: "celebration-romualdo", person_type: "singular", gender: "masculine" },
  { name: "Albano", fixed_month: 6, fixed_day: 22, description: "Primeiro mártir da Grã-Bretanha, 304", post_slug: "celebration-alban", person_type: "singular", gender: "masculine" },
  { name: "Natividade de João Batista", fixed_month: 6, fixed_day: 24, description: "Natividade de São João Batista", post_slug: "celebration-nativity-of-john-the-baptist", person_type: "event", gender: "neutral" },
  { name: "Confissão de Augsburgo", fixed_month: 6, fixed_day: 25, description: "1530", post_slug: "celebration-confession-of-augsburg", person_type: "event", gender: "neutral" },
  { name: "Cirilo de Alexandria", fixed_month: 6, fixed_day: 27, description: "Bispo de Alexandria, 444", post_slug: "celebration-cyril-of-alexandria", person_type: "singular", gender: "masculine" },
  { name: "Irineu", fixed_month: 6, fixed_day: 28, description: "Bispo de Lion, 202", post_slug: "celebration-irenaeus-of-lyons", person_type: "singular", gender: "masculine" },
  { name: "Sagração de Egmont Machado Krischke", fixed_month: 6, fixed_day: 28, description: "Primeiro Primaz Anglicano do Brasil, 1971", post_slug: "celebration-egmont-machado-krischke", person_type: "singular", gender: "masculine" },
  { name: "Pedro e Paulo, apóstolos", fixed_month: 6, fixed_day: 29, description: "Pedro e Paulo, apóstolos", post_slug: "celebration-peter-and-paul-apostles", person_type: "plural", gender: "masculine" },

  # ================================================================================
  # JULHO
  # ================================================================================
  { name: "São Tomé, apóstolo", fixed_month: 7, fixed_day: 3, description: "Tomé, apóstolo", post_slug: "celebration-thomas-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "João Huss", fixed_month: 7, fixed_day: 6, description: "Precursor da Reforma, 1415", post_slug: "celebration-john-huss", person_type: "singular", gender: "masculine" },
  { name: "Áquila e Priscila", fixed_month: 7, fixed_day: 8, description: "Cooperadores do apóstolo Paulo", post_slug: "celebration-aquila-priscila", person_type: "plural", gender: "mixed" },
  { name: "Bento de Núrsia", fixed_month: 7, fixed_day: 11, description: "Abade de Montecassino, 540", post_slug: "celebration-benedict-of-nursia", person_type: "singular", gender: "masculine" },
  { name: "Silas", fixed_month: 7, fixed_day: 13, description: "Companheiro do apóstolo Paulo", post_slug: "celebration-silas", person_type: "singular", gender: "masculine" },
  { name: "Richard Holden", fixed_month: 7, fixed_day: 17, description: "Tradutor do primeiro Livro de Oração Comum em português, 1876", post_slug: "celebration-richard-holden", person_type: "singular", gender: "masculine" },
  { name: "Maria Madalena", fixed_month: 7, fixed_day: 22, description: "Maria Madalena", post_slug: "celebration-mary-magdalene", person_type: "singular", gender: "feminine" },
  { name: "Thomas a Kempis", fixed_month: 7, fixed_day: 24, description: "Presbítero, 1471", post_slug: "celebration-thomas-kempis", person_type: "singular", gender: "masculine" },
  { name: "Tiago, apóstolo", fixed_month: 7, fixed_day: 25, description: "Tiago, apóstolo", post_slug: "celebration-james-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Marta, Maria e Lázaro de Betânia", fixed_month: 7, fixed_day: 29, description: "Amigos de Jesus", post_slug: "celebration-martha-mary-and-lazarus", person_type: "plural", gender: "mixed" },
  { name: "Pedro Crisólogo", fixed_month: 7, fixed_day: 30, description: "Bispo de Ravena, Itália, 450", post_slug: "celebration-pedro-crisologo", person_type: "singular", gender: "masculine" },
  { name: "José de Arimatéia", fixed_month: 7, fixed_day: 31, description: "Discípulo de Jesus", post_slug: "celebration-joseph-of-arimathea", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # AGOSTO
  # ================================================================================
  { name: "Eusébio", fixed_month: 8, fixed_day: 2, description: "Bispo de Vercelli, 371", post_slug: "celebration-eusebio", person_type: "singular", gender: "masculine" },
  { name: "Nicodemos", fixed_month: 8, fixed_day: 3, description: "Discípulo de Jesus", post_slug: "celebration-nicodemos", person_type: "singular", gender: "masculine" },
  { name: "Oswald de Nortúmbria", fixed_month: 8, fixed_day: 5, description: "Mártir, 642", post_slug: "celebration-oswald-of-northumbria", person_type: "singular", gender: "masculine" },
  { name: "João Ferreira de Almeida", fixed_month: 8, fixed_day: 6, description: "Primeiro tradutor protestante da Bíblia em português, 1691", post_slug: "celebration-joao-ferreira-de-almeida", person_type: "singular", gender: "masculine" },
  { name: "Sisto", fixed_month: 8, fixed_day: 7, description: "Bispo de Roma, e seus companheiros, mártires, 258", post_slug: "celebration-sisto", person_type: "plural", gender: "masculine" },
  { name: "Domingos", fixed_month: 8, fixed_day: 8, description: "Presbítero e frade, 1221", post_slug: "celebration-dominic", person_type: "singular", gender: "masculine" },
  { name: "Lourenço", fixed_month: 8, fixed_day: 10, description: "Diácono e mártir em Roma, 258", post_slug: "celebration-lawrence", person_type: "singular", gender: "masculine" },
  { name: "Destruição de Jerusalém", fixed_month: 8, fixed_day: 10, description: "70 d.C.", post_slug: "celebration-jerusalem-destruction", person_type: "event", gender: "neutral" },
  { name: "Hipólito e Ponciano", fixed_month: 8, fixed_day: 12, description: "Bispos e mártires, 235", post_slug: "celebration-hippolytus-and-pontian", person_type: "plural", gender: "masculine" },
  { name: "Dia da Escola Bíblica Dominical", fixed_month: 8, fixed_day: 19, description: "Dia da Escola Bíblica Dominical", post_slug: "celebration-sunday-school", person_type: "event", gender: "neutral" },
  { name: "Publicação das Institutas da Religião Cristã", fixed_month: 8, fixed_day: 23, description: "João Calvino, 1535", post_slug: "celebration-john-calvin", person_type: "event", gender: "neutral" },
  { name: "Bartolomeu, apóstolo", fixed_month: 8, fixed_day: 24, description: "Bartolomeu, apóstolo", post_slug: "celebration-bartholomew-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Agostinho de Hipona", fixed_month: 8, fixed_day: 28, description: "Bispo de Hipona, 430", post_slug: "celebration-augustine-of-hippo", person_type: "singular", gender: "masculine" },
  { name: "Aidan", fixed_month: 8, fixed_day: 31, description: "Abade e bispo de Lindisfarne, 651", post_slug: "celebration-aidan-of-lindisfarne", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # SETEMBRO
  # ================================================================================
  { name: "Mártires da Nova Guiné", fixed_month: 9, fixed_day: 2, description: "1942", post_slug: "celebration-martyrs-of-papua-new-guinea", person_type: "plural", gender: "masculine" },
  { name: "Dia da Pátria (Independência do Brasil)", fixed_month: 9, fixed_day: 7, description: "Independência do Brasil", post_slug: "celebration-dia-da-patria", person_type: "event", gender: "neutral" },
  { name: "Cipriano", fixed_month: 9, fixed_day: 13, description: "Bispo e mártir de Cartago, 258", post_slug: "celebration-cyprian", person_type: "singular", gender: "masculine" },
  { name: "Ninian", fixed_month: 9, fixed_day: 16, description: "Bispo missionário na Escócia, 430", post_slug: "celebration-ninian", person_type: "singular", gender: "masculine" },
  { name: "Teodoro de Tarso", fixed_month: 9, fixed_day: 19, description: "Arcebispo de Cantuária, 690", post_slug: "celebration-theodore-of-tarsus", person_type: "singular", gender: "masculine" },
  { name: "John Coleridge Patteson", fixed_month: 9, fixed_day: 20, description: "Bispo da Melanésia, e seus companheiros, mártires, 1871", post_slug: "celebration-john-coleridge-patteson", person_type: "plural", gender: "masculine" },
  { name: "Mateus, apóstolo e evangelista", fixed_month: 9, fixed_day: 21, description: "Mateus, apóstolo e evangelista", post_slug: "celebration-matthew-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Sérgio", fixed_month: 9, fixed_day: 25, description: "Abade da SS. Trindade, Moscou, 1392", post_slug: "celebration-sergius", person_type: "singular", gender: "masculine" },
  { name: "Jerônimo", fixed_month: 9, fixed_day: 30, description: "Presbítero e monge em Belém, 420", post_slug: "celebration-jerome-of-bethlehem", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # OUTUBRO
  # ================================================================================
  { name: "Francisco de Assis", fixed_month: 10, fixed_day: 4, description: "Frade, 1226", post_slug: "celebration-francis-of-assisi", person_type: "singular", gender: "masculine" },
  { name: "William Tyndale", fixed_month: 10, fixed_day: 6, description: "Presbítero e mártir, 1536", post_slug: "celebration-william-tyndale", person_type: "singular", gender: "masculine" },
  { name: "Thomas More", fixed_month: 10, fixed_day: 6, description: "Mártir, 1535", post_slug: "celebration-thomas-more", person_type: "singular", gender: "masculine" },
  { name: "John Fisher", fixed_month: 10, fixed_day: 6, description: "Bispo e mártir, 1535", post_slug: "celebration-john-fisher", person_type: "singular", gender: "masculine" },
  { name: "Dionísio", fixed_month: 10, fixed_day: 9, description: "Primeiro bispo de Paris, e seus companheiros, mártires, século III", post_slug: "celebration-dionysius-and-his-companions", person_type: "plural", gender: "masculine" },
  { name: "Paulino", fixed_month: 10, fixed_day: 10, description: "Primeiro arcebispo de York, 644", post_slug: "celebration-paulinus", person_type: "singular", gender: "masculine" },
  { name: "Felipe, diácono e evangelista", fixed_month: 10, fixed_day: 11, description: "Felipe, diácono e evangelista", post_slug: "celebration-philip", person_type: "singular", gender: "masculine" },
  { name: "Huldereich Zwinglio", fixed_month: 10, fixed_day: 11, description: "Presbítero e reformador suíço, 1531", post_slug: "celebration-huldereich-zwinglio", person_type: "singular", gender: "masculine" },
  { name: "Wilfrido", fixed_month: 10, fixed_day: 12, description: "Arcebispo de York, 709", post_slug: "celebration-wilfrido", person_type: "singular", gender: "masculine" },
  { name: "Hugh Latimer e Nicolas Ridley", fixed_month: 10, fixed_day: 16, description: "Bispos e mártires, 1555", post_slug: "celebration-hugh-latimer-and-nicholas-ridley", person_type: "plural", gender: "masculine" },
  { name: "Inácio", fixed_month: 10, fixed_day: 17, description: "Bispo de Antioquia e mártir, 107", post_slug: "celebration-ignatius-antiochia", person_type: "singular", gender: "masculine" },
  { name: "Lucas, evangelista", fixed_month: 10, fixed_day: 18, description: "Lucas, evangelista", post_slug: "celebration-luke-the-evangelist", person_type: "singular", gender: "masculine" },
  { name: "Simão e Judas, apóstolos", fixed_month: 10, fixed_day: 28, description: "Simão e Judas, apóstolos", post_slug: "celebration-simon-and-jude-apostles", person_type: "plural", gender: "masculine" },
  { name: "Reforma Protestante", fixed_month: 10, fixed_day: 31, description: "1517", post_slug: "celebration-protestant-reformation", person_type: "event", gender: "neutral" },

  # ================================================================================
  # NOVEMBRO
  # ================================================================================
  { name: "Fiéis falecidos", fixed_month: 11, fixed_day: 2, description: "Comemoração dos fiéis falecidos", post_slug: "celebration-faithful-departed", person_type: "plural", gender: "masculine" },
  { name: "Illtyd", fixed_month: 11, fixed_day: 6, description: "Abade de Glamorgan, século V", post_slug: "celebration-illtyd", person_type: "singular", gender: "masculine" },
  { name: "Martinho Lutero", fixed_month: 11, fixed_day: 11, description: "Nascido em 1483", post_slug: "celebration-martin-luther", person_type: "singular", gender: "masculine" },
  { name: "Martinho", fixed_month: 11, fixed_day: 11, description: "Bispo de Tours, 397", post_slug: "celebration-martin-of-tours", person_type: "singular", gender: "masculine" },
  { name: "Hilda", fixed_month: 11, fixed_day: 18, description: "Abadessa de Whitby, 680", post_slug: "celebration-hilda-of-whitby", person_type: "singular", gender: "feminine" },
  { name: "Clemente", fixed_month: 11, fixed_day: 23, description: "Bispo de Roma, 100, e Columbano, abade de Bóbio, Itália, 615", post_slug: "celebration-clement-of-rome", person_type: "plural", gender: "masculine" },
  { name: "André, apóstolo", fixed_month: 11, fixed_day: 30, description: "André, apóstolo", post_slug: "celebration-andrew-the-apostle", person_type: "singular", gender: "masculine" },

  # ================================================================================
  # DEZEMBRO
  # ================================================================================
  { name: "João Damasceno", fixed_month: 12, fixed_day: 4, description: "Presbítero, 760", post_slug: "celebration-john-of-damascus", person_type: "singular", gender: "masculine" },
  { name: "Confissão de Westminster", fixed_month: 12, fixed_day: 4, description: "1646", post_slug: "celebration-confession-of-westminster", person_type: "event", gender: "neutral" },
  { name: "Clemente de Alexandria", fixed_month: 12, fixed_day: 5, description: "Presbítero, 210", post_slug: "celebration-clement-of-alexandria", person_type: "singular", gender: "masculine" },
  { name: "Nicolau de Mira", fixed_month: 12, fixed_day: 6, description: "Turquia, 342", post_slug: "celebration-nicholas", person_type: "singular", gender: "masculine" },
  { name: "Ambrósio", fixed_month: 12, fixed_day: 7, description: "Bispo de Milão, 397", post_slug: "celebration-ambrose", person_type: "singular", gender: "masculine" },
  { name: "João da Cruz", fixed_month: 12, fixed_day: 14, description: "Monge, 1591", post_slug: "celebration-john-of-the-cross", person_type: "singular", gender: "masculine" },
  { name: "Estevão", fixed_month: 12, fixed_day: 26, description: "Diácono e mártir", post_slug: "celebration-stephen", person_type: "singular", gender: "masculine" },
  { name: "João, apóstolo e evangelista", fixed_month: 12, fixed_day: 27, description: "João, apóstolo e evangelista", post_slug: "celebration-john-the-apostle", person_type: "singular", gender: "masculine" },
  { name: "Thomas Becket", fixed_month: 12, fixed_day: 29, description: "Arcebispo de Cantuária e mártir, 1170", post_slug: "celebration-thomas-becket", person_type: "singular", gender: "masculine" },
  { name: "Silvestre", fixed_month: 12, fixed_day: 31, description: "Bispo de Roma, 335", post_slug: "celebration-silvestre", person_type: "singular", gender: "masculine" },
  { name: "John Wycliff", fixed_month: 12, fixed_day: 31, description: "Precursor da Reforma, 1384", post_slug: "celebration-john-wycliffe", person_type: "singular", gender: "masculine" }
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
    post_slug: comm[:post_slug],
    person_type: comm[:person_type],
    gender: comm[:gender],
    prayer_book_id: prayer_book&.id
  }

  Celebration.create!(data)
  Rails.logger.info "  ✓ #{comm[:fixed_month]}/#{comm[:fixed_day]} - #{comm[:name]}"
end

Rails.logger.info "  📅 Total: #{commemorations.count} comemorações criadas"