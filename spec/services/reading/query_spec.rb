# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reading::Query do
  let(:prayer_book) { PrayerBook.find_or_create_by!(code: "test_loc_2019") { |pb| pb.name = "Test LOC 2019" } }
  let(:date) { Date.new(2025, 12, 30) }

  let!(:evening_reading) do
    create(:lectionary_reading,
      prayer_book: prayer_book,
      date_reference: "dezembro_30",
      cycle: "all",
      service_type: "evening_prayer",
      first_reading: "Evening Reading 1",
      psalm: "Evening Psalm"
    )
  end

  let!(:morning_reading) do
    create(:lectionary_reading,
      prayer_book: prayer_book,
      date_reference: "dezembro_30",
      cycle: "all",
      service_type: "morning_prayer",
      first_reading: "Morning Reading 1",
      psalm: "Morning Psalm"
    )
  end

  describe "#find_by_reference" do
    it "filters by service_type when provided" do
      query = described_class.new(
        prayer_book_id: prayer_book.id,
        cycle: "all",
        date: date,
        service_type: "evening_prayer"
      )

      reading = query.find_by_reference("dezembro_30")

      expect(reading).to eq(evening_reading)
      expect(reading).not_to eq(morning_reading)
    end

    it "defaults to eucharist when service_type is nil" do
      query = described_class.new(
        prayer_book_id: prayer_book.id,
        cycle: "all",
        date: date
      )

      # Neither reading is eucharist
      reading = query.find_by_reference("dezembro_30")
      expect(reading).to be_nil
    end
  end

  describe "#find_weekly" do
    it "filters by service_type when provided" do
      query = described_class.new(
        prayer_book_id: prayer_book.id,
        cycle: "all",
        date: date,
        service_type: "evening_prayer"
      )

      reading = query.find_weekly("dezembro_30")

      expect(reading).to eq(evening_reading)
    end
  end
end
