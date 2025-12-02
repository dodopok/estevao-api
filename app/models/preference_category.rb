# frozen_string_literal: true

class PreferenceCategory < ApplicationRecord
  belongs_to :prayer_book
  has_many :preference_definitions, -> { order(:position) }, dependent: :destroy

  validates :key, presence: true, uniqueness: { scope: :prayer_book_id }
  validates :name, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order(:position) }

  def as_json_for_api
    {
      id: key,
      key: key,
      name: name,
      description: description,
      icon: icon,
      order: position,
      preferences: preference_definitions.map(&:as_json_for_api)
    }
  end
end
