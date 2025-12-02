# frozen_string_literal: true

require "rails_helper"

RSpec.describe BibleVersion, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:user_onboardings).dependent(:restrict_with_error) }
  end

  describe "validations" do
    subject { build(:bible_version) }

    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "scopes" do
    let!(:active_version) { create(:bible_version, is_active: true) }
    let!(:inactive_version) { create(:bible_version, is_active: false) }
    let!(:recommended_version) { create(:bible_version, is_recommended: true) }

    describe ".active" do
      it "returns only active versions" do
        expect(described_class.active).to include(active_version)
        expect(described_class.active).not_to include(inactive_version)
      end
    end

    describe ".recommended" do
      it "returns only recommended versions" do
        expect(described_class.recommended).to include(recommended_version)
        expect(described_class.recommended).not_to include(active_version)
      end
    end
  end

  describe ".find_by_code" do
    let!(:version) { create(:bible_version, code: "nvi") }

    it "finds by lowercase code" do
      expect(described_class.find_by_code("nvi")).to eq(version)
    end

    it "finds by uppercase code" do
      expect(described_class.find_by_code("NVI")).to eq(version)
    end

    it "returns nil for non-existent code" do
      expect(described_class.find_by_code("unknown")).to be_nil
    end
  end

  describe ".find_by_code!" do
    let!(:version) { create(:bible_version, code: "nvi") }

    it "finds by code" do
      expect(described_class.find_by_code!("nvi")).to eq(version)
    end

    it "raises error for non-existent code" do
      expect { described_class.find_by_code!("unknown") }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
