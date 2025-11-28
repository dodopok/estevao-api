# frozen_string_literal: true

require "rails_helper"

RSpec.describe LifeRule, type: :model do
  describe "associations" do
    let(:user) { create(:user) }
    let(:life_rule) { create(:life_rule, user: user) }

    it "belongs to user" do
      expect(life_rule).to respond_to(:user)
      expect(life_rule.user).to eq(user)
    end

    it "has many life_rule_steps" do
      expect(life_rule).to respond_to(:life_rule_steps)
    end

    it "has many adoptions" do
      expect(life_rule).to respond_to(:adoptions)
    end

    it "can belong to an original_life_rule" do
      original_rule = create(:life_rule)
      adopted_rule = create(:life_rule, :adopted, original_life_rule: original_rule)

      expect(adopted_rule.original_life_rule).to eq(original_rule)
    end
  end

  describe "validations" do
    let(:user) { create(:user) }

    it "validates presence of icon" do
      life_rule = LifeRule.new(user: user, icon: nil, title: "Test")
      expect(life_rule).not_to be_valid
      expect(life_rule.errors[:icon]).to include("can't be blank")
    end

    it "validates presence of title" do
      life_rule = LifeRule.new(user: user, icon: "📖", title: nil)
      expect(life_rule).not_to be_valid
      expect(life_rule.errors[:title]).to include("can't be blank")
    end

    it "validates uniqueness of user_id" do
      create(:life_rule, user: user)
      duplicate = LifeRule.new(user: user, icon: "📖", title: "Another Rule")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to include("has already been taken")
    end

    it "validates is_public is a boolean" do
      life_rule = LifeRule.new(user: user, icon: "📖", title: "Test", is_public: nil)
      expect(life_rule).not_to be_valid
    end

    it "validates approved is a boolean" do
      life_rule = LifeRule.new(user: user, icon: "📖", title: "Test", approved: nil)
      expect(life_rule).not_to be_valid
    end
  end

  describe "scopes" do
    let!(:private_rule) { create(:life_rule) }
    let!(:public_unapproved_rule) { create(:life_rule, :public) }
    let!(:public_approved_rule) { create(:life_rule, :public_approved) }
    let!(:popular_rule) { create(:life_rule, :public_approved, adoption_count: 10) }

    describe ".approved" do
      it "returns only approved rules" do
        expect(LifeRule.approved).to include(public_approved_rule, popular_rule)
        expect(LifeRule.approved).not_to include(private_rule, public_unapproved_rule)
      end
    end

    describe ".public_rules" do
      it "returns only public and approved rules" do
        expect(LifeRule.public_rules).to include(public_approved_rule, popular_rule)
        expect(LifeRule.public_rules).not_to include(private_rule, public_unapproved_rule)
      end
    end

    describe ".by_popularity" do
      it "orders by adoption_count descending" do
        result = LifeRule.by_popularity.to_a
        expect(result.first).to eq(popular_rule)
      end
    end

    describe ".search_by_title" do
      it "searches by title case-insensitively" do
        rule = create(:life_rule, title: "Morning Routine")
        expect(LifeRule.search_by_title("morning")).to include(rule)
        expect(LifeRule.search_by_title("MORNING")).to include(rule)
        expect(LifeRule.search_by_title("routine")).to include(rule)
      end
    end
  end

  describe "#adopt_by" do
    let(:original_user) { create(:user) }
    let(:adopting_user) { create(:user) }
    let(:original_rule) { create(:life_rule, :with_steps, user: original_user) }

    it "creates a copy for the adopting user" do
      adopted_rule = original_rule.adopt_by(adopting_user)

      expect(adopted_rule).to be_persisted
      expect(adopted_rule.user).to eq(adopting_user)
      expect(adopted_rule.original_life_rule).to eq(original_rule)
    end

    it "copies the attributes" do
      adopted_rule = original_rule.adopt_by(adopting_user)

      expect(adopted_rule.icon).to eq(original_rule.icon)
      expect(adopted_rule.title).to eq(original_rule.title)
      expect(adopted_rule.description).to eq(original_rule.description)
    end

    it "sets is_public and approved to false" do
      adopted_rule = original_rule.adopt_by(adopting_user)

      expect(adopted_rule.is_public).to be false
      expect(adopted_rule.approved).to be false
    end

    it "copies all steps" do
      adopted_rule = original_rule.adopt_by(adopting_user)

      expect(adopted_rule.life_rule_steps.count).to eq(original_rule.life_rule_steps.count)
      original_rule.life_rule_steps.each_with_index do |step, index|
        adopted_step = adopted_rule.life_rule_steps[index]
        expect(adopted_step.order).to eq(step.order)
        expect(adopted_step.title).to eq(step.title)
        expect(adopted_step.description).to eq(step.description)
      end
    end

    it "increments adoption_count on original rule" do
      expect { original_rule.adopt_by(adopting_user) }.to change { original_rule.reload.adoption_count }.by(1)
    end

    it "destroys existing life rule of adopting user" do
      existing_rule = create(:life_rule, user: adopting_user)
      original_rule.adopt_by(adopting_user)

      expect { existing_rule.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "nested attributes" do
    let(:user) { create(:user) }

    it "accepts nested attributes for life_rule_steps" do
      life_rule = LifeRule.create!(
        user: user,
        icon: "📖",
        title: "Test Rule",
        life_rule_steps_attributes: [
          { order: 1, title: "Step 1", description: "First step" },
          { order: 2, title: "Step 2", description: "Second step" }
        ]
      )

      expect(life_rule.life_rule_steps.count).to eq(2)
    end
  end
end
