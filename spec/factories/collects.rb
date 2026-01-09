FactoryBot.define do
  factory :collect do
    association :prayer_book
    text { "Almighty God, give us grace to cast away the works of darkness..." }

    # Default: usar celebration
    transient do
      skip_default_association { false }
    end

    # Uma collect deve ter celebration OU season OU sunday_reference
    trait :with_celebration do
      transient do
        skip_default_association { true }
      end
      celebration { association :celebration, prayer_book: prayer_book }
      season { nil }
      sunday_reference { nil }
    end

    trait :with_season do
      transient do
        skip_default_association { true }
      end
      celebration { nil }
      season { association :liturgical_season }
      sunday_reference { nil }
    end

    trait :with_sunday_reference do
      transient do
        skip_default_association { true }
      end
      celebration { nil }
      season { nil }
      sunday_reference { "advent_1" }
    end

    trait :portuguese do
      text { "Deus Todo-Poderoso, dai-nos graça para deixar as obras das trevas..." }
    end

    after(:build) do |collect, evaluator|
      unless evaluator.skip_default_association
        if collect.celebration.nil? && collect.season.nil? && collect.sunday_reference.nil?
          collect.celebration = build(:celebration, prayer_book: collect.prayer_book)
        end
      end
    end
  end
end
