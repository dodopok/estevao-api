# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationLog, type: :model do
  describe "associations" do
    let(:user) { User.create!(email: "test@example.com", provider_uid: "test123") }
    let(:notification_log) do
      NotificationLog.create!(
        user: user,
        notification_type: "test",
        title: "Test",
        body: "Test body"
      )
    end

    it "belongs to user" do
      expect(notification_log).to respond_to(:user)
      expect(notification_log.user).to eq(user)
    end
  end

  describe "validations" do
    let(:user) { User.create!(email: "test@example.com", provider_uid: "test123") }

    it "validates presence of notification_type" do
      log = NotificationLog.new(user: user, title: "Test", body: "Test body")
      expect(log).not_to be_valid
      expect(log.errors[:notification_type]).to include("can't be blank")
    end

    it "validates presence of title" do
      log = NotificationLog.new(user: user, notification_type: "test", body: "Test body")
      expect(log).not_to be_valid
      expect(log.errors[:title]).to include("can't be blank")
    end

    it "creates valid notification log" do
      log = NotificationLog.new(
        user: user,
        notification_type: "streak_reminder",
        title: "Streak Reminder",
        body: "Don't forget!",
        sent: true
      )
      expect(log).to be_valid
    end
  end

  describe "scopes" do
    let(:user) { User.create!(email: "test@example.com", provider_uid: "test123") }

    before do
      NotificationLog.create!(user: user, notification_type: "test1", title: "T1", body: "B1", sent: true)
      NotificationLog.create!(user: user, notification_type: "test2", title: "T2", body: "B2", sent: false)
      NotificationLog.create!(user: user, notification_type: "test1", title: "T3", body: "B3", sent: true)
    end

    it "filters sent notifications" do
      expect(NotificationLog.sent.count).to eq(2)
    end

    it "filters failed notifications" do
      expect(NotificationLog.failed.count).to eq(1)
    end

    it "filters by type" do
      expect(NotificationLog.by_type("test1").count).to eq(2)
    end
  end
end
