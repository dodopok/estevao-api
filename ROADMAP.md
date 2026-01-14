# Roadmap - Estêvão API & Ordo App

## 📋 Visão Geral

**Objetivo**: API completa de Ofício Diário Anglicano + App mobile Flutter
**Stack**: Rails 8.1 API (Backend) + Flutter (Frontend Mobile)

**Última atualização**: 2026-01-14

---

## 🎯 Estado Atual do Projeto

### ✅ Backend Rails - **COMPLETO PARA MVP**

O backend está **95% completo** e pronto para produção. Todos os recursos críticos para um MVP funcional estão implementados:

#### ✅ **FASE 1: FUNDAÇÃO DO OFÍCIO DIÁRIO** - COMPLETO
- [x] Model `LiturgicalText` com todos os textos fixos
  - Sentenças de abertura por temporada
  - Confissões (longa e curta)
  - Cânticos (Venite, Jubilate, Te Deum, Benedictus, Magnificat, Nunc Dimittis)
  - Orações (Pai Nosso, Sufrágios, São Crisóstomo)
  - Credos (Apostólico, Niceno)
  - Despedidas
- [x] Model `Psalm` com 150 salmos completos
- [x] Model `PsalmCycle` com ciclos semanais/mensais
- [x] Integração com textos bíblicos (12+ traduções via SQLite)
- [x] `BibleTextService` para busca de passagens
- [x] `DailyOfficeService` - montagem completa dos 4 ofícios:
  - [x] Morning Prayer (Oração da Manhã)
  - [x] Midday Prayer (Oração do Meio-Dia)
  - [x] Evening Prayer (Oração da Tarde / Vésperas)
  - [x] Compline (Completas)
- [x] Builders e componentes modulares
- [x] API endpoints:
  - `GET /api/v1/daily_office/today/:office_type`
  - `GET /api/v1/daily_office/:year/:month/:day/:office_type`
  - `GET /api/v1/daily_office/:year/:month/:day/:office_type/family`
  - `GET /api/v1/daily_office/preferences`
- [x] Testes completos (112 RSpec specs + integração)
- [x] Cache de ofícios (warm cache)

#### ✅ **FASE 2: REGRAS DE VIDA** - COMPLETO
- [x] Model `LifeRule` e `LifeRuleStep`
- [x] Seeds com regras conhecidas (Franciscana, Via Contemplativa, etc.)
- [x] API completa:
  - `GET /api/v1/life_rules` - listar
  - `GET /api/v1/life_rules/:id` - detalhes
  - `POST /api/v1/life_rules` - criar (usuários)
  - `POST /api/v1/life_rules/:id/adopt` - adotar regra
  - `POST /api/v1/life_rules/:id/approve` - aprovar (admin)
  - `GET /api/v1/life_rules/my` - minhas regras
- [x] Sistema de aprovação para regras criadas por usuários

#### ✅ **FASE 3: DIÁRIO ESPIRITUAL** - COMPLETO
- [x] Model `Journal` com suporte a:
  - Título e conteúdo
  - Data
  - Tags
  - Vinculação com ofício do dia
- [x] API de journals:
  - `POST /api/v1/journals` - criar entrada
  - `PUT /api/v1/journals/:id` - atualizar
  - `DELETE /api/v1/journals/:id` - deletar
  - `GET /api/v1/journals/:year/:month/:day` - entradas do dia
  - `GET /api/v1/journals/:year/:month` - entradas do mês
- [x] Autorização (usuário só vê seus próprios journals)

#### ✅ **FASE 4: PREFERÊNCIAS E CONFIGURAÇÕES** - COMPLETO
- [x] Autenticação com Firebase (JWT)
- [x] Model `User` com perfil completo
- [x] Model `PrayerBookUserPreference` - preferências dinâmicas por livro
- [x] Sistema de notificações push (FCM)
- [x] API de usuários:
  - `GET /api/v1/users/me` - perfil
  - `PATCH /api/v1/users/profile` - atualizar perfil
  - `PATCH /api/v1/users/preferences` - preferências gerais
  - `PATCH /api/v1/users/timezone` - timezone
  - `POST /api/v1/users/avatar` - upload avatar
  - `POST /api/v1/users/fcm_token` - registrar token push
