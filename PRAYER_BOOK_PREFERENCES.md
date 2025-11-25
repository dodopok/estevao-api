# Prayer Book Specific Preferences

Este documento descreve o sistema de preferências específicas por Prayer Book (LOC) implementado na API.

## Visão Geral

Cada Prayer Book pode ter características e opções únicas. Por exemplo:
- O LOC 2015 da IEAB oferece opções de leituras semicontínuas ou complementares
- O LOC 2019 da ACNA suporta vigília e tem 7 leituras por semana
- Alguns LOCs oferecem rito familiar, outros não

Este sistema permite que cada usuário configure suas preferências específicas para cada Prayer Book que utiliza.

## Estrutura de Features

Cada Prayer Book tem um campo `features` (JSONB) que define suas capacidades:

```json
{
  "lectionary": {
    "reading_types": ["semicontinuous", "complementary"],
    "default_reading_type": "semicontinuous",
    "readings_per_week": 4,
    "supports_vigil": false
  },
  "daily_office": {
    "supports_family_rite": true,
    "available_confession_types": ["long", "short"],
    "available_lords_prayer": ["traditional", "contemporary"]
  },
  "psalter": {
    "cycle_length": 30,
    "supports_seasonal_variations": true
  }
}
```

## Endpoints da API

### 1. Consultar Features de um Prayer Book

**Endpoint:** `GET /api/v1/prayer_books/:prayer_book_code/features`
**Autenticação:** Não requerida
**Descrição:** Retorna as capacidades e opções padrão de um Prayer Book específico

**Exemplo:**
```bash
curl http://localhost:3000/api/v1/prayer_books/loc_2015/features
```

**Resposta:**
```json
{
  "prayer_book_code": "loc_2015",
  "prayer_book_name": "Livro de Oração Comum - IEAB - 2015",
  "features": { ... },
  "default_options": {
    "lectionary": {
      "reading_type": "semicontinuous"
    },
    "daily_office": {
      "use_family_rite": false
    }
  },
  "capabilities": {
    "supports_family_rite": true,
    "supports_vigil": false,
    "available_reading_types": ["semicontinuous", "complementary"],
    "readings_per_week": 4
  }
}
```

### 2. Consultar Preferências do Usuário para um Prayer Book

**Endpoint:** `GET /api/v1/prayer_books/:prayer_book_code/preferences`
**Autenticação:** Requerida (Bearer token)
**Descrição:** Retorna as preferências salvas do usuário para aquele Prayer Book

**Exemplo:**
```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
  http://localhost:3000/api/v1/prayer_books/loc_2015/preferences
```

**Resposta:**
```json
{
  "prayer_book_code": "loc_2015",
  "options": {
    "lectionary": {
      "reading_type": "complementary"
    },
    "daily_office": {
      "use_family_rite": true
    }
  },
  "available_features": { ... }
}
```

### 3. Atualizar Preferências do Usuário

**Endpoint:** `PATCH /api/v1/prayer_books/:prayer_book_code/preferences`
**Autenticação:** Requerida (Bearer token)
**Descrição:** Atualiza as preferências do usuário para aquele Prayer Book

**Exemplo:**
```bash
curl -X PATCH \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "options": {
      "lectionary": {
        "reading_type": "complementary"
      },
      "daily_office": {
        "use_family_rite": true
      }
    }
  }' \
  http://localhost:3000/api/v1/prayer_books/loc_2015/preferences
```

**Resposta:**
```json
{
  "message": "Preferências atualizadas com sucesso",
  "prayer_book_code": "loc_2015",
  "options": {
    "lectionary": {
      "reading_type": "complementary"
    },
    "daily_office": {
      "use_family_rite": true
    }
  }
}
```

### 4. Rito Familiar

**Endpoint:** `GET /api/v1/daily_office/:year/:month/:day/:office_type/family`
**Autenticação:** Opcional
**Descrição:** Retorna uma versão resumida do ofício (rito familiar)

**Nota:** Só funciona se o Prayer Book selecionado suportar rito familiar (`supports_family_rite: true`)

**Exemplo:**
```bash
curl http://localhost:3000/api/v1/daily_office/2025/11/25/morning/family
```

Se o Prayer Book não suportar:
```json
{
  "error": "O Prayer Book 'loc_1662' não suporta rito familiar"
}
```

## Validações

O sistema valida automaticamente que as opções escolhidas são suportadas pelo Prayer Book:

1. **reading_type**: Deve estar na lista de `reading_types` disponíveis
2. **use_family_rite**: Só pode ser `true` se o Prayer Book suportar (`supports_family_rite: true`)

Se você tentar salvar uma opção inválida, receberá um erro:

```json
{
  "error": "Erro ao atualizar preferências",
  "messages": [
    "Options reading_type 'complementary' não é suportado por este Prayer Book. Opções válidas: semicontinuous"
  ]
}
```

## Persistência de Configurações

Quando um usuário troca de Prayer Book:
- As preferências do Prayer Book anterior **são mantidas**
- As preferências do novo Prayer Book são carregadas (ou os defaults se não existirem)
- Quando voltar ao Prayer Book anterior, as configurações anteriores são restauradas

Exemplo de fluxo:

