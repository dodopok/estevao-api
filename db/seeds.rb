# ================================================================================
# SEEDS - CALENDÁRIO LITÚRGICO ANGLICANO
# Este arquivo orquestra o carregamento de todos os dados do sistema
# ================================================================================

puts "🌱 Iniciando seeds do Calendário Litúrgico Anglicano..."

# Mostra totais antes da limpeza
puts "\n📊 TOTAL INICIAL:"
puts "  • #{LiturgicalColor.count} cores litúrgicas"
puts "  • #{LiturgicalSeason.count} quadras litúrgicas"
puts "  • #{Celebration.count} celebrações totais"
puts "    - #{Celebration.principal_feast.count rescue 0} festas principais"
puts "    - #{Celebration.major_holy_day.count rescue 0} dias santos principais"
puts "    - #{Celebration.festival.count rescue 0} festivais"
puts "    - #{Celebration.lesser_feast.count rescue 0} festas menores"
puts "  • #{LectionaryReading.count} leituras do lecionário"
puts "  • #{Collect.count} coletas"

# Limpa dados existentes
puts "\n🗑️  Limpando dados existentes..."
LectionaryReading.destroy_all
Collect.destroy_all
Celebration.destroy_all
LiturgicalColor.destroy_all
LiturgicalSeason.destroy_all

# ================================================================================
# DADOS FUNDAMENTAIS
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO DADOS FUNDAMENTAIS"
puts "="*80

# Cores Litúrgicas
if File.exist?(Rails.root.join('db/seeds/liturgical_colors.rb'))
  load Rails.root.join('db/seeds/liturgical_colors.rb')
else
  puts "⚠️  Arquivo de cores litúrgicas não encontrado."
end

# Estações Litúrgicas
if File.exist?(Rails.root.join('db/seeds/liturgical_seasons.rb'))
  load Rails.root.join('db/seeds/liturgical_seasons.rb')
else
  puts "⚠️  Arquivo de estações litúrgicas não encontrado."
end

# ================================================================================
# CELEBRAÇÕES (organizadas por categoria)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO CELEBRAÇÕES"
puts "="*80

# Festas Principais
if File.exist?(Rails.root.join('db/seeds/celebrations/principal_feasts.rb'))
  load Rails.root.join('db/seeds/celebrations/principal_feasts.rb')
else
  puts "⚠️  Arquivo de festas principais não encontrado."
end

# Dias Santos Principais
if File.exist?(Rails.root.join('db/seeds/celebrations/major_holy_days.rb'))
  load Rails.root.join('db/seeds/celebrations/major_holy_days.rb')
else
  puts "⚠️  Arquivo de dias santos principais não encontrado."
end

# Festivais
if File.exist?(Rails.root.join('db/seeds/celebrations/festivals.rb'))
  load Rails.root.join('db/seeds/celebrations/festivals.rb')
else
  puts "⚠️  Arquivo de festivais não encontrado."
end

# Festas Menores
if File.exist?(Rails.root.join('db/seeds/celebrations/lesser_feasts.rb'))
  load Rails.root.join('db/seeds/celebrations/lesser_feasts.rb')
else
  puts "⚠️  Arquivo de festas menores não encontrado."
end

# Celebrações da Semana Santa
if File.exist?(Rails.root.join('db/seeds/celebrations/holy_week.rb'))
  load Rails.root.join('db/seeds/celebrations/holy_week.rb')
else
  puts "⚠️  Arquivo de celebrações da Semana Santa não encontrado."
end

# Observâncias Especiais
if File.exist?(Rails.root.join('db/seeds/readings/special.rb'))
  load Rails.root.join('db/seeds/readings/special.rb')
else
  puts "⚠️  Arquivo de observâncias especiais não encontrado."
end

# Santos Adicionais
if File.exist?(Rails.root.join('db/seeds/more_saints.rb'))
  load Rails.root.join('db/seeds/more_saints.rb')
else
  puts "⚠️  Arquivo de santos adicionais não encontrado."
end

