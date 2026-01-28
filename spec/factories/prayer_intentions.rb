FactoryBot.define do
  factory :prayer_intention do
    association :user
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    status { :pending }
    category { PrayerIntention.categories.sample }
    prayer_count { 0 }
    
    # AI-generated prayer field
    generated_prayer { nil }
    ai_enriched_at { nil }
    ai_model_version { nil }
    
    # Traits for different statuses
    trait :pending do
      status { :pending }
    end
    
    trait :praying do
      status { :praying }
    end
    
    trait :answered do
      status { :answered }
      answered_at { Time.current }
      answer_notes { Faker::Lorem.sentence }
    end
    
    trait :archived do
      status { :archived }
    end
    
    # Traits for categories
    trait :personal do
      category { 'personal' }
      title { 'Personal Prayer Request' }
    end
    
    trait :family do
      category { 'family' }
      title { 'Prayer for Family' }
    end
    
    trait :community do
      category { 'community' }
      title { 'Community Prayer Need' }
    end
    
    trait :world do
      category { 'world' }
      title { 'Prayer for the World' }
    end
    
    trait :thanksgiving do
      category { 'thanksgiving' }
      title { 'Prayer of Thanksgiving' }
    end
    
    trait :intercession do
      category { 'intercession' }
      title { 'Intercessory Prayer' }
    end
    
    # Trait for generated prayer
    trait :with_prayer do
      generated_prayer do
        <<~PRAYER
          O God, the source of all comfort and strength,
          we bring before you this prayer for healing and restoration.
          Grant that your divine grace may work in this situation,
          bringing wholeness, peace, and renewed hope.
          Through Jesus Christ our Lord. Amen.
        PRAYER
      end
      ai_enriched_at { Time.current }
      ai_model_version { 'perplexity-1.0' }
    end
    
    # Combined traits
    trait :active_personal do
      pending
      personal
    end
    
    trait :answered_thanksgiving do
      answered
      thanksgiving
    end
    
    # Trait for frequently prayed intentions
    trait :frequently_prayed do
      prayer_count { rand(10..50) }
      last_prayed_at { rand(1..7).days.ago }
    end
    
    # Trait for long-term intention
    trait :long_term do
      created_at { rand(30..365).days.ago }
      prayer_count { rand(20..100) }
      last_prayed_at { rand(1..3).days.ago }
    end
    
    # Full example with generated prayer
    trait :healing_example do
      title { 'Healing for a loved one' }
      description { 'Praying for complete healing and restoration for my mother who is facing health challenges.' }
      category { 'intercession' }
      status { :praying }
      generated_prayer do
        <<~PRAYER
          Almighty God, the giver of life and health,
          in whom is the source of all healing power:
          Look with mercy upon your servant who is afflicted with illness,
          grant them patience in their suffering,
          and restore them to health of body and spirit,
          that they may give thanks unto your holy Name;
          through Jesus Christ our Lord. Amen.
        PRAYER
      end
      ai_enriched_at { 1.hour.ago }
      ai_model_version { 'llama-3.1-sonar-large-128k-online' }
      prayer_count { 15 }
      last_prayed_at { 2.hours.ago }
    end
  end
end
