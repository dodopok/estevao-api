# frozen_string_literal: true

class Completion < ApplicationRecord
  belongs_to :user

  validates :date_reference, presence: true
  validates :user_id, uniqueness: {
    scope: %i[date_reference office_type],
    message: "already completed this office today"
  }

  # Scopes úteis
  scope :today, -> { where(date_reference: Date.today) }
  scope :for_date, ->(date) { where(date_reference: date) }
  scope :for_office, ->(office_type) { where(office_type:) }
  scope :recent, ->(days = 30) { where("date_reference >= ?", days.days.ago.to_date).order(date_reference: :desc) }
  scope :by_user, ->(user_id) { where(user_id:) }

  # Get completions grouped by office type for reporting
  def self.summary_by_office_type
    group(:office_type).count
  end

  # Check if a specific office was completed on a date
  def self.completed?(user_id, date, office_type)
    exists?(user_id:, date_reference: date, office_type:)
  end
end
