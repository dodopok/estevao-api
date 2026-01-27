# ================================================================================
# LOC 2015 - LITURGIA DAS HORAS (IEAB)
# ================================================================================

base_path = 'db/seeds/prayer_books/loc_2015/data'

# ================================================================================
# CELEBRAÇÕES (organizadas por categoria)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO CELEBRAÇÕES - LOC 2015"
Rails.logger.info "="*80

# Festas Principais
load Rails.root.join("#{base_path}/celebrations/seed_celebrations.rb")

Rails.logger.info "✓ Celebrações carregadas com sucesso"

# ================================================================================
# LEITURAS DO LECIONÁRIO (organizadas por tempo litúrgico)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO LEITURAS DO LECIONÁRIO - LOC 2015"
Rails.logger.info "="*80

# Advento
load Rails.root.join("#{base_path}/readings/advent.rb")

# Natal
load Rails.root.join("#{base_path}/readings/christmas.rb")

# Epifania
load Rails.root.join("#{base_path}/readings/epiphany.rb")

# Quaresma
load Rails.root.join("#{base_path}/readings/lent.rb")

# Semana Santa e Páscoa
load Rails.root.join("#{base_path}/readings/holy_week_easter.rb")

# Tempo Pascal
load Rails.root.join("#{base_path}/readings/easter_season.rb")

# Pentecostes
load Rails.root.join("#{base_path}/readings/pentecost.rb")

# Tempo Comum
load Rails.root.join("#{base_path}/readings/ordinary_time.rb")

# Festas Fixas
load Rails.root.join("#{base_path}/readings/fixed_feasts.rb")

# Observâncias Especiais
load Rails.root.join("#{base_path}/readings/special.rb")

# Leituras Complementares (exemplos)
load Rails.root.join("#{base_path}/readings/complementary_examples.rb")

# Leituras Semanais do Ofício Diário
load Rails.root.join("#{base_path}/readings/weekly_office.rb")

Rails.logger.info "✓ Leituras carregadas com sucesso"

# ================================================================================
# COLETAS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO COLETAS - LOC 2015"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/collects.rb")

Rails.logger.info "✓ Coletas carregadas com sucesso"

# ================================================================================
# OFÍCIO DIÁRIO - TEXTOS LITÚRGICOS, SALMOS E CICLOS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO DIÁRIO - LOC 2015"
Rails.logger.info "="*80

# Textos Litúrgicos
load Rails.root.join("#{base_path}/liturgical_texts.rb")
load Rails.root.join("#{base_path}/family_rite_texts.rb")

# Preferências
load Rails.root.join("#{base_path}/preferences.rb")

# Salmos
load Rails.root.join("#{base_path}/psalms.rb")

# Ciclos de Salmos
load Rails.root.join("#{base_path}/psalm_cycles.rb")

Rails.logger.info "✓ Ofício Diário carregado com sucesso"

Rails.logger.info "\n" + "="*80
Rails.logger.info "LOC 2015 - CARREGAMENTO COMPLETO ✓"
Rails.logger.info "="*80
