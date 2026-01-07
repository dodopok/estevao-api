# frozen_string_literal: true

# Find the LOC 2021 prayer book
loc_2021 = PrayerBook.find_by(code: "loc_2021")

# ================================================================================
# LOC 2021 PREFERENCE CATEGORIES AND DEFINITIONS
# ================================================================================

loc_2021_preferences = [
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
        description: "Escolha entre o ofício tradicional ou alternativo",
        pref_type: "select_one",
        required: true,
        default_value: "traditional",
        position: 1,
        options: [
          { value: "traditional", label: "Ofício Tradicional", description: "Versão 1" },
          { value: "alternative", label: "Ofício Alternativo", description: "Versão 2" }
        ]
      }
    ]
  },
  {
    key: "morning_prayer",
    name: "Oração da Manhã",
    description: "Configure o ofício da manhã como preferir",
    icon: "wb_sunny",
    position: 2,
    preferences: [
      {
        key: "morning_creed_type",
        name: "Credo",
        description: "Escolha a versão do Credo",
        pref_type: "select_one",
        required: true,
        default_value: "apostolic",
        position: 1,
        options: [
          { value: "apostolic", label: "Credo Apostólico", description: "Creio em Deus Pai todo-poderoso..." },
          { value: "nicene", label: "Credo Niceno", description: "Cremos em um só Deus, Pai todo-poderoso..." }
        ]
      }
    ]
  },
  {
    key: "evening_prayer",
    name: "Oração da Tarde",
    description: "Configure o ofício da tarde como preferir",
    icon: "wb_sunny_outlined",
    position: 3,
    preferences: [
      {
        key: "evening_creed_type",
        name: "Credo",
        description: "Escolha a versão do Credo",
        pref_type: "select_one",
        required: true,
        default_value: "apostolic",
        position: 1,
        options: [
          { value: "apostolic", label: "Credo Apostólico", description: "Creio em Deus Pai todo-poderoso..." },
          { value: "nicene", label: "Credo Niceno", description: "Cremos em um só Deus, Pai todo-poderoso..." }
        ]
      }
    ]
  }
]

# Create categories and preferences
loc_2021_preferences.each do |category_data|
  preferences_list = category_data.delete(:preferences)

  category = loc_2021.preference_categories.find_or_initialize_by(key: category_data[:key])
  category.assign_attributes(category_data)
  category.save!

  preferences_list.each do |pref_data|
    definition = category.preference_definitions.find_or_initialize_by(key: pref_data[:key])
    definition.assign_attributes(pref_data)
    definition.save!
  end
end
