# frozen_string_literal: true

class Journal < ApplicationRecord
  belongs_to :user

  validates :date_reference, presence: true
  validates :entry_type, presence: true, inclusion: {
    in: %w[daily_office life_rule],
    message: "%<value>s is not a valid entry type"
  }
  validates :office_type, inclusion: {
    in: %w[morning midday evening compline],
    message: "%<value>s is not a valid office type"
  }, if: -> { entry_type == 'daily_office' }
  validates :content, presence: true, length: { minimum: 1, maximum: 10_000 }

  # Scopes
  scope :for_date, ->(date) { where(date_reference: date) }
  scope :for_month, ->(year, month) { 
    where(date_reference: Date.new(year, month, 1)..Date.new(year, month, -1))
  }
  scope :daily_office_entries, -> { where(entry_type: 'daily_office') }
  scope :life_rule_entries, -> { where(entry_type: 'life_rule') }
  scope :ordered_by_date, -> { order(date_reference: :desc, created_at: :desc) }
end
