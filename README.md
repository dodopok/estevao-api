# Estêvão API

[![CI](https://github.com/dodopok/estevao-api/actions/workflows/ci.yml/badge.svg)](https://github.com/dodopok/estevao-api/actions/workflows/ci.yml)
[![Ruby Version](https://img.shields.io/badge/ruby-3.2.3-red.svg)](https://www.ruby-lang.org)
[![Rails Version](https://img.shields.io/badge/rails-8.1.1-red.svg)](https://rubyonrails.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**API RESTful completa para a vida espiritual anglicana**, fornecendo calendário litúrgico, ofícios diários, leituras bíblicas, regras de vida espiritual e muito mais.

## 📖 Visão Geral

Backend Rails 8.1 desenvolvido para aplicativos de oração e espiritualidade anglicana, oferecendo:

### 🎯 Funcionalidades Principais

- **📅 Calendário Litúrgico**: Informações diárias, mensais e anuais sobre estações litúrgicas, domingos e dias santos
- **🙏 Ofício Diário**: Oração da Manhã, Meio-Dia, Tarde e Completas completas e formatadas (LOC 2015)
- **📚 Lecionário**: Leituras bíblicas organizadas por ciclos (A, B, C) para Eucaristia e Ofícios Diários
- **📖 Textos Bíblicos**: Integração com múltiplas traduções da Bíblia (12+ traduções)
- **✝️ Celebrações**: Festas principais, dias santos, festivais e comemorações de santos
- **🕊️ Coletas**: Orações próprias para cada celebração e estação litúrgica
- **🎨 Cores Litúrgicas**: Cores apropriadas para cada tempo e celebração
- **📿 Regras de Vida**: Sistema de regras de vida espiritual com aprovação e adoção
- **👤 Autenticação**: Sistema de usuários com Firebase Authentication
- **🔔 Notificações**: Sistema de notificações push (Firebase Cloud Messaging)
- **📊 Tracking**: Sistema de completions para acompanhar ofícios realizados
- **📕 Prayer Books**: Suporte a múltiplos livros de oração com preferências personalizadas

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

## 📡 Endpoints da API

> 📘 **Documentação Completa**: Acesse `/api-docs` para a documentação interativa (Swagger/OpenAPI)

### 🏠 Raiz da API
```
GET /
```
Retorna informações gerais da API e lista de endpoints disponíveis.

### 📅 Calendário Litúrgico

```bash
GET /api/v1/calendar/today                      # Informações do dia atual
GET /api/v1/calendar/:year/:month/:day          # Dia específico
GET /api/v1/calendar/:year/:month               # Calendário mensal
GET /api/v1/calendar/:year                       # Resumo anual
```

**Exemplo de resposta** (`/api/v1/calendar/2025/12/25`):
```json
{
  "data": "2025-12-25",
  "dia_da_semana": "Quinta-feira",
  "quadra_liturgica": "Natal",
  "cor_liturgica": "branco",
  "celebracao": {
    "nome": "Natividade de nosso Senhor Jesus Cristo",
    "tipo": "principal_feast"
  }
}
```

### ✝️ Celebrações

```bash
GET /api/v1/celebrations                        # Listar todas
GET /api/v1/celebrations/:id                    # Detalhes
GET /api/v1/celebrations/search?q=termo         # Buscar
GET /api/v1/celebrations/date/:month/:day       # Por data
GET /api/v1/celebrations/types                  # Tipos disponíveis
```

### 📚 Lecionário (Leituras)

```bash
GET /api/v1/lectionary/:year/:month/:day                  # Leituras do dia
GET /api/v1/lectionary/:year/:month/:day/all_services     # Todos os ofícios
GET /api/v1/lectionary/cycle/:year                        # Info do ciclo
```

### 🙏 Ofício Diário

```bash
GET /api/v1/daily_office/today/:office_type                         # Ofício de hoje
GET /api/v1/daily_office/:year/:month/:day/:office_type            # Data específica
GET /api/v1/daily_office/:year/:month/:day/:office_type/family     # Rito familiar
GET /api/v1/daily_office/preferences                               # Opções disponíveis
```

**Tipos de ofício**: `morning` | `midday` | `evening` | `compline`

### 👤 Usuários e Autenticação

```bash
GET    /api/v1/users/me                        # Perfil do usuário
PATCH  /api/v1/users/preferences                # Atualizar preferências
GET    /api/v1/users/completions                # Histórico de ofícios
POST   /api/v1/users/fcm_token                  # Registrar token push
DELETE /api/v1/users/fcm_token                  # Remover token
```

### ✅ Completions (Tracking de Ofícios)

```bash
POST   /api/v1/completions                                        # Marcar como completo
DELETE /api/v1/completions/:id                                    # Desmarcar
GET    /api/v1/completions/:year/:month/:day/:office_type        # Verificar status
```

### 🔔 Notificações (Admin)

```bash
POST /api/v1/notifications/send         # Enviar para usuários específicos
POST /api/v1/notifications/broadcast    # Broadcast para todos
```

### 📕 Livros de Oração (Prayer Books)

```bash
GET   /api/v1/prayer_books                                    # Listar todos
GET   /api/v1/prayer_books/:code                              # Detalhes
GET   /api/v1/prayer_books/:code/features                     # Features disponíveis
GET   /api/v1/prayer_books/:code/preferences                  # Preferências do usuário
PATCH /api/v1/prayer_books/:code/preferences                  # Atualizar preferências
```

### 📿 Regras de Vida

```bash
GET  /api/v1/life_rules                 # Listar regras
GET  /api/v1/life_rules/:id             # Detalhes
POST /api/v1/life_rules                 # Criar nova (usuário)
POST /api/v1/life_rules/:id/adopt       # Adotar uma regra
POST /api/v1/life_rules/:id/approve     # Aprovar regra (admin)
```

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

## 🗂️ Modelos de Dados

### Principais Modelos

**Litúrgicos**:
- `Celebration` - Festas, dias santos e comemorações
- `LectionaryReading` - Leituras bíblicas organizadas por ciclo
- `Collect` - Orações próprias para celebrações e estações
- `LiturgicalSeason` - Estações do ano litúrgico
- `LiturgicalColor` - Cores litúrgicas
- `LiturgicalText` - Textos fixos dos ofícios (sentenças, confissões, cânticos, etc.)

**Ofício Diário**:
- `Psalm` - Salmos completos com versículos
- `PsalmCycle` - Ciclos de leitura dos salmos (semanal/mensal)
- `BibleText` - Textos bíblicos em múltiplas traduções

**Usuários e Tracking**:
- `User` - Usuários autenticados (Firebase)
- `Completion` - Registro de ofícios completados
- `FcmToken` - Tokens para notificações push
- `NotificationLog` - Histórico de notificações enviadas

**Prayer Books e Preferências**:
- `PrayerBook` - Livros de oração disponíveis (LOC 2015, etc.)
- `PrayerBookUserPreference` - Preferências do usuário por livro

**Regras de Vida**:
- `LifeRule` - Regras de vida espiritual
- `LifeRuleStep` - Passos/práticas de cada regra

### 🔧 Serviços Principais

**Calendário e Liturgia**:
- `LiturgicalCalendar` - Calcula o calendário litúrgico completo
- `Liturgical::EasterCalculator` - Calcula a Páscoa e datas móveis (algoritmo Computus)
- `Liturgical::CelebrationResolver` - Resolve precedência entre celebrações
- `Liturgical::ColorDeterminator` - Determina cores litúrgicas
- `Liturgical::SeasonDeterminator` - Identifica estações litúrgicas
- `Liturgical::TransferRules` - Regras de transferência de celebrações
- `Liturgical::Translator` - Tradução de termos litúrgicos

**Leituras e Textos**:
- `ReadingService` - Busca leituras do lecionário
- `Reading::Loc2015Service` - Leituras específicas do LOC 2015
- `CollectService` - Busca coletas apropriadas
- `BibleTextService` - Busca textos bíblicos completos

**Ofício Diário**:
- `DailyOfficeService` - Monta ofícios completos
- `DailyOffice::Builders::*` - Builders para cada tipo de ofício
- `DailyOffice::Components::*` - Componentes (salmos, cânticos, leituras, orações)

**Notificações**:
- `NotificationService` - Envio de notificações
- `FcmService` - Integração com Firebase Cloud Messaging
- `FirebaseAuthService` - Autenticação Firebase

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

## 📚 Documentação Adicional

Este projeto possui documentação técnica detalhada em arquivos separados:

- **[ROADMAP.md](ROADMAP.md)** - Roadmap completo de desenvolvimento do projeto (Fases 1-10)
- **[DAILY_OFFICE_GUIDE.md](DAILY_OFFICE_GUIDE.md)** - Guia completo do sistema de Ofício Diário
- **[DAILY_OFFICE_ARCHITECTURE.md](DAILY_OFFICE_ARCHITECTURE.md)** - Arquitetura técnica do Daily Office
- **[FIREBASE_SETUP.md](FIREBASE_SETUP.md)** - Configuração do Firebase Authentication
- **[NOTIFICATIONS_SETUP.md](NOTIFICATIONS_SETUP.md)** - Configuração de notificações push (FCM)
- **[PRAYER_BOOK_PREFERENCES.md](PRAYER_BOOK_PREFERENCES.md)** - Sistema de Prayer Books e preferências
- **[README_API.md](README_API.md)** - Documentação detalhada da API
- **[TODO.md](TODO.md)** - Lista de melhorias e próximos passos (veja este arquivo!)

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## ✨ Créditos

Desenvolvido com base nas **Normas para o Ano Cristão da Igreja Episcopal Anglicana do Brasil (IEAB)** e no **Livro de Oração Comum 2015**.

---

**Tecnologia a serviço da vida espiritual** 🙏
