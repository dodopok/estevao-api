FactoryBot.define do
  factory :liturgical_color do
    sequence(:name) { |n| "Color #{n}" }
    hex_code { "#FFFFFF" }

    trait :white do
      name { "white" }
      hex_code { "#FFFFFF" }
    end

    trait :red do
      name { "red" }
      hex_code { "#DC143C" }
    end

    trait :purple do
      name { "purple" }
      hex_code { "#800080" }
    end

    trait :violet do
      name { "violet" }
      hex_code { "#8B00FF" }
    end

    trait :green do
      name { "green" }
      hex_code { "#228B22" }
    end

    trait :rose do
      name { "rose" }
      hex_code { "#FFB6C1" }
    end

    trait :black do
      name { "black" }
      hex_code { "#000000" }
    end
  end
end
