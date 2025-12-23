base_path = 'db/seeds/prayer_books/locb_2008/data/liturgical_texts'

# ================================================================================
# OFÍCIO DIÁRIO (organizados por rito)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO MATUTINO - RITO 1 - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/morning_prayer_rite_one.rb")

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO MATUTINO - RITO 2 - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/morning_prayer_rite_two.rb")

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO MATUTINO - RITO 3 - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/morning_prayer_rite_three.rb")

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO MATUTINO - RITO 4 - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/morning_prayer_rite_four.rb")

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO DO MEIO-DIA - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/midday_prayer.rb")

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO VESPERTINO - RITO 1 - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/evening_prayer_rite_one.rb")
