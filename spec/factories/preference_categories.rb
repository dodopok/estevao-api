# frozen_string_literal: true

FactoryBot.define do
  factory :preference_category do
    association :prayer_book
    sequence(:key) { |n| "category_#{n}" }
    sequence(:name) { |n| "Category #{n}" }
    description { "A preference category" }
    icon { "settings" }
    sequence(:position) { |n| n }

    trait :daily_office do
      key { "daily_office" }
      name { "Ofício Diário" }
      description { "Customize as orações e elementos do ofício diário" }
      icon { "auto_stories" }
      position { 1 }
    end

    trait :lectionary do
      key { "lectionary" }
      name { "Lecionário" }
      description { "Configure as leituras bíblicas diárias" }
      icon { "book" }
      position { 2 }
    end

    trait :with_preferences do
      after(:create) do |category|
        create(:preference_definition, :select_one, preference_category: category)
        create(:preference_definition, :toggle, preference_category: category)
      end
    end
  end
end
