# frozen_string_literal: true

class PrayerBook < ApplicationRecord
  has_many :collects, dependent: :restrict_with_error
  has_many :lectionary_readings, dependent: :restrict_with_error
  has_many :liturgical_texts, dependent: :restrict_with_error
  has_many :psalms, dependent: :restrict_with_error
  has_many :psalm_cycles, dependent: :restrict_with_error

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :year, numericality: { only_integer: true, allow_nil: true }

  scope :default, -> { where(is_default: true) }

  def self.find_by_code!(code)
    find_by!(code: code)
  end

  def self.find_by_code_or_default(code)
    code.present? ? find_by(code: code) || default.first : default.first
  end
end
