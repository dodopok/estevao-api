# Estêvão API

[![CI](https://github.com/dodopok/estevao-api/actions/workflows/ci.yml/badge.svg)](https://github.com/dodopok/estevao-api/actions/workflows/ci.yml)
[![Ruby Version](https://img.shields.io/badge/ruby-3.2.3-red.svg)](https://www.ruby-lang.org)
[![Rails Version](https://img.shields.io/badge/rails-8.1.1-red.svg)](https://rubyonrails.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

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
- **Banco de Dados**: PostgreSQL
- **Servidor Web**: Puma + Thruster
- **Cache**: Solid Cache
- **Background Jobs**: Solid Queue
- **Action Cable**: Solid Cable
- **Testes**: Minitest
- **CI/CD**: GitHub Actions
- **Code Quality**: Rubocop, Brakeman, Bundler Audit

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

A aplicação possui **171 testes (613 asserções)** cobrindo:
- Cálculo de datas móveis (Páscoa, Quaresma, Advento) - 49 testes
- Resolução de celebrações e hierarquia litúrgica - 32 testes
- Calendário litúrgico e cores - 30 testes
- Serviços de leituras e coletas - 27 testes
- Endpoints da API (unit) - 36 testes
- **Testes de integração end-to-end - 27 testes**

**Cobertura de Testes**: 100% dos serviços e controllers principais + integração completa

### Integração Contínua (CI)

O projeto utiliza GitHub Actions para CI/CD com 3 jobs:

1. **Security Scan** (`scan_ruby`)
   - Brakeman: Análise estática de vulnerabilidades Rails
   - Bundler Audit: Verificação de gems com vulnerabilidades conhecidas

2. **Lint** (`lint`)
   - Rubocop: Verificação de estilo de código e boas práticas
   - Cache de análise para builds mais rápidas

3. **Tests** (`test`)
   - Execução de todos os 171 testes (613 asserções) com PostgreSQL
   - 27 testes de integração end-to-end
   - Setup automático do banco de dados
   - Validação completa da aplicação

Todos os jobs são executados automaticamente em:
- Pull Requests
- Push para branch `main`

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
- **Liturgical::EasterCalculator**: Calcula a Páscoa e datas móveis relacionadas (algoritmo Computus)
- **Liturgical::CelebrationResolver**: Resolve precedência entre celebrações conforme hierarquia litúrgica
- **ReadingService**: Busca leituras do lecionário por celebração, Proper ou domingo
- **CollectService**: Busca coletas apropriadas para cada celebração e estação
- **SundayReferenceMapper**: Mapeia datas para referências de domingos

## Funcionalidades

### Hierarquia Litúrgica
A API implementa corretamente a hierarquia de celebrações:
- Festas Principais (Principal Feasts) têm precedência máxima
- Domingos em quadras principais (Advento, Natal, Quaresma, Páscoa) têm precedência sobre festivais
- Transferência automática de celebrações quando necessário (ex: Anunciação, Todos os Santos)
- Resolução de conflitos baseada em rank (quanto menor o rank, maior a precedência)

### Cores Litúrgicas
- Domingos sempre usam a cor da estação litúrgica, nunca da celebração
- Dias de semana podem usar cor específica da celebração
- Suporte completo para: branco, vermelho, roxo, violeta, rosa, verde, preto

### Ciclos do Lecionário
- **Domingos**: Ciclos A, B, C (trienal)
- **Dias de semana**: Anos pares e ímpares (bienal)
- Cálculo automático baseado no ano litúrgico (que inicia no Advento)

## Licença

Este projeto está sob a licença MIT.
