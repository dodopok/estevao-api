FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:provider_uid) { |n| "firebase_uid_#{n}" }
    name { "Test User" }
    timezone { "America/Sao_Paulo" }
    current_streak { 0 }
    longest_streak { 0 }
    admin { false }
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
        "preferred_audio_voice" => "male_1"
      }
    end

    trait :admin do
      admin { true }
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

    trait :with_onboarding do
      after(:create) do |user|
        prayer_book = create(:prayer_book, :with_preferences)
        bible_version = create(:bible_version)
        create(:user_onboarding, user: user, prayer_book: prayer_book, bible_version: bible_version)
      end
    end
  end
end
