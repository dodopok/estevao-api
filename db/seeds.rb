# ================================================================================
# SEEDS - CALENDÁRIO LITÚRGICO ANGLICANO
# Este arquivo orquestra o carregamento de todos os dados do sistema
# ================================================================================

# Não executar seeds em ambiente de testes
# Os testes devem usar factories (FactoryBot) para criar seus próprios dados
if Rails.env.test?
  puts "⚠️  Seeds desabilitados em ambiente de testes. Use factories para criar dados de teste."
  return
end

puts "🌱 Iniciando seeds do Calendário Litúrgico Anglicano..."

# Mostra totais antes da limpeza
puts "\n📊 TOTAL INICIAL:"
puts "  • #{PrayerBook.count} livros de oração"
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
LiturgicalText.destroy_all
# Note: Prayer books não são limpos pois são dados mestres

# ================================================================================
# DADOS FUNDAMENTAIS
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO DADOS FUNDAMENTAIS"
puts "="*80

# Livros de Oração (DEVE SER CARREGADO PRIMEIRO)
if File.exist?(Rails.root.join('db/seeds/prayer_books.rb'))
  load Rails.root.join('db/seeds/prayer_books.rb')
else
  puts "⚠️  Arquivo de livros de oração não encontrado."
end

# Cores Litúrgicas
if File.exist?(Rails.root.join('db/seeds/colors.rb'))
  load Rails.root.join('db/seeds/colors.rb')
else
  puts "⚠️  Arquivo de cores litúrgicas não encontrado."
end

# Estações Litúrgicas
if File.exist?(Rails.root.join('db/seeds/seasons.rb'))
  load Rails.root.join('db/seeds/seasons.rb')
else
  puts "⚠️  Arquivo de estações litúrgicas não encontrado."
end

# ================================================================================
# LEITURAS DO LECIONÁRIO E COLETAS POR LIVRO DE ORAÇÃO
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO LEITURAS E COLETAS POR LIVRO DE ORAÇÃO"
puts "="*80

# Carregar dados para cada livro de oração
PrayerBook.find_each do |prayer_book|
  prayer_book_dir = Rails.root.join("db/seeds/prayer_books/#{prayer_book.code}")

  next unless Dir.exist?(prayer_book_dir)

  puts "\n📚 Carregando dados para: #{prayer_book.name}"

  # Carregar Coletas
  collects_file = prayer_book_dir.join('seed.rb')
  if File.exist?(collects_file)
    load collects_file
  else
    puts "  ⚠️  Arquivo de seed não encontrado para #{prayer_book.code}"
  end
end

# Coletas e leituras já foram carregados por livro de oração acima

# ================================================================================
# REGRAS DE VIDA
# ================================================================================

puts "\n" + "="*80
puts "CARREGANDO REGRAS DE VIDA"
puts "="*80

if File.exist?(Rails.root.join('db/seeds/life_rules.rb'))
  load Rails.root.join('db/seeds/life_rules.rb')
else
  puts "⚠️  Arquivo de regras de vida não encontrado."
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
puts "  • #{LiturgicalText.count} textos litúrgicos"
puts "  • #{Psalm.count} salmos"
puts "  • #{PsalmCycle.count} ciclos de salmos"
puts "  • #{LifeRule.count} regras de vida"

puts "\n✅ Banco de dados populado com sucesso!"
