# frozen_string_literal: true

class FcmToken < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, uniqueness: { scope: :user_id }
  validates :platform, inclusion: { in: %w[android ios web] }, allow_nil: true

  # Tokens ativos são aqueles atualizados nos últimos 60 dias
  scope :active, -> { where("updated_at > ?", 60.days.ago) }
end
