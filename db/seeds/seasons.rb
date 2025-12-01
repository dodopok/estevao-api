# ================================================================================
# ESTAÇÕES LITÚRGICAS (6 estações)
# ================================================================================

Rails.logger.info "📅 Criando quadras litúrgicas..."

seasons = [
  { name: "Advento", color: "violeta", description: "Tempo de preparação para o Natal" },
  { name: "Natal", color: "branco", description: "Celebração da Natividade do Senhor" },
  { name: "Epifania", color: "verde", description: "Manifestação de Cristo ao mundo" },
  { name: "Quaresma", color: "roxo", description: "Tempo de penitência e preparação para a Páscoa" },
  { name: "Páscoa", color: "branco", description: "Celebração da Ressurreição do Senhor" },
  { name: "Tempo Comum", color: "verde", description: "Tempo de crescimento espiritual" }
]

seasons.each do |season_data|
  LiturgicalSeason.create!(season_data)
  Rails.logger.info "  ✓ #{season_data[:name]}"
end
