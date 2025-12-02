# frozen_string_literal: true

require "rails_helper"

RSpec.describe PreferenceCategory, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:prayer_book) }
    it { is_expected.to have_many(:preference_definitions).dependent(:destroy) }
  end

  describe "validations" do
    subject { build(:preference_category) }

    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_uniqueness_of(:key).scoped_to(:prayer_book_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_numericality_of(:position).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe "default_scope" do
    let(:prayer_book) { create(:prayer_book) }
    let!(:category_3) { create(:preference_category, prayer_book: prayer_book, position: 3) }
    let!(:category_1) { create(:preference_category, prayer_book: prayer_book, position: 1) }
    let!(:category_2) { create(:preference_category, prayer_book: prayer_book, position: 2) }

    it "orders by position" do
      expect(prayer_book.preference_categories).to eq([ category_1, category_2, category_3 ])
    end
  end

  describe "#as_json_for_api" do
    let(:category) { create(:preference_category, :with_preferences) }

    it "returns the expected structure" do
      json = category.as_json_for_api

      expect(json[:id]).to eq(category.key)
      expect(json[:key]).to eq(category.key)
      expect(json[:name]).to eq(category.name)
      expect(json[:description]).to eq(category.description)
      expect(json[:icon]).to eq(category.icon)
      expect(json[:order]).to eq(category.position)
      expect(json[:preferences]).to be_an(Array)
      expect(json[:preferences].length).to eq(2)
    end
  end
end
