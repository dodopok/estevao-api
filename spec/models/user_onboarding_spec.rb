# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserOnboarding, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:prayer_book) }
    it { is_expected.to belong_to(:bible_version) }
  end

  describe "validations" do
    subject { build(:user_onboarding) }

    it { is_expected.to validate_uniqueness_of(:user_id) }
    it { is_expected.to validate_presence_of(:mode) }
    it { is_expected.to validate_inclusion_of(:mode).in_array(%w[basic advanced]) }

    context "with preference validation" do
      let(:prayer_book) { create(:prayer_book) }
      let(:category) { create(:preference_category, prayer_book: prayer_book) }
      let!(:definition) { create(:preference_definition, :select_one, preference_category: category, key: "test_pref") }
      let(:bible_version) { create(:bible_version) }
      let(:user) { create(:user) }

      it "validates that preference keys exist for the prayer book" do
        onboarding = build(:user_onboarding,
          user: user,
          prayer_book: prayer_book,
          bible_version: bible_version,
          mode: "advanced",
          preferences: { "invalid_key" => "value" })

        expect(onboarding).not_to be_valid
        expect(onboarding.errors[:preferences].first).to include("key 'invalid_key' does not exist")
      end

      it "validates that preference values are valid" do
        onboarding = build(:user_onboarding,
          user: user,
          prayer_book: prayer_book,
          bible_version: bible_version,
          mode: "advanced",
          preferences: { "test_pref" => "invalid_value" })

        expect(onboarding).not_to be_valid
        expect(onboarding.errors[:preferences].first).to include("invalid value")
      end

      it "allows valid preferences" do
        onboarding = build(:user_onboarding,
          user: user,
          prayer_book: prayer_book,
          bible_version: bible_version,
          mode: "advanced",
          preferences: { "test_pref" => "traditional" })

        expect(onboarding).to be_valid
      end
    end
  end

  describe "callbacks" do
    describe "apply_defaults_for_basic_mode" do
      let(:prayer_book) { create(:prayer_book) }
      let(:category) { create(:preference_category, prayer_book: prayer_book) }
      let!(:definition) { create(:preference_definition, :select_one, preference_category: category, key: "test_pref", default_value: "traditional") }
      let(:bible_version) { create(:bible_version) }
      let(:user) { create(:user) }

      it "applies default preferences for basic mode" do
        onboarding = create(:user_onboarding,
          user: user,
          prayer_book: prayer_book,
          bible_version: bible_version,
          mode: "basic",
          preferences: {})

        expect(onboarding.preferences["test_pref"]).to eq("traditional")
      end
    end

    describe "set_completed_at" do
      it "sets completed_at when onboarding_completed is true" do
        onboarding = create(:user_onboarding, onboarding_completed: true, completed_at: nil)
        expect(onboarding.completed_at).to be_present
      end
    end
  end

  describe "#preference_value" do
    let(:prayer_book) { create(:prayer_book) }
    let(:category) { create(:preference_category, prayer_book: prayer_book) }
    let!(:definition) { create(:preference_definition, :select_one, preference_category: category, key: "test_pref", default_value: "traditional") }
    let(:bible_version) { create(:bible_version) }
    let(:user) { create(:user) }

    it "returns the preference value if set" do
      onboarding = create(:user_onboarding,
        user: user,
        prayer_book: prayer_book,
        bible_version: bible_version,
        preferences: { "test_pref" => "contemporary" })

      expect(onboarding.preference_value("test_pref")).to eq("contemporary")
    end

    it "returns the default value if not set" do
      onboarding = create(:user_onboarding,
        user: user,
        prayer_book: prayer_book,
        bible_version: bible_version,
        preferences: {})

      expect(onboarding.preference_value("test_pref")).to eq("traditional")
    end
  end

  describe "#preferences_with_defaults" do
    let(:prayer_book) { create(:prayer_book) }
    let(:category) { create(:preference_category, prayer_book: prayer_book) }
    let!(:definition1) { create(:preference_definition, :select_one, preference_category: category, key: "pref1", default_value: "traditional") }
    let!(:definition2) { create(:preference_definition, :toggle, preference_category: category, key: "pref2", default_value: "true") }
    let(:bible_version) { create(:bible_version) }
    let(:user) { create(:user) }

    it "returns all preferences with defaults applied" do
      onboarding = create(:user_onboarding,
        user: user,
        prayer_book: prayer_book,
        bible_version: bible_version,
        mode: "advanced",
        preferences: { "pref1" => "contemporary" })

      prefs = onboarding.preferences_with_defaults
      expect(prefs["pref1"]).to eq("contemporary")
      expect(prefs["pref2"]).to be true
    end
  end
end
