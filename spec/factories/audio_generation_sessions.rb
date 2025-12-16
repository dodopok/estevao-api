FactoryBot.define do
  factory :audio_generation_session do
    prayer_book_code { "loc_2015" }
    voice_keys { [ "male_1", "female_1" ] }
    current_voice_key { nil }
    current_text_id { nil }
    status { "running" }
    total_texts { 100 }
    processed_count { 0 }
    failed_count { 0 }
    started_at { Time.current }
    completed_at { nil }
    error_log { nil }
  end
end
