# frozen_string_literal: true

FactoryBot.define do
  factory :shared_office do
    prayer_book_code { "loc_2015" }
    office_type { "morning" }
    date { Date.current }
    seed { rand(1_000_000..9_999_999) }
    preferences { {} }

    trait :with_user do
      association :user
    end

    trait :with_preferences do
      preferences do
        {
          "bible_version" => "nvi",
          "lords_prayer_version" => "traditional",
          "confession_type" => "long",
          "creed_type" => "apostles"
        }
      end
    end

    trait :expired do
      expires_at { 1.day.ago }
    end

    trait :evening do
      office_type { "evening" }
    end

    trait :midday do
      office_type { "midday" }
    end

    trait :compline do
      office_type { "compline" }
    end
  end
end
