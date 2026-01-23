# frozen_string_literal: true

class LifeRuleStep < ApplicationRecord
  belongs_to :life_rule

  validates :order, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true
  
  # Validação de unicidade customizada para permitir reordenação e ignorar itens deletados
  validate :unique_order_in_life_rule

  default_scope { order(:order) }

  private

  def unique_order_in_life_rule
    return unless life_rule
    
    # Busca outros passos da mesma regra
    other_steps = life_rule.life_rule_steps.select do |s| 
      s != self && !s.marked_for_destruction?
    end
    
    if other_steps.any? { |s| s.order == order }
      errors.add(:order, "has already been taken")
    end
  end
end
