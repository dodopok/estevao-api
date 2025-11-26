# frozen_string_literal: true

require "rails_helper"

RSpec.describe FcmToken, type: :model do
  describe "associations" do
    let(:user) { User.create!(email: "test@example.com", provider_uid: "test123") }
    let(:fcm_token) { FcmToken.create!(user: user, token: "test_token", platform: "android") }

    it "belongs to user" do
      expect(fcm_token).to respond_to(:user)
      expect(fcm_token.user).to eq(user)
    end
  end

  describe "validations" do
    let(:user) { User.create!(email: "test@example.com", provider_uid: "test123") }

    it "validates presence of token" do
      fcm_token = FcmToken.new(user: user, token: nil)
      expect(fcm_token).not_to be_valid
      expect(fcm_token.errors[:token]).to include("can't be blank")
    end

    it "validates uniqueness of token scoped to user" do
      FcmToken.create!(user: user, token: "token123", platform: "android")
      duplicate = FcmToken.new(user: user, token: "token123", platform: "ios")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:token]).to include("has already been taken")
    end

    it "validates platform inclusion" do
      fcm_token = FcmToken.new(user: user, token: "token123", platform: "invalid")
      expect(fcm_token).not_to be_valid
      expect(fcm_token.errors[:platform]).to include("is not included in the list")
    end

    it "allows valid platforms" do
      %w[android ios web].each do |platform|
        fcm_token = FcmToken.new(user: user, token: "token_#{platform}", platform: platform)
        expect(fcm_token).to be_valid
      end
    end
  end

  describe "scopes" do
    let(:user) { User.create!(email: "test@example.com", provider_uid: "test123") }

    describe ".active" do
      it "returns tokens updated within 60 days" do
        active_token = FcmToken.create!(user: user, token: "active_token", platform: "android")
        old_token = FcmToken.create!(user: user, token: "old_token", platform: "android")
        old_token.update_column(:updated_at, 61.days.ago)

        expect(FcmToken.active).to include(active_token)
        expect(FcmToken.active).not_to include(old_token)
      end
    end
  end
end
