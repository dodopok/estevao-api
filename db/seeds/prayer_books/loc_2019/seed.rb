# Main seed file for LOC 2019 Portuguese
# This file coordinates the loading of all data for this prayer book

Rails.logger.info "📖 Starting LOC 2019 Portuguese (loc_2019) seed..."

base_path = 'db/seeds/prayer_books/loc_2019/data'

# 1. Celebrations
require Rails.root.join(base_path, 'celebrations/seed_celebrations.rb')

# 2. Collects
require Rails.root.join(base_path, 'collects.rb')

# 3. Readings
require Rails.root.join(base_path, 'readings/advent.rb')
require Rails.root.join(base_path, 'readings/christmas.rb')
require Rails.root.join(base_path, 'readings/epiphany.rb')
require Rails.root.join(base_path, 'readings/lent.rb')
require Rails.root.join(base_path, 'readings/holy_week.rb')
require Rails.root.join(base_path, 'readings/easter.rb')
require Rails.root.join(base_path, 'readings/pentecost_ordinary.rb')
require Rails.root.join(base_path, 'readings/fixed_feasts.rb')
require Rails.root.join(base_path, 'readings/daily_office.rb')

# 4. Liturgical Texts
require Rails.root.join(base_path, 'liturgical_texts.rb')

# 5. Preferences
require Rails.root.join(base_path, 'preferences.rb')

Rails.logger.info "✅ LOC 2019 Portuguese (loc_2019) seed completed!"
