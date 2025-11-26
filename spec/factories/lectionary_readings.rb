FactoryBot.define do
  factory :lectionary_reading do
    association :prayer_book
    date_reference { "advent_1" }
    cycle { "A" }
    service_type { "eucharist" }
    reading_type { "semicontinuous" }
    first_reading { "Isaiah 2:1-5" }
    psalm { "Psalm 122" }
    second_reading { "Romans 13:11-14" }
    gospel { "Matthew 24:36-44" }

    trait :with_celebration do
      association :celebration
    end

    trait :cycle_a do
      cycle { "A" }
    end

    trait :cycle_b do
      cycle { "B" }
    end

    trait :cycle_c do
      cycle { "C" }
    end

    trait :morning_prayer do
      service_type { "morning_prayer" }
    end

    trait :evening_prayer do
      service_type { "evening_prayer" }
    end

    trait :complementary do
      reading_type { "complementary" }
    end

    trait :semicontinuous do
      reading_type { "semicontinuous" }
    end
  end
end
