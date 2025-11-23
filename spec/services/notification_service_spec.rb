# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationService do
  let(:user) { User.create!(email: "test@example.com", provider_uid: "firebase123") }
  let(:fcm_token) { user.fcm_tokens.create!(token: "device_token_123", platform: "android") }

  before do
    allow(FcmService).to receive(:send_to_user).and_return({ success: true })
  end

  describe ".send_streak_reminder" do
    it "sends streak reminder notification" do
      expect(FcmService).to receive(:send_to_user).with(
        user,
        hash_including(
          title: "Mantenha seu Streak! 🔥",
          body: "Não perca seu streak! Complete pelo menos um ofício hoje."
        )
      )

      NotificationService.send_streak_reminder(user)
    end

    it "creates notification log" do
      expect {
        NotificationService.send_streak_reminder(user)
      }.to change(NotificationLog, :count).by(1)

      log = NotificationLog.last
      expect(log.user).to eq(user)
      expect(log.notification_type).to eq("streak_reminder")
      expect(log.sent).to be true
    end

    it "respects user notification preferences" do
      user.update!(preferences: user.preferences.merge("notifications" => false))

      result = NotificationService.send_streak_reminder(user)

      expect(result[:sent]).to be false
      expect(result[:error]).to eq("Notifications disabled for user")
    end
  end

  describe ".send_to_users" do
    let(:user2) { User.create!(email: "test2@example.com", provider_uid: "firebase456") }

    before do
      user.fcm_tokens.create!(token: "token1", platform: "android")
      user2.fcm_tokens.create!(token: "token2", platform: "ios")
    end

    it "sends notifications to multiple users" do
      results = NotificationService.send_to_users(
        [ user.id, user2.id ],
        "Test Title",
        "Test Body",
        { type: "test" }
      )

      expect(results[:success]).to eq(2)
      expect(results[:failed]).to eq(0)
    end
  end
end
