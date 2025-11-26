FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:provider_uid) { |n| "firebase_uid_#{n}" }
    name { "Test User" }
    current_streak { 0 }
    longest_streak { 0 }
    preferences do
      {
        "notifications" => true,
        "notifications_enabled" => true,
        "streak_reminder_enabled" => true,
        "prayer_times" => [],
        "version" => "loc_2015",
        "prayer_book_code" => "loc_2015",
        "language" => "pt-BR",
        "bible_version" => "nvi",
        "lords_prayer_version" => "traditional",
        "creed_type" => "apostles",
        "confession_type" => "long"
      }
    end

    trait :with_streak do
      current_streak { 5 }
      longest_streak { 10 }
      last_completed_office_at { Time.current }
    end

    trait :with_completions do
      after(:create) do |user|
        create_list(:completion, 3, user: user)
      end
    end
  end
end
