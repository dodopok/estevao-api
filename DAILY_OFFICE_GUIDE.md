# Guia do Ofício Diário - Daily Office API

## 📖 Visão Geral

Este guia documenta a implementação completa do sistema de Ofício Diário Anglicano na API. O sistema foi construído para gerar liturgias completas dos quatro ofícios diários baseados no Livro de Oração Comum (LOC) 2015.

---

## 🏗️ Arquitetura

### Modelos

#### 1. **LiturgicalText**
Armazena todos os textos litúrgicos fixos usados nos ofícios.

**Campos**:
- `slug`: Identificador único do texto (ex: 'opening_sentence_advent')
- `category`: Categoria do texto ('opening_sentence', 'confession', 'canticle', etc.)
- `content`: O texto completo
- `version`: Versão do LOC (padrão: 'loc_2015')
- `language`: Idioma (padrão: 'pt-BR')
- `reference`: Referência bíblica (opcional)
- `audio_url`: URL do áudio (futuro)

**Uso**:
```ruby
text = LiturgicalText.find_text('venite', version: 'loc_2015')
puts text.content
```

#### 2. **Psalm**
Armazena os 150 salmos com versículos estruturados.

**Campos**:
- `number`: Número do salmo (1-150)
- `title`: Título do salmo
- `verses`: JSONB com array de versículos
- `translation`: Tradução (padrão: 'loc_2015')
- `antiphon`: Antífona opcional

**Estrutura de `verses`**:
```json
[
  {
    "number": 1,
    "text": "Bem-aventurado o homem...",
    "hebrew_pointer": "1a"
  }
]
```

**Uso**:
```ruby
psalm = Psalm.find_psalm(23, translation: 'loc_2015')
puts psalm.full_title  # "Salmo 23: O Bom Pastor"
puts psalm.full_text   # Texto completo
```

#### 3. **PsalmCycle**
Define qual(is) salmo(s) usar em cada dia e ofício.

**Campos**:
- `cycle_type`: 'weekly' ou 'monthly'
- `week_number`: Semana do ciclo (se aplicável)
- `day_of_week`: Dia da semana (0-6, Domingo = 0)
- `office_type`: 'morning', 'evening', 'midday', 'compline'
- `psalm_numbers`: Array JSONB com números dos salmos

**Uso**:
```ruby
cycle = PsalmCycle.find_for_date_and_office(Date.today, 'morning')
cycle.psalms  # Retorna array de objetos Psalm
```

#### 4. **BibleText**
Armazena textos bíblicos completos para uso offline.

**Campos**:
- `book`: Nome do livro (ex: 'João')
- `book_number`: Número do livro (1-66)
- `chapter`: Capítulo
- `verse`: Versículo
- `text`: Texto do versículo
- `translation`: Tradução (ex: 'nvi', 'ntlh')
- `verse_type`: 'prose' ou 'poetry' (para formatação)

**Uso**:
```ruby
verses = BibleText.fetch_passage('João 3:16-17', translation: 'nvi')
html = BibleText.format_passage_html('Salmos 23')
```

---

## 🔧 Services

### BibleTextService

Service para buscar e formatar passagens bíblicas.

```ruby
service = BibleTextService.new(translation: 'nvi')

# Buscar como HTML formatado
html = service.fetch_passage_html('João 3:16')

# Buscar como texto puro
text = service.fetch_passage_text('João 3:16')

# Buscar estruturado
data = service.fetch_passage_structured('João 3:16')
# Retorna: { reference:, translation:, verses: [{number:, text:, type:}] }
```

### DailyOfficeService

**O coração do sistema**. Monta ofícios litúrgicos completos.

#### Inicialização

```ruby
service = DailyOfficeService.new(
  date: Date.today,
  office_type: :morning,  # :morning, :evening, :midday, :compline
  preferences: {
    version: 'loc_2015',
    bible_version: 'nvi',
    lords_prayer_version: 'traditional',  # ou 'contemporary'
    creed_type: :apostles,  # ou :nicene
    confession_type: 'long'  # ou 'short'
  }
)

office = service.call
```

