# ================================================================================
# LOC 2019 PREFERENCE CATEGORIES AND DEFINITIONS (PT)
# ================================================================================

loc_2019 = PrayerBook.find_by!(code: "loc_2019")

preferences_data = [
  {
    key: "daily_office",
    name: "Ofício Diário",
    description: "Personalize as orações e elementos do Ofício Diário",
    icon: "auto_stories",
    position: 1,
    preferences: [
      {
        key: "lords_prayer_version",
        name: "Pai Nosso",
        description: "Escolha a versão do Pai Nosso",
        pref_type: "select_one",
        required: true,
        default_value: "contemporary",
        position: 1,
        options: [
          { value: "traditional", label: "Tradicional", description: "Pai Nosso, que estás nos céus..." },
          { value: "contemporary", label: "Contemporâneo", description: "Pai nosso que estás no céu..." }
        ]
      }
    ]
  },
  {
    key: "morning_prayer",
    name: "Oração da Manhã",
    description: "Configure a Oração da Manhã como preferir",
    icon: "wb_sunny",
    position: 2,
    preferences: [
      {
        key: "morning_opening_sentence",
        name: "Sentença de Abertura",
        description: "Escolha a sentença de abertura (ignorada se houver uma sazonal)",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher aleatoriamente" },
          { value: "1", label: "Filipenses 1:2", description: "Graça a vós e paz..." },
          { value: "2", label: "Salmo 122:1", description: "Alegrei-me quando me disseram..." },
          { value: "3", label: "Salmo 19:14", description: "Sejam agradáveis as palavras da minha boca..." }
        ]
      },
      {
        key: "morning_confession_type",
        name: "Confissão",
        description: "Escolha entre exortação completa ou convite curto",
        pref_type: "select_one",
        required: true,
        default_value: "long",
        position: 1,
        options: [
          { value: "long", label: "Exortação Completa", description: "Diletos irmãos, as Escrituras nos ensinam..." },
          { value: "short", label: "Convite Curto", description: "Confessemos humildemente nossos pecados..." }
        ]
      },
      {
        key: "morning_invitatory_canticle",
        name: "Cântico Invitatório",
        description: "Escolha o Salmo Invitatório",
        pref_type: "select_one",
        required: true,
        default_value: "venite",
        position: 2,
        options: [
          { value: "venite", label: "Venite", description: "Salmo 95" },
          { value: "jubilate", label: "Jubilate", description: "Salmo 100" }
        ]
      },
      {
        key: "morning_prayer_for_mission",
        name: "Oração pela Missão",
        description: "Escolha uma das três orações pela missão",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 3,
        options: [
          { value: "1", label: "Deus onipotente e eterno...", description: "Opção 1" },
          { value: "2", label: "Ó Deus, que de um só sangue...", description: "Opção 2" },
          { value: "3", label: "Senhor Jesus Cristo, que estendeste...", description: "Opção 3" }
        ]
      },
      {
        key: "morning_concluding_sentence",
        name: "Sentença Conclusiva",
        description: "Escolha a sentença conclusiva",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 4,
        options: [
          { value: "1", label: "2 Coríntios 13:14", description: "A graça de nosso Senhor Jesus Cristo..." },
          { value: "2", label: "Romanos 15:13", description: "O Deus da esperança nos encha..." },
          { value: "3", label: "Efésios 3:20-21", description: "Glória a Deus, cujo poder..." }
        ]
      }
    ]
  },
  {
    key: "midday_prayer",
    name: "Oração do Meio-Dia",
    description: "Configure a Oração do Meio-Dia como preferir",
    icon: "sunny",
    position: 3,
    preferences: [
      {
        key: "midday_reading",
        name: "Seleção de Leitura",
        description: "Escolha qual leitura incluir",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher aleatoriamente" },
          { value: "1", label: "João 12:31-32", description: "Agora é o julgamento deste mundo..." },
          { value: "2", label: "2 Coríntios 5:17-18", description: "Se alguém está em Cristo..." },
          { value: "3", label: "Malaquias 1:11", description: "Desde o nascente do sol..." }
        ]
      },
      {
        key: "midday_psalm_selection",
        name: "Seleção de Salmos",
        description: "Escolha quais Salmos incluir",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher um Salmo aleatoriamente" },
          { value: "all", label: "Todos", description: "Incluir todos os quatro Salmos" },
          { value: "midday_psalm_119", label: "Salmo 119:105-112", description: "Lucerna pedibus meis" },
          { value: "midday_psalm_121", label: "Salmo 121", description: "Levavi oculos" },
          { value: "midday_psalm_124", label: "Salmo 124", description: "Nisi quia Dominus" },
          { value: "midday_psalm_126", label: "Salmo 126", description: "In convertendo" }
        ]
      },
      {
        key: "midday_kyrie_version",
        name: "Versão do Kyrie",
        description: "Escolha a versão do Kyrie",
        pref_type: "select_one",
        required: true,
        default_value: "long",
        position: 2,
        options: [
          { value: "long", label: "Longo", description: "Senhor, tem piedade de nós..." },
          { value: "short", label: "Curto", description: "Senhor, tem piedade..." }
        ]
      },
      {
        key: "midday_concluding_sentence",
        name: "Sentença Conclusiva",
        description: "Escolha a sentença conclusiva",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 3,
        options: [
          { value: "1", label: "2 Coríntios 13:14", description: "A graça de nosso Senhor Jesus Cristo..." },
          { value: "2", label: "Romanos 15:13", description: "O Deus da esperança nos encha..." },
          { value: "3", label: "Efésios 3:20-21", description: "Glória a Deus, cujo poder..." }
        ]
      }
    ]
  },
  {
    key: "evening_prayer",
    name: "Oração da Noite",
    description: "Configure a Oração da Noite como preferir",
    icon: "dark_mode",
    position: 4,
    preferences: [
      {
        key: "evening_opening_sentence",
        name: "Sentença de Abertura",
        description: "Escolha a sentença de abertura (ignorada se houver uma sazonal)",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher aleatoriamente" },
          { value: "1", label: "João 8:12", description: "Eu sou a luz do mundo..." },
          { value: "2", label: "Salmo 26:8", description: "SENHOR, eu amo a habitação..." },
          { value: "3", label: "Salmo 141:2", description: "Suba a minha oração..." }
        ]
      },
      {
        key: "evening_confession_type",
        name: "Confissão",
        description: "Escolha entre exortação completa ou convite curto",
        pref_type: "select_one",
        required: true,
        default_value: "long",
        position: 1,
        options: [
          { value: "long", label: "Exortação Completa", description: "Diletos irmãos, as Escrituras nos ensinam..." },
          { value: "short", label: "Convite Curto", description: "Confessemos humildemente nossos pecados..." }
        ]
      },
      {
        key: "evening_suffrages_type",
        name: "Sufrágios",
        description: "Escolha entre Sufrágios A ou B",
        pref_type: "select_one",
        required: true,
        default_value: "a",
        position: 2,
        options: [
          { value: "a", label: "Sufrágios A", description: "Mostra-nos, Senhor, a tua misericórdia..." },
          { value: "b", label: "Sufrágios B", description: "Que esta noite seja santa, boa e pacífica..." }
        ]
      },
      {
        key: "evening_prayer_for_mission",
        name: "Oração pela Missão",
        description: "Escolha uma das três orações pela missão",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 3,
        options: [
          { value: "1", label: "Ó Deus e Pai de todos...", description: "Opção 1" },
          { value: "2", label: "Vela, querido Senhor...", description: "Opção 2" },
          { value: "3", label: "Ó Deus, tu manifestas em teus servos...", description: "Opção 3" }
        ]
      },
      {
        key: "evening_concluding_sentence",
        name: "Sentença Conclusiva",
        description: "Escolha a sentença conclusiva",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 4,
        options: [
          { value: "1", label: "2 Coríntios 13:14", description: "A graça de nosso Senhor Jesus Cristo..." },
          { value: "2", label: "Romanos 15:13", description: "O Deus da esperança nos encha..." },
          { value: "3", label: "Efésios 3:20-21", description: "Glória a Deus, cujo poder..." }
        ]
      }
    ]
  },
  {
    key: "compline",
    name: "Completas",
    description: "Configure as Completas como preferir",
    icon: "bedtime",
    position: 5,
    preferences: [
      {
        key: "compline_psalm_selection",
        name: "Seleção de Salmos",
        description: "Escolha quais Salmos incluir",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher um Salmo aleatoriamente" },
          { value: "all", label: "Todos", description: "Incluir todos os quatro Salmos" },
          { value: "compline_psalm_4", label: "Salmo 4", description: "Cum invocarem" },
          { value: "compline_psalm_31", label: "Salmo 31:1-6", description: "In te, Domine, speravi" },
          { value: "compline_psalm_91", label: "Salmo 91", description: "Qui habitat" },
          { value: "compline_psalm_134", label: "Salmo 134", description: "Ecce nunc" }
        ]
      },
      {
        key: "compline_reading_selection",
        name: "Seleção de Leitura",
        description: "Escolha qual leitura incluir",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher aleatoriamente" },
          { value: "1", label: "Jeremias 14:9", description: "Tu, ó SENHOR, estás no meio de nós..." },
          { value: "2", label: "Mateus 11:28-30", description: "Vinde a mim, todos os que estais cansados..." },
          { value: "3", label: "Hebreus 13:20-21", description: "O Deus da paz..." },
          { value: "4", label: "1 Pedro 5:8-9", description: "Sede sóbrios; vigiai..." }
        ]
      },
      {
        key: "compline_mission_selection",
        name: "Oração pela Missão",
        description: "Escolha qual oração pela missão incluir",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher aleatoriamente" },
          { value: "1", label: "Opção 1", description: "Vela, querido Senhor..." },
          { value: "2", label: "Opção 2", description: "Ó Deus, tua infalível providência..." }
        ]
      }
    ]
  }
]

# Create categories and preferences
preferences_data.each do |category_data|
  preferences = category_data.delete(:preferences)

  category = loc_2019.preference_categories.find_or_initialize_by(key: category_data[:key])
  category.assign_attributes(category_data)
  category.save!

  preferences.each do |pref_data|
    definition = category.preference_definitions.find_or_initialize_by(key: pref_data[:key])
    definition.assign_attributes(pref_data)
    definition.save!
  end
end

Rails.logger.info "✅ Seeded preferences for LOC 2019"
