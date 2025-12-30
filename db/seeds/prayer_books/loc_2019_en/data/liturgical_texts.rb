# Seeds for Liturgical Texts - LOC 2019 EN
# This file coordinates the loading of all granular liturgical texts for this prayer book

def create_text(slug, category, content, reference: nil, title: nil)
  prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')
  LiturgicalText.find_or_create_by!(slug: slug, prayer_book_id: prayer_book.id) do |lt|
    lt.category = category
    lt.content = content
    lt.reference = reference
    lt.title = title
    lt.language = 'en'
  end
end

Rails.logger.info "Creating granular liturgical texts for LOC 2019 English..."

# Load specific office texts
load Rails.root.join('db/seeds/prayer_books/loc_2019_en/data/morning_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_2019_en/data/midday_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_2019_en/data/evening_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_2019_en/data/compline_prayer_texts.rb')

# Shared/Common texts
create_text('gloria_patri', 'prayer', "Glory be to the Father, and to the Son, and to the Holy Spirit; as it was in the beginning, is now, and ever shall be, world without end. Amen.")

Rails.logger.info "✅ LOC 2019 English liturgical texts updated!"
