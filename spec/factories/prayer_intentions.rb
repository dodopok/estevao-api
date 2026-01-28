FactoryBot.define do
  factory :prayer_intention do
    association :user
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    status { :pending }
    category { PrayerIntention.categories.sample }
    is_private { true }
    allow_community_prayer { false }
    prayer_count { 0 }
    
    # AI enrichment fields
    spiritual_context { nil }
    related_scriptures { [] }
    suggested_prayers { [] }
    theological_insights { nil }
    reflection_prompts { [] }
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
    
    # Privacy traits
    trait :public do
      is_private { false }
    end
    
    trait :private do
      is_private { true }
    end
    
    trait :community_prayer_enabled do
      allow_community_prayer { true }
    end
    
    # AI enrichment traits
    trait :ai_enriched do
      spiritual_context { Faker::Lorem.paragraph(sentence_count: 2) }
      related_scriptures do
        [
          {
            book: 'Psalms',
            chapter: 23,
            verse: 1,
            text: 'The Lord is my shepherd; I shall not want.'
          },
          {
            book: 'Matthew',
            chapter: 6,
            verse: 9,
            text: 'Our Father in heaven, hallowed be your name.'
          }
        ]
      end
      suggested_prayers do
        [
          {
            title: 'Serenity Prayer',
            text: 'God, grant me the serenity to accept the things I cannot change...'
          }
        ]
      end
      theological_insights { Faker::Lorem.paragraph(sentence_count: 3) }
      reflection_prompts do
        [
          'How does this prayer reflect your trust in God?',
          'What steps can you take while waiting for an answer?'
        ]
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
    
    trait :public_with_community_prayer do
      public
      community_prayer_enabled
    end
    
    # Trait for intention that has been prayed for multiple times
    trait :frequently_prayed do
      prayer_count { rand(10..50) }
      last_prayed_at { rand(1..7).days.ago }
    end
    
    # Trait for long-standing intention
    trait :long_term do
      created_at { rand(30..365).days.ago }
      prayer_count { rand(20..100) }
      last_prayed_at { rand(1..3).days.ago }
    end
    
    # Full example with all AI enrichment
    trait :fully_enriched_example do
      title { 'Healing for a loved one' }
      description { 'Praying for complete healing and restoration for my mother who is facing health challenges.' }
      category { 'intercession' }
      status { :praying }
      spiritual_context do
        'This prayer reflects the biblical understanding of God as our healer and the importance of intercession for loved ones. '\
        'In the tradition of the Church, we bring our sick before the Lord, trusting in His mercy and timing.'
      end
      related_scriptures do
        [
          {
            book: 'James',
            chapter: 5,
            verse: 14,
            text: 'Is anyone among you sick? Let them call the elders of the church to pray over them and anoint them with oil in the name of the Lord.',
            reference: 'James 5:14'
          },
          {
            book: 'Psalms',
            chapter: 103,
            verse: 3,
            text: 'who forgives all your sins and heals all your diseases',
            reference: 'Psalm 103:3'
          },
          {
            book: '3 John',
            chapter: 1,
            verse: 2,
            text: 'Dear friend, I pray that you may enjoy good health and that all may go well with you, even as your soul is getting along well.',
            reference: '3 John 1:2'
          }
        ]
      end
      suggested_prayers do
        [
          {
            title: 'Prayer for Healing (Book of Common Prayer)',
            text: 'Heavenly Father, giver of life and health: Comfort and relieve your sick servant, and give your power of healing to those who minister to their needs...'
          },
          {
            title: 'Visitation of the Sick',
            text: 'O God of heavenly powers, by the might of your command you drive away from our bodies all sickness and all infirmity...'
          }
        ]
      end
      theological_insights do
        'Christian healing prayer acknowledges both divine sovereignty and human compassion. While we pray for physical healing, '\
        'we also recognize that God\'s ultimate healing may come through spiritual means, and that suffering can be redemptive '\
        'when united with Christ\'s passion. The ministry of healing combines prayer, sacramental anointing, and medical care.'
      end
      reflection_prompts do
        [
          'How can you support your loved one practically while also praying for them?',
          'What comfort do you find in knowing others are praying with you?',
          'In what ways might God be working through this situation beyond physical healing?',
          'How does this experience deepen your trust in God\'s timing and wisdom?'
        ]
      end
      ai_enriched_at { 1.hour.ago }
      ai_model_version { 'perplexity-1.0' }
      prayer_count { 15 }
      last_prayed_at { 2.hours.ago }
    end
  end
end
