# frozen_string_literal: true

class LifeRule < ApplicationRecord
  belongs_to :user
  belongs_to :original_life_rule, class_name: "LifeRule", optional: true
  has_many :life_rule_steps, dependent: :destroy
  has_many :adoptions, class_name: "LifeRule", foreign_key: "original_life_rule_id", dependent: :nullify

  validates :icon, presence: true
  validates :title, presence: true
  validates :is_public, inclusion: { in: [ true, false ] }
  validates :approved, inclusion: { in: [ true, false ] }
  validates :user_id, uniqueness: true

  accepts_nested_attributes_for :life_rule_steps, allow_destroy: true

  scope :approved, -> { where(approved: true) }
  scope :public_rules, -> { where(is_public: true, approved: true) }
  scope :by_popularity, -> { order(adoption_count: :desc) }
  scope :search_by_title, ->(query) { where("title ILIKE ?", "%#{query}%") }

  # Cria uma cópia desta regra para outro usuário
  # Destrói a regra anterior do usuário antes de criar a nova
  def adopt_by(user)
    # Remove a regra anterior do usuário, se existir
    user.life_rule&.destroy

    adopted_rule = self.class.new(
      user: user,
      original_life_rule: self,
      icon: icon,
      title: title,
      description: description,
      is_public: false, # Cópia é privada por padrão
      approved: false
    )

    # Copia as etapas
    life_rule_steps.each do |step|
      adopted_rule.life_rule_steps.build(
        order: step.order,
        title: step.title,
        description: step.description
      )
    end

    if adopted_rule.save
      increment!(:adoption_count)
      adopted_rule
    else
      adopted_rule
    end
  end
end
