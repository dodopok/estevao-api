# Main seed file for LOC 2019 English
# This file coordinates the loading of all data for this prayer book

Rails.logger.info "📖 Starting LOC 2019 English (loc_2019_en) seed..."

base_path = 'db/seeds/prayer_books/loc_2019_en/data'

# 1. Celebrations
require Rails.root.join(base_path, 'celebrations/seed_celebrations.rb')

# Future seeds for LOC 2019 EN can be added here:
# - Liturgical Texts
# - Psalms
# - Collects
# - Readings

Rails.logger.info "✅ LOC 2019 English (loc_2019_en) seed completed!"
