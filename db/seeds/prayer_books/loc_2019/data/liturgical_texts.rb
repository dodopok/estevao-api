# Seeds for Liturgical Texts - LOC 2019
# This file coordinates the loading of all granular liturgical texts for this prayer book

def create_text(slug, category, content, reference: nil, title: nil)
  prayer_book = PrayerBook.find_by!(code: 'loc_2019')
  LiturgicalText.find_or_create_by!(slug: slug, prayer_book_id: prayer_book.id) do |lt|
    lt.category = category
    lt.content = content
    lt.reference = reference
    lt.title = title
      end
end

Rails.logger.info "Creating granular liturgical texts for LOC 2019 Portuguese..."

# Load specific office texts
load Rails.root.join('db/seeds/prayer_books/loc_2019/data/morning_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_2019/data/midday_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_2019/data/evening_prayer_texts.rb')
load Rails.root.join('db/seeds/prayer_books/loc_2019/data/compline_prayer_texts.rb')

# Shared/Common texts
create_text('gloria_patri', 'prayer', "Glória ao Pai, e ao Filho, e ao Espírito Santo; como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém.")

Rails.logger.info "✅ LOC 2019 Portuguese liturgical texts updated!"
