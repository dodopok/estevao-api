# ================================================================================
# LOCB 2008 - LIVRO DE ORAÇÃO COMUM BRASILEIRO
# Diocese do Recife - Comunhão Anglicana
# ================================================================================

base_path = 'db/seeds/prayer_books/locb_2008/data'

# ================================================================================
# CELEBRAÇÕES (organizadas por categoria)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO CELEBRAÇÕES - LOCB 2008"
Rails.logger.info "="*80

# Festas Principais (7 celebrações)
load Rails.root.join("#{base_path}/celebrations/principal_feasts.rb")

# Dias Santos (Outras Festas do Senhor + Calendário Maior)
load Rails.root.join("#{base_path}/celebrations/holy_days.rb")

# Dias de Jejum
load Rails.root.join("#{base_path}/celebrations/fasting_days.rb")

# Comemorações (Janeiro a Dezembro)
load Rails.root.join("#{base_path}/celebrations/commemorations.rb")

Rails.logger.info "✓ Celebrações carregadas com sucesso"

# ================================================================================
# LEITURAS DO LECIONÁRIO (organizadas por tempo litúrgico)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO LEITURAS DO LECIONÁRIO - LOCB 2008"
Rails.logger.info "="*80

# Advento
load Rails.root.join("#{base_path}/readings/advent.rb")

# Natal
load Rails.root.join("#{base_path}/readings/christmas.rb")

# Tempo Comum I (Domingos após Epifania)
load Rails.root.join("#{base_path}/readings/epiphany.rb")

# Quaresma
load Rails.root.join("#{base_path}/readings/lent.rb")

# Semana Santa
load Rails.root.join("#{base_path}/readings/holy_week.rb")

# Tempo Pascal
load Rails.root.join("#{base_path}/readings/easter.rb")

# Pentecostes
load Rails.root.join("#{base_path}/readings/pentecost.rb")

# Tempo Comum II (Domingos após Pentecostes)
load Rails.root.join("#{base_path}/readings/ordinary_time.rb")

# Dias Santos e Festas Maiores
load Rails.root.join("#{base_path}/readings/holy_days.rb")

# Ocasiões Especiais
load Rails.root.join("#{base_path}/readings/special_occasions.rb")

Rails.logger.info "✓ Leituras carregadas com sucesso"

# ================================================================================
# COLETAS (organizadas por tempo litúrgico)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO COLETAS - LOCB 2008"
Rails.logger.info "="*80

# Advento
load Rails.root.join("#{base_path}/collects/advent.rb")

# Natal
load Rails.root.join("#{base_path}/collects/christmas.rb")

# Tempo Comum I (Domingos após Epifania)
load Rails.root.join("#{base_path}/collects/epiphany.rb")

# Quaresma
load Rails.root.join("#{base_path}/collects/lent.rb")

# Semana Santa
load Rails.root.join("#{base_path}/collects/holy_week.rb")

# Tempo Pascal
load Rails.root.join("#{base_path}/collects/easter.rb")

# Pentecostes
load Rails.root.join("#{base_path}/collects/pentecost.rb")

# Tempo Comum II (Domingos após Pentecostes)
load Rails.root.join("#{base_path}/collects/ordinary_time.rb")

# Dias Santos e Festas Maiores
load Rails.root.join("#{base_path}/collects/holy_days.rb")

# Coletas Comuns para Comemorações
load Rails.root.join("#{base_path}/collects/common.rb")

# Ocasiões Especiais
load Rails.root.join("#{base_path}/collects/special_occasions.rb")

Rails.logger.info "✓ Coletas carregadas com sucesso"

# ================================================================================
# OFÍCIO DIÁRIO - CICLO DE SALMOS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO CICLO DE SALMOS - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/psalm_cycles.rb")

# ================================================================================
# OFÍCIO DIÁRIO - TEXTOS LITÚRGICOS, SALMOS E CICLOS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO OFÍCIO DIÁRIO - LOC 2015"
Rails.logger.info "="*80

# Textos Litúrgicos
load Rails.root.join("#{base_path}/liturgical_texts.rb")

# Preferências
load Rails.root.join("#{base_path}/preferences.rb")

# ================================================================================
# OFÍCIO DIÁRIO - LEITURAS DIÁRIAS (Ciclo Bianual)
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO LEITURAS DIÁRIAS - LOCB 2008"
Rails.logger.info "="*80

load Rails.root.join("#{base_path}/readings/daily_office.rb")

Rails.logger.info "\n" + "="*80
Rails.logger.info "LOCB 2008 - CARREGAMENTO COMPLETO ✓"
Rails.logger.info "="*80
