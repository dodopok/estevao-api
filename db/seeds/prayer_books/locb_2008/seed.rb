# ================================================================================
# LOCB 2008 - LIVRO DE ORAÇÃO COMUM BRASILEIRO
# Diocese do Recife - Comunhão Anglicana
# ================================================================================

base_path = 'db/seeds/prayer_books/locb_2008/data'

# ================================================================================
# CELEBRAÇÕES (organizadas por categoria)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO CELEBRAÇÕES - LOCB 2008"
puts "="*80

# Festas Principais (7 celebrações)
load Rails.root.join("#{base_path}/celebrations/principal_feasts.rb")

# Dias Santos (Outras Festas do Senhor + Calendário Maior)
load Rails.root.join("#{base_path}/celebrations/holy_days.rb")

# Dias de Jejum
load Rails.root.join("#{base_path}/celebrations/fasting_days.rb")

# Comemorações (Janeiro a Dezembro)
load Rails.root.join("#{base_path}/celebrations/commemorations.rb")

puts "✓ Celebrações carregadas com sucesso"

# ================================================================================
# LEITURAS DO LECIONÁRIO (organizadas por tempo litúrgico)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO LEITURAS DO LECIONÁRIO - LOCB 2008"
puts "="*80

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

puts "✓ Leituras carregadas com sucesso"

# ================================================================================
# COLETAS (organizadas por tempo litúrgico)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO COLETAS - LOCB 2008"
puts "="*80

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

puts "✓ Coletas carregadas com sucesso"

# ================================================================================
# OFÍCIO DIÁRIO - CICLO DE SALMOS
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO CICLO DE SALMOS - LOCB 2008"
puts "="*80

load Rails.root.join("#{base_path}/psalm_cycles.rb")

# ================================================================================
# OFÍCIO DIÁRIO - LEITURAS DIÁRIAS (Ciclo Bianual)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO LEITURAS DIÁRIAS - LOCB 2008"
puts "="*80

load Rails.root.join("#{base_path}/readings/daily_office.rb")

puts "\n" + "="*80
puts "LOCB 2008 - CARREGAMENTO COMPLETO ✓"
puts "="*80
