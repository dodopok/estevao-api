FactoryBot.define do
  factory :journal do
    association :user
    date_reference { Date.today }
    entry_type { "daily_office" }
    office_type { "morning" }
    content { "This is my journal entry for today's morning prayer." }

    trait :daily_office do
      entry_type { "daily_office" }
      office_type { "morning" }
    end

    trait :life_rule do
      entry_type { "life_rule" }
      office_type { nil }
    end

    trait :morning do
      entry_type { "daily_office" }
      office_type { "morning" }
    end

    trait :midday do
      entry_type { "daily_office" }
      office_type { "midday" }
    end

    trait :evening do
      entry_type { "daily_office" }
      office_type { "evening" }
    end

    trait :compline do
      entry_type { "daily_office" }
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