# Santos Anglicanos
if File.exist?(Rails.root.join('db/seeds/anglican_saints.rb'))
  load Rails.root.join('db/seeds/anglican_saints.rb')
else
  puts "⚠️  Arquivo de santos anglicanos não encontrado."
end

# ================================================================================
# LEITURAS DO LECIONÁRIO (organizadas por estação litúrgica)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO LEITURAS DO LECIONÁRIO"
puts "="*80

# Advento
if File.exist?(Rails.root.join('db/seeds/readings/advent.rb'))
  load Rails.root.join('db/seeds/readings/advent.rb')
else
  puts "⚠️  Arquivo de leituras do Advento não encontrado."
end

# Natal
if File.exist?(Rails.root.join('db/seeds/readings/christmas.rb'))
  load Rails.root.join('db/seeds/readings/christmas.rb')
else
  puts "⚠️  Arquivo de leituras do Natal não encontrado."
end

# Epifania
if File.exist?(Rails.root.join('db/seeds/readings/epiphany.rb'))
  load Rails.root.join('db/seeds/readings/epiphany.rb')
else
  puts "⚠️  Arquivo de leituras da Epifania não encontrado."
end

# Quaresma
if File.exist?(Rails.root.join('db/seeds/readings/lent.rb'))
  load Rails.root.join('db/seeds/readings/lent.rb')
else
  puts "⚠️  Arquivo de leituras da Quaresma não encontrado."
end

# Semana Santa e Páscoa
if File.exist?(Rails.root.join('db/seeds/readings/holy_week_easter.rb'))
  load Rails.root.join('db/seeds/readings/holy_week_easter.rb')
else
  puts "⚠️  Arquivo de leituras da Semana Santa e Páscoa não encontrado."
end

# Tempo Pascal
if File.exist?(Rails.root.join('db/seeds/readings/easter_season.rb'))
  load Rails.root.join('db/seeds/readings/easter_season.rb')
else
  puts "⚠️  Arquivo de leituras do Tempo Pascal não encontrado."
end

# Pentecostes e Trindade
if File.exist?(Rails.root.join('db/seeds/readings/pentecost.rb'))
  load Rails.root.join('db/seeds/readings/pentecost.rb')
else
  puts "⚠️  Arquivo de leituras de Pentecostes não encontrado."
end

# Tempo Comum (Próprios)
if File.exist?(Rails.root.join('db/seeds/readings/ordinary_time.rb'))
  load Rails.root.join('db/seeds/readings/ordinary_time.rb')
else
  puts "⚠️  Arquivo de leituras do Tempo Comum não encontrado."
end

# Festas Fixas e Santos
if File.exist?(Rails.root.join('db/seeds/readings/fixed_feasts.rb'))
  load Rails.root.join('db/seeds/readings/fixed_feasts.rb')
else
  puts "⚠️  Arquivo de leituras de festas fixas não encontrado."
end

# ================================================================================
# COLETAS (ORAÇÕES)
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO COLETAS"
puts "="*80

# Coletas
if File.exist?(Rails.root.join('db/seeds/collects.rb'))
  load Rails.root.join('db/seeds/collects.rb')
else
  puts "⚠️  Arquivo de coletas não encontrado."
end

# ================================================================================
# RESUMO FINAL
# ================================================================================

puts "\n" + "="*80
puts "RESUMO FINAL"
puts "="*80

puts "\n📊 TOTAL FINAL:"
puts "  • #{LiturgicalColor.count} cores litúrgicas"
puts "  • #{LiturgicalSeason.count} quadras litúrgicas"
puts "  • #{Celebration.count} celebrações totais"
puts "    - #{Celebration.principal_feast.count} festas principais"
puts "    - #{Celebration.major_holy_day.count} dias santos principais"
puts "    - #{Celebration.festival.count} festivais"
puts "    - #{Celebration.lesser_feast.count} festas menores"
puts "  • #{LectionaryReading.count} leituras do lecionário"
puts "  • #{Collect.count} coletas"

puts "\n✅ Banco de dados populado com sucesso!"