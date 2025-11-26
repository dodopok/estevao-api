FactoryBot.define do
  factory :prayer_book_user_preference do
    association :user
    association :prayer_book
    options do
      {
        "lectionary" => {
          "reading_type" => "semicontinuous"
        },
        "daily_office" => {
          "use_family_rite" => false
        }
      }
    end

    trait :with_complementary_readings do
      options do
        {
          "lectionary" => {
            "reading_type" => "complementary"
          },
          "daily_office" => {
            "use_family_rite" => false
          }
        }
      end
    end

    trait :with_family_rite do
      options do
        {
          "lectionary" => {
            "reading_type" => "semicontinuous"
          },
          "daily_office" => {
            "use_family_rite" => true
          }
        }
      end
    end
  end
end
