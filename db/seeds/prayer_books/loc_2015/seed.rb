# ================================================================================
# LOC 2015 - LITURGIA DAS HORAS (IEAB)
# ================================================================================

base_path = 'db/seeds/prayer_books/loc_2015/data'

# ================================================================================
# CELEBRAÇÕES (organizadas por categoria)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO CELEBRAÇÕES - LOC 2015"
puts "="*80

# Festas Principais
load Rails.root.join("#{base_path}/celebrations/principal_feasts.rb")

# Dias Santos Principais
load Rails.root.join("#{base_path}/celebrations/major_holy_days.rb")

# Festivais
load Rails.root.join("#{base_path}/celebrations/festivals.rb")

# Festas Menores
load Rails.root.join("#{base_path}/celebrations/lesser_feasts.rb")

# Celebrações da Semana Santa
load Rails.root.join("#{base_path}/celebrations/holy_week.rb")

# Santos Adicionais
load Rails.root.join("#{base_path}/celebrations/more_saints.rb")

# Santos Anglicanos
load Rails.root.join("#{base_path}/celebrations/anglican_saints.rb")

puts "✓ Celebrações carregadas com sucesso"

# ================================================================================
# LEITURAS DO LECIONÁRIO (organizadas por tempo litúrgico)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO LEITURAS DO LECIONÁRIO - LOC 2015"
puts "="*80

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

puts "✓ Leituras carregadas com sucesso"

# ================================================================================
# COLETAS
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO COLETAS - LOC 2015"
puts "="*80

load Rails.root.join("#{base_path}/collects.rb")

puts "✓ Coletas carregadas com sucesso"

# ================================================================================
# OFÍCIO DIÁRIO - TEXTOS LITÚRGICOS, SALMOS E CICLOS
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO OFÍCIO DIÁRIO - LOC 2015"
puts "="*80

# Textos Litúrgicos
load Rails.root.join("#{base_path}/liturgical_texts.rb")

# Salmos
load Rails.root.join("#{base_path}/psalms.rb")

# Ciclos de Salmos
load Rails.root.join("#{base_path}/psalm_cycles.rb")

puts "✓ Ofício Diário carregado com sucesso"

puts "\n" + "="*80
puts "LOC 2015 - CARREGAMENTO COMPLETO ✓"
puts "="*80
