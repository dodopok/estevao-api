FactoryBot.define do
  factory :liturgical_text do
    association :prayer_book

    sequence(:slug) { |n| "liturgical_text_#{n}" }
    category { "prayer" }
    content { "Sample liturgical text content" }
    title { "Sample Liturgical Text" }
    reference { nil }
    audio_urls { {} }
    audio_generation_status { "pending" }
  end
end
