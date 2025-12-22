# Find the LOCB 2008 prayer book
locb_2008 = PrayerBook.find_by(code: "locb_2008")

# ================================================================================
# LOCB 2008 PREFERENCE CATEGORIES AND DEFINITIONS
# ================================================================================

locb_2008_preferences = [
  {
    key: "daily_office",
    name: "Ofício Diário",
    description: "Customize as orações e elementos do ofício diário",
    icon: "auto_stories",
    position: 1,
    preferences: [
      {
        key: "office_type",
        name: "Tipo de Ofício",
        description: "Escolha entre o ofício tradicional ou adaptado",
        pref_type: "select_one",
        required: true,
        default_value: "traditional",
        position: 1,
        options: [
          { value: "traditional", label: "Ofício Tradicional", description: "Ofício Diário completo e tradicional" },
          { value: "family", label: "Ofício para Indivíduo e Família", description: "Versão BEM simplificada para uso individual ou em família" }
        ]
      }
    ]
  },
  {
    key: "morning_prayer",
    name: "Tipo da Oração da Manhã",
    description: "Configure o ofício da manhã como preferir",
    icon: "wb_sunny",
    position: 2,
    preferences: [
      {
        key: "morning_prayer_rite",
        name: "Ofício Escolhido",
        description: "Escolha a Oração Matutina a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 1,
        options: [
          { value: "1", label: "Oração Matutina I", description: "" },
          { value: "2", label: "Oração Matutina II", description: "" },
          { value: "3", label: "Oração Matutina III", description: "" },
          { value: "4", label: "Oração Matutina IV (BCP 1928)", description: "" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "morning_prayer_1",
    name: "Oração da Manhã I",
    description: "Configure o ofício da manhã I como preferir",
    icon: "wb_sunny",
    position: 3,
    preferences: [
      {
        key: "morning_1_preparation",
        name: "Preparação",
        description: "Escolha a preparação a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "1", description: "Graça, misericórdia e Paz de Deus..." },
          { value: "2", label: "2", description: "Senhor, abre meus lábios..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_1_conclusion",
        name: "Conclusão",
        description: "Escolha a conclusão a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "blessing", label: "A bênção", description: "O Senhor nos abençoe, guarde de todo mal..." },
          { value: "grace", label: "A graça", description: "A graça de nosso Senhor Jesus Cristo..." },
          { value: "peace", label: "A paz", description: "Que a paz de Deus que excede..." },
          { value: "dismissal", label: "A despedida", description: "Ide na paz de Cristo! Sede corajosos e fortes..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "morning_prayer_2",
    name: "Oração da Manhã II",
    description: "Configure o ofício da manhã II como preferir",
    icon: "wb_sunny",
    position: 4,
    preferences: [
      {
        key: "morning_2_confession_invitation",
        name: "Convite à Confissão",
        description: "Escolha o texto a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "1", description: "Amados irmãos, as Escrituras nos recomendam..." },
          { value: "2", label: "2", description: "Amados, nós nos aproximamos da presença de Deus..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_2_canticle_post_reading",
        name: "Cântico - Pós Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "benedictus", label: "Benedictus", description: "Bendito seja o Senhor, Deus de Israel..." },
          { value: "jubilate_deo", label: "Jubilate Deo", description: "Celebrai com júbilo ao Senhor, todas as terras..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_2_conclusion",
        name: "Conclusão",
        description: "Escolha a conclusão a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "grace", label: "A graça", description: "A graça de nosso Senhor Jesus Cristo..." },
          { value: "dismissal", label: "A despedida", description: "Ide na paz de Cristo! Sede corajosos e fortes..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "morning_prayer_3",
    name: "Oração da Manhã III",
    description: "Configure o ofício da manhã III como preferir",
    icon: "wb_sunny",
    position: 5,
    preferences: [
      {
        key: "morning_3_canticle_before_reading",
        name: "Cântico - Antes da Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "venite", label: "Venite", description: "Vinde, cantemos ao Senhor, com júbilo..." },
          { value: "jubilate_deo", label: "Jubilate Deo", description: "Celebrai com júbilo ao Senhor, todas as terras..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_3_canticle_after_reading",
        name: "Cântico - Pós Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "benedictus", label: "Benedictus", description: "Bendito seja o Senhor, Deus de Israel..." },
          { value: "benedic_anima_mea", label: "Benedic, anima mea", description: "Bendize, ó minha alma, ao Senhor, e tudo..." },
          { value: "magna_et_mirabilia", label: "Magna et mirabilia", description: "Grandes e admiráveis são as tuas obras..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_3_canticle_after_second_reading",
        name: "Cântico - Pós Segunda Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "te_deum", label: "Te Deum laudamus", description: "A Ti, ó Deus, louvamos e, por Senhor nosso, confessamos..." },
          { value: "gloria_in_excelsis", label: "Gloria in excelsis", description: "Glória a Deus nas alturas, e na terra paz..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_3_prayer_conclusion",
        name: "Oração de Conclusão",
        description: "Escolha a oração de conclusão a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "1", label: "1 (mais longa)", description: "Senhor, mostra-nos a tua misericórdia..." },
          { value: "2", label: "2 (mais curta)", description: "Senhor Deus, pedimos a tua bênção: para a tua Igreja..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_2_conclusion",
        name: "Conclusão",
        description: "Escolha a oração final a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "1", label: "1", description: "Pai eterno e onipotente: agradecemos-Te..." },
          { value: "2", label: "2", description: "Ó Deus, Tu és o Autor da paz e amas a concórdia..." },
          { value: "3", label: "3", description: "Deus, Pai eterno, fomos criados pelo teu poder..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "morning_prayer_4",
    name: "Oração da Manhã IV",
    description: "Configure o ofício da manhã IV como preferir",
    icon: "wb_sunny",
    position: 6,
    preferences: [
      {
        key: "morning_4_invitatory",
        name: "Sentença de Abertura",
        description: "Escolha a sentença inicial a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "Hab 2:20", description: "O Senhor, porém, está no seu santo templo..." },
          { value: "2", label: "Salmo 122:1", description: "Alegrei-me quando me disseram..." },
          { value: "3", label: "Salmo 19:14", description: "As palavras dos meus lábios e o meditar..." },
          { value: "4", label: "Salmo 43:3", description: "Envia a tua luz e a tua verdade, para que..." },
          { value: "5", label: "Isaías 57:15", description: "Porque assim diz o Alto, o Sublime, que habita..." },
          { value: "6", label: "João 4:23", description: "Mas vem a hora e já chegou, em que os..." },
          { value: "7", label: "Fil 1:2", description: "Graça e paz a vós outros, da parte de Deus..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_4_confession_type",
        name: "Confissão",
        description: "Formato da confissão de pecados",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "long", label: "Longa", description: "Meus irmãos muito amados, a Escritura nos exorta..." },
          { value: "short", label: "Breve", description: "Confessemos humildemente os nossos pecados a Deus Todo-poderoso." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_4_canticle_after_first_reading",
        name: "Cântico - Pós Primeira Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "te_deum", label: "Te Deum laudamus", description: "A Ti, ó Deus, louvamos, e por Senhor nosso confessamos..." },
          { value: "benedictus_es_domine", label: "Benedictus es, Domine", description: "Bendito és tu, Senhor Deus de nossos pais..." },
          { value: "benedicite_omnia_opera_domini", label: "Benedicite omnia opera Domini", description: "Bendigam ao Senhor todas as suas Obras..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_4_canticle_after_second_reading",
        name: "Cântico - Pós Segunda Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "benedictur", label: "Benedictus", description: "Bendito seja o Senhor, Deus de Israel..." },
          { value: "jubilate_deo", label: "Jubilate Deo", description: "Celebrai com júbilo ao Senhor, todas as terras..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_4_creed_type",
        name: "Credo Apostólico",
        description: "Escolha o tipo de credo a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "apostolic", label: "Apostólico", description: "Creio em Deus Pai Todo-poderoso..." },
          { value: "nicene", label: "Niceno-Constantinopolitano", description: "Creio em um só Deus Pai Onipotente..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_4_general_collects",
        name: "Coletas Gerais",
        description: "Escolha a(s) coleta(s) a ser(em) utilizada(s)",
        pref_type: "select_one",
        required: true,
        default_value: "for_peace",
        position: 6,
        options: [
          { value: "for_peace", label: "Pela paz", description: "Ó Deus, que és da paz o autor e amigo..." },
          { value: "for_grace", label: "Pela graça", description: "Ó Senhor, nosso Pai celestial, Todo-poderoso..." },
          { value: "for_authorities_1", label: "Pelas autoridades - 1", description: "Ó Senhor, nosso Pai celeste, alto e poderoso..." },
          { value: "for_authorities_2", label: "Pelas autoridades - 2", description: "Ó Senhor, que nos governas, e de quem a glória..." },
          { value: "for_clergy", label: "Pelo clero", description: "Onipotente e sempiterno Deus, do qual mana..." },
          { value: "for_all_humanity", label: "Por toda a humanidade", description: "Ó Deus, Criador e Preservador de todo o gênero humano..." },
          { value: "general_thanksgiving", label: "Geral de Ação de Graças", description: "Onipotente Deus, Pai de toda a misericórdia..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todas", description: "Quero todas as coletas" }
        ]
      }
    ]
  },
  {
    key: "midday_prayer",
    name: "Oração do Meio-Dia",
    description: "Configure o ofício do meio-dia como preferir",
    icon: "wb_sunny_outlined",
    position: 7,
    preferences: [
      {
        key: "midday_psalm",
        name: "Cântico - Invitatório",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "psalm_119", label: "Salmo 119", description: "Lâmpada para os meus pés é a tua palavra..." },
          { value: "psalm_121", label: "Salmo 121", description: "Elevo os olhos para os montes: de onde..." },
          { value: "psalm_126", label: "Salmo 126", description: "Quando o Senhor restaurou a sorte de Sião..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "midday_collect",
        name: "Coleta",
        description: "Escolha a coleta a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "1", label: "1", description: "Pai celestial, envia teu Santo Espírito..." },
          { value: "2", label: "2", description: "Bendito Salvador, nesta hora em que..." },
          { value: "3", label: "3", description: "Salvador Todo-poderoso, que ao meio-dia..." },
          { value: "4", label: "4", description: "Senhor Jesus Cristo, que disseste aos vossos apóstolos..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      }
    ]
  },
  {
    key: "evening_prayer",
    name: "Tipo da Oração da Tarde",
    description: "Configure o ofício da tarde como preferir",
    icon: "wb_sunny_outlined",
    position: 8,
    preferences: [
      {
        key: "evening_opening_sentence",
        name: "Ofício Escolhido",
        description: "Escolha a Oração Vespertina a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 1,
        options: [
          { value: "1", label: "Oração Vespertina I", description: "" },
          { value: "2", label: "Oração Vespertina II", description: "" },
          { value: "3", label: "Oração Vespertina III", description: "" },
          { value: "4", label: "Oração Vespertina IV (BCP 1928)", description: "" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "evening_prayer_1",
    name: "Oração da Tarde I",
    description: "Configure o ofício da tarde I como preferir",
    icon: "wb_sunny_outlined",
    position: 9,
    preferences: [
      {
        key: "evening_1_preparation",
        name: "Preparação",
        description: "Escolha a preparação a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "1", description: "A luz e paz de Jesus Cristo estejam com vocês..." },
          { value: "2", label: "2", description: "Deus, apressa-te em nos salvar..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_1_canticle_post_reading",
        name: "Cântico - Abertura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "psalm_104", label: "Salmo 104", description: "Bendize, ó minha alma, ao Senhor..." },
          { value: "psalm_141", label: "Salmo 141", description: "Senhor, a ti clamo, dá-te pressa em me acudir..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_1_lords_prayer_opening",
        name: "A Oração do Senhor - Abertura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "1", label: "Salmo 104", description: "Juntando nossas vozes e louvores, numa só voz, oremos como Jesus Cristo
nos ensinou..." },
          { value: "2", label: "Salmo 141", description: "Juntando nossas orações e louvores numa só voz, oremos com confiança
como Jesus nos ensinou..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_1_conclusion",
        name: "Conclusão",
        description: "Escolha a conclusão a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "grace", label: "A graça", description: "A graça de nosso Senhor Jesus Cristo..." },
          { value: "peace", label: "A paz", description: "Que a paz de Deus que excede..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "evening_prayer_2",
    name: "Oração da Tarde II",
    description: "Configure o ofício da tarde II como preferir",
    icon: "wb_sunny_outlined",
    position: 10,
    preferences: [
      {
        key: "evening_2_preparation",
        name: "Preparação",
        description: "Escolha a preparação a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "1", description: "Amados irmãos, a Escritura nos recomenda em vários lugares..." },
          { value: "2", label: "2", description: "Amados, estamos juntos na presença de Deus Todo-poderoso..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_2_canticle_post_first_reading",
        name: "Cântico - Pós Primeira Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "magnificat", label: "Magnificat", description: "A minha alma engrandece ao Senhor..." },
          { value: "cantate_domino", label: "Cantate Domino", description: "Cantai ao Senhor um cântico novo..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_2_canticle_post_second_reading",
        name: "Cântico - Pós Segunda Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "nunc_dimittis", label: "Nunc dimittis", description: "Agora, Senhor, podes despedir em paz..." },
          { value: "deus_misereatur", label: "Deus misereatur", description: "Seja Deus gracioso para conosco, e nos..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_2_creed_type",
        name: "Credo Apostólico",
        description: "Escolha o tipo de credo a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "apostolic", label: "Apostólico", description: "Creio em Deus Pai Todo-poderoso..." },
          { value: "nicene", label: "Niceno-Constantinopolitano", description: "Creio em um só Deus Pai Onipotente..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_2_conclusion",
        name: "Conclusão",
        description: "Escolha a conclusão a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "grace", label: "A graça", description: "A graça de nosso Senhor Jesus Cristo..." },
          { value: "dismissal", label: "A despedida", description: "Ide na paz de Cristo! Sede corajosos..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "evening_prayer_3",
    name: "Oração da Tarde III",
    description: "Configure o ofício da tarde III como preferir",
    icon: "wb_sunny_outlined",
    position: 11,
    preferences: [
      {
        key: "evening_3_invitating_canticle",
        name: "Cântico - Invitatório",
        description: "Escolha o salmo a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "Salmo 134", description: "Bendizei ao Senhor, vós todos..." },
          { value: "2", label: "Phos hilaron", description: "Salve, alegre luz, puro esplendor..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_3_canticle_post_first_reading",
        name: "Cântico - Pós Primeira Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "magnificat", label: "Magnificat", description: "A minha alma engrandece ao Senhor..." },
          { value: "benedic_anima_mea", label: "Benedic, anima mea", description: "Bendize, ó minha alma, ao Senhor..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_3_canticle_post_second_reading",
        name: "Cântico - Pós Segunda Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "nunc_dimittis", label: "Nunc dimittis", description: "Agora, Senhor, podes despedir em paz..." },
          { value: "canticle_of_christ_glory", label: "Cântico da glória de Cristo", description: "Pois Cristo, subsistindo em forma de Deus..." },
          { value: "gloria_et_honor", label: "Glória e honra", description: "Tu és digno, Senhor e Deus nosso..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_3_conclusion",
        name: "Conclusão",
        description: "Escolha a conclusão a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "1", label: "1", description: "Ó Deus origem dos desejos bons..." },
          { value: "2", label: "2", description: "Ilumina as nossas trevas, nós te pedimos..." },
          { value: "3", label: "3", description: "Senhor Deus, pedimos a tua bênção:..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
     key: "evening_prayer_4",
    name: "Oração da Tarde IV",
    description: "Configure o ofício da tarde IV como preferir",
    icon: "wb_sunny_outlined",
    position: 12,
    preferences: [
      {
        key: "evening_4_invitatory",
        name: "Sentença de Abertura",
        description: "Escolha a sentença inicial a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "Hab 2:20", description: "O Senhor, porém, está no seu santo templo..." },
          { value: "2", label: "Salmo 26:8", description: "Eu amo, Senhor, a habitação de tua casa..." },
          { value: "3", label: "Salmo 141:2", description: "Suba à tua presença a minha oração..." },
          { value: "4", label: "Salmo 96:9", description: "Adorai o Senhor na beleza da sua santidade..." },
          { value: "5", label: "Salmo 19:14", description: "As palavras dos meus lábios e o meditar..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_4_confession_type",
        name: "Confissão",
        description: "Formato da confissão de pecados",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "long", label: "Longa", description: "Meus irmãos muito amados, a Escritura nos exorta..." },
          { value: "short", label: "Breve", description: "Confessemos humildemente os nossos pecados a Deus Todo-poderoso." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_4_canticle_after_first_reading",
        name: "Cântico - Pós Primeira Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "magnificat", label: "Magnificat", description: "A minha alma engrandece ao Senhor..." },
          { value: "cantate_domino", label: "Cantate Domino", description: "Cantai ao Senhor um cântico novo..." },
          { value: "bonum_est_confiteri", label: "Bonum est confiteri", description: "Bom é render graças ao Senhor..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_4_canticle_after_second_reading",
        name: "Cântico - Pós Segunda Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "nunc_dimittis", label: "Nunc dimittis", description: "Agora, Senhor, podes despedir em paz..." },
          { value: "deus_misereatur", label: "Deus misereatur", description: "Seja Deus gracioso para conosco, e nos..." },
          { value: "benedic_anima_mea", label: "Benedic, anima mea", description: "Bendize, ó minha alma, ao Senhor, e tudo..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_4_creed_type",
        name: "Credo Apostólico",
        description: "Escolha o tipo de credo a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "apostolic", label: "Apostólico", description: "Creio em Deus Pai Todo-poderoso..." },
          { value: "nicene", label: "Niceno-Constantinopolitano", description: "Creio em um só Deus Pai Onipotente..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_4_general_collects",
        name: "Coletas Gerais",
        description: "Escolha a(s) coleta(s) a ser(em) utilizada(s)",
        pref_type: "select_one",
        required: true,
        default_value: "for_peace",
        position: 6,
        options: [
          { value: "for_peace", label: "Pela paz", description: "Ó Deus, de quem procedem os desejos santos..." },
          { value: "against_dangers_of_night", label: "Contra os Perigos da Noite", description: "Ilumina, suplicamos-te, Senhor Deus..." },
          { value: "for_authorities", label: "Pelas autoridades", description: "Ó Deus Onipotente, de quem o reino..." },
          { value: "for_clergy", label: "Pelo clero", description: "Onipotente e sempiterno Deus, do qual mana..." },
          { value: "for_all_humanity", label: "Por toda a humanidade", description: "Ó Deus, Criador e Preservador de todo o gênero humano..." },
          { value: "general_thanksgiving", label: "Geral de Ação de Graças", description: "Onipotente Deus, Pai de toda a misericórdia..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todas", description: "Quero todas as coletas" }
        ]
      }
    ]
  },
  {
    key: "compline_prayer",
    name: "Tipo da Oração da Noite",
    description: "Configure o ofício da noite como preferir",
    icon: "wb_sunny",
    position: 2,
    preferences: [
      {
        key: "compline_opening_sentence",
        name: "Ofício Escolhido",
        description: "Escolha a Oração Noturna a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 1,
        options: [
          { value: "1", label: "Oração Noturna I", description: "" },
          { value: "2", label: "Oração Noturna II", description: "" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "compline_prayer_1",
    name: "Oração da Noite I",
    description: "Configure o ofício das completas I como preferir",
    icon: "wb_sunny_outlined",
    position: 13,
    preferences: [
      {
        key: "compline_1_brief_lesson",
        name: "Frase de Abertura",
        description: "Escolha a frase de abertura a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "Jr 14:9", description: "Senhor, tu estás no nosso meio" },
          { value: "2", label: "Mt 11:28-30", description: "Vinde a Mim todos os que andais cansados" },
          { value: "3", label: "1 Pe 5:8-9", description: "Sede prudentes e estai alerta, pois o vosso" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "compline_1_psalm",
        name: "Salmo",
        description: "Escolha o salmo a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "psalm_4", label: "Salmo 4", description: "Responde-me quando clamo, ó Deus da minha justiça..." },
          { value: "psalm_16", label: "Salmo 16:7", description: "Bendigo o Senhor, que me aconselha..." },
          { value: "psalm_17", label: "Salmo 17:1b-8", description: "Atende ao meu clamor, dá ouvidos à minha oração..." },
          { value: "psalm_31", label: "Salmo 31:2-6", description: "Inclina-me os ouvidos, livra-me depressa..." },
          { value: "psalm_91", label: "Salmo 91", description: "O que habita no esconderijo do Altíssimo..." },
          { value: "psalm_134", label: "Salmo 134", description: "Bendizei ao Senhor, vós todos, servos..." },
          { value: "psalm_139", label: "Salmo 139:1-12, 23-24", description: "Senhor, tu me sondas e me conheces..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "compline_1_final_prayer",
        name: "Oração Final",
        description: "Escolha a oração final a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "1", label: "1", description: "Visita, Senhor, esta morada, e afasta dela.." },
          { value: "2", label: "2", description: "Senhor, sê Tu a nossa luz durante a noite..." },
          { value: "3", label: "3", description: "Sê conosco, bondoso Deus, e protege-nos..." },
          { value: "4", label: "4", description: "Senhor nosso Deus, concede-nos um descanso..." },
          { value: "5", label: "5", description: "Senhor, olha-nos complacente do teu trono..." },
          { value: "6", label: "6", description: "Senhor Jesus Cristo, Filho do Deus vivo..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "compline_1_conclusion",
        name: "Conclusão",
        description: "Escolha a conclusão a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "1", label: "1", description: "O Senhor, onipotente e misericordioso..." },
          { value: "2", label: "2", description: "Ide na paz de Cristo! Sede corajosos..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "compline_prayer_2",
    name: "Oração da Noite II",
    description: "Configure o ofício das completas II como preferir",
    icon: "wb_sunny_outlined",
    position: 14,
    preferences: [
      {
        key: "compline_2_psalm",
        name: "Salmo",
        description: "Escolha o salmo a ser utilizado",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "psalm_4", label: "Salmo 4", description: "Responde-me quando clamo, ó Deus da minha justiça..." },
          { value: "psalm_91", label: "Salmo 91", description: "O que habita no esconderijo do Altíssimo..." },
          { value: "psalm_134", label: "Salmo 134", description: "Bendizei ao Senhor, vós todos, servos..." },
          { value: "te_lucis_ante_terminum", label: "Te lucis ante terminum", description: "Antes que a luz chegue ao fim, Ó Criador, te pedimos..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "compline_2_final_prayer",
        name: "Oração Final",
        description: "Escolha a oração final a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "1", label: "1", description: "Ilumina, suplicamos-te, Senhor Deus..." },
          { value: "2", label: "2", description: "Visita, ó Senhor, este lugar, e afasta..." },
          { value: "3", label: "3", description: "Sê presente conosco, ó Deus de misericórdia..." },
          { value: "4", label: "4", description: "Vela, ó Senhor amado, com os que trabalham..." },
          { value: "5", label: "5", description: "Ó Deus, tua Providência inesgotável ..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  }
]

# Create categories and preferences
locb_2008_preferences.each do |category_data|
  preferences = category_data.delete(:preferences)

  category = locb_2008.preference_categories.find_or_initialize_by(key: category_data[:key])
  category.assign_attributes(category_data)
  category.save!

  preferences.each do |pref_data|
    definition = category.preference_definitions.find_or_initialize_by(key: pref_data[:key])
    definition.assign_attributes(pref_data)
    definition.save!
  end
end

puts "✅ Seeded #{PreferenceCategory.count} preference categories"
puts "✅ Seeded #{PreferenceDefinition.count} preference definitions"
