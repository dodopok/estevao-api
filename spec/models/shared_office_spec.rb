# frozen_string_literal: true

require "rails_helper"

RSpec.describe SharedOffice, type: :model do
  describe "validations" do
    it { should validate_presence_of(:prayer_book_code) }
    it { should validate_presence_of(:office_type) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:seed) }

    it { should validate_inclusion_of(:office_type).in_array(SharedOffice::VALID_OFFICE_TYPES) }

    it "validates short_code uniqueness" do
      create(:shared_office)
      should validate_uniqueness_of(:short_code)
    end

    it "validates short_code length" do
      should validate_length_of(:short_code).is_equal_to(SharedOffice::SHORT_CODE_LENGTH)
    end
  end

  describe "associations" do
    it { should belong_to(:user).optional }
  end

  describe "callbacks" do
    describe "before_validation on create" do
      it "generates a unique short_code" do
        shared_office = build(:shared_office)
        expect(shared_office.short_code).to be_nil

        shared_office.valid?

        expect(shared_office.short_code).to be_present
        expect(shared_office.short_code.length).to eq(SharedOffice::SHORT_CODE_LENGTH)
      end

      it "sets expires_at to 30 days from now" do
        shared_office = build(:shared_office, expires_at: nil)
        shared_office.valid?

        expected_expiration = SharedOffice::DEFAULT_EXPIRATION_DAYS.days.from_now
        expect(shared_office.expires_at).to be_within(1.minute).of(expected_expiration)
      end

      it "does not override existing expires_at" do
        custom_expiration = 7.days.from_now
        shared_office = build(:shared_office, expires_at: custom_expiration)
        shared_office.valid?

        expect(shared_office.expires_at).to be_within(1.second).of(custom_expiration)
      end
    end
  end

  describe "scopes" do
    describe ".active" do
      it "returns only non-expired shared offices" do
        active = create(:shared_office)
        _expired = create(:shared_office, :expired)

        expect(SharedOffice.active).to eq([ active ])
      end
    end

    describe ".expired" do
      it "returns only expired shared offices" do
        _active = create(:shared_office)
        expired = create(:shared_office, :expired)

        expect(SharedOffice.expired).to eq([ expired ])
      end
    end
  end

  describe ".find_active" do
    it "finds an active shared office by short_code" do
      shared_office = create(:shared_office)

      found = SharedOffice.find_active(shared_office.short_code)

      expect(found).to eq(shared_office)
    end

    it "returns nil for expired shared offices" do
      expired = create(:shared_office, :expired)

      found = SharedOffice.find_active(expired.short_code)

      expect(found).to be_nil
    end

    it "returns nil for non-existent short codes" do
      found = SharedOffice.find_active("INVALID")

      expect(found).to be_nil
    end
  end

  describe "#active?" do
    it "returns true for non-expired shared offices" do
      shared_office = create(:shared_office)

      expect(shared_office.active?).to be true
    end

    it "returns false for expired shared offices" do
      expired = create(:shared_office, :expired)

      expect(expired.active?).to be false
    end
  end

  describe "#expired?" do
    it "returns false for non-expired shared offices" do
      shared_office = create(:shared_office)

      expect(shared_office.expired?).to be false
    end

    it "returns true for expired shared offices" do
      expired = create(:shared_office, :expired)

      expect(expired.expired?).to be true
    end
  end

  describe "#share_path" do
    it "returns the correct path with short_code" do
      shared_office = create(:shared_office)

      expect(shared_office.share_path).to eq("/o/#{shared_office.short_code}")
    end
  end

  describe "#office_preferences" do
    it "merges stored preferences with prayer_book_code and seed" do
      shared_office = create(:shared_office, :with_preferences)

      prefs = shared_office.office_preferences

      expect(prefs[:prayer_book_code]).to eq(shared_office.prayer_book_code)
      expect(prefs[:seed]).to eq(shared_office.seed)
      expect(prefs["bible_version"]).to eq("nvi")
    end

    it "handles empty preferences" do
      shared_office = create(:shared_office, preferences: {})

      prefs = shared_office.office_preferences

      expect(prefs[:prayer_book_code]).to eq(shared_office.prayer_book_code)
      expect(prefs[:seed]).to eq(shared_office.seed)
    end
  end

  describe "short_code generation" do
    it "generates only alphanumeric characters" do
      shared_office = create(:shared_office)

      expect(shared_office.short_code).to match(/\A[A-Za-z0-9]+\z/)
    end

    it "generates unique codes even when collisions occur" do
      # Create many shared offices to test uniqueness
      codes = 10.times.map { create(:shared_office).short_code }

      expect(codes.uniq.length).to eq(10)
    end
  end
end
