# Find the LOC 2015 prayer book
loc_2015 = PrayerBook.find_by(code: "loc_2015")

# ================================================================================
# LOC 2015 PREFERENCE CATEGORIES AND DEFINITIONS
# ================================================================================

loc_2015_preferences = [
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
          { value: "family", label: "Ofício para Indivíduo e Família", description: "Versão simplificada para uso individual ou em família" }
        ]
      },
      {
        key: "prayer_style",
        name: "Estilo das Orações",
        description: "Linguagem das orações litúrgicas",
        pref_type: "select_one",
        required: true,
        default_value: "traditional",
        position: 2,
        options: [
          { value: "traditional", label: "Orações Tradicionais", description: "Linguagem clássica e formal" },
          { value: "contemporary", label: "Orações Contemporâneas", description: "Linguagem moderna e atualizada" }
        ]
      }
    ]
  },
  {
    key: "lectionary",
    name: "Lecionário",
    description: "Configure as leituras bíblicas diárias",
    icon: "book",
    position: 2,
    preferences: [
      {
        key: "reading_type",
        name: "Padrão de Leituras",
        description: "Como as leituras são organizadas a partir do Próprio 4",
        pref_type: "select_one",
        required: true,
        default_value: "semicontinuous",
        position: 1,
        options: [
          { value: "semicontinuous", label: "Leituras Semi-Contínuas", description: "Relacionam-se com os textos do Primeiro Testamento do domingo anterior e do seguinte" },
          { value: "complementary", label: "Leituras Complementares", description: "Têm maior relação com os textos do Segundo Testamento do mesmo dia" }
        ]
      }
    ]
  },
  {
    key: "morning_prayer",
    name: "Oração da Manhã",
    description: "Configure o ofício da manhã como preferir",
    icon: "wb_sunny",
    position: 3,
    preferences: [
      {
        key: "confession_type",
        name: "Confissão",
        description: "Formato da confissão de pecados",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "long", label: "Longa", description: "Irmãs e irmãos em Cristo, na presença de Deus..." },
          { value: "short", label: "Breve", description: "Confessemos humildemente os nossos pecados a Deus Todo-poderoso." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_confession_prayer_type",
        name: "Oração de Confissão",
        description: "Formato da oração de confissão de pecados",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "1", label: "1", description: "Misericordioso Deus, confessamos que temos pecado contra ti..." },
          { value: "2", label: "2", description: "Ó Deus, sentimos sobre nossos ombros o peso..." },
          { value: "3", label: "3", description: "Tem misericórdia de nós, ó Deus, segundo a tua benignidade..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_inviting_canticle",
        name: "Cântico - Invitatório",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "venite", label: "Venite, exultemus Domino", description: "Salmo 95 - \"Venham, cantemos ao SENHOR\"" },
          { value: "jubilate", label: "Jubilate Deo", description: "Salmo 100 - \"CELEBREM com júbilo ao SENHOR\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "morning_post_first_reading_canticle",
        name: "Cântico - após a Primeira Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "benedictus", label: "Benedictus es, Domine", description: "\"Bendito és tu, Senhor Deus de nossas mães e nossos pais\"" },
          { value: "cantate_domino", label: "Cantate Domino", description: "Salmo 98 - \"CANTEM ao SENHOR um cântico novo\"" },
          { value: "benedicite_omnia_opera", label: "Benedicite Omnia Opera", description: "Dn 3.57-87 - \"Bendigam ao SENHOR todas as suas obras\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os cânticos" }
        ]
      },
      {
        key: "morning_post_second_reading_canticle",
        name: "Cântico - após a Segunda Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "te_deum", label: "Te Deum Laudamus", description: "\"A ti, ó Deus, louvamos, e por Senhor nosso confessamos\"" },
          { value: "magna_et_mirabilia", label: "Magna et mirabilia", description: "Ap 15.3,4 - \"Grandes e admiráveis são as tuas obras\"" },
          { value: "benedic_anima_mea", label: "Benedic, anima mea", description: "Salmo 103 - \"BENDIZE, ó minha alma, ao SENHOR\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os cânticos" }
        ]
      },
      {
        key: "morning_creed_type",
        name: "Credo",
        description: "Tipo de Credo",
        pref_type: "select_one",
        required: true,
        default_value: "apostolic",
        position: 5,
        options: [
          { value: "apostolic", label: "Credo Apostólico", description: "Creio em Deus Pai todo-poderoso..." },
          { value: "apostolic_paraphrase", label: "Paráfrase do Credo Apostólico", description: "Bendigamos a Deus, Pai, Filho e Espírito Santo..." }
        ]
      },
      {
        key: "morning_post_lords_prayer_prayer",
        name: "Oração após o Pai Nosso",
        description: "Escolha a versão da oração",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 6,
        options: [
          { value: "1", label: "1", description: "Ó Senhor, mostra-nos a tua misericórdia..." },
          { value: "2", label: "2", description: "Salva, ó Deus, o teu povo..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "morning_general_collects",
        name: "Coletas Gerais",
        description: "Escolha a(s) coleta(s) a ser(em) utilizada(s)",
        pref_type: "select_one",
        required: true,
        default_value: "for_peace",
        position: 7,
        options: [
          { value: "for_peace", label: "Pela paz", description: "Ó Deus, que és o autor da paz..." },
          { value: "for_grace", label: "Pela graça", description: "Ó Deus Eterno, nosso Pai e Mãe de misericórdia..." },
          { value: "for_all_authorities", label: "Por todas as autoridades", description: "Ó Deus, que és justo e compassivo, oramos por nosso país e pelo mundo todo..." },
          { value: "for_clergy", label: "Pela liderança clerical", description: "Ó Deus, nosso Pai Materno, oramos pela liderança clerical de tua Igreja" },
          { value: "for_parish_family", label: "Pela família paroquial", description: "Ó Deus, Espírito Santo, Santificador das pessoas fiéis..." },
          { value: "for_all_humanity", label: "Por toda a humanidade", description: "Ó Deus, Criador e Protetor de todo o gênero humano..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todas", description: "Quero todas as coletas" }
        ]
      },
      {
        key: "morning_general_thanksgivings",
        name: "Coleta Geral de Ação de Graças",
        description: "Escolha a(s) coleta(s) a ser(em) utilizada(s)",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 8,
        options: [
          { value: "1", label: "1", description: "Nós te bendizemos por nossa criação..." },
          { value: "2", label: "2", description: "Pelo dom de teu Espírito. Bendito sejas, ó Cristo..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todas", description: "Quero ambas as coletas" }
        ]
      },
      {
        key: "morning_concluding_prayer",
        name: "Oração Conclusiva",
        description: "Escolha a oração a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 9,
        options: [
          { value: "1", label: "2 Co 13.14", description: "A Graça de nosso Senhor Jesus Cristo..." },
          { value: "2", label: "Nm 6.24-26", description: "O Senhor nos abençoe e nos guarde..." },
          { value: "2", label: "Rm 15.13", description: "Que o Deus da esperança..." },
          { value: "2", label: "Ef 3.20-21", description: "Glória a Deus, cujo poder agindo em nós..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "midday_prayer",
    name: "Oração do Meio-Dia",
    description: "Configure o ofício do meio-dia como preferir",
    icon: "wb_sunny_outlined",
    position: 4,
    preferences: [
      {
        key: "midday_inviting_canticle",
        name: "Cântico - Invitatório",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "lucerna_pedius_meis", label: "Lucerna pedibus meis", description: "Salmo 119 - \"A TUA palavra é lâmpada para os meus pés\"" },
          { value: "levavi_oculos", label: "Levavi oculos", description: "Salmo 121 - \"PARA os montes elevo os meus olhos\"" },
          { value: "in_convertendo", label: "In convertendo", description: "Salmo 126 - \"QUANDO o SENHOR nos fez voltar do cativeiro\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      }
    ]
  },
  {
    key: "evening_prayer",
    name: "Oração da Tarde",
    description: "Configure o ofício da tarde como preferir",
    icon: "wb_sunny_outlined",
    position: 5,
    preferences: [
      {
        key: "evening_opening_sentence",
        name: "Sentença Inicial",
        description: "Escolha a sentença inicial a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "Sl 26.8 / Sl 141.2", description: "Eu amo, SENHOR, a habitação da tua casa..." },
          { value: "2", label: "Sl 19.15 / Sl 43.3", description: "Sejam bem aceitas as palavras de minha boca..." },
          { value: "3", label: "Sl 74.16,17", description: "O dia e a noite são teus; formaste a luz e o sol..." },
          { value: "4", label: "Sl 96.9,13", description: "Adorem ao SENHOR na beleza da santidade..." },
          { value: "5", label: "Sl 16.7-8", description: "Bendigo ao SENHOR que aconselha..." },
          { value: "6", label: "Sl 119.105 / Sl 17.5", description: "A tua palavra é lâmpada para os meus pés..." },
          { value: "7", label: "Sl 139.11-12", description: "Mesmo que eu dissesse: Cubram-me só trevas..." },
          { value: "8", label: "Jo 8.12", description: "Jesus disse: Eu sou a luz do mundo..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_confession_type",
        name: "Confissão",
        description: "Formato da confissão de pecados",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "long", label: "Longa", description: "Queridas irmãs e irmãos, as Santas Escrituras nos lembram..." },
          { value: "short", label: "Breve", description: "Confessemos humildemente os nossos pecados a Deus Todo-poderoso." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_confession_prayer_type",
        name: "Oração de Confissão",
        description: "Formato da oração de confissão de pecados",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "1", label: "1", description: "Justo e compassivo Deus, nós chegamos à tua presença..." },
          { value: "2", label: "2", description: "Ó Deus de misericórdia; temos errado..." },
          { value: "3", label: "3", description: "Deus Santíssimo e misericordioso, confessamos a ti ..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_inviting_canticle",
        name: "Cântico da Tarde - Invitatório",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "ecce_nunc", label: "Ecce nunc", description: "Salmo 134 - \"BENDIGAM ao SENHOR, todas as pessoas que servem\"" },
          { value: "phos_hilaron", label: "Phos Hilaron", description: "\"Salve, alegre luz, puro esplendor\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "evening_post_first_reading_canticle",
        name: "Cântico - após a Primeira Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "magnificat", label: "Magnificat", description: "S. Lucas 1.46 - \"A minha alma engrandece ao Senhor\"" },
          { value: "bonum_est_confiteri", label: "Bonum est confiteri", description: "Salmo 92 - \"BOM é louvar ao SENHOR\"" },
          { value: "benedictus", label: "Benedictus", description: "S. Lucas 1.68-79 - \"Bendito seja o SENHOR Deus de Israel\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os cânticos" }
        ]
      },
      {
        key: "evening_post_second_reading_canticle",
        name: "Cântico - após a Segunda Leitura",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 6,
        options: [
          { value: "nunc_dimittis", label: "Nunc dimittis", description: "S. Lucas 2.29 - \"Eis que agora, SENHOR, despedes em paz o teu servo\"" },
          { value: "deus_misereatur", label: "Deus misereatur", description: "Salmo 67 - \"DEUS tenha misericórdia de nós e nos abençoe\"" },
          { value: "dignus_es", label: "Dignus es", description: "Ap 4.11; 5.9-10,13 - \"Digno és tu, Senhor nosso Deus\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os cânticos" }
        ]
      },
      {
        key: "evening_creed_type",
        name: "Credo",
        description: "Tipo de Credo",
        pref_type: "select_one",
        required: true,
        default_value: "apostolic",
        position: 7,
        options: [
          { value: "apostolic", label: "Credo Apostólico", description: "Creio em Deus Pai todo-poderoso..." },
          { value: "faith_affirmation", label: "Afirmação de Fé", description: "Cremos em Deus; Cremos na força das pessoas pobres..." }
        ]
      },
      {
        key: "evening_post_lords_prayer_prayer",
        name: "Oração após o Pai Nosso",
        description: "Escolha a versão da oração",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 8,
        options: [
          { value: "1", label: "1", description: "Ó Senhor, mostra-nos a tua misericórdia..." },
          { value: "2", label: "2", description: "Para que esta noite seja santa, boa e pacífica..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "evening_general_collects",
        name: "Coletas Gerais",
        description: "Escolha a(s) coleta(s) a ser(em) utilizada(s)",
        pref_type: "select_one",
        required: true,
        default_value: "for_peace",
        position: 9,
        options: [
          { value: "for_peace", label: "Pela paz", description: "Bondoso Deus, Criador do Universo..." },
          { value: "for_grace", label: "Pela graça", description: "Ó Deus, amor eterno, que com tua luz..." },
          { value: "for_protection", label: "Por proteção", description: "Ó Deus, que és a vida daquelas pessoas que estão vivas..." },
          { value: "for_christ_presence", label: "Pela presença de Cristo", description: "Fica conosco, Senhor Jesus, agora que a noite" },
          { value: "evening_for_all_authorities", label: "Por todas as autoridades", description: "Ó Senhor, que nos governas..." },
          { value: "evening_for_clergy", label: "Pela liderança clerical", description: "Onipotente e sempiterno Deus..." },
          { value: "evening_for_parish_family", label: "Pela família paroquial", description: "Deus cheio de graça, humildemente suplicamos..." },
          { value: "litany_for_all_humanity", label: "Litania por toda a humanidade", description: "Sobre a Igreja Una, Santa, Católica e Apostólica..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todas", description: "Quero todas as coletas" }
        ]
      },
      {
        key: "evening_general_thanksgivings",
        name: "Coleta Geral de Ação de Graças",
        description: "Escolha a(s) coleta(s) a ser(em) utilizada(s)",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 10,
        options: [
          { value: "1", label: "1", description: "Nós te bendizemos por nossa criação..." },
          { value: "2", label: "2", description: "Pelo dom de teu Espírito. Bendito sejas, ó Cristo..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todas", description: "Quero ambas as coletas" }
        ]
      },
      {
        key: "evening_concluding_prayer",
        name: "Oração Conclusiva",
        description: "Escolha a oração a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 11,
        options: [
          { value: "1", label: "2 Co 13.14", description: "A Graça de nosso Senhor Jesus Cristo..." },
          { value: "2", label: "Nm 6.24-26", description: "O Senhor nos abençoe e nos guarde..." },
          { value: "2", label: "Rm 15.13", description: "Que o Deus da esperança..." },
          { value: "2", label: "Ef 3.20-21", description: "Glória a Deus, cujo poder agindo em nós..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "compline_prayer",
    name: "Oração da Noite",
    description: "Configure o ofício das completas como preferir",
    icon: "wb_sunny_outlined",
    position: 4,
    preferences: [
      {
        key: "compline_inviting_canticle",
        name: "Cântico - Invitatório",
        description: "Salmo",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "cum_invocarem", label: "Cum invocarem", description: "Salmo 4 - \"RESPONDE ao meu clamor, DEUS de minha justiça\"" },
          { value: "qui_habitat", label: "Qui habitat", description: "Salmo 91 - \"Quem habita sob a proteção do Altíssimo\"" },
          { value: "ecce_nunc", label: "Ecce Nunc", description: "Salmo 134 - \"BENDIGAM ao SENHOR, todas as pessoas\"" },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" },
          { value: "all", label: "Todos", description: "Quero todos os salmos" }
        ]
      },
      {
        key: "compline_brief_lesson",
        name: "Lições Breves",
        description: "Escolha a leitura a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "1", label: "Jr 14.9-22", description: "Tu estás em nosso meio, ó Senhor..." },
          { value: "2", label: "Mt 11.28-30", description: "Venham a mim, todas as pessoas que estão cansadas..." },
          { value: "3", label: "Hb 13.20-21", description: "O Deus da paz, que pelo sangue da eterna aliança tirou da morte..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      },
      {
        key: "compline_final_prayer",
        name: "Oração Final",
        description: "Escolha a oração final a ser utilizada",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "1", label: "1", description: "Ilumina, suplicamos-te, Senhor Deus, as nossas trevas..." },
          { value: "2", label: "2", description: "Sê presente conosco, ó Deus de misericórdia..." },
          { value: "3", label: "3", description: "Ó radiante sol da justiça, olha para nós..." },
          { value: "4", label: "4", description: "Damos-te graças, ó Deus..." },
          { value: "5", label: "5", description: "Olha, ó Senhor amado, as pessoas que..." },
          { value: "6", label: "6", description: "Ó Deus, tua providência inesgotável sustenta..." },
          { value: "random", label: "Variar", description: "Quero variar dia a dia aleatoriamente" }
        ]
      }
    ]
  }
]

# Create categories and preferences
loc_2015_preferences.each do |category_data|
  preferences = category_data.delete(:preferences)

  category = loc_2015.preference_categories.find_or_initialize_by(key: category_data[:key])
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
