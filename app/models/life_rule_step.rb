# frozen_string_literal: true

class LifeRuleStep < ApplicationRecord
  belongs_to :life_rule

  validates :order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true
  validates :order, uniqueness: { scope: :life_rule_id }

  default_scope { order(:order) }
end
