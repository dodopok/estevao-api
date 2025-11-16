# API do Calendário Litúrgico Anglicano

API RESTful para fornecer informações sobre o ano litúrgico anglicano, incluindo celebrações, leituras, coletas e cores litúrgicas.

## 🎯 Funcionalidades Implementadas

### ✅ Banco de Dados
- **5 tabelas principais:**
  - `liturgical_seasons` - Quadras litúrgicas (Advento, Natal, Quaresma, etc)
  - `celebrations` - Festas principais, dias santos e festivais
  - `collects` - Coletas (orações) para celebrações e domingos
  - `lectionary_readings` - Leituras bíblicas do lecionário
  - `liturgical_colors` - Cores litúrgicas e seu significado

### ✅ Cálculo de Datas Móveis
- **EasterCalculator** implementado com algoritmo de Computus (Gauss)
- Calcula automaticamente:
  - Data da Páscoa
  - Quarta-feira de Cinzas
  - Domingo de Ramos
  - Quinta-feira Santa e Sexta-feira da Paixão
  - Ascensão (40 dias após Páscoa)
  - Pentecostes (50 dias após Páscoa)
  - Santíssima Trindade
  - Cristo Rei do Universo
  - Primeiro Domingo do Advento

### ✅ Lógica de Hierarquia e Transferência
- **CelebrationResolver** implementa todas as regras das normas:
  - Hierarquia: Festas Principais > Dias Santos > Festivais > Festas Menores
  - Transferência da Anunciação quando cai em domingo ou Semana Santa
  - Transferência de José de Nazaré e Marcos quando caem na Semana Santa
  - Transferência de festivais que caem em domingo
  - Proteção de períodos especiais (Semana Santa até 2º Domingo da Páscoa)
  - Transferência de Todos os Santos para domingo mais próximo

### ✅ API REST v1

Todos os endpoints retornam JSON em português.

#### Calendário

```bash
# Informações de um dia específico
GET /api/v1/calendar/2025/12/25

Resposta:
{
  "data": "2025-12-25",
  "dia_da_semana": "Quinta-feira",
  "quadra_liturgica": "Natal",
  "cor_liturgica": "branco",
  "e_domingo": false,
  "e_dia_santo": true,
  "celebracao": {
    "id": 1,
    "nome": "Natividade de nosso Senhor Jesus Cristo",
    "tipo": "principal_feast",
    "rank": 1,
    "cor": "branco",
    "transferred": false
  },
  "coleta": { "texto": "..." },
  "leituras": {
    "primeira_leitura": "Isaías 9:2-7",
    "salmo": "Salmo 96",
    "segunda_leitura": "Tito 2:11-14",
    "evangelho": "Lucas 2:1-20"
  }
}

# Calendário de um mês
GET /api/v1/calendar/2025/4

# Resumo do ano (datas importantes)
GET /api/v1/calendar/2025
```

#### Celebrações

```bash
# Listar todas as celebrações
GET /api/v1/celebrations

# Detalhes de uma celebração
GET /api/v1/celebrations/1

# Buscar celebrações
GET /api/v1/celebrations/search?q=Pedro

# Celebrações em uma data específica (mês/dia)
GET /api/v1/celebrations/date/12/25

# Tipos de celebração disponíveis
GET /api/v1/celebrations/types
```

#### Lecionário (Leituras)

```bash
# Leituras do dia
GET /api/v1/lectionary/2025/12/25

# Leituras de todos os ofícios (Eucaristia, Matinas, Vésperas)
GET /api/v1/lectionary/2025/12/25/all_services

# Ciclo litúrgico do ano
GET /api/v1/lectionary/cycle/2025

Resposta:
{
  "ano": 2025,
  "ciclo_dominical": "A",
  "ciclo_semanal": "odd",
  "descricao": {
    "dominical": "Leituras dos domingos seguem o ciclo A (rotação trienal A, B, C)",
    "semanal": "Leituras dos dias de semana seguem o ano ímpar (rotação bienal par/ímpar)"
  }
}
```

## 📊 Dados Populados

### Celebrações (41 no total)
- **13 Festas Principais:**
  - Natal, Epifania, Batismo do Senhor, Apresentação, Anunciação
  - Páscoa, Ascensão, Pentecostes
  - Santíssima Trindade, Transfiguração
  - Todos os Santos, Cristo Rei

- **3 Dias Santos Principais:**
  - Quarta-feira de Cinzas
  - Quinta-feira Santa
  - Sexta-feira da Paixão

- **25 Festivais:**
  - Todos os apóstolos e evangelistas
  - Principais santos do calendário anglicano

### Cores Litúrgicas (9)
- Branco, Vermelho, Roxo, Violeta, Azul-escuro, Rosa, Verde, Preto, Pano-cru

### Quadras Litúrgicas (6)
- Advento, Natal, Epifania, Quaresma, Páscoa, Tempo Comum

## 📝 Próximos Passos

### Para Você Adicionar:

#### 1. **Coletas (Orações)**
```ruby
# Exemplo de como adicionar uma coleta
celebracao = Celebration.find_by(name: "Natal")

Collect.create!(
  celebration: celebracao,
  language: "pt-BR",
  text: "Ó Deus, que de modo maravilhoso criaste e ainda mais maravilhosamente..."
)
```