#### Estrutura do Retorno

```json
{
  "date": "2025-11-22",
  "office_type": "morning",
  "season": "Tempo Comum",
  "color": "verde",
  "celebration": { ... },
  "saint": { ... },
  "modules": [
    {
      "name": "Sentença de Abertura",
      "slug": "opening_sentence",
      "lines": [
        {
          "content": "Senhor, abre os meus lábios...",
          "line_type": "leader"
        }
      ]
    },
    {
      "name": "Confissão de Pecados",
      "slug": "confession",
      "lines": [ ... ]
    }
  ],
  "metadata": {
    "version": "loc_2015",
    "bible_version": "nvi",
    "language": "pt-BR"
  }
}
```

#### Tipos de Linha (line_type)

- `heading`: Título de seção
- `subheading`: Subtítulo
- `rubric`: Instrução litúrgica (em vermelho/itálico)
- `leader`: Texto do oficiante/sacerdote
- `congregation`: Texto da congregação (negrito)
- `reader`: Texto do leitor
- `responsive`: Texto responsivo (alternado)
- `citation`: Citação bíblica
- `html`: HTML formatado (para leituras bíblicas)
- `spacer`: Espaçamento

### Estrutura dos Ofícios

#### Morning Prayer (Oração Matutina)
1. Sentença de Abertura
2. Confissão de Pecados
3. Absolvição
4. Invocação
5. Invitatório (Venite ou Jubilate)
6. Salmos
7. Primeira Leitura
8. Primeiro Cântico (Te Deum ou Benedictus es Domine)
9. Segunda Leitura
10. Segundo Cântico (Benedictus)
11. Credo Apostólico
12. Kyrie
13. Pai Nosso
14. Sufrágios
15. Coletas (do dia, pela paz, pela graça)
16. Ação de Graças Geral
17. Oração de São Crisóstomo
18. Despedida

#### Evening Prayer (Oração Vespertina)
Similar à Oração Matutina, mas com:
- Magnificat (em vez de Te Deum)
- Nunc Dimittis (em vez de Benedictus)
- Salmos diferentes
- Sufrágios vespertinos

#### Midday Prayer (Oração do Meio-Dia)
Estrutura simplificada:
1. Sentença de Abertura
2. Salmo
3. Leitura Breve
4. Kyrie
5. Pai Nosso
6. Coleta
7. Despedida

#### Compline (Completas)
1. Sentença de Abertura
2. Confissão
3. Absolvição
4. Invocação
5. Salmos fixos (4, 31, 91, 134)
6. Leitura Breve
7. Hino
8. Nunc Dimittis
9. Credo Apostólico
10. Kyrie
11. Pai Nosso
12. Orações
13. Despedida

---

## 🌐 API Endpoints

### 1. Obter Ofício de Hoje

```http
GET /api/v1/daily_office/today/:office_type
```

**Parâmetros de URL**:
- `office_type`: `morning`, `midday`, `evening`, `compline`

**Query Parameters** (opcionais):
- `version`: Versão do LOC (padrão: 'loc_2015')
- `bible_version`: Tradução bíblica (padrão: 'nvi')
- `language`: Idioma (padrão: 'pt-BR')
- `lords_prayer_version`: 'traditional' ou 'contemporary'
- `creed_type`: 'apostles' ou 'nicene'
- `confession_type`: 'long' ou 'short'

**Exemplo**:
```bash
curl http://localhost:3000/api/v1/daily_office/today/morning

curl http://localhost:3000/api/v1/daily_office/today/evening?bible_version=ntlh
```

### 2. Obter Ofício de Data Específica

```http
GET /api/v1/daily_office/:year/:month/:day/:office_type
```

**Exemplo**:
```bash
curl http://localhost:3000/api/v1/daily_office/2025/12/25/morning
```

### 3. Obter Opções de Preferências

```http
GET /api/v1/daily_office/preferences
```

