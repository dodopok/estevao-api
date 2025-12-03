# frozen_string_literal: true

class SharedOffice < ApplicationRecord
  # Base62 characters for short code generation (URL-safe)
  BASE62_CHARS = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a

  SHORT_CODE_LENGTH = 7
  DEFAULT_EXPIRATION_DAYS = 30

  VALID_OFFICE_TYPES = %w[morning midday evening compline].freeze

  belongs_to :user, optional: true

  validates :short_code, presence: true, uniqueness: true, length: { is: SHORT_CODE_LENGTH }
  validates :prayer_book_code, presence: true
  validates :office_type, presence: true, inclusion: { in: VALID_OFFICE_TYPES }
  validates :date, presence: true
  validates :seed, presence: true
  validates :expires_at, presence: true

  before_validation :generate_short_code, on: :create
  before_validation :set_expiration, on: :create

  scope :active, -> { where("expires_at > ?", Time.current) }
  scope :expired, -> { where("expires_at <= ?", Time.current) }

  # Find an active shared office by its short code
  def self.find_active(short_code)
    active.find_by(short_code: short_code)
  end

  # Check if this shared office is still valid
  def active?
    expires_at > Time.current
  end

  def expired?
    !active?
  end

  # Returns the full shareable URL path
  def share_path
    "/o/#{short_code}"
  end

  # Builds the preferences hash to be used when generating the office
  def office_preferences
    (preferences || {}).merge(
      prayer_book_code: prayer_book_code,
      seed: seed
    ).with_indifferent_access
  end

  private

  def generate_short_code
    return if short_code.present?

    loop do
      self.short_code = generate_base62_code
      break unless self.class.exists?(short_code: short_code)
    end
  end

  def generate_base62_code
    SHORT_CODE_LENGTH.times.map { BASE62_CHARS.sample }.join
  end

  def set_expiration
    return if expires_at.present?

    self.expires_at = DEFAULT_EXPIRATION_DAYS.days.from_now
  end
end
