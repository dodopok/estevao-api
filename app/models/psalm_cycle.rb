class PsalmCycle < ApplicationRecord
  # Relacionamentos
  belongs_to :prayer_book

  # Validações
  validates :cycle_type, presence: true, inclusion: { in: %w[weekly monthly] }
  validates :day_of_week, presence: true, inclusion: { in: 0..6 }
  validates :office_type, presence: true, inclusion: { in: %w[morning evening midday compline] }
  validates :psalm_numbers, presence: true

  # Scopes
  scope :weekly, -> { where(cycle_type: "weekly") }
  scope :monthly, -> { where(cycle_type: "monthly") }
  scope :for_office, ->(office_type) { where(office_type: office_type) }
  scope :for_day, ->(day_of_week) { where(day_of_week: day_of_week) }
  scope :for_prayer_book, ->(code) {
    prayer_book = PrayerBook.find_by(code: code)
    where(prayer_book_id: prayer_book&.id)
  }

  # Find psalms for a specific date and office
  def self.find_for_date_and_office(date, office_type, cycle_type: "weekly")
    day_of_week = date.wday

    if cycle_type == "weekly"
      # Simple weekly cycle
      find_by(
        cycle_type: "weekly",
        day_of_week: day_of_week,
        office_type: office_type,
        week_number: nil
      )
    elsif cycle_type == "monthly"
      # 30-day monthly cycle
      day_of_month = ((date.day - 1) % 30) + 1
      find_by(
        cycle_type: "monthly",
        day_of_week: day_of_month,
        office_type: office_type
      )
    end
  end

  # Get the actual Psalm objects for this cycle
  def psalms(prayer_book_code: "loc_2015")
    return [] unless psalm_numbers.is_a?(Array)

    psalm_numbers.map do |number|
      Psalm.find_psalm(number, prayer_book_code: prayer_book_code)
    end.compact
  end

  # Get formatted psalm numbers as string (e.g., "95, 96")
  def formatted_psalm_numbers
    return "" unless psalm_numbers.is_a?(Array)

    if psalm_numbers.length == 1
      "Salmo #{psalm_numbers.first}"
    else
      "Salmos #{psalm_numbers.join(', ')}"
    end
  end

  # Constants for office types
  OFFICE_TYPES = {
    morning: "morning",
    evening: "evening",
    midday: "midday",
    compline: "compline"
  }.freeze

  CYCLE_TYPES = {
    weekly: "weekly",
    monthly: "monthly"
  }.freeze
end
