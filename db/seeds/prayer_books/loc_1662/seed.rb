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
