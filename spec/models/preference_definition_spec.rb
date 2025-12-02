# frozen_string_literal: true

require "rails_helper"

RSpec.describe PreferenceDefinition, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:preference_category) }
    it { is_expected.to have_one(:prayer_book).through(:preference_category) }
  end

  describe "validations" do
    subject { build(:preference_definition) }

    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_uniqueness_of(:key).scoped_to(:preference_category_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:pref_type) }
    it { is_expected.to validate_inclusion_of(:pref_type).in_array(%w[select_one toggle time text number]) }
    it { is_expected.to validate_presence_of(:position) }

    context "with select_one type" do
      it "validates options are present" do
        definition = build(:preference_definition, pref_type: "select_one", options: nil)
        expect(definition).not_to be_valid
        expect(definition.errors[:options]).to include("must be a non-empty array for select_one type")
      end

      it "validates options have value and label" do
        definition = build(:preference_definition, pref_type: "select_one", options: [ { "value" => "test" } ])
        expect(definition).not_to be_valid
        expect(definition.errors[:options].first).to include("must have 'value' and 'label'")
      end
    end
  end

  describe "#typed_default_value" do
    it "returns boolean for toggle type" do
      definition = build(:preference_definition, :toggle, default_value: "true")
      expect(definition.typed_default_value).to be true

      definition = build(:preference_definition, :toggle, default_value: "false")
      expect(definition.typed_default_value).to be false
    end

    it "returns integer for number type" do
      definition = build(:preference_definition, pref_type: "number", default_value: "42", options: nil)
      expect(definition.typed_default_value).to eq(42)
    end

    it "returns string for other types" do
      definition = build(:preference_definition, :select_one, default_value: "traditional")
      expect(definition.typed_default_value).to eq("traditional")
    end
  end

  describe "#valid_value?" do
    context "for select_one type" do
      let(:definition) { build(:preference_definition, :select_one) }

      it "returns true for valid option value" do
        expect(definition.valid_value?("traditional")).to be true
        expect(definition.valid_value?("contemporary")).to be true
      end

      it "returns false for invalid option value" do
        expect(definition.valid_value?("invalid")).to be false
      end
    end

    context "for toggle type" do
      let(:definition) { build(:preference_definition, :toggle) }

      it "returns true for boolean values" do
        expect(definition.valid_value?(true)).to be true
        expect(definition.valid_value?(false)).to be true
        expect(definition.valid_value?("true")).to be true
        expect(definition.valid_value?("false")).to be true
      end

      it "returns false for non-boolean values" do
        expect(definition.valid_value?("yes")).to be false
      end
    end

    context "for time type" do
      let(:definition) { build(:preference_definition, :time) }

      it "returns true for valid time format" do
        expect(definition.valid_value?("07:00")).to be true
        expect(definition.valid_value?("23:59")).to be true
      end

      it "returns false for invalid time format" do
        expect(definition.valid_value?("25:00")).to be false
        expect(definition.valid_value?("7:00")).to be false
        expect(definition.valid_value?("invalid")).to be false
      end

      it "returns true for nil" do
        expect(definition.valid_value?(nil)).to be true
      end
    end
  end

  describe "#as_json_for_api" do
    let(:definition) { create(:preference_definition, :select_one, default_value: "traditional") }

    it "returns the expected structure" do
      json = definition.as_json_for_api

      expect(json[:id]).to eq(definition.key)
      expect(json[:key]).to eq(definition.key)
      expect(json[:name]).to eq(definition.name)
      expect(json[:type]).to eq("select_one")
      expect(json[:required]).to be true
      expect(json[:default_value]).to eq("traditional")
      expect(json[:options]).to be_an(Array)
    end

    it "marks the default option as is_default" do
      json = definition.as_json_for_api
      default_option = json[:options].find { |o| o[:value] == "traditional" }
      expect(default_option[:is_default]).to be true
    end

    it "includes depends_on when present" do
      definition = create(:preference_definition, :with_dependency)
      json = definition.as_json_for_api
      expect(json[:depends_on]).to be_present
    end
  end
end
