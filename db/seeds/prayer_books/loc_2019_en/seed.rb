# Main seed file for LOC 2019 English
# This file coordinates the loading of all data for this prayer book

Rails.logger.info "📖 Starting LOC 2019 English (loc_2019_en) seed..."

base_path = 'db/seeds/prayer_books/loc_2019_en/data'

# 1. Celebrations
require Rails.root.join(base_path, 'celebrations/seed_celebrations.rb')

# 2. Collects
require Rails.root.join(base_path, 'collects.rb')

# 3. Readings
load Rails.root.join(base_path, 'readings/advent.rb')
load Rails.root.join(base_path, 'readings/christmas.rb')
load Rails.root.join(base_path, 'readings/epiphany.rb')
load Rails.root.join(base_path, 'readings/lent.rb')
load Rails.root.join(base_path, 'readings/holy_week.rb')
load Rails.root.join(base_path, 'readings/easter.rb')
load Rails.root.join(base_path, 'readings/pentecost_ordinary.rb')
load Rails.root.join(base_path, 'readings/fixed_feasts.rb')
load Rails.root.join(base_path, 'readings/daily_office_jan_may.rb')
load Rails.root.join(base_path, 'readings/daily_office.rb')

# 4. Liturgical Texts
load Rails.root.join(base_path, 'liturgical_texts.rb')

# 5. Preferences
load Rails.root.join(base_path, 'preferences.rb')

Rails.logger.info "✅ LOC 2019 English (loc_2019_en) seed completed!"