Retorna todas as opções disponíveis para customização.

**Resposta**:
```json
{
  "versions": ["loc_2015"],
  "languages": ["pt-BR", "en"],
  "bible_versions": ["nvi", "ntlh", "arc"],
  "lords_prayer_versions": ["traditional", "contemporary"],
  "creed_types": ["apostles", "nicene"],
  "confession_types": ["long", "short"],
  "office_types": ["morning", "midday", "evening", "compline"]
}
```

---

## 🌱 Seeds e Dados

### Estado Atual

Os seeds de exemplo foram criados em:
- `db/seeds/liturgical_texts_example.rb`
- `db/seeds/psalms_example.rb`
- `db/seeds/psalm_cycles_example.rb`

**IMPORTANTE**: Estes são **dados de exemplo**. Você precisa:

1. **Extrair textos reais do LOC 2015**
2. **Adicionar todos os 150 salmos**
3. **Configurar o ciclo de salmos correto** (verificar se LOC usa semanal ou mensal de 30 dias)

### Como Executar Seeds

```bash
# Executar com PostgreSQL rodando
bin/rails db:migrate
bin/rails db:seed
```

### Estrutura de Dados Necessária

#### Textos Litúrgicos Faltantes

Você precisa adicionar:
- [ ] Sentenças de abertura completas para todas as temporadas
- [ ] Todos os cânticos: Te Deum, Benedictus es Domine, Magnificat, Nunc Dimittis, Benedicite
- [ ] Sufrágios (manhã e tarde) completos
- [ ] Hinos de Completas
- [ ] Leituras breves (para Meio-Dia e Completas)
- [ ] Coletas específicas (meio-dia, completas, etc.)

#### Salmos

Atualmente há apenas 7 salmos de exemplo. **Você precisa adicionar todos os 150 salmos do LOC 2015**.

Formato de exemplo:
```ruby
Psalm.create!(
  number: 51,
  title: 'Oração de Arrependimento',
  translation: 'loc_2015',
  verses: [
    { number: 1, text: 'Tem misericórdia de mim, ó Deus...', hebrew_pointer: '1' },
    # ... todos os versículos
  ]
)
```

#### Ciclos de Salmos

Verificar no LOC 2015 qual sistema é usado:
- **Semanal**: Cada dia da semana tem salmos fixos
- **Mensal (30 dias)**: Ciclo de 30 dias que se repete

Atualmente está implementado o semanal simplificado.

---

## 🔄 Próximos Passos

### Tarefas Pendentes para Completar a Fase 1

- [ ] **Extrair textos do LOC 2015 PDF** (manualmente ou com OCR)
- [ ] **Popular todos os 150 salmos**
- [ ] **Configurar ciclo de salmos correto**
- [ ] **Importar textos bíblicos** (SQL dump de NVI/NTLH)
- [ ] **Testar endpoints** com dados reais
- [ ] **Adicionar documentação Swagger/RSwag**
- [ ] **Escrever testes** (DailyOfficeService, Controller)

### Como Importar Textos Bíblicos

Opções:

1. **Usar dump SQL existente** (se disponível)
2. **API de terceiros** e cachear localmente
3. **Importar de arquivo JSON/CSV**

Estrutura esperada:
```sql
INSERT INTO bible_texts (book, book_number, chapter, verse, text, translation)
VALUES ('João', 43, 3, 16, 'Porque Deus amou o mundo...', 'nvi');
```

### Extraindo Textos do LOC 2015

Como o PDF está protegido/compactado, você precisará:

1. **Abrir o PDF** manualmente
2. **Copiar e colar** cada texto litúrgico
3. **Atualizar os seeds** em `liturgical_texts_example.rb`

Ou alternativamente:

1. **Usar ferramenta de OCR** (Adobe Acrobat, Google Drive)
2. **Converter para texto**
3. **Organizar em seeds**

---

## 🧪 Testes

### Testando Localmente

