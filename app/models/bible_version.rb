# frozen_string_literal: true

class BibleVersion < ApplicationRecord
  has_many :user_onboardings, dependent: :restrict_with_error

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true

  scope :active, -> { where(is_active: true) }
  scope :recommended, -> { where(is_recommended: true) }

  def self.find_by_code!(code)
    find_by!(code: code.to_s.downcase)
  end

  def self.find_by_code(code)
    find_by(code: code.to_s.downcase)
  end
end
