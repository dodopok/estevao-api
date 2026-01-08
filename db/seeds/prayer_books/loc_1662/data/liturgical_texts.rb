# Seeds for Liturgical Texts - LOC 1662
# This file coordinates the loading of all granular liturgical texts for this prayer book

def create_text(slug, category, content, reference: nil, title: nil)
  prayer_book = PrayerBook.find_by!(code: 'loc_1662')
  LiturgicalText.find_or_create_by!(slug: slug, prayer_book_id: prayer_book.id) do |lt|
    lt.category = category
    lt.content = content
    lt.reference = reference
    lt.title = title
    lt.language = 'pt-BR'
  end
end

Rails.logger.info "Creating granular liturgical texts for LOC 1662 Portuguese..."

# Load specific office texts
load Rails.root.join('db/seeds/prayer_books/loc_1662/data/morning_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_1662/data/evening_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_1662/data/additional_texts.rb')

Rails.logger.info "✅ LOC 1662 Portuguese liturgical texts updated!"
