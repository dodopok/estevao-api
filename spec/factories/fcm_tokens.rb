# frozen_string_literal: true

FactoryBot.define do
  factory :fcm_token do
    user
    sequence(:token) { |n| "fcm_token_#{n}" }
    platform { "android" }
  end
end
