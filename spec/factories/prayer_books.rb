FactoryBot.define do
  factory :prayer_book do
    sequence(:code) { |n| "prayer_book_#{n}" }
    sequence(:name) { |n| "Prayer Book #{n}" }
    year { 2015 }
    is_recommended { false }
    features do
      {
        "lectionary" => {
          "reading_types" => [ "semicontinuous", "complementary" ],
          "default_reading_type" => "semicontinuous",
          "supports_vigil" => false
        },
        "daily_office" => {
          "supports_family_rite" => false
        },
        "psalter" => {}
      }
    end

    trait :recommended do
      is_recommended { true }
    end

    # Alias for backwards compatibility
    trait :default do
      is_recommended { true }
    end

    trait :loc_2015 do
      code { "loc_2015" }
      name { "Livro de Oração Comum 2015" }
      year { 2015 }
    end

    trait :bcp_1979 do
      code { "bcp_1979" }
      name { "Book of Common Prayer 1979" }
      year { 1979 }
    end

    trait :with_preferences do
      after(:create) do |prayer_book|
        category = create(:preference_category, prayer_book: prayer_book)
        create(:preference_definition, preference_category: category)
      end
    end
  end
end
