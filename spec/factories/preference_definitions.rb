# frozen_string_literal: true

FactoryBot.define do
  factory :preference_definition do
    association :preference_category
    sequence(:key) { |n| "preference_#{n}" }
    sequence(:name) { |n| "Preference #{n}" }
    description { "A preference definition" }
    pref_type { "select_one" }
    required { true }
    default_value { "option_1" }
    sequence(:position) { |n| n }
    options do
      [
        { "value" => "option_1", "label" => "Option 1", "description" => "First option" },
        { "value" => "option_2", "label" => "Option 2", "description" => "Second option" }
      ]
    end

    trait :select_one do
      pref_type { "select_one" }
      default_value { "traditional" }
      options do
        [
          { "value" => "traditional", "label" => "Traditional", "description" => "Traditional style" },
          { "value" => "contemporary", "label" => "Contemporary", "description" => "Contemporary style" }
        ]
      end
    end

    trait :toggle do
      key { "toggle_preference" }
      pref_type { "toggle" }
      required { false }
      default_value { "true" }
      options { nil }
    end

    trait :time do
      key { "time_preference" }
      pref_type { "time" }
      required { false }
      default_value { "07:00" }
      options { nil }
    end

    trait :with_dependency do
      depends_on { { "key" => "toggle_preference", "value" => true } }
    end
  end
end
