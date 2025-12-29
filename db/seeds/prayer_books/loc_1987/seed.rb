# frozen_string_literal: true

prayer_book_dir = Rails.root.join("db/seeds/prayer_books/loc_1987")

puts "📚 Seeding LOC 1987 data..."

# Load Preferences
if File.exist?(prayer_book_dir.join("data/preferences.rb"))
  load prayer_book_dir.join("data/preferences.rb")
end

# Load Liturgical Texts
if File.exist?(prayer_book_dir.join("data/liturgical_texts/canticles.rb"))
  load prayer_book_dir.join("data/liturgical_texts/canticles.rb")
end

if File.exist?(prayer_book_dir.join("data/liturgical_texts/daily_office.rb"))
  load prayer_book_dir.join("data/liturgical_texts/daily_office.rb")
end

# Load Collects
if File.exist?(prayer_book_dir.join("collects.rb"))
  load prayer_book_dir.join("collects.rb")
end

puts "✅ LOC 1987 seeded successfully!"
