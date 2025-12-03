# frozen_string_literal: true

require "rails_helper"

RSpec.describe SharedOfficeService do
  let(:date) { Date.current }
  let(:office_type) { "morning" }
  let(:prayer_book_code) { "loc_2015" }
  let(:seed) { 12345678 }
  let(:preferences) { { "bible_version" => "nvi", "confession_type" => "long" } }
  let(:user) { create(:user) }

  describe "#create" do
    subject do
      described_class.new(
        date: date,
        office_type: office_type,
        prayer_book_code: prayer_book_code,
        seed: seed,
        preferences: preferences,
        user: user
      )
    end

    it "creates a new SharedOffice" do
      expect { subject.create }.to change(SharedOffice, :count).by(1)
    end

    it "sets the correct attributes" do
      shared_office = subject.create

      expect(shared_office.date).to eq(date)
      expect(shared_office.office_type).to eq(office_type)
      expect(shared_office.prayer_book_code).to eq(prayer_book_code)
      expect(shared_office.seed).to eq(seed)
      expect(shared_office.user).to eq(user)
    end

    it "sanitizes preferences by removing seed key" do
      prefs_with_seed = preferences.merge("seed" => 999)
      service = described_class.new(
        date: date,
        office_type: office_type,
        prayer_book_code: prayer_book_code,
        seed: seed,
        preferences: prefs_with_seed
      )

      shared_office = service.create

      expect(shared_office.preferences).not_to have_key("seed")
    end

    it "filters out non-allowed preference keys" do
      prefs_with_extra = preferences.merge(
        "invalid_key" => "value",
        "another_invalid" => 123
      )
      service = described_class.new(
        date: date,
        office_type: office_type,
        prayer_book_code: prayer_book_code,
        seed: seed,
        preferences: prefs_with_extra
      )

      shared_office = service.create

      expect(shared_office.preferences).not_to have_key("invalid_key")
      expect(shared_office.preferences).not_to have_key("another_invalid")
      expect(shared_office.preferences["bible_version"]).to eq("nvi")
    end

    it "works without a user" do
      service = described_class.new(
        date: date,
        office_type: office_type,
        prayer_book_code: prayer_book_code,
        seed: seed
      )

      shared_office = service.create

      expect(shared_office.user).to be_nil
    end

    it "works with empty preferences" do
      service = described_class.new(
        date: date,
        office_type: office_type,
        prayer_book_code: prayer_book_code,
        seed: seed,
        preferences: nil
      )

      shared_office = service.create

      expect(shared_office.preferences).to eq({})
    end
  end

  describe "#find_or_create" do
    subject do
      described_class.new(
        date: date,
        office_type: office_type,
        prayer_book_code: prayer_book_code,
        seed: seed,
        preferences: preferences,
        user: user
      )
    end

    context "when no matching shared office exists" do
      it "creates a new SharedOffice" do
        expect { subject.find_or_create }.to change(SharedOffice, :count).by(1)
      end
    end

    context "when a matching shared office exists" do
      let!(:existing) do
        create(:shared_office,
          date: date,
          office_type: office_type,
          prayer_book_code: prayer_book_code,
          seed: seed,
          preferences: { "bible_version" => "nvi", "confession_type" => "long" },
          user: user
        )
      end

      it "returns the existing SharedOffice" do
        result = subject.find_or_create

        expect(result).to eq(existing)
      end

      it "does not create a new SharedOffice" do
        expect { subject.find_or_create }.not_to change(SharedOffice, :count)
      end
    end

    context "when existing shared office has different preferences" do
      before do
        create(:shared_office,
          date: date,
          office_type: office_type,
          prayer_book_code: prayer_book_code,
          seed: seed,
          preferences: { "bible_version" => "arc" }, # Different preference
          user: user
        )
      end

      it "creates a new SharedOffice" do
        expect { subject.find_or_create }.to change(SharedOffice, :count).by(1)
      end
    end

    context "when existing shared office is expired" do
      before do
        create(:shared_office, :expired,
          date: date,
          office_type: office_type,
          prayer_book_code: prayer_book_code,
          seed: seed,
          preferences: { "bible_version" => "nvi", "confession_type" => "long" },
          user: user
        )
      end

      it "creates a new SharedOffice" do
        expect { subject.find_or_create }.to change(SharedOffice, :count).by(1)
      end
    end
  end
end