- [x] API de notificações (admin):
  - `POST /api/v1/notifications/send` - enviar para usuários específicos
  - `POST /api/v1/notifications/broadcast` - broadcast

#### ✅ **FASE 5: GAMIFICAÇÃO (BÁSICA)** - PARCIALMENTE COMPLETO
- [x] Model `Completion` - tracking de ofícios completados
- [x] API de completions:
  - `POST /api/v1/completions` - marcar como completo
  - `DELETE /api/v1/completions/:id` - desmarcar
  - `GET /api/v1/completions/:year/:month/:day/:office_type` - verificar
  - `GET /api/v1/users/completions` - histórico
- [x] Cálculo básico de streaks
- [ ] **Pendente**: Sistema completo de conquistas (achievements)
- [ ] **Pendente**: Sistema de XP e níveis
- [ ] **Pendente**: Desafios semanais/mensais

#### ✅ **RECURSOS ADICIONAIS IMPLEMENTADOS**

**Prayer Books e Preferências Dinâmicas**:
- [x] Model `PrayerBook` (LOC 2015, BCP 1979, etc.)
- [x] Sistema de preferências dinâmicas por livro
- [x] API:
  - `GET /api/v1/prayer_books` - listar
  - `GET /api/v1/prayer_books/:code` - detalhes
  - `GET /api/v1/prayer_books/:code/preferences` - preferências

**Premium Audio (IA)**:
- [x] `ElevenlabsAudioService` - integração com ElevenLabs
- [x] `BatchAudioGeneratorService` - geração em lote
- [x] `RevenueCatService` - verificação de assinatura premium
- [x] `GenerateLiturgicalAudioJob` - job de geração
- [x] 3 vozes em português (male_1, female_1, male_2)
- [x] Sanitização de texto (remove Markdown e referências)
- [x] API:
  - `GET /api/v1/audio/voice_samples` - amostras (público)
  - `GET /api/v1/audio/url/:prayer_book/:voice/:slug` - URL do áudio (premium)
  - `POST /api/v1/subscription/verify` - verificar assinatura
  - `GET /api/v1/subscription/premium_status` - status premium
  - `GET /api/v1/admin/audio/generation_status` - status geração (admin)

**Compartilhamento de Ofícios**:
- [x] Model `SharedOffice`
- [x] API:
  - `POST /api/v1/shared_offices` - criar link de compartilhamento
  - `GET /api/v1/shared_offices/:code` - buscar ofício compartilhado

**Onboarding**:
- [x] API de onboarding:
  - `POST /api/v1/users/onboarding` - salvar progresso
  - `GET /api/v1/users/me/onboarding` - buscar status

**Infraestrutura e Qualidade**:
- [x] Calendário litúrgico completo (Easter Calculator, Celebration Resolver)
- [x] Lecionário com ciclos A, B, C
- [x] 12+ traduções da Bíblia
- [x] Sistema de cache (Solid Cache) com warm cache
- [x] Performance optimizations (N+1 queries resolvidas)
- [x] Datadog APM e monitoring
- [x] 112 RSpec specs + testes de integração
- [x] CI/CD com GitHub Actions (security scan, lint, tests)
- [x] Docker Compose para desenvolvimento
- [x] Documentação Swagger/OpenAPI
- [x] Rate limiting (Rack Attack)
- [x] Segurança (Brakeman, Bundler Audit)

### 🚧 Frontend Flutter - **EM DESENVOLVIMENTO**

