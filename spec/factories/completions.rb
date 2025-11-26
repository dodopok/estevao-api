FactoryBot.define do
  factory :completion do
    association :user
    date_reference { Date.today }
    office_type { "morning" }
    duration_seconds { 300 }

    trait :morning do
      office_type { "morning" }
    end

    trait :midday do
      office_type { "midday" }
    end

    trait :evening do
      office_type { "evening" }
    end

    trait :compline do
      office_type { "compline" }
    end

    trait :yesterday do
      date_reference { Date.yesterday }
    end

    trait :today do
      date_reference { Date.today }
    end
  end
end
