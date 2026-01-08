# ================================================================================
# LOC 1662 PREFERENCE CATEGORIES AND DEFINITIONS (PT)
# ================================================================================

loc_1662 = PrayerBook.find_by!(code: "loc_1662")

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
        default_value: "traditional",
        position: 1,
        options: [
          { value: "traditional", label: "Tradicional", description: "Pai Nosso, que estás nos céus..." }
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
        description: "Escolha a sentença de abertura",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher aleatoriamente" },
          { value: "1", label: "Ezequiel 18:27", description: "Quando o homem perverso..." },
          { value: "2", label: "Salmo 51:3", description: "Porque eu reconheço..." },
          { value: "3", label: "Salmo 51:9", description: "Esconde a tua face..." },
          { value: "4", label: "Salmo 51:17", description: "Os sacrifícios para Deus..." },
          { value: "5", label: "Joel 2:13", description: "E rasgai o vosso coração..." },
          { value: "6", label: "Daniel 9:9, 10", description: "Ao Senhor nosso Deus..." },
          { value: "7", label: "Jeremias 10:24", description: "Ó SENHOR, corrige-me..." },
          { value: "8", label: "S. Mateus 3:2", description: "Arrependei-vos..." },
          { value: "9", label: "S. Lucas 15:18,19", description: "Levantar-me-ei..." },
          { value: "10", label: "Salmo 143:2", description: "E não entres em juízo..." },
          { value: "11", label: "1 João 1:8,9", description: "Se dissermos que não temos..." }
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
        description: "Escolha a sentença de abertura",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Aleatória", description: "Escolher aleatoriamente" },
          { value: "1", label: "Ezequiel 18:27", description: "Quando o homem perverso..." },
          { value: "2", label: "Salmo 51:3", description: "Porque eu reconheço..." },
          { value: "3", label: "Salmo 51:9", description: "Esconde a tua face..." },
          { value: "4", label: "Salmo 51:17", description: "Os sacrifícios para Deus..." },
          { value: "5", label: "Joel 2:13", description: "E rasgai o vosso coração..." },
          { value: "6", label: "Daniel 9:9, 10", description: "Ao Senhor nosso Deus..." },
          { value: "7", label: "Jeremias 10:24", description: "Ó SENHOR, corrige-me..." },
          { value: "8", label: "S. Mateus 3:2", description: "Arrependei-vos..." },
          { value: "9", label: "S. Lucas 15:18,19", description: "Levantar-me-ei..." },
          { value: "10", label: "Salmo 143:2", description: "E não entres em juízo..." },
          { value: "11", label: "1 João 1:8,9", description: "Se dissermos que não temos..." }
        ]
      },
      {
        key: "evening_first_canticle",
        name: "Primeiro Cântico",
        description: "Escolha o cântico após a primeira leitura",
        pref_type: "select_one",
        required: true,
        default_value: "magnificat",
        position: 2,
        options: [
          { value: "magnificat", label: "Magnificat", description: "Cântico de Maria" },
          { value: "cantate_domino", label: "Cantate Domino", description: "Salmo 98" }
        ]
      },
      {
        key: "evening_second_canticle",
        name: "Segundo Cântico",
        description: "Escolha o cântico após a segunda leitura",
        pref_type: "select_one",
        required: true,
        default_value: "nunc_dimittis",
        position: 3,
        options: [
          { value: "nunc_dimittis", label: "Nunc Dimittis", description: "Cântico de Simeão" },
          { value: "deus_misereatur", label: "Deus Misereatur", description: "Salmo 67 (96 no livro)" }
        ]
      }
    ]
  }
]

# Create categories and preferences
preferences_data.each do |category_data|
  preferences = category_data.delete(:preferences)

  category = loc_1662.preference_categories.find_or_initialize_by(key: category_data[:key])
  category.assign_attributes(category_data)
  category.save!

  preferences.each do |pref_data|
    definition = category.preference_definitions.find_or_initialize_by(key: pref_data[:key])
    definition.assign_attributes(pref_data)
    definition.save!
  end
end

Rails.logger.info "✅ Seeded preferences for LOC 1662"
