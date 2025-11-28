FactoryBot.define do
  factory :life_rule do
    association :user
    sequence(:title) { |n| "Life Rule #{n}" }
    icon { "📖" }
    description { "A meaningful life rule description" }
    is_public { false }
    approved { false }
    adoption_count { 0 }

    trait :public do
      is_public { true }
    end

    trait :approved do
      approved { true }
    end

    trait :public_approved do
      is_public { true }
      approved { true }
    end

    trait :with_steps do
      after(:create) do |life_rule|
        create_list(:life_rule_step, 3, life_rule: life_rule)
      end
    end

    trait :adopted do
      association :original_life_rule, factory: :life_rule
    end
  end
end
