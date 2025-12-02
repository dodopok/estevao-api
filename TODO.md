# TODO - Melhorias e Próximos Passos

> **Última atualização**: 2025-12-02
>
> Este documento lista melhorias práticas, bugs conhecidos e próximos passos para o desenvolvimento da Estêvão API.
> Para o roadmap completo de longo prazo, consulte [ROADMAP.md](ROADMAP.md).

## 🎯 Prioridades Imediatas

### 🔴 Alta Prioridade

- [ ] **Testes para Bible Text Service**
  - Adicionar testes de integração para verificação de traduções
  - Testar fallbacks quando tradução não está disponível
  - Arquivo: `spec/services/bible_text_service_spec.rb`

- [ ] **Validação de Tokens FCM**
  - Implementar limpeza automática de tokens inválidos/expirados
  - Adicionar job para remover tokens antigos (> 6 meses sem uso)
  - Arquivo: `app/jobs/cleanup_expired_fcm_tokens_job.rb`

- [ ] **Rate Limiting para API**
  - Adicionar rate limiting por IP/usuário
  - Usar gem `rack-attack` ou similar
  - Configurar limites: 100 req/min para autenticados, 20 req/min para não-autenticados
  - Arquivo: `config/initializers/rack_attack.rb`

- [ ] **Logging e Monitoramento**
  - Integrar com Sentry ou similar para tracking de erros
  - Adicionar métricas de performance (tempo de resposta por endpoint)
  - Implementar health check mais robusto (verificar conexão com DB, Redis, etc.)

### 🟡 Média Prioridade

- [ ] **Cache de Respostas da API**
  - Implementar cache HTTP para endpoints de calendário (que mudam apenas diariamente)
  - Usar `Cache-Control` headers adequados
  - Cache de 24h para `/calendar/today`, 1 semana para datas passadas

- [ ] **Paginação Consistente**
  - Adicionar paginação para todos os endpoints de listagem
  - Usar gem `pagy` ou `kaminari`
  - Incluir meta informação (total, current_page, total_pages) nas respostas

- [ ] **Versionamento de API Melhorado**
  - Preparar estrutura para API v2
  - Adicionar deprecation warnings nos headers
  - Documentar política de versionamento

- [ ] **Testes de Integração E2E**
  - Expandir suite de testes de integração (atualmente 27 testes)
  - Cobrir fluxos completos de usuário (signup → preferências → completions → notificações)
  - Meta: 100+ testes de integração

- [ ] **Documentação Swagger/OpenAPI Completa**
  - Completar especificações de todos os endpoints
  - Adicionar exemplos de request/response
  - Documentar códigos de erro e suas causas
  - Arquivo: `swagger/v1/swagger.yaml`

### 🟢 Baixa Prioridade

- [ ] **Internacionalização (i18n)**
  - Preparar API para múltiplos idiomas (português, inglês, espanhol)
  - Extrair strings hard-coded para arquivos de locale
  - Permitir header `Accept-Language`

- [ ] **GraphQL API (opcional)**
  - Avaliar implementação de GraphQL como alternativa ao REST
  - Permitir queries mais flexíveis para frontends

- [ ] **Webhooks**
  - Implementar sistema de webhooks para eventos importantes
  - Eventos: nova celebração, mudança de estação litúrgica, etc.

---

## 🐛 Bugs Conhecidos

### Críticos
- Nenhum bug crítico conhecido no momento

### Menores
- [ ] **Timezone handling**: Verificar se todas as datas estão sendo processadas no timezone correto (especialmente `calendar/today`)
- [ ] **Life Rules sorting**: Ordenação de regras de vida não está consistente na listagem

---

## ✨ Novas Funcionalidades Sugeridas

### 📊 Analytics e Estatísticas

- [ ] **Dashboard de Estatísticas do Usuário**
  - Endpoint: `GET /api/v1/users/stats`
  - Retornar:
    - Total de ofícios completados
    - Streak atual (dias consecutivos)
    - Longest streak
    - Ofícios favoritos (mais completados)
    - Gráfico de atividade mensal
    - Taxa de conclusão por tipo de ofício

- [ ] **Streaks e Motivação**
  - Calcular streaks automaticamente
  - Enviar notificação de parabéns ao atingir marcos (7 dias, 30 dias, 100 dias)
  - Sistema de "don't break the chain"