O app Flutter está sendo desenvolvido em repositório separado: [ordo-app](https://github.com/dodopok/ordo-app/)

**Stack**: Flutter + Riverpod + Firebase
**Status**: Em desenvolvimento ativo, integrando com a API do backend

---

## 📍 PRÓXIMAS FASES (Prioridades)

### 🔴 **PRIORIDADE MÁXIMA: INTEGRAÇÃO BACKEND ↔ FLUTTER**

**Objetivo**: Garantir integração estável e completa entre API Rails e app Flutter

**Foco**: API stability, documentação completa, suporte a features do Flutter

#### TODOs Backend (Suporte ao Flutter):

**Estabilidade da API**
- [ ] **Swagger 100% completo** - documentar todos os endpoints
  - Parâmetros (tipos, required/optional)
  - Exemplos de request/response
  - Códigos de erro
  - Headers necessários
- [ ] **Rate limiting refinado** - proteger API em produção
  - Limites por tipo de endpoint
  - Whitelist para IPs internos
- [ ] **Erros padronizados** - formato JSON consistente
  - Criar concern `ErrorHandler`
  - Documentar códigos de erro no Swagger
- [ ] **Health check robusto** - `/api/v1/health`
  - Verificar DB, Redis, Solid Queue
  - Para monitoring e load balancers

**Suporte a Offline-First**
- [ ] **Endpoint de sincronização** - `GET /api/v1/sync?days=7`
  - Retornar todos os dados para X dias
  - Calendário + ofícios + leituras + preferências
  - Permite app funcionar 100% offline
- [ ] **Paginação consistente** - todos os endpoints de listagem
  - Usar `pagy` ou `kaminari`
  - Meta: total, per_page, current_page, total_pages
- [ ] **Cache HTTP** - `Cache-Control` headers
  - Calendário: 12h-24h
  - Ofícios: 12h-24h
  - Reduz latência e uso de dados

**Recursos para Flutter**
- [ ] **Estatísticas de usuário** - `GET /api/v1/users/stats`
  - Streaks, total de orações, favoritos
  - Para telas de perfil e gamificação
- [ ] **Versículo do dia** - `GET /api/v1/bible/verse-of-the-day`
  - Conteúdo inspirador diário
- [ ] **Busca de versículos** - `GET /api/v1/bible/search?q=`
  - Full-text search em textos bíblicos

**Performance e Confiabilidade**
- [ ] **Testes E2E expandidos** - 50+ integration tests
  - Fluxos completos: auth → preferences → offices
- [ ] **Indexes otimizados** - queries < 50ms
  - Análise com `bullet` gem
- [ ] **Jobs em background** - notificações broadcast
  - Evitar timeouts em operações pesadas

---

### 🟡 **PRIORIDADE MÉDIA: RECURSOS ADICIONAIS (BACKEND)**

**Objetivo**: Funcionalidades que enriquecem a experiência do app

#### TODOs Backend:

**Sistema de Conquistas**
- [ ] Criar model `Achievement` e `UserAchievement`
- [ ] Definir conquistas:
  - 🌅 Primeira Luz (primeira manhã)
  - 🔥 Guerreiro (7 dias)
  - 💪 Fiel (30 dias)
  - 🏆 Maratonista (100 dias)
  - ✝️ Caminhada Santa (Semana Santa completa)
- [ ] Service `AchievementCalculator` para calcular conquistas
- [ ] Endpoints:
  - `GET /api/v1/achievements` - listar todas
  - `GET /api/v1/users/achievements` - conquistas do usuário

**Recursos Sociais/Comunitários** (Futuro)
- [ ] Intenções de oração compartilhadas
  - Tabela `prayer_intentions`
  - Moderação por admin
  - API CRUD básica
- [ ] Grupos de estudo bíblico
  - Baseado no lecionário
  - Apenas para v2.0+

**Internacionalização**
- [ ] Extrair strings para `config/locales/`
- [ ] Suportar `Accept-Language` header
- [ ] Idiomas: pt-BR, en, es

---

### 🟢 **PRIORIDADE BAIXA: POLISH E PRÉ-LANÇAMENTO (BACKEND)**

**Objetivo**: Backend production-ready para lançamento do app

#### TODOs:

**Testes**
- [ ] 95%+ cobertura de testes
- [ ] 50+ testes E2E (integração)
- [ ] Performance tests (benchmarks)
- [ ] Load testing (simular 1000+ users)

**Performance**
- [ ] Otimizar queries remanescentes (N+1)
- [ ] CDN para assets de áudio (CloudFront)
- [ ] Compression (gzip/brotli) para JSONs grandes
- [ ] Database connection pooling otimizado

**Documentação**
- [ ] Swagger 100% completo
- [ ] Guia de contribuição (CONTRIBUTING.md)
- [ ] Changelog detalhado (CHANGELOG.md)
- [ ] API versioning policy

**Deploy e Infraestrutura**
- [x] Deploy em Railway ✅
- [ ] Configurar domínio custom (api.ordo.app ou similar)
- [ ] Backups automáticos do banco (diários)
- [ ] Monitoring completo (Datadog já configurado)
- [ ] Error tracking (Sentry ou similar)
- [ ] Uptime monitoring (UptimeRobot ou similar)
- [ ] Logs centralizados

**Segurança**
- [ ] Rate limiting testado em produção
- [ ] Audit log para ações administrativas
- [ ] Penetration testing básico
- [ ] Revisar permissões de usuários

---

## 📊 MÉTRICAS DE SUCESSO (BACKEND)

**Performance API**:
- [ ] P95 < 200ms (95% dos requests)
- [ ] P99 < 500ms (99% dos requests)
- [ ] 99.9% uptime
- [ ] < 0.1% error rate (5xx)

**Qualidade de Código**:
- [x] 0 offenses RuboCop ✅
- [x] 0 vulnerabilidades Brakeman ✅
- [x] CI/CD verde ✅
- [ ] 95%+ cobertura de testes
- [ ] 0 gems com vulnerabilidades conhecidas

**Integração com Flutter**:
- [ ] 100% endpoints documentados no Swagger
- [ ] Formato de erro padronizado
- [ ] Rate limiting configurado
- [ ] Cache HTTP funcionando
- [ ] Endpoint de sync para offline

**Uso da API** (pós-lançamento):
- [ ] Monitorar requests/dia (meta: 10k+/dia)
- [ ] Monitorar usuários ativos (DAU, MAU)
- [ ] Monitorar uso de premium audio
- [ ] Monitorar taxa de erro por endpoint

---

## 🔄 PÓS-LANÇAMENTO (v2.0+)

### Funcionalidades Futuras

**Social/Comunidade**:
- [ ] Modo comunitário (rezar com outros em tempo real)
- [ ] Grupos de estudo bíblico
- [ ] Intenções de oração compartilhadas

**Conteúdo**:
- [ ] Mais Prayer Books (BCP inglês, LOC Portugal)
- [ ] Multi-idioma (inglês, espanhol)
- [ ] Integração com calendários diocesanos

**Plataformas**:
- [ ] Versão web (PWA)
- [ ] Apple Watch / Wear OS
- [ ] Tablet (layout otimizado)

**IA**:
- [ ] Reflexões personalizadas baseadas em leituras (GPT)
- [ ] Busca semântica de versículos

**Integrações**:
- [ ] Spotify/Apple Music (música litúrgica)
- [ ] Google Calendar sync

---

## 📝 NOTAS IMPORTANTES

### Escopo do Roadmap

**Este roadmap foca no BACKEND (API Rails).**

O app Flutter está sendo desenvolvido em paralelo no repositório: [ordo-app](https://github.com/dodopok/ordo-app/)

**Prioridades do Backend**:
1. **Integração com Flutter** (alta): API stability, docs, sync endpoint
2. **Recursos adicionais** (média): Achievements, stats, busca de versículos
3. **Polish e produção** (baixa): Testes, performance, deploy

### Stack Técnica Final

**Backend** (Completo):
- Rails 8.1 ✅
- PostgreSQL 16 ✅
- Solid Cache/Queue/Cable ✅
- Firebase Auth + FCM ✅
- ElevenLabs (áudio) ✅
- RevenueCat (subscriptions) ✅
- Datadog (monitoring) ✅

**Frontend** (Em desenvolvimento - [ordo-app](https://github.com/dodopok/ordo-app/)):
- Flutter 3.x
- Riverpod (state)
- GoRouter (navegação)
- Freezed (models)
- Dio (HTTP)
- Sqflite (cache)
- Firebase SDK

### Considerações Teológicas

- ✅ Conteúdo validado por sacerdote anglicano
- ✅ Fidelidade ao LOC 2015
- [ ] Consultar sobre recursos comunitários antes de implementar
- [ ] Permitir customização diocesana

---

**Versão do roadmap**: 2.1
**Status**: Backend MVP completo, Flutter em desenvolvimento paralelo ([ordo-app](https://github.com/dodopok/ordo-app/))
