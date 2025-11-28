# frozen_string_literal: true

require "rails_helper"

RSpec.describe LifeRuleStep, type: :model do
  describe "associations" do
    let(:life_rule) { create(:life_rule) }
    let(:step) { create(:life_rule_step, life_rule: life_rule) }

    it "belongs to life_rule" do
      expect(step).to respond_to(:life_rule)
      expect(step.life_rule).to eq(life_rule)
    end
  end

  describe "validations" do
    let(:life_rule) { create(:life_rule) }

    it "validates presence of order" do
      step = LifeRuleStep.new(life_rule: life_rule, order: nil, title: "Test")
      expect(step).not_to be_valid
      expect(step.errors[:order]).to include("can't be blank")
    end

    it "validates presence of title" do
      step = LifeRuleStep.new(life_rule: life_rule, order: 1, title: nil)
      expect(step).not_to be_valid
      expect(step.errors[:title]).to include("can't be blank")
    end

    it "validates order is an integer" do
      step = LifeRuleStep.new(life_rule: life_rule, order: "not_a_number", title: "Test")
      expect(step).not_to be_valid
    end

    it "validates order is greater than or equal to 0" do
      step = LifeRuleStep.new(life_rule: life_rule, order: -1, title: "Test")
      expect(step).not_to be_valid
      expect(step.errors[:order]).to include("must be greater than or equal to 0")
    end

    it "validates uniqueness of order scoped to life_rule" do
      create(:life_rule_step, life_rule: life_rule, order: 1)
      duplicate = LifeRuleStep.new(life_rule: life_rule, order: 1, title: "Another Step")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:order]).to include("has already been taken")
    end

    it "allows same order for different life_rules" do
      another_life_rule = create(:life_rule)
      create(:life_rule_step, life_rule: life_rule, order: 1)
      step = LifeRuleStep.new(life_rule: another_life_rule, order: 1, title: "Step")

      expect(step).to be_valid
    end
  end

  describe "default scope" do
    let(:life_rule) { create(:life_rule) }

    it "orders by order ascending" do
      step3 = create(:life_rule_step, life_rule: life_rule, order: 3)
      step1 = create(:life_rule_step, life_rule: life_rule, order: 1)
      step2 = create(:life_rule_step, life_rule: life_rule, order: 2)

      steps = life_rule.life_rule_steps.to_a
      expect(steps).to eq([ step1, step2, step3 ])
    end
  end
end
