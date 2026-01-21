# Guia de Gramática para Celebrations

## Campos de Gramática

A partir de agora, todas as celebrations devem incluir os campos `person_type` e `gender` para garantir a concordância gramatical correta nas coletas.

### Campo `person_type`

Indica se a celebração é sobre pessoa(s) ou um evento:

- **`event`** (padrão): Não é sobre pessoa(s), é um evento ou data comemorativa
  - Exemplos: "Batismo do Senhor", "Dia Mundial da Paz", "Confissão de Pedro"
  - **NÃO** recebe coleta comum com "teu servo N."

- **`singular`**: Uma única pessoa
  - Exemplos: "Inês", "Policarpo", "William Laud"
  - Recebe: "teu servo" ou "tua serva"

- **`plural`**: Múltiplas pessoas
  - Exemplos: "Timóteo e Tito", "Lídia, Dorcas e Febe"
  - Recebe: "teus servos" ou "tuas servas"

### Campo `gender`

Indica o gênero gramatical (usado apenas quando `person_type` não é `event`):

- **`neutral`** (padrão): Neutro ou não aplicável (para eventos)

- **`masculine`**: Masculino (singular ou plural)
  - Singular: "teu servo Policarpo"
  - Plural: "teus servos Timóteo e Tito"

- **`feminine`**: Feminino (singular ou plural)
  - Singular: "tua serva Inês"
  - Plural: "tuas servas Lídia, Dorcas e Febe"

- **`mixed`**: Misto (apenas para plural com pessoas de gêneros diferentes)
  - Exemplo: "Perpétua, Felicidade e seus companheiros"
  - Usa: "teus servos" (padrão masculino em português)

## Exemplos de Seeds

### Eventos (não recebem coleta comum)

```ruby
{
  name: "Batismo de nosso Senhor Jesus Cristo",
  fixed_month: 1,
  fixed_day: 9,
  description: "Ou no 1º Domingo após a Epifania",
  person_type: "event",
  gender: "neutral"
}

{
  name: "Dia Mundial da Paz",
  fixed_month: 1,
  fixed_day: 1,
  description: "Dia Mundial da Paz",
  person_type: "event",
  gender: "neutral"
}

{
  name: "Confissão do apóstolo Pedro",
  fixed_month: 1,
  fixed_day: 18,
  description: "Confissão de São Pedro",
  person_type: "event",
  gender: "neutral"
}
```

### Pessoa Singular Masculina

```ruby
{
  name: "Policarpo",
  fixed_month: 2,
  fixed_day: 23,
  description: "Bispo de Esmirna e mártir, 156",
  person_type: "singular",
  gender: "masculine"
}
# Resultado: "teu servo Policarpo"

{
  name: "William Laud",
  fixed_month: 1,
  fixed_day: 10,
  description: "Arcebispo de Cantuária, 1645",
  person_type: "singular",
  gender: "masculine"
}
# Resultado: "teu servo William Laud"
```

### Pessoa Singular Feminina

```ruby
{
  name: "Inês",
  fixed_month: 1,
  fixed_day: 21,
  description: "Mártir em Roma, 304",
  person_type: "singular",
  gender: "feminine"
}
# Resultado: "tua serva Inês"

{
  name: "Brígida",
  fixed_month: 2,
  fixed_day: 1,
  description: "Abadessa de Kildare, 523",
  person_type: "singular",
  gender: "feminine"
}
# Resultado: "tua serva Brígida"
```

### Pessoas Plurais Masculinas

```ruby
{
  name: "Timóteo e Tito",
  fixed_month: 1,
  fixed_day: 26,
  description: "Companheiros do apóstolo Paulo",
  person_type: "plural",
  gender: "masculine"
}
# Resultado: "teus servos Timóteo e Tito"

{
  name: "Cirilo e Metódio",
  fixed_month: 2,
  fixed_day: 14,
  description: "Monge, 869, e Bispo, 885, missionários entre os eslavos",
  person_type: "plural",
  gender: "masculine"
}
# Resultado: "teus servos Cirilo e Metódio"
```

### Pessoas Plurais Femininas

```ruby
{
  name: "Lídia, Dorcas e Febe",
  fixed_month: 1,
  fixed_day: 29,
  description: "Cooperadoras dos apóstolos",
  person_type: "plural",
  gender: "feminine"
}
# Resultado: "tuas servas Lídia, Dorcas e Febe"
```

### Pessoas Plurais Mistas

```ruby
{
  name: "Perpétua, Felicidade e seus companheiros",
  fixed_month: 3,
  fixed_day: 7,
  description: "Mártires em Cartago, 203",
  person_type: "plural",
  gender: "mixed"
}
# Resultado: "teus servos Perpétua, Felicidade e seus companheiros"
# (usa masculino plural como padrão em português)
```

## Migração de Dados Existentes

Para atualizar celebrations existentes, use a rake task:

```bash
docker compose exec -T web bundle exec rails celebrations:update_grammar
```

**IMPORTANTE:** A task faz uma classificação automática baseada em padrões, mas você **deve revisar manualmente** os resultados, especialmente para:

1. Casos ambíguos (eventos vs. pessoas)
2. Grupos mistos de gêneros
3. Nomes que não seguem padrões óbvios
4. Títulos que mencionam eventos relacionados a pessoas (ex: "Martírio de João")

## Checklist para Novos Seeds

Ao criar uma nova celebration, pergunte-se:

1. **É sobre uma pessoa ou é um evento/data?**
   - Evento → `person_type: "event"`, `gender: "neutral"`
   - Pessoa(s) → continue

2. **É uma pessoa ou múltiplas?**
   - Uma → `person_type: "singular"`
   - Múltiplas → `person_type: "plural"`

3. **Qual o gênero?**
   - Homem/Homens → `gender: "masculine"`
   - Mulher/Mulheres → `gender: "feminine"`
   - Grupo misto → `gender: "mixed"`

## Efeito nas Coletas

Com esses campos corretamente preenchidos:

- Celebrations de **eventos** não receberão coletas comuns com "N."
- Celebrations de **pessoas** receberão coletas com concordância correta:
  - ✅ "tua serva Inês" (não "teu servo Inês")
  - ✅ "teus servos Timóteo e Tito" (não "teu servo Timóteo e Tito")
  - ✅ "tuas servas Lídia, Dorcas e Febe" (não "teu servo Lídia, Dorcas e Febe")
  - ✅ "Batismo do Senhor" sem coleta comum (não "teu servo Batismo do Senhor")
