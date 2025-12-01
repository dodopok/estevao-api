# ================================================================================
# CORES LITÚRGICAS (9 cores)
# ================================================================================

Rails.logger.info "📊 Criando cores litúrgicas..."

colors = [
  { name: "branco", hex_code: "#FFFFFF", usage_description: "Natal, Páscoa, Festas do Senhor, Santos não-mártires, Funerais" },
  { name: "vermelho", hex_code: "#DC143C", usage_description: "Semana Santa (exceto Quinta-feira Santa), Pentecostes, Mártires, Confirmações e Ordenações" },
  { name: "roxo", hex_code: "#800080", usage_description: "Quaresma (desde Quarta-feira de Cinzas até véspera de Domingo de Ramos)" },
  { name: "violeta", hex_code: "#8B00FF", usage_description: "Advento (preferencial)" },
  { name: "azul_escuro", hex_code: "#00008B", usage_description: "Advento (alternativo)" },
  { name: "rosa", hex_code: "#FFB6C1", usage_description: "3º Domingo do Advento e 4º Domingo na Quaresma" },
  { name: "verde", hex_code: "#228B22", usage_description: "Tempo Comum" },
  { name: "preto", hex_code: "#000000", usage_description: "Sexta-feira da Paixão (opcional), Funerais (opcional)" },
  { name: "pano_cru", hex_code: "#F5DEB3", usage_description: "Quaresma (alternativo ao roxo)" }
]

colors.each do |color_data|
  LiturgicalColor.create!(color_data)
  Rails.logger.info "  ✓ #{color_data[:name]}"
end