### 🎮 Gamificação

- [ ] **Sistema de Conquistas (Achievements)**
  - Tabela `achievements` e `user_achievements`
  - Conquistas sugeridas:
    - 🌅 "Primeira Luz" - completar primeira Oração da Manhã
    - 🌙 "Fim do Dia" - completar primeira Completas
    - 🔥 "Guerreiro de Oração" - 7 dias consecutivos
    - 💪 "Fiel e Constante" - 30 dias consecutivos
    - 🏆 "Maratonista Espiritual" - 100 dias consecutivos
    - 📖 "Leitor Dedicado" - ler todas as leituras de um ciclo litúrgico completo
    - ✝️ "Caminhada Santa" - completar todos os ofícios da Semana Santa
    - 🎄 "Espírito Natalino" - completar ofícios durante toda a quadra de Natal

- [ ] **Níveis de Usuário**
  - Sistema de XP baseado em ofícios completados
  - Níveis: Iniciante → Praticante → Dedicado → Devoto → Santo/a
  - Badge visual para cada nível

- [ ] **Desafios Semanais/Mensais**
  - Desafio: "Complete os 4 ofícios em um dia"
  - Desafio: "Leia todos os salmos desta semana"
  - Recompensas em XP ou conquistas especiais

### 🤝 Recursos Sociais/Comunitários

- [ ] **Orações em Grupo/Comunidade** (versão simplificada)
  - Criar "salas" de oração onde múltiplos usuários podem indicar que estão orando juntos
  - Mostrar quantas pessoas estão orando agora
  - Sem chat - apenas presença e lista de nomes

- [ ] **Intenções de Oração Compartilhadas**
  - Endpoint para usuários compartilharem intenções de oração
  - Moderação por admin
  - Pode ser usado durante os ofícios

- [ ] **Grupos de Estudo Bíblico**
  - Criar grupos baseados nas leituras do lecionário
  - Membros podem adicionar notas/reflexões sobre as leituras
  - Visível apenas para membros do grupo

### 📖 Melhorias em Leituras e Textos

- [ ] **Notas e Highlights**
  - Permitir usuários salvarem notas em leituras específicas
  - Sistema de highlights (marcar versículos favoritos)
  - Tabelas: `user_notes`, `user_highlights`

- [ ] **Histórico de Leituras**
  - Rastrear quais leituras bíblicas o usuário já leu
  - Progress bar: "Você leu X% do Novo Testamento"
  - Badge ao completar livros inteiros da Bíblia

- [ ] **Busca de Versículos**
  - Endpoint: `GET /api/v1/bible/search?q=amor`
  - Busca full-text nos textos bíblicos
  - Retornar versículos que contenham a palavra/frase

- [ ] **Versículo do Dia**
  - Endpoint: `GET /api/v1/bible/verse-of-the-day`
  - Retornar um versículo inspirador diário
  - Pode ser aleatório ou seguir uma curadoria

### 🔔 Melhorias em Notificações

- [ ] **Notificações Contextuais**
  - "Faltam 10 minutos para a Oração da Tarde" (baseado em preferências)
  - "Você está próximo de quebrar seu streak de X dias!"
  - "Hoje é festa de São [Nome]!"

- [ ] **Preferências Granulares de Notificação**
  - Permitir ativar/desativar por tipo de notificação
  - Permitir "quiet hours" (não enviar notificações durante certos horários)
  - Smart notifications (não enviar se o usuário já completou o ofício)

- [ ] **Digest Semanal**
  - Email ou notificação semanal com resumo:
    - Ofícios completados essa semana
    - Próximas celebrações importantes
    - Versículo/reflexão da semana

### 🎨 Customização e Preferências

- [ ] **Temas Visuais (Backend)**
  - Endpoint para retornar configurações de tema baseadas na estação litúrgica
  - Paletas de cores para frontend (roxo no Advento, branco no Natal, etc.)
  - Permite app ajustar UI automaticamente

- [ ] **Ordem Customizada de Ofícios**
  - Permitir usuário reordenar ofícios na tela principal
  - Salvar preferência de ordem
  - Alguns podem preferir: Manhã → Meio-Dia → Tarde → Completas
  - Outros: apenas Manhã e Tarde

