# ================================================================================
# LOC 2019 EN PREFERENCE CATEGORIES AND DEFINITIONS
# ================================================================================

loc_2019_en = PrayerBook.find_by!(code: "loc_2019_en")

preferences_data = [
  {
    key: "daily_office",
    name: "Daily Office",
    description: "Customize the prayers and elements of the Daily Office",
    icon: "auto_stories",
    position: 1,
    preferences: [
      {
        key: "lords_prayer_version",
        name: "Lord's Prayer",
        description: "Choose the version of the Lord's Prayer",
        pref_type: "select_one",
        required: true,
        default_value: "contemporary",
        position: 1,
        options: [
          { value: "traditional", label: "Traditional", description: "Our Father, who art in heaven..." },
          { value: "contemporary", label: "Contemporary", description: "Our Father in heaven..." }
        ]
      }
    ]
  },
  {
    key: "morning_prayer",
    name: "Morning Prayer",
    description: "Configure Morning Prayer as you prefer",
    icon: "wb_sunny",
    position: 2,
    preferences: [
      {
        key: "morning_opening_sentence",
        name: "Opening Sentence",
        description: "Choose the opening sentence (ignored if there is a seasonal one)",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Random", description: "Choose randomly" },
          { value: "1", label: "Philippians 1:2", description: "Grace to you and peace..." },
          { value: "2", label: "Psalm 122:1", description: "I was glad when they said..." },
          { value: "3", label: "Psalm 19:14", description: "Let the words of my mouth..." }
        ]
      },
      {
        key: "morning_confession_type",
        name: "Confession",
        description: "Choose between full exhortation or short invitation",
        pref_type: "select_one",
        required: true,
        default_value: "long",
        position: 1,
        options: [
          { value: "long", label: "Full Exhortation", description: "Dearly beloved, the Scriptures teach us..." },
          { value: "short", label: "Short Invitation", description: "Let us humbly confess our sins..." }
        ]
      },
      {
        key: "morning_invitatory_canticle",
        name: "Invitatory Canticle",
        description: "Choose the Invitatory Psalm",
        pref_type: "select_one",
        required: true,
        default_value: "venite",
        position: 2,
        options: [
          { value: "venite", label: "Venite", description: "Psalm 95" },
          { value: "jubilate", label: "Jubilate", description: "Psalm 100" }
        ]
      },
      {
        key: "morning_prayer_for_mission",
        name: "Prayer for Mission",
        description: "Choose one of the three prayers for mission",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 3,
        options: [
          { value: "1", label: "Almighty and everlasting God...", description: "Option 1" },
          { value: "2", label: "O God, you have made of one blood...", description: "Option 2" },
          { value: "3", label: "Lord Jesus Christ, you stretched out...", description: "Option 3" }
        ]
      },
      {
        key: "morning_concluding_sentence",
        name: "Concluding Sentence",
        description: "Choose the concluding sentence",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 4,
        options: [
          { value: "1", label: "2 Corinthians 13:14", description: "The grace of our Lord Jesus Christ..." },
          { value: "2", label: "Romans 15:13", description: "May the God of hope fill us..." },
          { value: "3", label: "Ephesians 3:20-21", description: "Glory to God whose power..." }
        ]
      }
    ]
  },
  {
    key: "midday_prayer",
    name: "Midday Prayer",
    description: "Configure Midday Prayer as you prefer",
    icon: "sunny",
    position: 3,
    preferences: [
      {
        key: "midday_reading",
        name: "Reading Selection",
        description: "Choose which reading to include",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Random", description: "Choose randomly" },
          { value: "1", label: "John 12:31-32", description: "Now is the judgment of this world..." },
          { value: "2", label: "2 Corinthians 5:17-18", description: "If anyone is in Christ..." },
          { value: "3", label: "Malachi 1:11", description: "From the rising of the sun..." }
        ]
      },
      {
        key: "midday_psalm_selection",
        name: "Psalm Selection",
        description: "Choose which Psalms to include",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Random", description: "Choose one Psalm randomly" },
          { value: "all", label: "All", description: "Include all four Psalms" },
          { value: "midday_psalm_119", label: "Psalm 119:105-112", description: "Lucerna pedibus meis" },
          { value: "midday_psalm_121", label: "Psalm 121", description: "Levavi oculos" },
          { value: "midday_psalm_124", label: "Psalm 124", description: "Nisi quia Dominus" },
          { value: "midday_psalm_126", label: "Psalm 126", description: "In convertendo" }
        ]
      },
      {
        key: "midday_kyrie_version",
        name: "Kyrie Version",
        description: "Choose the version of the Kyrie",
        pref_type: "select_one",
        required: true,
        default_value: "long",
        position: 2,
        options: [
          { value: "long", label: "Long", description: "Lord, have mercy upon us..." },
          { value: "short", label: "Short", description: "Lord, have mercy..." }
        ]
      },
      {
        key: "midday_concluding_sentence",
        name: "Concluding Sentence",
        description: "Choose the concluding sentence",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 3,
        options: [
          { value: "1", label: "2 Corinthians 13:14", description: "The grace of our Lord Jesus Christ..." },
          { value: "2", label: "Romans 15:13", description: "May the God of hope fill us..." },
          { value: "3", label: "Ephesians 3:20-21", description: "Glory to God whose power..." }
        ]
      }
    ]
  },
  {
    key: "evening_prayer",
    name: "Evening Prayer",
    description: "Configure Evening Prayer as you prefer",
    icon: "dark_mode",
    position: 4,
    preferences: [
      {
        key: "evening_opening_sentence",
        name: "Opening Sentence",
        description: "Choose the opening sentence (ignored if there is a seasonal one)",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Random", description: "Choose randomly" },
          { value: "1", label: "John 8:12", description: "I am the light of the world..." },
          { value: "2", label: "Psalm 26:8", description: "LORD, I have loved the habitation..." },
          { value: "3", label: "Psalm 141:2", description: "Let my prayer be set forth..." }
        ]
      },
      {
        key: "evening_confession_type",
        name: "Confession",
        description: "Choose between full exhortation or short invitation",
        pref_type: "select_one",
        required: true,
        default_value: "long",
        position: 1,
        options: [
          { value: "long", label: "Full Exhortation", description: "Dearly beloved, the Scriptures teach us..." },
          { value: "short", label: "Short Invitation", description: "Let us humbly confess our sins..." }
        ]
      },
      {
        key: "evening_suffrages_type",
        name: "Suffrages",
        description: "Choose between Suffrages A or B",
        pref_type: "select_one",
        required: true,
        default_value: "a",
        position: 2,
        options: [
          { value: "a", label: "Suffrages A", description: "O Lord, show your mercy upon us..." },
          { value: "b", label: "Suffrages B", description: "That this evening may be holy, good, and peaceful..." }
        ]
      },
      {
        key: "evening_prayer_for_mission",
        name: "Prayer for Mission",
        description: "Choose one of the three prayers for mission",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 3,
        options: [
          { value: "1", label: "O God and Father of all...", description: "Option 1" },
          { value: "2", label: "Keep watch, dear Lord...", description: "Option 2" },
          { value: "3", label: "O God, you manifest in your servants...", description: "Option 3" }
        ]
      },
      {
        key: "evening_concluding_sentence",
        name: "Concluding Sentence",
        description: "Choose the concluding sentence",
        pref_type: "select_one",
        required: true,
        default_value: "1",
        position: 4,
        options: [
          { value: "1", label: "2 Corinthians 13:14", description: "The grace of our Lord Jesus Christ..." },
          { value: "2", label: "Romans 15:13", description: "May the God of hope fill us..." },
          { value: "3", label: "Ephesians 3:20-21", description: "Glory to God whose power..." }
        ]
      }
    ]
  },
  {
    key: "compline",
    name: "Compline",
    description: "Configure Compline as you prefer",
    icon: "bedtime",
    position: 5,
    preferences: [
      {
        key: "compline_psalm_selection",
        name: "Psalm Selection",
        description: "Choose which Psalms to include",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 1,
        options: [
          { value: "random", label: "Random", description: "Choose one Psalm randomly" },
          { value: "all", label: "All", description: "Include all four Psalms" },
          { value: "compline_psalm_4", label: "Psalm 4", description: "Cum invocarem" },
          { value: "compline_psalm_31", label: "Psalm 31:1-6", description: "In te, Domine, speravi" },
          { value: "compline_psalm_91", label: "Psalm 91", description: "Qui habitat" },
          { value: "compline_psalm_134", label: "Psalm 134", description: "Ecce nunc" }
        ]
      },
      {
        key: "compline_reading_selection",
        name: "Reading Selection",
        description: "Choose which reading to include",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 2,
        options: [
          { value: "random", label: "Random", description: "Choose randomly" },
          { value: "1", label: "Jeremiah 14:9", description: "You, O LORD, are in the midst..." },
          { value: "2", label: "Matthew 11:28-30", description: "Come to me, all who labor..." },
          { value: "3", label: "Hebrews 13:20-21", description: "Now may the God of peace..." },
          { value: "4", label: "1 Peter 5:8-9", description: "Be sober-minded; be watchful..." }
        ]
      },
      {
        key: "compline_mission_selection",
        name: "Mission Prayer",
        description: "Choose which mission prayer to include",
        pref_type: "select_one",
        required: true,
        default_value: "random",
        position: 3,
        options: [
          { value: "random", label: "Random", description: "Choose randomly" },
          { value: "1", label: "Option 1", description: "Keep watch, dear Lord..." },
          { value: "2", label: "Option 2", description: "O God, your unfailing providence..." }
        ]
      }
    ]
  }
]

# Create categories and preferences
preferences_data.each do |category_data|
  preferences = category_data.delete(:preferences)

  category = loc_2019_en.preference_categories.find_or_initialize_by(key: category_data[:key])
  category.assign_attributes(category_data)
  category.save!

  preferences.each do |pref_data|
    definition = category.preference_definitions.find_or_initialize_by(key: pref_data[:key])
    definition.assign_attributes(pref_data)
    definition.save!
  end
end

Rails.logger.info "✅ Seeded preferences for LOC 2019 EN"
