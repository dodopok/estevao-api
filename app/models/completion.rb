# frozen_string_literal: true

class Completion < ApplicationRecord
  belongs_to :user

  validates :date_reference, presence: true
  validates :office_type, presence: true, inclusion: {
    in: %w[morning midday evening compline],
    message: "%<value>s is not a valid office type"
  }
  validates :user_id, uniqueness: {
    scope: %i[date_reference office_type],
    message: "already completed this office today"
  }

  # Scopes úteis
  scope :today, -> { where(date_reference: Date.today) }
  scope :for_date, ->(date) { where(date_reference: date) }
  scope :for_office, ->(office_type) { where(office_type:) }
end
