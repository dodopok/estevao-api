# TODO - Próximos Passos

> **Última atualização**: 2026-01-14
>
> Este documento lista melhorias práticas e próximos passos para o backend da Estêvão API.
> O backend está **95% completo** e pronto para MVP. As tarefas abaixo são refinamentos e preparação para o Flutter app.
>
> Para o roadmap completo de longo prazo (incluindo Flutter), consulte [ROADMAP.md](ROADMAP.md).

---

## 🎯 Contexto

**Estado Atual**: Backend MVP completo e funcional
**App Flutter**: Em desenvolvimento paralelo no repo [ordo-app](https://github.com/dodopok/ordo-app/)
**Foco Deste TODO**: Polish do backend + suporte à integração com Flutter

---

## 🔴 ALTA PRIORIDADE (Integração com Flutter)

### Backend Essencial

- [ ] **Testes de Integração E2E Expandidos**
  - Atual: 27 testes de integração
  - Meta: 50+ testes cobrindo fluxos completos
  - Focar em: autenticação → preferências → ofícios → completions
  - Arquivo: `spec/integration/` ou similar
  - **Motivo**: Garantir que Flutter integre com API estável

- [ ] **Documentação Swagger 100% Completa**
  - Atual: Parcial (alguns endpoints faltando exemplos)
  - Documentar TODOS os endpoints com:
    - Parâmetros (tipos, required/optional)
    - Exemplos de request/response
    - Códigos de erro possíveis e suas causas
    - Headers necessários (Authorization)
  - Arquivo: `swagger/v1/swagger.yaml`
  - **Motivo**: Flutter precisa de documentação clara da API

- [ ] **Rate Limiting Refinado**
  - Atual: Rack Attack configurado basicamente
  - Ajustar limites por endpoint:
    - Auth endpoints: 5 req/min
    - GET endpoints: 100 req/min
    - POST endpoints: 30 req/min
  - Adicionar whitelist para IPs internos
  - Arquivo: `config/initializers/rack_attack.rb`
  - **Motivo**: Proteger API em produção

- [ ] **Health Check Robusto**
  - Atual: `/up` verifica apenas boot da app
  - Melhorar para verificar:
    - Conexão com PostgreSQL
    - Conexão com Redis (cache)
    - Status de Solid Queue (jobs)
    - Status de serviços externos (Firebase, RevenueCat) - opcional
  - Endpoint: `GET /api/v1/health`
  - **Motivo**: Monitoring confiável em produção

- [ ] **Validação de FCM Tokens**
  - Implementar job automático para limpar tokens inválidos
  - Criar `CleanupExpiredFcmTokensJob`
  - Rodar diariamente via cron
  - Remover tokens: sem uso há 60+ dias OU inválidos
  - **Motivo**: Reduzir custos de FCM e melhorar deliverability

### Suporte ao Flutter App

- [ ] **Endpoint de Sincronização Offline**
  - Novo endpoint: `GET /api/v1/sync?days=7`
  - Retornar TODOS os dados necessários para X dias:
    - Calendário (datas, celebrações, cores)
    - Ofícios completos (4 tipos por dia)
    - Leituras do lecionário
    - Textos litúrgicos
    - Preferências do usuário
  - Permite app Flutter funcionar 100% offline
  - Arquivo: `app/controllers/api/v1/sync_controller.rb`
  - **Motivo**: UX crítico para app mobile

- [ ] **Paginação Consistente**
  - Adicionar paginação para todos os endpoints de listagem:
    - `GET /api/v1/celebrations`
    - `GET /api/v1/life_rules`
    - `GET /api/v1/users/completions`
    - `GET /api/v1/journals/:year/:month`
  - Usar gem `pagy` ou `kaminari`
  - Incluir meta: `{ total, per_page, current_page, total_pages }`
  - **Motivo**: Performance e UX em listas longas

- [ ] **Erros Padronizados**
  - Criar concern `app/controllers/concerns/error_handler.rb`
  - Padronizar formato de erro JSON:
    ```json
    {
      "error": {
        "code": "UNAUTHORIZED",
        "message": "Token inválido ou expirado",
        "details": { ... }
      }
    }
    ```
  - Documentar todos os códigos de erro no Swagger
  - **Motivo**: Flutter precisa de erros previsíveis

---

## 🟡 MÉDIA PRIORIDADE (Melhorias Desejáveis)

### Performance e Otimização

- [ ] **Cache HTTP para Calendário**
  - Adicionar `Cache-Control` headers em endpoints de calendário
  - `/calendar/today`: 12 horas (muda à meia-noite)
  - `/calendar/:year/:month/:day`: 7 dias (datas passadas) ou 12 horas (futuro)
  - Usar `stale-while-revalidate`
  - **Motivo**: Reduzir carga do servidor, melhorar latência

- [ ] **Database Indexes Adicionais**
  - Analisar slow queries (usar `bullet` gem em development)
  - Adicionar indexes em:
    - `completions(user_id, date, office_type)` - composto
    - `journals(user_id, date)` - composto
    - `liturgical_texts(slug)` - já existe?
  - Rodar `EXPLAIN ANALYZE` em queries críticas
  - **Motivo**: Manter API rápida com muitos usuários

- [ ] **Background Jobs para Notificações**
  - Mover envio de notificações para background:
    - `POST /api/v1/notifications/broadcast` → enqueue job
    - Retornar imediatamente `{ status: "enqueued", job_id: "..." }`
  - Criar `BroadcastNotificationJob`
  - Processar em lotes (chunks de 100 usuários)
  - **Motivo**: Evitar timeout em broadcasts grandes

- [ ] **Compressão de Respostas**
  - Habilitar gzip/brotli para respostas JSON grandes
  - Middleware `Rack::Deflater`
  - Especialmente para: ofícios completos, sync endpoint
  - **Motivo**: Reduzir uso de dados móveis

### Recursos Novos (Backend)

- [ ] **Sistema de Conquistas (Achievements)**
  - Criar models:
    - `Achievement` (slug, name, description, icon, criteria JSONB)
    - `UserAchievement` (user_id, achievement_id, earned_at, progress)
  - Seeds com conquistas:
    - 🌅 "Primeira Luz" - primeira manhã
    - 🔥 "Guerreiro de Oração" - 7 dias consecutivos
    - 💪 "Fiel e Constante" - 30 dias consecutivos
    - 🏆 "Maratonista Espiritual" - 100 dias consecutivos
    - ✝️ "Caminhada Santa" - completar Semana Santa
    - 🎄 "Advento Dedicado" - todo Advento
  - Service `AchievementCalculator`
  - Endpoints:
    - `GET /api/v1/achievements` - listar todas
    - `GET /api/v1/users/achievements` - conquistas do usuário
  - **Motivo**: Gamificação aumenta engajamento

- [ ] **Estatísticas de Usuário**
  - Endpoint: `GET /api/v1/users/stats`
  - Retornar:
    - Total de ofícios completados
    - Streak atual (dias consecutivos)
    - Longest streak
    - Ofício favorito (mais completado)
    - Taxa de conclusão por tipo de ofício
    - Gráfico de atividade mensal (last 12 months)
  - Cache: 1 hora
  - **Motivo**: Visualização de progresso motiva usuários

- [ ] **Busca de Versículos**
  - Endpoint: `GET /api/v1/bible/search?q=amor&version=nvi`
  - Full-text search nos textos bíblicos
  - Usar `pg_search` gem ou raw SQL `to_tsvector`
  - Paginação (max 50 resultados)
  - Highlight de matches
  - **Motivo**: Feature útil para estudo bíblico

- [ ] **Versículo do Dia**
  - Endpoint: `GET /api/v1/bible/verse-of-the-day`
  - Retornar versículo inspirador diário
  - Lógica: curadoria manual ou seleção aleatória
  - Seeds com lista de versículos populares
  - Cache: 24 horas
  - **Motivo**: Conteúdo diário adicional

### Código e Qualidade

- [ ] **Refatorar DailyOfficeService**
  - Atual: Arquivo muito grande (~500+ linhas)
  - Quebrar em sub-services:
    - `DailyOffice::MorningPrayerBuilder`
    - `DailyOffice::EveningPrayerBuilder`
    - `DailyOffice::MiddayPrayerBuilder`
    - `DailyOffice::ComplineBuilder`
  - Manter `DailyOfficeService` como orquestrador
  - **Motivo**: Manutenibilidade

- [ ] **Concerns Reutilizáveis**
  - Criar `Cacheable` concern para padronizar cache
  - Criar `Paginatable` concern para padronizar paginação
  - Criar `ApiErrorHandler` concern
  - **Motivo**: DRY, consistência

- [ ] **Aumentar Cobertura de Testes**
  - Atual: 112 RSpec specs
  - Meta: 200+ specs
  - Focar em:
    - Jobs (GenerateLiturgicalAudioJob, etc.)
    - Services novos (RevenueCatService, etc.)
    - Edge cases em controllers
  - Rodar `COVERAGE=true bundle exec rspec`
  - Meta: 95%+ cobertura
  - **Motivo**: Confiança em refatorações

---

## 🟢 BAIXA PRIORIDADE (Futuro)

### Recursos Avançados

- [ ] **Intenções de Oração Compartilhadas**
  - Tabela `prayer_intentions`
  - Moderação por admin
  - API CRUD básica
  - **Quando**: Pós-lançamento, se houver demanda

- [ ] **Grupos de Estudo Bíblico**
  - Tabelas: `study_groups`, `group_members`, `group_notes`
  - Baseado no lecionário
  - **Quando**: v2.0+

- [ ] **Internacionalização (i18n)**
  - Extrair strings para `config/locales/`
  - Suportar `Accept-Language` header
  - Idiomas: pt-BR, en, es
  - **Quando**: Se expandir internacionalmente

- [ ] **GraphQL API**
  - Alternativa ao REST
  - Queries mais flexíveis
  - **Quando**: Se Flutter requisitar (provavelmente não)

- [ ] **Webhooks**
  - Sistema de webhooks para eventos:
    - Nova celebração principal
    - Mudança de estação litúrgica
    - Novo conteúdo de áudio
  - **Quando**: Se sites de paróquias integrarem

### Infraestrutura

- [ ] **CDN para Áudio**
  - Mover arquivos de áudio para CloudFront ou similar
  - Atualizar `audio_urls` no banco
  - **Quando**: Custos de bandwidth aumentarem

- [ ] **Backup Automático do Banco**
  - Configurar backups diários via Railway
  - Testar restore periodicamente
  - **Quando**: Antes do lançamento público

- [ ] **Staging Environment**
  - Ambiente separado para testes
  - CI/CD: deploy automático para staging
  - **Quando**: Equipe crescer ou beta testers

---

## 🐛 Bugs Conhecidos (Nenhum Crítico)

### Menores
- [ ] **Timezone Handling**: Verificar se `calendar/today` respeita timezone do usuário (se enviado via header)
- [ ] **Life Rules Sorting**: Ordenação inconsistente na listagem

---

## 📋 Checklist Pré-Lançamento (Backend)

Antes de lançar o app publicamente, garantir:

- [ ] Todos os endpoints documentados no Swagger
- [ ] Rate limiting configurado e testado
- [ ] Health check funcionando
- [ ] FCM tokens sendo limpos automaticamente
- [ ] Backups automáticos do banco configurados
- [ ] Monitoring (Datadog) configurado em produção
- [ ] Erros sendo rastreados (Sentry ou similar)
- [ ] SSL configurado (Railway já faz isso)
- [ ] Variáveis de ambiente em produção (Firebase, RevenueCat, ElevenLabs)
- [ ] Seeds de produção rodados (celebrações, coletas, textos)
- [ ] Cache funcionando (Solid Cache + Redis)
- [ ] Jobs rodando (Solid Queue)
- [ ] Testes passando (CI verde)
- [ ] RuboCop limpo (0 offenses)
- [ ] Brakeman limpo (0 vulnerabilidades)
- [ ] Bundler Audit limpo (gems atualizadas)
- [ ] Performance testada (< 200ms para 95% dos requests)

---

## 📊 Métricas de Sucesso (Backend)

Acompanhar:

- **Performance**:
  - [ ] P95 < 200ms (95% dos requests em menos de 200ms)
  - [ ] P99 < 500ms
  - [ ] Uptime > 99.9%

- **Qualidade**:
  - [x] 0 offenses RuboCop ✅
  - [x] 0 vulnerabilidades Brakeman ✅
  - [x] CI/CD verde ✅
  - [ ] 95%+ cobertura de testes

- **Erros**:
  - [ ] < 0.1% error rate (5xx)
  - [ ] 0 erros não rastreados

- **Usuários** (pós-Flutter):
  - [ ] Monitorar uso de API (requests/dia)
  - [ ] Monitorar users ativos (DAU, MAU)
  - [ ] Monitorar uso de premium audio

---

## 🔧 Comandos Úteis

**Testes e Qualidade**:
```bash
# Rodar testes
docker-compose exec -T web bundle exec rspec

# Cobertura de testes
docker-compose exec -T web COVERAGE=true bundle exec rspec

# RuboCop
docker-compose exec -T web bundle exec rubocop

# Segurança
docker-compose exec -T web bundle exec brakeman --no-pager
docker-compose exec -T web bundle exec bundler-audit
```

**Database**:
```bash
# Console
docker-compose exec web bundle exec rails c

# Migrations
docker-compose exec -T web bundle exec rails db:migrate

# Seeds
docker-compose exec -T web bundle exec rails db:seed
```

**Cache**:
```bash
# Warm cache
docker-compose exec -T web bundle exec rails cache:warm

# Stats
docker-compose exec -T web bundle exec rails cache:stats

# Clear
docker-compose exec -T web bundle exec rails cache:clear_all
```

**Áudio**:
```bash
# Estatísticas
docker-compose exec -T web bundle exec rails audio:stats

# Gerar áudio
docker-compose exec -T web bundle exec rails audio:generate[loc_2015,male_1]
```

---

## 📚 Documentação Relacionada

- **[ROADMAP.md](ROADMAP.md)** - Roadmap completo (backend + Flutter)
- **[README.md](README.md)** - Visão geral e setup
- **[CLAUDE.md](CLAUDE.md)** - Instruções para AI assistants
- **[DAILY_OFFICE_GUIDE.md](DAILY_OFFICE_GUIDE.md)** - Guia do sistema de Ofício
- **[DAILY_OFFICE_ARCHITECTURE.md](DAILY_OFFICE_ARCHITECTURE.md)** - Arquitetura técnica
- **[PRAYER_BOOK_PREFERENCES.md](PRAYER_BOOK_PREFERENCES.md)** - Sistema de preferências

---

## 💡 Contribuindo

Se você deseja contribuir:

1. Escolha uma tarefa marcada como [ ] acima
2. Crie uma branch: `git checkout -b feature/nome-da-feature`
3. Implemente com testes
4. Rode RuboCop e corrija violations
5. Abra um Pull Request

---

**Última atualização**: 2026-01-14
**Status**: Backend 95% completo, integrando com Flutter ([ordo-app](https://github.com/dodopok/ordo-app/))
