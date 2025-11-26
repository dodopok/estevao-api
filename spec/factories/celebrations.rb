FactoryBot.define do
  factory :celebration do
    association :prayer_book
    sequence(:name) { |n| "Celebration #{n}" }
    celebration_type { :lesser_feast }
    rank { 10 }
    liturgical_color { "white" }
    movable { false }
    fixed_month { 1 }
    fixed_day { 1 }

    trait :principal_feast do
      celebration_type { :principal_feast }
      rank { 1 }
      liturgical_color { "white" }
    end

    trait :major_holy_day do
      celebration_type { :major_holy_day }
      rank { 2 }
    end

    trait :festival do
      celebration_type { :festival }
      rank { 5 }
      liturgical_color { "red" }
    end

    trait :movable do
      movable { true }
      fixed_month { nil }
      fixed_day { nil }
    end

    trait :christmas do
      name { "Christmas Day" }
      celebration_type { :principal_feast }
      rank { 1 }
      liturgical_color { "white" }
      fixed_month { 12 }
      fixed_day { 25 }
    end

    trait :easter do
      name { "Easter Day" }
      celebration_type { :principal_feast }
      rank { 1 }
      liturgical_color { "white" }
      movable { true }
      fixed_month { nil }
      fixed_day { nil }
    end
  end
end