1. Usuário configura LOC 2015 com `reading_type: "complementary"`
2. Usuário troca para LOC 2019
3. Usuário configura LOC 2019 com `use_family_rite: true`
4. Usuário volta para LOC 2015
5. A configuração `reading_type: "complementary"` ainda está lá! ✅

## Integração com DailyOffice

O `DailyOfficeController` automaticamente carrega as preferências específicas do Prayer Book do usuário e as aplica ao gerar o ofício.

Ordem de prioridade das preferências:
1. **Query params** (maior prioridade)
2. **Preferências específicas do Prayer Book** do usuário
3. **Preferências globais** do usuário
4. **Defaults do Prayer Book** (menor prioridade)

## Modelos

### PrayerBook

```ruby
prayer_book = PrayerBook.find_by(code: "loc_2015")

# Acessar features
prayer_book.lectionary_features
prayer_book.daily_office_features
prayer_book.psalter_features

# Verificar suporte
prayer_book.supports_family_rite?  # => true
prayer_book.supports_vigil?        # => false

# Opções padrão
prayer_book.default_options
prayer_book.available_reading_types  # => ["semicontinuous", "complementary"]
```

### User

```ruby
user = User.find(...)

# Obter preferências para um Prayer Book específico
user.prayer_book_preferences_for("loc_2015")
# => { "lectionary" => { "reading_type" => "complementary" }, ... }

# Criar/atualizar preferências
pref = user.find_or_initialize_prayer_book_preference("loc_2015")
pref.options = { "lectionary" => { "reading_type" => "complementary" } }
pref.save!
```

## TODO: Implementações Futuras

### Lectionary Reading Type

Atualmente, o sistema está preparado mas não implementado no `LectionaryController`. Para implementar:

1. Adicionar coluna `reading_type` na tabela `lectionary_readings`
2. Popular leituras complementares no seed
3. Descomentar e usar o método `get_user_reading_type_preference` no `LectionaryController`
4. Filtrar leituras por `reading_type` na busca

Veja os comentários TODO em [app/controllers/api/v1/lectionary_controller.rb](app/controllers/api/v1/lectionary_controller.rb#L111-L114)

## Comparação entre Prayer Books

| Feature | LOC 1662 | LOC 2015 | LOC 2019 |
|---------|----------|----------|----------|
| Rito Familiar | ❌ | ✅ | ✅ |
| Vigília | ❌ | ❌ | ✅ |
| Reading Types | Semicontinuous | Semicontinuous, Complementary | Semicontinuous, Complementary |
| Leituras/Semana | 4 | 4 | 7 |
| Ciclo do Saltério | 30 dias | 30 dias | 60 dias |
| Confissão Curta | ❌ | ✅ | ✅ |
| Pai Nosso Contemporâneo | ❌ | ✅ | ✅ |

## Exemplos de Uso no Frontend

### 1. Descobrir capacidades antes de mostrar opções

```javascript
// Buscar as features do Prayer Book selecionado
const response = await fetch('/api/v1/prayer_books/loc_2015/features');
const { capabilities } = await response.json();

// Mostrar opção de rito familiar apenas se suportado
if (capabilities.supports_family_rite) {
  showFamilyRiteOption();
}

// Mostrar dropdown de reading_type apenas se houver múltiplas opções
if (capabilities.available_reading_types.length > 1) {
  showReadingTypeSelector(capabilities.available_reading_types);
}
```

### 2. Salvar preferências do usuário

```javascript
await fetch('/api/v1/prayer_books/loc_2015/preferences', {
  method: 'PATCH',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    options: {
      lectionary: {
        reading_type: 'complementary'
      },
      daily_office: {
        use_family_rite: true
      }
    }
  })
});
```

### 3. Carregar preferências existentes

```javascript
const response = await fetch('/api/v1/prayer_books/loc_2015/preferences', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
});

const { options } = await response.json();

// Aplicar ao UI
setReadingType(options.lectionary.reading_type);
setUseFamilyRite(options.daily_office.use_family_rite);
```

## Estrutura do Banco de Dados

### Tabela: `prayer_books`

```sql
CREATE TABLE prayer_books (
  id BIGSERIAL PRIMARY KEY,
  code VARCHAR NOT NULL UNIQUE,
  name VARCHAR,
  features JSONB NOT NULL DEFAULT '{}',
  -- outros campos...
);

CREATE INDEX ON prayer_books USING GIN (features);
```

### Tabela: `prayer_book_user_preferences`

```sql
CREATE TABLE prayer_book_user_preferences (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id),
  prayer_book_id BIGINT NOT NULL REFERENCES prayer_books(id),
  options JSONB NOT NULL DEFAULT '{}',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

CREATE UNIQUE INDEX ON prayer_book_user_preferences (user_id, prayer_book_id);
CREATE INDEX ON prayer_book_user_preferences USING GIN (options);
```

## Contribuindo

Para adicionar novas features a um Prayer Book:

1. Editar `db/seeds/prayer_books.rb`
2. Adicionar as features no hash do Prayer Book
3. Rodar `rails db:seed:replant SEED=db/seeds/prayer_books.rb`

Para adicionar novos tipos de features:

1. Documentar a estrutura esperada neste README
2. Adicionar validações no modelo `PrayerBookUserPreference`
3. Adicionar helper methods no modelo `PrayerBook` se necessário