**Sugestão:** Crie um script de importação em `db/migrate/` ou `lib/tasks/` para importar todas as coletas de um arquivo CSV ou JSON.

#### 2. **Leituras do Lecionário**
```ruby
# Exemplo de leitura para um domingo
LectionaryReading.create!(
  date_reference: "1_domingo_do_advento", # ou use celebration_id para festas
  cycle: "A", # ou "B", "C" para domingos, "even"/"odd" para dias de semana, "all" para sempre
  service_type: "eucharist", # ou "morning_prayer", "evening_prayer"
  first_reading: "Isaías 2:1-5",
  psalm: "Salmo 122",
  second_reading: "Romanos 13:11-14",
  gospel: "Mateus 24:36-44"
)
```

**Sugestão:** Organize as leituras em arquivos YAML ou JSON por ciclo (A, B, C) e crie um rake task para importá-las.

#### 3. **Festas Menores**
Adicione as festas menores do calendário (santos, doutores da Igreja, etc.) seguindo o mesmo padrão das celebrações já criadas, com `celebration_type: :lesser_feast`.

#### 4. **Dias de Rogações e Têmporas**
Implemente a lógica para dias de rogações e têmporas conforme descrito nas normas.

#### 5. **Domingos do Ano**
Adicione leituras para todos os domingos do Tempo Comum, Advento, etc.

## 🚀 Como Rodar a API

```bash
# 1. Instalar dependências
bundle install

# 2. Criar e configurar banco de dados
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# 3. Iniciar servidor
bin/rails server

# 4. Acessar API
curl http://localhost:3000/
# Retorna a documentação básica dos endpoints

# Teste um endpoint
curl http://localhost:3000/api/v1/calendar/2025
```

## 📦 Estrutura do Projeto

```
app/
├── models/
│   ├── celebration.rb           # Festas, dias santos, festivais
│   ├── collect.rb                # Coletas (orações)
│   ├── lectionary_reading.rb    # Leituras do lecionário
│   ├── liturgical_color.rb      # Cores litúrgicas
│   └── liturgical_season.rb     # Quadras do ano
├── services/
│   ├── easter_calculator.rb     # Cálculo da Páscoa (Computus)
│   ├── liturgical_calendar.rb   # Calendário completo
│   └── celebration_resolver.rb  # Hierarquia e transferências
└── controllers/api/v1/
    ├── calendar_controller.rb   # Endpoints do calendário
    ├── celebrations_controller.rb # Endpoints de celebrações
    └── lectionary_controller.rb # Endpoints do lecionário
```

## 🔧 Exemplos de Scripts de Importação

### Importar Coletas de CSV

```ruby
# lib/tasks/import_collects.rake
namespace :import do
  desc "Importar coletas de um arquivo CSV"
  task collects: :environment do
    require 'csv'

    CSV.foreach('data/collects.csv', headers: true) do |row|
      celebration = Celebration.find_by(name: row['celebration_name'])
      next unless celebration

      Collect.find_or_create_by!(
        celebration: celebration,
        language: 'pt-BR'
      ) do |collect|
        collect.text = row['text']
      end
    end

    puts "Coletas importadas com sucesso!"
  end
end
```

### Importar Leituras de YAML

```ruby
# lib/tasks/import_lectionary.rake
namespace :import do
  desc "Importar leituras do lecionário"
  task lectionary: :environment do
    data = YAML.load_file('data/lectionary_cycle_a.yml')

    data.each do |reading_data|
      LectionaryReading.find_or_create_by!(
        date_reference: reading_data['date_reference'],
        cycle: 'A',
        service_type: 'eucharist'
      ) do |reading|
        reading.first_reading = reading_data['first_reading']
        reading.psalm = reading_data['psalm']
        reading.second_reading = reading_data['second_reading']
        reading.gospel = reading_data['gospel']
      end
    end

    puts "Leituras importadas com sucesso!"
  end
end
```

## 🧪 Testando a API

```bash
# Testar cálculo da Páscoa
bin/rails runner "puts EasterCalculator.new(2025).easter_date"
# => 2025-04-20

# Testar calendário de um dia
bin/rails runner "puts LiturgicalCalendar.new(2025).day_info(Date.new(2025, 12, 25)).to_json"

# Listar celebrações
bin/rails console
> Celebration.principal_feast.pluck(:name)
> Celebration.festival.count
```

## 📚 Recursos

- **Normas do Ano Cristão:** As regras implementadas seguem fielmente as normas fornecidas
- **Algoritmo de Computus:** https://en.wikipedia.org/wiki/Computus
- **Calendário Litúrgico:** Baseado no calendário da Igreja Episcopal Anglicana do Brasil

## ⚠️ Importante

- As **coletas** e **leituras** precisam ser adicionadas por você
- A API está preparada para recebê-las, basta importar os dados
- Use migrations ou rake tasks para importação em massa
- Mantenha o padrão de idioma em português brasileiro (pt-BR)

## 📞 Suporte

Para dúvidas sobre a implementação ou como adicionar dados, consulte:
- Os modelos em `app/models/`
- Os services em `app/services/`
- O arquivo de seeds em `db/seeds.rb`

---

**Desenvolvido com base nas Normas para o Ano Cristão da IEAB** 📖
