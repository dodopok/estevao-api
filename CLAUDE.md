# CLAUDE.md

Este arquivo contém instruções para o GitHub Copilot/Claude sobre o contexto do projeto.

## Sobre o Projeto

**estevao-api** é uma API Ruby on Rails para o aplicativo Ordo, um app Flutter de oração e liturgia das horas (Daily Office) baseado no Book of Common Prayer.

### Principais funcionalidades:
- Daily Office (Liturgia das Horas): Matinas, Laudes, Vésperas, Completas
- Calendário litúrgico com celebrações e cores litúrgicas
- Leituras bíblicas (lecionário)
- Salmos e ciclos de salmos
- Coletas e textos litúrgicos
- Preferências de usuário para diferentes Prayer Books
- Notificações push via Firebase
- Compartilhamento de ofícios

## Ambiente

- **Runtime**: Ruby on Rails via Docker Compose
- **Shell**: Bash
- **Banco de dados**: PostgreSQL (rodando no Docker)
- **IMPORTANTE**: O projeto roda em `docker-compose`. Todos os comandos Rails devem ser executados via container.

## Build & Run Commands

```bash
# Subir os containers
docker-compose up -d

# Parar os containers
docker-compose down

# Server (se não estiver rodando via docker-compose up)
docker-compose exec -T web bundle exec rails s -b 0.0.0.0

# Console Rails
docker-compose exec -T web bundle exec rails c

# Migrations
docker-compose exec -T web bundle exec rails db:migrate

# Testes
docker-compose exec -T web bundle exec rspec

# Testes específicos
docker-compose exec -T web bundle exec rspec spec/path/to/file_spec.rb

# RuboCop (linter)
docker-compose exec -T web bundle exec rubocop

# RuboCop com auto-correção
docker-compose exec -T web bundle exec rubocop -a

# Bundle install
docker-compose exec -T web bundle install

# Seeds
docker-compose exec -T web bundle exec rails db:seed
```

## ⚠️ REGRAS OBRIGATÓRIAS AO FINALIZAR TAREFAS

1. **SEMPRE rodar os testes** ao finalizar uma tarefa:
   ```bash
   docker-compose exec -T web bundle exec rspec
   ```

2. **SEMPRE rodar o RuboCop** para verificar estilo de código:
   ```bash
   docker-compose exec -T web bundle exec rubocop
   ```

3. **ADICIONAR TESTES** para qualquer código novo ou modificado:
   - Testes de model em `spec/models/`
   - Testes de request/controller em `spec/requests/`
   - Testes de service em `spec/services/`
   - Testes de job em `spec/jobs/`
   - Usar factories em `spec/factories/`

## Estrutura do Projeto

```
app/
├── controllers/api/    # Controllers da API (versionados em v1/)
├── models/             # Models ActiveRecord
├── services/           # Service objects (lógica de negócio)
│   ├── daily_office/   # Services específicos do Daily Office
│   ├── liturgical/     # Services do calendário litúrgico
│   └── reading/        # Services de leituras bíblicas
├── jobs/               # Background jobs
└── helpers/            # Helpers

spec/                   # Testes RSpec
├── factories/          # FactoryBot factories
├── models/             # Testes de models
├── requests/           # Testes de API/controllers
├── services/           # Testes de services
└── jobs/               # Testes de jobs

config/                 # Configurações Rails
db/
├── migrate/            # Migrations
├── seeds/              # Seed data
└── schema.rb           # Schema atual
```

## Convenções de Código

- Seguir o estilo definido no RuboCop
- Services para lógica de negócio complexa
- Factories para testes (FactoryBot)
- Documentação de API com Swagger/OpenAPI

## Documentação Adicional

- `README.md` - Visão geral do projeto