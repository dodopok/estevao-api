# frozen_string_literal: true

Rails.logger.info "Seeding Preference Categories and Definitions for LOC 2015..."

# Find or create the LOC 2015 prayer book
loc_2015 = PrayerBook.find_by(code: "loc_2015")

unless loc_2015
  puts "⚠️  LOC 2015 not found. Skipping preference seeding."
  return
end

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
          { value: "traditional", label: "Ofício Tradicional", description: "Formato litúrgico completo e tradicional" },
          { value: "family", label: "Ofício para Indivíduo e Família", description: "Versão simplificada para uso doméstico" }
        ]
      },
      {
        key: "prayer_style",
        name: "Estilo das Orações",
        description: "Linguagem das orações litúrgicas",
        pref_type: "select_one",
        required: true,
        default_value: "contemporary",
        position: 2,
        options: [
          { value: "traditional", label: "Orações Tradicionais", description: "Linguagem clássica e formal" },
          { value: "contemporary", label: "Orações Contemporâneas", description: "Linguagem moderna e acessível" }
        ]
      },
      {
        key: "lords_prayer_version",
        name: "Oração do Senhor",
        description: "Versão do Pai Nosso",
        pref_type: "select_one",
        required: true,
        default_value: "short",
        position: 3,
        options: [
          { value: "complete", label: "Versão Completa", description: "Com doxologia final (Porque teu é o reino...)" },
          { value: "short", label: "Versão Resumida", description: "Sem doxologia final" }
        ]
      },
      {
        key: "creed_type",
        name: "Credo",
        description: "Tipo de profissão de fé",
        pref_type: "select_one",
        required: true,
        default_value: "apostolic",
        position: 4,
        options: [
          { value: "apostolic", label: "Credo Apostólico", description: "Creio em Deus Pai todo-poderoso..." },
          { value: "apostolic_paraphrase", label: "Paráfrase do Credo Apostólico", description: "Versão em linguagem contemporânea" },
          { value: "nicene", label: "Credo Niceno", description: "Creio em um só Deus, Pai todo-poderoso..." },
          { value: "athanasian", label: "Credo Atanasiano", description: "Versão mais extensa e detalhada" }
        ]
      },
      {
        key: "confession_type",
        name: "Confissão",
        description: "Formato da confissão de pecados",
        pref_type: "select_one",
        required: true,
        default_value: "short",
        position: 5,
        options: [
          { value: "long", label: "Confissão Longa", description: "Confissão geral completa e detalhada" },
          { value: "short", label: "Confissão Breve", description: "Versão condensada" }
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
        key: "reading_pattern",
        name: "Padrão de Leituras",
        description: "Como as leituras são organizadas",
        pref_type: "select_one",
        required: true,
        default_value: "continuous",
        position: 1,
        options: [
          { value: "continuous", label: "Leituras Contínuas", description: "Lê os livros da Bíblia sequencialmente" },
          { value: "semi_continuous", label: "Leituras Semi-Contínuas", description: "Segue temas litúrgicos com algumas leituras sequenciais" },
          { value: "thematic", label: "Leituras Temáticas", description: "Focadas no tema do tempo litúrgico" }
        ]
      },
      {
        key: "psalm_selection",
        name: "Seleção de Salmos",
        description: "Como os salmos são escolhidos",
        pref_type: "select_one",
        required: true,
        default_value: "daily",
        position: 2,
        options: [
          { value: "daily", label: "Salmos Diários", description: "Salmos designados para cada dia" },
          { value: "weekly", label: "Ciclo Semanal", description: "Salmos organizados por semana" },
          { value: "monthly", label: "Ciclo Mensal", description: "Todos os 150 salmos em 30 dias" }
        ]
      },
      {
        key: "old_testament_reading",
        name: "Leitura do Antigo Testamento",
        description: "Incluir leituras do AT",
        pref_type: "toggle",
        required: false,
        default_value: "true",
        position: 3
      },
      {
        key: "new_testament_reading",
        name: "Leitura do Novo Testamento",
        description: "Incluir leituras do NT",
        pref_type: "toggle",
        required: false,
        default_value: "true",
        position: 4
      },
      {
        key: "gospel_reading",
        name: "Leitura do Evangelho",
        description: "Incluir leitura específica dos Evangelhos",
        pref_type: "toggle",
        required: false,
        default_value: "true",
        position: 5
      }
    ]
  },
  {
    key: "canticles",
    name: "Cânticos",
    description: "Escolha os cânticos bíblicos para cada ofício",
    icon: "music_note",
    position: 3,
    preferences: [
      {
        key: "morning_canticle",
        name: "Cântico da Manhã",
        description: "Cântico após a primeira leitura",
        pref_type: "select_one",
        required: true,
        default_value: "te_deum",
        position: 1,
        options: [
          { value: "te_deum", label: "Te Deum Laudamus", description: "A ti, ó Deus, louvamos" },
          { value: "benedicite", label: "Benedicite", description: "Todas as obras do Senhor, bendizei ao Senhor" },
          { value: "benedictus", label: "Benedictus", description: "Cântico de Zacarias" },
          { value: "jubilate", label: "Jubilate Deo", description: "Salmo 100" }
        ]
      },
      {
        key: "evening_canticle",
        name: "Cântico da Tarde",
        description: "Cântico após a primeira leitura",
        pref_type: "select_one",
        required: true,
        default_value: "magnificat",
        position: 2,
        options: [
          { value: "magnificat", label: "Magnificat", description: "Cântico de Maria" },
          { value: "nunc_dimittis", label: "Nunc Dimittis", description: "Cântico de Simeão" },
          { value: "bonum_est", label: "Bonum Est", description: "Salmo 92" }
        ]
      }
    ]
  },
  {
    key: "language",
    name: "Idioma e Localização",
    description: "Configure o idioma dos ofícios",
    icon: "language",
    position: 4,
    preferences: [
      {
        key: "office_language",
        name: "Idioma dos Ofícios",
        description: "Idioma utilizado nas orações e textos litúrgicos",
        pref_type: "select_one",
        required: true,
        default_value: "pt-BR",
        position: 1,
        options: [
          { value: "pt-BR", label: "Português (Brasil)", description: "Português brasileiro" },
          { value: "pt-PT", label: "Português (Portugal)", description: "Português de Portugal" },
          { value: "en", label: "English", description: "English language" },
          { value: "es", label: "Español", description: "Idioma español" }
        ]
      }
    ]
  },
  {
    key: "liturgical_calendar",
    name: "Calendário Litúrgico",
    description: "Preferências relacionadas ao ano litúrgico",
    icon: "calendar_today",
    position: 6,
    preferences: [
      {
        key: "commemoration_level",
        name: "Nível de Comemorações",
        description: "Quais santos e festividades celebrar",
        pref_type: "select_one",
        required: true,
        default_value: "major",
        position: 1,
        options: [
          { value: "all", label: "Todas as Comemorações", description: "Inclui todos os santos e festividades menores" },
          { value: "major", label: "Festividades Principais", description: "Apenas domingos, festas principais e santos maiores" },
          { value: "minimal", label: "Mínimo", description: "Somente domingos e festas obrigatórias" }
        ]
      },
      {
        key: "proper_collect",
        name: "Coleta do Dia",
        description: "Usar a coleta própria do dia litúrgico",
        pref_type: "toggle",
        required: false,
        default_value: "true",
        position: 2
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
