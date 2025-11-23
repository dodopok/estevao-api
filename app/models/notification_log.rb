# frozen_string_literal: true

class NotificationLog < ApplicationRecord
  belongs_to :user

  validates :notification_type, presence: true
  validates :title, presence: true

  # Scopes úteis
  scope :sent, -> { where(sent: true) }
  scope :failed, -> { where(sent: false) }
  scope :by_type, ->(type) { where(notification_type: type) }
  scope :recent, -> { order(created_at: :desc) }
end
