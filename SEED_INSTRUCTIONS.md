# Instruções para Popular o Banco de Dados

Este guia explica como popular o banco de dados com todos os dados litúrgicos.

## 📋 O que será criado

### Dados Básicos (db/seeds.rb)
- **9 Cores Litúrgicas** (branco, vermelho, roxo, violeta, rosa, verde, preto, etc.)
- **6 Estações Litúrgicas** (Advento, Natal, Epifania, Quaresma, Páscoa, Tempo Comum)
- **13 Festas Principais** (Natal, Páscoa, Epifania, Pentecostes, etc.)
- **3 Dias Santos Principais** (Quarta-feira de Cinzas, Quinta-feira Santa, Sexta-feira da Paixão)
- **25+ Festivais** (Apóstolos e Evangelistas)
- **20 Festas Menores Iniciais** (Santos como São Francisco, Santo Agostinho, etc.)

### Leituras do Lecionário (db/seeds/lectionary_readings.rb)
- **100+ Leituras** do Revised Common Lectionary (RCL)
- Leituras para todos os domingos de Advento (ciclos A, B, C)
- Leituras para todos os domingos de Natal (ciclos A, B, C)
- Leituras para todos os domingos de Quaresma (ciclos A, B, C)
- Leituras para todos os domingos de Páscoa (ciclos A, B, C)
- Leituras para festas principais (Natal, Páscoa, Pentecostes, etc.)
- Leituras para grandes festas (Epifania, Ascensão, Transfiguração, etc.)

### Santos Adicionais (db/seeds/more_saints.rb)
- **100+ Santos** adicionais do calendário anglicano/episcopal
- Santos para cada mês do ano
- Inclui bispos, mártires, doutores, místicos, fundadores
- Santos da tradição católica e anglicana

## 🚀 Como Popular o Banco

### Opção 1: Popular Tudo de Uma Vez (Recomendado)

```bash
# Limpar banco e recriar (ATENÇÃO: Apaga todos os dados!)
rails db:reset

# Ou apenas rodar os seeds (sem apagar dados existentes)
rails db:seed
```

Isso irá:
1. Criar cores e estações litúrgicas
2. Criar celebrações básicas (festas principais, festivais, festas menores)
3. Carregar automaticamente leituras do lecionário
4. Carregar automaticamente santos adicionais

### Opção 2: Popular Apenas Leituras

```bash
# Se você só quer adicionar/atualizar leituras
rails runner db/seeds/lectionary_readings.rb
```

### Opção 3: Popular Apenas Santos

```bash
# Se você só quer adicionar/atualizar santos
rails runner db/seeds/more_saints.rb
```

## 📊 Verificar Dados Criados

Após rodar os seeds, você pode verificar no console do Rails:

```bash
rails console
```

```ruby
# Contar registros
LiturgicalColor.count          # Deve ser 9
LiturgicalSeason.count         # Deve ser 6
Celebration.count              # Deve ser 100+ (depende dos santos)
LectionaryReading.count        # Deve ser 100+

# Ver detalhes
Celebration.principal_feast.count  # Festas principais
Celebration.festival.count         # Festivais
Celebration.lesser_feast.count     # Festas menores

# Buscar exemplos
Celebration.find_by(name: "Páscoa")
Celebration.where(fixed_month: 12, fixed_day: 25).first  # Natal

# Ver leituras de exemplo
LectionaryReading.where(date_reference: "easter_sunday")
LectionaryReading.where(cycle: "A", date_reference: "1st_sunday_of_advent")
```

## ⚠️ Importante

### Antes de Rodar em Produção

1. **Backup**: Sempre faça backup do banco antes de rodar seeds em produção
2. **Teste Local**: Teste os seeds em desenvolvimento primeiro
3. **Review**: Revise os dados criados antes de usar em produção

### Evitar Duplicatas

Os arquivos de seeds estão preparados para evitar duplicatas:
- `more_saints.rb` verifica se o santo já existe antes de criar
- Se você rodar os seeds múltiplas vezes, pode haver duplicatas nas leituras

### Limpar e Recriar (Development Only)

```bash
# ATENÇÃO: Isso APAGA TUDO!
rails db:drop db:create db:migrate db:seed
```

## 📝 Estrutura dos Dados

### Leituras (LectionaryReading)

```ruby
{
  date_reference: "1st_sunday_of_advent",  # Referência da data
  cycle: "A",                               # Ciclo A, B, C, ou "all"
  service_type: "eucharist",                # Tipo de serviço
  first_reading: "Isaiah 2:1-5",            # Primeira leitura
  psalm: "Psalm 122",                       # Salmo
  second_reading: "Romans 13:11-14",        # Segunda leitura
  gospel: "Matthew 24:36-44"                # Evangelho
}
```

### Celebrações (Celebration)

```ruby
{
  name: "São Francisco de Assis",
  celebration_type: :lesser_feast,  # :principal_feast, :festival, :lesser_feast, etc.
  rank: 105,                        # Rank para ordenação
  fixed_month: 10,                  # Mês (nil se móvel)
  fixed_day: 4,                     # Dia (nil se móvel)
  movable: false,                   # true para festas móveis (Páscoa, etc.)
  liturgical_color: "branco",       # Cor litúrgica
  description: "Frade e Fundador, 1226"
}
```

## 🔄 Atualizar Seeds

Se você fez mudanças nos arquivos de seeds:

```bash
# Limpar leituras e recriar
rails console
LectionaryReading.destroy_all
exit

rails runner db/seeds/lectionary_readings.rb

# Ou limpar tudo e recriar
rails db:reset
```

## 📚 Próximos Passos

Após popular os dados básicos:

1. **Adicionar Coletas** - Criar seeds para orações do dia
2. **Adicionar Leituras de Dias de Semana** - Expandir o lecionário
3. **Internacionalização** - Adicionar traduções em inglês
4. **Validar Dados** - Revisar e corrigir conforme necessário

## 🆘 Troubleshooting

### Erro: "PG::ConnectionBad"
- Certifique-se que o PostgreSQL está rodando
- Verifique as configurações em `config/database.yml`

### Erro: "ActiveRecord::RecordInvalid"
- Verifique se há validações falhando
- Rode `rails db:migrate` para garantir que o schema está atualizado

### Seeds Rodando Devagar
- Normal! São muitos dados sendo criados
- Use `db:reset` em vez de `db:drop` + `db:create` + `db:migrate` + `db:seed`

### Leituras Duplicadas
- Execute `LectionaryReading.destroy_all` antes de rodar os seeds de leituras novamente