- [ ] **Favoritos/Bookmarks**
  - Permitir marcar celebrações, coletas ou salmos como favoritos
  - Endpoint: `GET /api/v1/users/favorites`
  - Tipos: celebration, collect, psalm, prayer

### 📱 Suporte Mobile/Offline

- [ ] **Sync API para Offline-First Apps**
  - Endpoint que retorna todos os dados necessários para X dias
  - `GET /api/v1/sync?days=7`
  - Retornar: calendário, ofícios, leituras, textos bíblicos
  - Permite apps funcionarem completamente offline

- [ ] **Partial Updates**
  - Suportar `If-Modified-Since` headers
  - Retornar apenas dados que mudaram desde última sincronização
  - Reduz uso de dados móveis

### 📚 Conteúdo Educacional

- [ ] **Glossário Litúrgico**
  - Tabela `glossary_terms`
  - Explicação de termos litúrgicos (ex: "Coleta", "Proper", "Antífona")
  - Endpoint: `GET /api/v1/glossary`

- [ ] **Sobre os Santos**
  - Expandir dados de celebrações com biografia de santos
  - Adicionar campo `biography` (text) na tabela celebrations
  - Imagens dos santos (URLs)

- [ ] **Guias e Tutoriais**
  - Endpoint retornando guias sobre:
    - "Como rezar a Oração da Manhã"
    - "Entendendo o Ano Litúrgico"
    - "O que é uma Coleta?"
  - Tabela: `guides` (title, content, category)

### 🔐 Segurança e Admin

- [ ] **Audit Log**
  - Registrar ações administrativas
  - Tabela: `audit_logs`
  - Rastrear: criação/aprovação de life rules, envio de notificações broadcast

- [ ] **Dashboard Admin**
  - Endpoints para estatísticas agregadas:
    - Total de usuários ativos
    - Usuários novos por semana
    - Ofícios mais populares
    - Taxa de retenção
  - Endpoint: `GET /api/v1/admin/stats` (requer admin)

- [ ] **Moderação de Conteúdo**
  - Sistema de review para life rules criadas por usuários
  - Sistema de reports para conteúdo inapropriado

---

## 🔧 Refatorações e Melhorias Técnicas

### Code Quality

- [ ] **Rubocop: Resolver Offenses Remanescentes**
  - Executar `rubocop -a` para auto-correções
  - Resolver manualmente offenses complexas
  - Meta: 0 offenses

- [ ] **Simplificar Services Complexos**
  - `DailyOfficeService` está muito grande - considerar quebrar em sub-services
  - Aplicar padrão Service Object consistentemente

- [ ] **Concerns Reutilizáveis**
  - Criar concerns para lógica comum (ex: `Cacheable`, `Paginatable`)
  - Reduzir duplicação de código

### Performance

- [ ] **Database Indexes**
  - Analisar slow queries (usar `bullet` gem)
  - Adicionar indexes onde necessário
  - Especialmente em foreign keys e campos de busca

- [ ] **N+1 Queries**
  - Usar gem `bullet` em development para detectar
  - Adicionar `includes` onde necessário
  - Revisar controllers e services

- [ ] **Background Jobs**
  - Mover operações pesadas para background jobs:
    - Envio de notificações em massa
    - Cálculo de estatísticas agregadas
    - Limpeza de dados antigos

- [ ] **Database Connection Pooling**
  - Otimizar configuração de pool de conexões
  - Especialmente importante para deploy em produção

### Testing

- [ ] **Aumentar Cobertura de Testes**
  - Atual: 171 testes
  - Meta: 300+ testes
  - Áreas com pouca cobertura:
    - Jobs (background jobs)
    - Alguns services novos
    - Edge cases em controllers

- [ ] **Testes de Performance**
  - Adicionar benchmarks para operações críticas
  - Garantir endpoints respondem em < 200ms

- [ ] **Factory Bot: Melhorar Factories**
  - Adicionar traits úteis
  - Factories para todos os modelos
  - Sequences para evitar duplicatas

### DevOps e Infraestrutura

- [ ] **Docker Compose para Desenvolvimento**
  - Melhorar `docker-compose.yml`
  - Adicionar Redis para cache
  - Adicionar Sidekiq para jobs
  - Seed automático ao subir containers

