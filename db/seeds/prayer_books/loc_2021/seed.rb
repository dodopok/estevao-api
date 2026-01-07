# ================================================================================
# LOC 2021 - IAB
# ================================================================================

base_path = 'db/seeds/prayer_books/loc_2021/data'

# ================================================================================
# CELEBRAÇÕES
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO CELEBRAÇÕES - LOC 2021"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/celebrations/seed_celebrations.rb") if File.exist?(Rails.root.join("#{base_path}/celebrations/seed_celebrations.rb"))

# ================================================================================
# LEITURAS DO LECIONÁRIO
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO LEITURAS DO LECIONÁRIO - LOC 2021"
Rails.logger.info "="*80

# Advento
load Rails.root.join("#{base_path}/readings/advent.rb") if File.exist?(Rails.root.join("#{base_path}/readings/advent.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_advent.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_advent.rb"))

# Natal
load Rails.root.join("#{base_path}/readings/christmas.rb") if File.exist?(Rails.root.join("#{base_path}/readings/christmas.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_christmas.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_christmas.rb"))

# Epifania
load Rails.root.join("#{base_path}/readings/epiphany.rb") if File.exist?(Rails.root.join("#{base_path}/readings/epiphany.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_epiphany.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_epiphany.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_epiphany_part2.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_epiphany_part2.rb"))

# Quaresma
load Rails.root.join("#{base_path}/readings/lent.rb") if File.exist?(Rails.root.join("#{base_path}/readings/lent.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_lent.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_lent.rb"))

# Semana Santa e Páscoa
load Rails.root.join("#{base_path}/readings/holy_week_easter.rb") if File.exist?(Rails.root.join("#{base_path}/readings/holy_week_easter.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_easter.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_easter.rb"))

# Tempo Pascal
load Rails.root.join("#{base_path}/readings/easter_season.rb") if File.exist?(Rails.root.join("#{base_path}/readings/easter_season.rb"))

# Pentecostes
load Rails.root.join("#{base_path}/readings/pentecost.rb") if File.exist?(Rails.root.join("#{base_path}/readings/pentecost.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_pentecost.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_pentecost.rb"))

# Tempo Comum
load Rails.root.join("#{base_path}/readings/ordinary_time.rb") if File.exist?(Rails.root.join("#{base_path}/readings/ordinary_time.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_ordinary_part1.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_ordinary_part1.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_ordinary_part2.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_ordinary_part2.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_ordinary_part3.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_ordinary_part3.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_ordinary_part4.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_ordinary_part4.rb"))

# Anos Pares
load Rails.root.join("#{base_path}/readings/daily_office_advent_even.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_advent_even.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_christmas_even.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_christmas_even.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_epiphany_even_part2.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_epiphany_even_part2.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_lent_even.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_lent_even.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_easter_even.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_easter_even.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_ordinary_even_part1.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_ordinary_even_part1.rb"))
load Rails.root.join("#{base_path}/readings/daily_office_ordinary_even_part2.rb") if File.exist?(Rails.root.join("#{base_path}/readings/daily_office_ordinary_even_part2.rb"))

# Festas Fixas
load Rails.root.join("#{base_path}/readings/fixed_feasts.rb") if File.exist?(Rails.root.join("#{base_path}/readings/fixed_feasts.rb"))

Rails.logger.info "✓ Leituras carregadas com sucesso"

# ================================================================================
# COLETAS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO COLETAS - LOC 2021"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/collects.rb") if File.exist?(Rails.root.join("#{base_path}/collects.rb"))

Rails.logger.info "✓ Coletas carregadas com sucesso"
