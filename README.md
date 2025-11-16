# Estêvão API

API RESTful para Calendário Litúrgico Anglicano, fornecendo informações sobre celebrações, leituras do lecionário, cores litúrgicas e o calendário litúrgico completo.

## Descrição

API completa desenvolvida em Rails 8.1.1 para fornecer dados do calendário litúrgico anglicano, incluindo:

- **Calendário Litúrgico**: Informações diárias, mensais e anuais sobre estações litúrgicas, domingos e dias santos
- **Celebrações**: Festas principais, dias santos, festivais e comemorações de santos
- **Lecionário**: Leituras bíblicas organizadas por ciclos (A, B, C) para Eucaristia e Ofícios Diários
- **Coletas**: Orações próprias para cada celebração e estação litúrgica
- **Cores Litúrgicas**: Cores apropriadas para cada tempo e celebração

## Tecnologias

- **Ruby**: 3.2.3
- **Rails**: 8.1.1
- **Banco de Dados**: PostgreSQL (produção) / SQLite3 (desenvolvimento)
- **Servidor Web**: Puma + Thruster
- **Cache**: Solid Cache
- **Background Jobs**: Solid Queue
- **Action Cable**: Solid Cable

## Configuração Inicial

### Pré-requisitos

- Ruby 3.2.3
- Bundler
- PostgreSQL (para produção)

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/estevao-api.git
cd estevao-api
```

2. Instale as dependências:
```bash
bundle install
```

3. Configure o banco de dados:
```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### Executar em Desenvolvimento

#### Opção 1: Local (sem Docker)

```bash
bin/rails server
```

A API estará disponível em `http://localhost:3000`

#### Opção 2: Com Docker

```bash
docker-compose up --build
```

Veja [DOCKER.md](DOCKER.md) para guia completo de uso com Docker.

### Executar Testes

```bash
bin/rails test
```

Com Docker:
```bash
docker-compose exec web bin/rails test
```

## Endpoints da API

### Raiz da API
```
GET /
```
Retorna informações gerais da API e lista de endpoints disponíveis.

### Calendário Litúrgico

#### Informações de um dia específico
```
GET /api/v1/calendar/:year/:month/:day
```
Retorna informações litúrgicas completas de um dia, incluindo estação, cor litúrgica, celebração, coleta e leituras.

**Exemplo**: `/api/v1/calendar/2025/12/25`

#### Calendário de um mês
```
GET /api/v1/calendar/:year/:month
```
Retorna o calendário litúrgico de um mês completo.

**Exemplo**: `/api/v1/calendar/2025/12`

#### Informações de um ano
```
GET /api/v1/calendar/:year
```
Retorna datas móveis (Páscoa, Advento, etc.) e resumo das estações litúrgicas do ano.

**Exemplo**: `/api/v1/calendar/2025`

### Celebrações

#### Listar todas as celebrações
```
GET /api/v1/celebrations
```
Parâmetros opcionais:
- `type`: Filtrar por tipo de celebração
- `movable`: Filtrar celebrações móveis (true/false)

#### Detalhes de uma celebração
```
GET /api/v1/celebrations/:id
```
Retorna informações completas incluindo coletas e leituras.

#### Buscar celebrações
```
GET /api/v1/celebrations/search?q=termo
```
Busca celebrações por nome.

**Exemplo**: `/api/v1/celebrations/search?q=Maria`

#### Celebrações em uma data
```
GET /api/v1/celebrations/date/:month/:day
```
Retorna celebrações fixas em um mês/dia específico.

**Exemplo**: `/api/v1/celebrations/date/12/25`

#### Tipos de celebrações
```
GET /api/v1/celebrations/types
```
Lista todos os tipos de celebração disponíveis.

### Lecionário (Leituras)

#### Leituras de um dia
```
GET /api/v1/lectionary/:year/:month/:day
```
Retorna as leituras bíblicas para Eucaristia do dia especificado.

**Exemplo**: `/api/v1/lectionary/2025/12/25`

#### Leituras de todos os ofícios
```
GET /api/v1/lectionary/:year/:month/:day/all_services
```
Retorna leituras para Eucaristia, Oração da Manhã e Oração da Tarde.

#### Informações do ciclo
```
GET /api/v1/lectionary/cycle/:year
```
Retorna o ciclo do lecionário (A, B ou C) para o ano especificado.

**Exemplo**: `/api/v1/lectionary/cycle/2025`

## Deploy com Docker

### Build da imagem
```bash
docker build -t estevao-api .
```

### Executar o container
```bash
docker run -d -p 3000:80 \
  -e SECRET_KEY_BASE=<sua_secret_key> \
  -e DATABASE_URL=<url_do_postgresql> \
  -e RAILS_ENV=production \
  --name estevao-api estevao-api
```

### Gerar SECRET_KEY_BASE
```bash
ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"
```

## Deploy no Render

### Variáveis de Ambiente Necessárias

Configure as seguintes variáveis de ambiente no painel do Render:

1. **SECRET_KEY_BASE** (obrigatório)
   - Gere com: `ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"`

2. **DATABASE_URL** (obrigatório)
   - Fornecido automaticamente pelo Render ao adicionar PostgreSQL

3. **RAILS_ENV** (obrigatório)
   - Valor: `production`

### Comandos de Build e Inicialização

**Build Command**:
```bash
./bin/render-build.sh
```

**Start Command**:
```bash
bundle exec puma -C config/puma.rb
```

### Observações Importantes

- Aplicação API-only (sem assets ou views)
- Adicione um banco PostgreSQL no Render antes do deploy
- O script `render-build.sh` executa migrations automaticamente
- Cache habilitado para melhor performance
- Aplicação usa variáveis de ambiente (não requer RAILS_MASTER_KEY)

## Modelos de Dados

### Principais Modelos

- **Celebration**: Festas, dias santos e comemorações
- **LectionaryReading**: Leituras bíblicas organizadas por ciclo
- **Collect**: Orações próprias para celebrações e estações
- **LiturgicalSeason**: Estações do ano litúrgico
- **LiturgicalColor**: Cores litúrgicas

### Serviços

- **LiturgicalCalendar**: Calcula o calendário litúrgico completo
- **EasterCalculator**: Calcula a Páscoa e datas móveis relacionadas
- **CelebrationResolver**: Resolve precedência entre celebrações

## Licença

Este projeto está sob a licença MIT.
