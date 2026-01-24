# ================================================================================
# LOC REB - LECIONÁRIO COMUM DA REDE EVANGÉLICA BRASILEIRA
# ================================================================================

base_path = 'db/seeds/prayer_books/loc_reb/data'

# ================================================================================
# CELEBRAÇÕES (Festas e Memórias)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO CELEBRAÇÕES - LOC REB"
Rails.logger.info "="*80

# Festas Principais e Memórias
load Rails.root.join("#{base_path}/celebrations/seed_celebrations.rb")

Rails.logger.info "✓ Celebrações carregadas com sucesso"

# ================================================================================
# LEITURAS DO LECIONÁRIO (organizadas por tempo litúrgico)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO LEITURAS DO LECIONÁRIO - LOC REB"
Rails.logger.info "="*80

# Advento, Natal e Epifania - Domingos
load Rails.root.join("#{base_path}/readings/advent_christmas_epiphany.rb")

# Advento, Natal e Epifania - Leituras Diárias
load Rails.root.join("#{base_path}/readings/advent_christmas_epiphany_daily.rb")

# Quaresma e Semana Santa - Domingos
load Rails.root.join("#{base_path}/readings/lent_holy_week.rb")

# Quaresma e Semana Santa - Leituras Diárias
load Rails.root.join("#{base_path}/readings/lent_holy_week_daily.rb")

# Páscoa e Pentecostes - Domingos
load Rails.root.join("#{base_path}/readings/easter_pentecost.rb")

# Tempo Comum - Domingos
load Rails.root.join("#{base_path}/readings/ordinary_time_sundays.rb")

# Tempo Comum - Leituras Diárias
load Rails.root.join("#{base_path}/readings/ordinary_time_daily.rb")

Rails.logger.info "✓ Leituras carregadas com sucesso"

# ================================================================================
# COLETAS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO COLETAS - LOC REB"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/collects.rb")

Rails.logger.info "✓ Coletas carregadas com sucesso"

Rails.logger.info "\n" + "="*80
Rails.logger.info "LOC REB - CARREGAMENTO COMPLETO ✓"
Rails.logger.info "="*80
