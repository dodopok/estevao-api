# frozen_string_literal: true

# ================================================================================
# SEEDS - REGRAS DE VIDA
# Regras de vida pré-definidas para o sistema
# ================================================================================

puts "\n📿 Carregando Regras de Vida..."

# Precisamos de um usuário "sistema" para associar às regras públicas pré-definidas
system_user = User.find_or_create_by!(email: "system@estevao.app") do |user|
  user.provider_uid = "system_user_uid"
  user.name = "Sistema"
  user.admin = true
end

# Remove regra anterior do usuário sistema, se existir
system_user.life_rule&.destroy

# ================================================================================
# REGRA DE VIDA ANGLICANA DE SÃO BERNARDO
# ================================================================================

sao_bernardo_rule = LifeRule.create!(
  user: system_user,
  icon: "⛪",
  title: "Regra de Vida Anglicana de São Bernardo",
  description: "Baseada no Livro de Oração Comum, esta regra contém os elementos essenciais para a vida cristã anglicana. Como disse Martin Thornton: 'O Livro de Oração Comum não é uma lista de cultos, mas um sistema ascético para a vida cristã em todos os seus detalhes.'",
  is_public: true,
  approved: true,
  adoption_count: 0
)

# Passos da Regra
steps = [
  {
    order: 1,
    title: "Oração Diária",
    description: "Orar as Orações da Manhã e da Noite em horário fixo, de segunda a sexta-feira. Quando possível, orar na igreja paroquial como liturgia pública."
  },
  {
    order: 2,
    title: "Jejum nas Sextas-feiras",
    description: "Jejuar de todo alimento até as 17h na Quarta-feira de Cinzas, Sexta-feira Santa e todas as sextas-feiras do ano (exceto durante os 12 Dias do Natal e os 50 dias da Páscoa)."
  },
  {
    order: 3,
    title: "Jejum Eucarístico",
    description: "Abster-se de todo alimento do sábado à meia-noite até após a Eucaristia matinal de domingo."
  },
  {
    order: 4,
    title: "Moderação no Álcool",
    description: "Nunca consumir quantidade excessiva de álcool. Seguir a regra dos 'dois': nunca mais que duas doses por ocasião, beber com companhia e evitar consumo por mais de dois dias consecutivos."
  },
  {
    order: 5,
    title: "Vida Escondida",
    description: "Abster-se do uso de redes sociais, buscando uma vida de recolhimento e oração."
  },
  {
    order: 6,
    title: "Meditação nas Escrituras",
    description: "Passar pelo menos 30 minutos por semana em meditação nas Sagradas Escrituras, recebendo cada versículo com simplicidade e fé."
  },
  {
    order: 7,
    title: "Estudo do Saltério",
    description: "Comprometer-se com a obra vitalícia do Saltério: memorização e interiorização por meio da recitação constante e do canto."
  },
  {
    order: 8,
    title: "Confissão Anual",
    description: "Examinar a si mesmo, fazendo confissão auricular a um sacerdote ao menos uma vez por ano."
  },
  {
    order: 9,
    title: "Retiros Espirituais",
    description: "Participar de um retiro pelo menos uma vez por ano, preferencialmente trimestralmente."
  },
  {
    order: 10,
    title: "Pureza de Vida",
    description: "Comprometer-se vigorosamente com a pureza em pensamento e ação, mantendo o mais alto padrão do santo matrimônio."
  },
  {
    order: 11,
    title: "Humildade e Obediência",
    description: "Submeter-se aos superiores eclesiásticos e recusar falar mal de qualquer um deles, sabendo que a humildade na obediência é a maior virtude."
  },
  {
    order: 12,
    title: "Fidelidade Doutrinária",
    description: "Não ensinar nada como necessário para a salvação exceto aquilo que pode ser provado pelas Escrituras, seguindo as liturgias do Livro de Oração Comum."
  }
]

steps.each do |step_attrs|
  sao_bernardo_rule.life_rule_steps.create!(step_attrs)
end

puts "  ✅ Regra de São Bernardo criada com #{sao_bernardo_rule.life_rule_steps.count} passos"
puts "  📊 Total de Regras de Vida: #{LifeRule.count}"
