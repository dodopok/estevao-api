# frozen_string_literal: true

FactoryBot.define do
  factory :user_onboarding do
    association :user
    association :prayer_book
    association :bible_version
    mode { "basic" }
    preferences { {} }
    onboarding_completed { true }
    completed_at { Time.current }

    trait :basic_mode do
      mode { "basic" }
      preferences { {} }
    end

    trait :advanced_mode do
      mode { "advanced" }
      preferences do
        {
          "office_type" => "traditional",
          "prayer_style" => "contemporary"
        }
      end
    end

    trait :incomplete do
      onboarding_completed { false }
      completed_at { nil }
    end
  end
end