```bash
# Inicie o servidor
bin/rails server

# Teste o endpoint
curl http://localhost:3000/api/v1/daily_office/today/morning | jq

# Ou use um cliente HTTP como Postman/Insomnia
```

### Exemplo de Resposta

```json
{
  "date": "2025-11-22",
  "office_type": "morning",
  "season": "Tempo Comum",
  "color": "verde",
  "modules": [
    {
      "name": "Sentença de Abertura",
      "slug": "opening_sentence",
      "lines": [
        {
          "content": "Senhor, abre os meus lábios...",
          "line_type": "leader"
        }
      ]
    }
  ]
}
```

---

## 📱 Uso no Flutter

### Exemplo de Chamada

```dart
final response = await http.get(
  Uri.parse('https://api.example.com/api/v1/daily_office/today/morning'),
);

if (response.statusCode == 200) {
  final office = DailyOffice.fromJson(jsonDecode(response.body));
  // Renderizar ofício
}
```

### Renderizando no Flutter

Para cada `line` no ofício, renderizar de acordo com `line_type`:

```dart
Widget buildLine(OfficeLine line) {
  switch (line.lineType) {
    case 'heading':
      return Text(line.content, style: headingStyle);
    case 'leader':
      return Text(line.content, style: leaderStyle);
    case 'congregation':
      return Text(line.content, style: TextStyle(fontWeight: FontWeight.bold));
    case 'rubric':
      return Text(line.content, style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red));
    case 'html':
      return Html(data: line.content);  // usando flutter_html
    default:
      return Text(line.content);
  }
}
```

---

## 🎨 Cores Litúrgicas

As cores retornadas pela API seguem as temporadas:

- **Advento**: violeta (ou rosa no 3º domingo)
- **Natal**: branco
- **Epifania**: verde
- **Quaresma**: roxo (ou rosa no 4º domingo)
- **Semana Santa**: vermelho
- **Páscoa**: branco
- **Tempo Comum**: verde

Use essas cores no app Flutter para decoração visual.

---

## 📚 Recursos

### Referências

- **LOC 2015**: https://igrejadetodosossantos.wordpress.com/wp-content/uploads/2018/09/loc_2015.pdf
- **Book of Common Prayer (BCP)**: https://www.bcponline.org/
- **Revised Common Lectionary**: https://lectionary.library.vanderbilt.edu/

### Documentação Rails

- ActiveRecord: https://guides.rubyonrails.org/active_record_basics.html
- Service Objects: https://medium.com/@jcarlosmenezesmartins/rails-service-objects-9c9b3d6c3b42

---

## ❓ FAQ

### 1. Por que não usar API externa para textos bíblicos?

Queremos que o app funcione **100% offline**. Ter os textos localmente garante isso.

### 2. Como adicionar uma nova tradução bíblica?

```ruby
# Importar com translation diferente
BibleText.create!(
  book: 'João',
  chapter: 3,
  verse: 16,
  text: 'For God so loved the world...',
  translation: 'kjv'  # King James Version
)
```

### 3. Como adicionar novos idiomas?

Adicione textos litúrgicos com `language: 'en'` e configure o service:

```ruby
service = DailyOfficeService.new(
  date: Date.today,
  office_type: :morning,
  preferences: { language: 'en' }
)
```

### 4. Os salmos devem ser responsivos (alternados)?

Sim! O método `psalm.responsive_format` retorna os versículos alternando entre 'leader' e 'congregation'.

### 5. Como funciona o cache?

A API cacheia respostas por 1 dia usando `Rails.cache`. Isso evita reprocessar o mesmo ofício múltiplas vezes.

---

## 🚀 Conclusão

A Fase 1 está **estruturalmente completa**. Todos os models, services, e endpoints estão implementados.

**Próximo passo crítico**: Povoar o banco com dados reais do LOC 2015.

Depois disso, você terá uma API totalmente funcional que o app Flutter pode consumir para exibir os ofícios diários completos!

---

**Última atualização**: 2025-11-22
**Versão**: 1.0
