# Find the LOC 1987 prayer book
loc_1987 = PrayerBook.find_by(code: "loc_1987")

# ================================================================================
# LOC 1987 PREFERENCE CATEGORIES AND DEFINITIONS
# ================================================================================

loc_1987_preferences = [
  {
    key: "morning_prayer",
    name: "Oração Matutina",
    description: "Configure a Oração Matutina como preferir",
    icon: "wb_sunny",
    position: 1,
    preferences: [
      {
        key: "morning_confession_type",
        name: "Confissão",
        description: "Escolha a oração de confissão",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "1 (Misericordioso Deus...)", description: "Misericordioso Deus, confessamos que temos pecado..." },
          { value: "2", label: "2 (Ó Deus Onipotente...)", description: "Ó Deus Onipotente e Pai Misericordioso..." },
          { value: "3", label: "3 (Tem misericórdia...)", description: "Tem misericórdia de nós, ó Deus..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "morning_abs_type",
        name: "Absolvição",
        description: "Escolha a oração de absolvição",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 1,
        options: [
          { value: "1", label: "Oração de Confissão", description: "Para leigos e diáconos" },
          { value: "2", label: "Absolvição", description: "Apenas para presbíteros e bispos" }
        ]
      },
      {
        key: "morning_invitatory_psalm",
        name: "Salmo Invitatório",
        description: "Escolha o salmo de abertura",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "venite", label: "Venite (Salmo 95)", description: "Vinde, cantemos ao Senhor..." },
          { value: "jubilate", label: "Jubilate (Salmo 100)", description: "Celebrai com júbilo ao Senhor..." },
          { value: "pascha_nostrum", label: "Pascha Nostrum (Páscoa)", description: "Cristo, que é nossa Páscoa..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "morning_canticle",
        name: "Cântico",
        description: "Escolha o cântico",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "te_deum", label: "Te Deum Laudamus", description: "A ti, ó Deus, louvamos..." },
          { value: "benedictus_es", label: "Benedictus es, Domine", description: "Bendito és tu, Senhor Deus..." },
          { value: "benedictus", label: "Benedictus (Lucas 1)", description: "Bendito o Senhor Deus de Israel..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "morning_suffrages",
        name: "Sufrágios",
        description: "Escolha as orações responsivas",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "1", label: "1 (Ó Senhor, mostra-nos...)", description: "Ó Senhor, mostra-nos a tua misericórdia..." },
          { value: "2", label: "2 (Salva, Senhor...)", description: "Salva, Senhor, o teu povo..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "morning_conclusion",
        name: "Conclusão",
        description: "Escolha a bênção final",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "1", label: "1 (A Graça...)", description: "A Graça de nosso Senhor Jesus Cristo..." },
          { value: "2", label: "2 (O Senhor nos abençoe...)", description: "O Senhor nos abençoe e nos guarde..." },
          { value: "3", label: "3 (A divina proteção...)", description: "A divina proteção permaneça conosco..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      }
    ]
  },
  {
    key: "evening_prayer",
    name: "Oração Vespertina",
    description: "Configure a Oração Vespertina como preferir",
    icon: "nightlight_round",
    position: 2,
    preferences: [
      {
        key: "evening_confession_type",
        name: "Confissão",
        description: "Escolha a oração de confissão",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "1", label: "1 (Misericordioso Deus...)", description: "Misericordioso Deus, confessamos que temos pecado..." },
          { value: "2", label: "2 (Ó Deus Onipotente...)", description: "Ó Deus Onipotente e Pai Misericordioso..." },
          { value: "3", label: "3 (Tem misericórdia...)", description: "Tem misericórdia de nós, ó Deus..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "evening_abs_type",
        name: "Absolvição",
        description: "Escolha a oração de absolvição",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 2,
        options: [
          { value: "1", label: "Oração de Confissão", description: "Para leigos e diáconos" },
          { value: "2", label: "Absolvição", description: "Apenas para presbíteros e bispos" }
        ]
      },
      {
        key: "evening_canticle_1",
        name: "1º Cântico",
        description: "Escolha o primeiro cântico",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "magnificat", label: "Magnificat", description: "A minha alma engrandece ao Senhor..." },
          { value: "cantate_domino", label: "Cantate Domino", description: "Cantai ao Senhor um cântico novo..." },
          { value: "bonum_est", label: "Bonum est confiteri", description: "Bom é louvar ao Senhor..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "evening_canticle_2",
        name: "2º Cântico",
        description: "Escolha o segundo cântico",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 4,
        options: [
          { value: "nunc_dimittis", label: "Nunc Dimittis", description: "Eis que agora, Senhor, despedes em paz..." },
          { value: "deus_misereatur", label: "Deus Misereatur", description: "Deus tenha misericórdia de nós..." },
          { value: "benedic_anima_mea", label: "Benedic, anima mea", description: "Bendize, ó minha alma, ao Senhor..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "evening_suffrages",
        name: "Sufrágios",
        description: "Escolha as orações responsivas",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 5,
        options: [
          { value: "1", label: "1 (Ó Senhor, mostra-nos...)", description: "Ó Senhor, mostra-nos a tua misericórdia..." },
          { value: "2", label: "2 (Salva, Senhor...)", description: "Salva, Senhor, o teu povo..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      },
      {
        key: "evening_conclusion",
        name: "Conclusão",
        description: "Escolha a bênção final",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 6,
        options: [
          { value: "1", label: "1 (A Graça...)", description: "A Graça de nosso Senhor Jesus Cristo..." },
          { value: "2", label: "2 (O Senhor nos abençoe...)", description: "O Senhor nos abençoe e nos guarde..." },
          { value: "3", label: "3 (A divina proteção...)", description: "A divina proteção permaneça conosco..." },
          { value: "random", label: "Variar", description: "Variar aleatoriamente" }
        ]
      }
    ]
  }
]

# Create categories and preferences
loc_1987_preferences.each do |category_data|
  preferences = category_data.delete(:preferences)

  category = loc_1987.preference_categories.find_or_initialize_by(key: category_data[:key])
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
