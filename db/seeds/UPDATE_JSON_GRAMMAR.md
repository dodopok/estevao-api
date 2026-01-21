# Atualização de Campos Gramaticais em Arquivos JSON de Celebrations

## Visão Geral

Este guia explica como atualizar todos os arquivos JSON de celebrations com os campos `person_type` e `gender` necessários para a concordância gramatical correta das coletas.

## Status Atual

### ✅ Completados (Ruby seeds)
- **LOCB 2008**: Todos os arquivos `.rb` atualizados manualmente
  - `commemorations.rb` (101 entradas)
  - `holy_days.rb` (17 entradas)
  - `principal_feasts.rb` (7 entradas)

### ⚙️ Em Progresso (JSON seeds)
- **LOC 2015**: Parcialmente atualizado
  - ✅ `principal_feast.json` (14 entradas)
  - ✅ `major_holy_days.json` (3 entradas)
  - ⏳ `festival.json`
  - ⏳ `lesser_feast.json` (maior arquivo, ~200+ entradas)
  - ⏳ `holy_week.json`

### ⏳ Pendentes (JSON seeds)
- **LOC 2019** (português)
- **LOC 2019_EN** (inglês)
- **LOC 2021**
- **LOC 1987**
- **LOC 1662**

## Como Atualizar

### Opção 1: Rake Task Automatizada (Recomendada)

Execute a rake task que processa todos os arquivos JSON automaticamente:

```bash
docker-compose exec -T web bundle exec rails celebrations:update_json_grammar
```

Esta task irá:
1. Processar todos os arquivos JSON em todos os prayer books
2. Analisar cada celebration usando padrões inteligentes
3. Adicionar os campos `person_type` e `gender`
4. Preservar a formatação JSON
5. Pular arquivos já atualizados
6. Exibir um resumo das mudanças

**Padrões de Detecção:**
- **Eventos**: Detecta padrões como "Batismo", "Dia de", "Vigília", "Martírio de", etc.
- **Singular Masculino**: Detecta "São", "Santo", nomes masculinos, títulos como "Bispo", "Padre"
- **Singular Feminino**: Detecta nomes femininos, "Santa", títulos como "Abadessa", "Virgem"
- **Plural**: Detecta padrões como " e ", "Apóstolos", "Mártires", etc.
- **Misto**: Detecta grupos com homens e mulheres

### Opção 2: Atualização Manual

Se preferir atualizar manualmente, siga este formato:

```json
{
  "name": "São João Batista",
  "celebration_type": "major_holy_day",
  "liturgical_color": "white",
  "person_type": "singular",
  "gender": "masculine"
}
```

**Valores para `person_type`:**
- `"event"`: Eventos, datas comemorativas (não pessoas)
- `"singular"`: Uma única pessoa
- `"plural"`: Múltiplas pessoas

**Valores para `gender`:**
- `"neutral"`: Para eventos
- `"masculine"`: Masculino (singular ou plural)
- `"feminine"`: Feminino (singular ou plural)
- `"mixed"`: Grupo com pessoas de gêneros diferentes

### Exemplos

#### Evento
```json
{
  "name": "Batismo de Nosso Senhor Jesus Cristo",
  "person_type": "event",
  "gender": "neutral"
}
```

#### Santo Singular Masculino
```json
{
  "name": "São João Batista",
  "person_type": "singular",
  "gender": "masculine"
}
```

#### Santa Singular Feminina
```json
{
  "name": "Santa Inês",
  "person_type": "singular",
  "gender": "feminine"
}
```

#### Santos Plurais Masculinos
```json
{
  "name": "São Pedro e São Paulo",
  "person_type": "plural",
  "gender": "masculine"
}
```

#### Grupo Misto
```json
{
  "name": "Todos os Santos e Santas",
  "person_type": "plural",
  "gender": "mixed"
}
```

## Verificação

Após a atualização, você pode verificar se os campos foram adicionados:

```bash
# Ver um arquivo específico
cat db/seeds/prayer_books/loc_2015/data/celebrations/principal_feast.json | jq '.[0]'

# Contar quantas celebrations não têm os campos
find db/seeds/prayer_books/*/data/celebrations -name "*.json" -exec sh -c '
  jq -r ".[] | select(.person_type == null or .gender == null) | .name" "$1" 2>/dev/null
' _ {} \; | wc -l
```

## Próximos Passos

Após atualizar os JSONs:

1. **Rodar as migrações:**
   ```bash
   docker-compose exec -T web bundle exec rails db:migrate
   ```

2. **Recriar o banco com os novos dados:**
   ```bash
   docker-compose exec -T web bundle exec rails db:reset
   ```

3. **Testar as coletas:**
   - Verificar que eventos não recebem coletas comuns
   - Verificar concordância correta para santos/santas
   - Verificar plural/singular

## Troubleshooting

### A rake task não encontra alguns arquivos
- Verifique se o caminho está correto em `lib/tasks/update_celebration_json_grammar.rake`
- Alguns prayer books podem ter estrutura diferente de diretórios

### Classificação incorreta
- A task usa padrões heurísticos que podem errar em casos ambíguos
- Revise manualmente os casos duvidosos, especialmente:
  - Grupos mistos (homens e mulheres)
  - Eventos relacionados a pessoas (ex: "Martírio de X")
  - Nomes que não seguem padrões comuns

### JSON inválido após atualização
- A task preserva a formatação, mas se houver erros:
  ```bash
  # Validar JSON
  jq empty db/seeds/prayer_books/loc_2015/data/celebrations/*.json
  ```

## Contribuindo

Se encontrar celebrações mal classificadas:
1. Atualize manualmente o JSON
2. Adicione o padrão em `lib/tasks/update_celebration_json_grammar.rake`
3. Documente casos especiais neste arquivo
