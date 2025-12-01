# frozen_string_literal: true

# Concern para services que precisam acessar PrayerBook
# Centraliza a lógica de lookup de prayer_book por código
module PrayerBookAware
  extend ActiveSupport::Concern

  included do
    attr_reader :prayer_book_code
  end

  def prayer_book
    @prayer_book ||= PrayerBook.find_by_code(prayer_book_code)
  end

  def prayer_book_id
    prayer_book&.id
  end
end
