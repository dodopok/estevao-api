# ================================================================================
# LOC 1662 - LIVRO DE ORAÇÃO COMUM (IARB)
# ================================================================================

base_path = 'db/seeds/prayer_books/loc_1662/data'

# ================================================================================
# CELEBRAÇÕES
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO CELEBRAÇÕES - LOC 1662"
Rails.logger.info "="*80

if File.exist?(Rails.root.join("#{base_path}/celebrations/seed_celebrations.rb"))
  load Rails.root.join("#{base_path}/celebrations/seed_celebrations.rb")
  Rails.logger.info "✓ Celebrações carregadas com sucesso"
else
  Rails.logger.info "⚠️  Arquivo de celebrações não encontrado"
end

# ================================================================================
# PREFERÊNCIAS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO PREFERÊNCIAS - LOC 1662"
Rails.logger.info "="*80

if File.exist?(Rails.root.join("#{base_path}/preferences.rb"))
  load Rails.root.join("#{base_path}/preferences.rb")
  Rails.logger.info "✓ Preferências carregadas com sucesso"
else
  Rails.logger.info "⚠️  Arquivo de preferências não encontrado"
end

# ================================================================================
# TEXTOS LITÚRGICOS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO TEXTOS LITÚRGICOS - LOC 1662"
Rails.logger.info "="*80

if File.exist?(Rails.root.join("#{base_path}/liturgical_texts.rb"))
  load Rails.root.join("#{base_path}/liturgical_texts.rb")
  Rails.logger.info "✓ Textos litúrgicos carregados com sucesso"
else
  Rails.logger.info "⚠️  Arquivo de textos litúrgicos não encontrado"
end

# ================================================================================
# LEITURAS DO LECIONÁRIO
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO LEITURAS DO LECIONÁRIO - LOC 1662"
Rails.logger.info "="*80

# Carregar arquivos de leituras se existirem
Dir[Rails.root.join("#{base_path}/readings/*.rb")].each do |file|
  load file
  Rails.logger.info "✓ Carregado: #{File.basename(file)}"
end

# ================================================================================
# COLETAS
# ================================================================================

Rails.logger.info "\n" + "="*80
Rails.logger.info "CARREGANDO COLETAS - LOC 1662"
Rails.logger.info "="*80

if File.exist?(Rails.root.join("#{base_path}/collects.rb"))
  load Rails.root.join("#{base_path}/collects.rb")
  Rails.logger.info "✓ Coletas carregadas com sucesso"
elsif File.exist?(Rails.root.join("db/seeds/prayer_books/loc_1662/collects.rb"))
  load Rails.root.join("db/seeds/prayer_books/loc_1662/collects.rb")
  Rails.logger.info "✓ Coletas carregadas com sucesso (caminho antigo)"
else
  Rails.logger.info "⚠️  Arquivo de coletas não encontrado"
end

Rails.logger.info "\n" + "="*80
Rails.logger.info "LOC 1662 - CARREGAMENTO COMPLETO ✓"
Rails.logger.info "="*80
