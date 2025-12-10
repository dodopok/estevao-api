# frozen_string_literal: true

# ================================================================================
# JOURNALS SEED - Exemplo de anotações/diário
# ================================================================================

puts "\n📝 Criando anotações de exemplo..."

# Apenas cria journals se houver usuários (não criar em testes)
if User.any?
  # Pega o primeiro usuário ou cria um de exemplo
  user = User.first

  # Cria algumas anotações de exemplo
  [
    {
      date_reference: Date.today,
      entry_type: 'daily_office',
      office_type: 'morning',
      content: 'Hoje refleti sobre a importância da oração matinal. O Salmo lido foi especialmente tocante e me fez pensar sobre minha jornada de fé.'
    },
    {
      date_reference: Date.today,
      entry_type: 'life_rule',
      office_type: nil,
      content: 'Estou comprometido a seguir minha regra de vida diariamente. Hoje consegui cumprir todos os passos e me sinto renovado.'
    },
    {
      date_reference: Date.yesterday,
      entry_type: 'daily_office',
      office_type: 'evening',
      content: 'As vésperas de ontem foram um momento de paz após um dia agitado. Agradeço por esse momento de conexão com Deus.'
    },
    {
      date_reference: Date.today - 2.days,
      entry_type: 'daily_office',
      office_type: 'morning',
      content: 'Leitura do evangelho trouxe nova perspectiva sobre o amor ao próximo.'
    }
  ].each do |journal_attrs|
    Journal.find_or_create_by!(
      user: user,
      date_reference: journal_attrs[:date_reference],
      entry_type: journal_attrs[:entry_type],
      office_type: journal_attrs[:office_type]
    ) do |journal|
      journal.content = journal_attrs[:content]
    end
  end

  puts "  ✅ #{Journal.count} anotações criadas"
else
  puts "  ⚠️  Nenhum usuário encontrado. Pulando criação de journals."
end
