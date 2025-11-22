# Gerando Documentação Swagger

## Pré-requisitos

- PostgreSQL rodando
- Banco de dados criado e migrado

## Comandos

### 1. Iniciar PostgreSQL (com Docker)

```bash
docker compose up -d db
```

### 2. Preparar banco de dados

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed  # Opcional, mas recomendado
```

### 3. Gerar documentação Swagger

```bash
bin/rails rswag:specs:swaggerize
```

Isso irá:
- Executar os specs de API em `spec/requests/api/v1/*_spec.rb`
- Gerar a documentação JSON em `swagger/v1/swagger.yaml`
- Disponibilizar a UI em `http://localhost:3000/api-docs`

### 4. Acessar a documentação

Inicie o servidor:

```bash
bin/rails server
```

Acesse: **http://localhost:3000/api-docs**

## Endpoints Documentados

### Calendar
- `GET /api/v1/calendar/today`
- `GET /api/v1/calendar/{year}/{month}/{day}`
- `GET /api/v1/calendar/{year}/{month}`
- `GET /api/v1/calendar/{year}`

### Celebrations
- `GET /api/v1/celebrations`
- `GET /api/v1/celebrations/{id}`
- `GET /api/v1/celebrations/search`
- `GET /api/v1/celebrations/types`
- `GET /api/v1/celebrations/date/{month}/{day}`

### Lectionary
- `GET /api/v1/lectionary/{year}/{month}/{day}`
- `GET /api/v1/lectionary/{year}/{month}/{day}/all_services`
- `GET /api/v1/lectionary/cycle/{year}`

### **Daily Office** ✨ (NOVO)
- `GET /api/v1/daily_office/preferences`
- `GET /api/v1/daily_office/today/{office_type}`
- `GET /api/v1/daily_office/{year}/{month}/{day}/{office_type}`

## Estrutura dos Specs

Cada endpoint é documentado em `spec/requests/api/v1/` com:

- **Tags**: Agrupamento na UI
- **Parameters**: Parâmetros de path, query, body
- **Responses**: Códigos de status e schemas
- **Examples**: Exemplos de resposta real

### Exemplo Daily Office Spec

```ruby
path "/api/v1/daily_office/today/{office_type}" do
  parameter name: "office_type", in: :path, type: :string, required: true
  parameter name: :bible_version, in: :query, type: :string, required: false

  get("Get today's Daily Office") do
    tags "Daily Office"
    produces "application/json"

    response(200, "successful") do
      schema type: :object, properties: { ... }
      run_test!
    end
  end
end
```

## Troubleshooting

### Erro: "Database does not exist"

```bash
bin/rails db:create
```

### Erro: "Pending migrations"

```bash
bin/rails db:migrate RAILS_ENV=test
```

### Swagger UI não carrega

Verifique se o servidor está rodando em `http://localhost:3000` e acesse `/api-docs`.

### Atualizar documentação após mudanças

Sempre que modificar os specs ou adicionar novos endpoints:

```bash
bin/rails rswag:specs:swaggerize
```

## Customização

Para customizar a aparência ou metadados do Swagger, edite:

- `config/initializers/rswag_api.rb`
- `config/initializers/rswag_ui.rb`
- `spec/swagger_helper.rb`

## Versionamento

A documentação gerada é versionada em `swagger/v1/swagger.yaml` e deve ser commitada no Git para que outros desenvolvedores tenham acesso.

---

**Última atualização**: 2025-11-22
