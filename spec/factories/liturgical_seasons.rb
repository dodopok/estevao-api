FactoryBot.define do
  factory :liturgical_season do
    sequence(:name) { |n| "Season #{n}" }
    color { "green" }

    trait :advent do
      name { "Advento" }
      color { "violet" }
    end

    trait :christmas do
      name { "Natal" }
      color { "white" }
    end

    trait :epiphany do
      name { "Epifania" }
      color { "white" }
    end

    trait :lent do
      name { "Quaresma" }
      color { "purple" }
    end

    trait :easter do
      name { "Páscoa" }
      color { "white" }
    end

    trait :ordinary_time do
      name { "Tempo Comum" }
      color { "green" }
    end
  end
end
