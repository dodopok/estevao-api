FactoryBot.define do
  factory :life_rule_step do
    association :life_rule
    sequence(:order)
    sequence(:title) { |n| "Step #{n}" }
    description { "Step description" }
  end
end