- [ ] **CI/CD: Deploy Automático**
  - Configurar deploy automático para staging após merge na `main`
  - Deploy para produção apenas com tag de versão

- [ ] **Ambiente de Staging**
  - Configurar ambiente de staging separado
  - Testar features antes de produção

- [ ] **Backup Automático**
  - Configurar backups automáticos do banco de dados
  - Testar processo de restore

---

## 📋 Manutenção de Dados

### Seeds e Fixtures

- [ ] **Expandir Seeds de Leituras**
  - Atualmente tem algumas leituras, mas não está completo
  - Popular todas as leituras dos 3 ciclos (A, B, C)
  - Adicionar leituras de dias de semana (anos pares/ímpares)

- [ ] **Seeds de Coletas**
  - Verificar se todas as celebrações têm coletas
  - Adicionar coletas alternativas
  - Coletas para estações litúrgicas

- [ ] **Mais Santos e Comemorações**
  - Expandir calendário de santos
  - Adicionar festivais menores (lesser feasts)
  - Incluir santos relevantes para dioceses específicas

- [ ] **Traduções de Textos Bíblicos**
  - Atualmente suporta 12+ traduções
  - Verificar integridade dos dados
  - Adicionar traduções faltantes se necessário

---

## 🎯 Métricas de Sucesso (KPIs)

Para acompanhar o progresso e saúde da API:

- **Performance**:
  - [ ] 95% dos endpoints respondem em < 200ms
  - [ ] 99.9% uptime
  - [ ] 0 erros 5xx por semana

- **Cobertura de Testes**:
  - [ ] 90%+ cobertura de código
  - [ ] 300+ testes totais
  - [ ] 100% de endpoints críticos com testes de integração

- **Qualidade de Código**:
  - [ ] 0 offenses do Rubocop
  - [ ] 0 vulnerabilidades de segurança (Brakeman)
  - [ ] Todas as gems atualizadas (sem vulnerabilidades conhecidas)

- **Documentação**:
  - [ ] 100% dos endpoints documentados no Swagger
  - [ ] Todos os models com comentários explicativos
  - [ ] README atualizado mensalmente

- **Usuários** (quando em produção):
  - [ ] 1000+ usuários ativos
  - [ ] 30% de retenção em 7 dias
  - [ ] 20% de retenção em 30 dias
  - [ ] 4.5+ estrelas de avaliação no app

---

## 🚀 Roadmap de Versões

### v1.1 (Próxima release menor)
- Rate limiting
- Paginação consistente
- Cache de respostas
- Documentação Swagger completa
- Testes: 250+

### v1.2
- Sistema de conquistas
- Estatísticas de usuário
- Notas e highlights
- Busca de versículos

### v2.0 (Breaking changes)
- GraphQL API
- Recursos sociais/comunitários
- Internacionalização completa
- Novo sistema de autenticação (se necessário)

---

## 💡 Ideias para Explorar (Brainstorm)

Ideias que precisam de mais pesquisa/validação:

- **IA para Reflexões**: Usar LLM para gerar reflexões personalizadas baseadas nas leituras do dia
- **Integração com Calendários**: Sincronizar celebrações com Google Calendar, Apple Calendar
- **Widget para Sites de Paróquias**: Código embed para mostrar calendário litúrgico em sites
- **Podcast de Ofícios**: Gerar áudio dos ofícios automaticamente usando Text-to-Speech
- **Modo "Rezar Junto"**: Video/audio call integrado para grupos rezarem juntos
- **Integração com Spotify**: Playlists de música litúrgica para cada estação
- **API Pública**: Disponibilizar API publicamente para outros desenvolvedores (com rate limits)
- **Versão Web (PWA)**: Frontend web progressivo que funciona offline
- **Outros Ritos**: Suportar BCP (Book of Common Prayer) inglês, LOC Portugal, etc.

---

## 📝 Notas Importantes

- Consultar com líder litúrgico/sacerdote antes de implementar mudanças que afetem conteúdo litúrgico
- Priorizar funcionalidades que aumentem engajamento e retenção de usuários
- Manter foco na simplicidade - evitar over-engineering
- Sempre adicionar testes para novas funcionalidades
- Documentar mudanças de API que quebrem compatibilidade

---

**Contribua!** Se você tem sugestões de melhorias, abra uma issue ou PR no GitHub.
