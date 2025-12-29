# frozen_string_literal: true

prayer_book_dir = Rails.root.join("db/seeds/prayer_books/loc_1987")

puts "📚 Seeding LOC 1987 data..."

# Load Celebrations
if File.exist?(prayer_book_dir.join("data/celebrations/seed_celebrations.rb"))
  load prayer_book_dir.join("data/celebrations/seed_celebrations.rb")
end

# Load Preferences
if File.exist?(prayer_book_dir.join("data/preferences.rb"))
  load prayer_book_dir.join("data/preferences.rb")
end

# Load Daily Readings (CSV Import)
if File.exist?(prayer_book_dir.join("data/daily_readings.rb"))
  load prayer_book_dir.join("data/daily_readings.rb")
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

# Load Readings (if present)
readings_dir = prayer_book_dir.join("data/readings")
if Dir.exist?(readings_dir)
  Dir[readings_dir.join('**/*.rb')].sort.each do |f|
    load f
  end
end

puts "✅ LOC 1987 seeded successfully!"
