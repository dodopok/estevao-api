# Roadmap - App de Ofício Diário Anglicano

## 📋 Visão Geral

**Objetivo**: Criar um app completo de Ofício Diário Anglicano com lecionário
**Stack**: Flutter (Frontend) + Rails 8 API (Backend)

---

## 🎯 Estado Atual (O que já existe)

### ✅ Backend Rails - Já Implementado

- [x] Modelos principais (Celebration, Collect, LectionaryReading, LiturgicalSeason, LiturgicalColor)
- [x] Serviços de calendário litúrgico (LiturgicalCalendar, EasterCalculator, CelebrationResolver)
- [x] API v1 endpoints básicos (calendar, celebrations, lectionary)
- [x] Seeds de leituras, celebrações, santos e coletas
- [x] Testes (171 testes, 613 asserções)
- [x] CI/CD com GitHub Actions
- [x] Endpoint `/api/v1/calendar/today` que retorna informações do dia

### ❌ Frontend Flutter - Não iniciado

- Nada implementado ainda

---

## 📍 FASE 1: FUNDAÇÃO DO OFÍCIO DIÁRIO (Backend)

**Objetivo**: Criar toda infraestrutura para gerar os ofícios completos

### 1.1 Modelo de Textos Litúrgicos

**Arquivo**: `app/models/liturgical_text.rb`

```ruby
# Tabela para armazenar todos os textos fixos dos ofícios
# - Sentenças de abertura
# - Confissões (longa e curta)
# - Absolvições
# - Cânticos (Venite, Jubilate, Te Deum, Benedictus, Magnificat, Nunc Dimittis)
# - Orações (Pai Nosso em diferentes versões, Sufrágios)
# - Credos (Apostólico, Niceno)
# - Despedidas
```

#### TODOs:

- [ ] Criar migration `create_liturgical_texts`
  - Campos: `slug` (string, indexed), `category` (string), `content` (text), `version` (string, default: 'loc_2015'), `language` (string, default: 'pt-BR'), `reference` (string, nullable), `audio_url` (string, nullable)
  - Index em `slug` e `category`
- [ ] Criar model `LiturgicalText` com validations
- [ ] Criar seed file `db/seeds/liturgical_texts/opening_sentences.rb`
  - Sentenças para cada temporada (Advento, Natal, Epifania, Quaresma, Páscoa, Tempo Comum)
- [ ] Criar seed file `db/seeds/liturgical_texts/confessions.rb`
  - Confissão geral (versão longa e curta)
  - Absolvição
- [ ] Criar seed file `db/seeds/liturgical_texts/canticles.rb`
  - Venite (Salmo 95)
  - Jubilate (Salmo 100)
  - Te Deum
  - Benedictus (Cântico de Zacarias)
  - Magnificat (Cântico de Maria)
  - Nunc Dimittis (Cântico de Simeão)
  - Benedicite (Cântico das Três Crianças)
- [ ] Criar seed file `db/seeds/liturgical_texts/prayers.rb`
  - Pai Nosso (versão tradicional e contemporânea)
  - Sufrágios (manhã e tarde)
  - Oração de São Crisóstomo
  - Graça
- [ ] Criar seed file `db/seeds/liturgical_texts/creeds.rb`
  - Credo Apostólico
  - Credo Niceno

### 1.2 Modelo de Salmos

**Arquivo**: `app/models/psalm.rb`

#### TODOs:

- [ ] Criar migration `create_psalms`
  - Campos: `number` (integer, indexed), `verses` (jsonb), `title` (string), `translation` (string, default: 'loc_2015'), `antiphon` (text, nullable)
  - Structure de `verses`: `[{number: 1, text: "...", hebrew_pointer: "1a"}, ...]`
- [ ] Criar model `Psalm` com validations
- [ ] Criar seed file `db/seeds/psalms.rb` (ou importar de arquivo JSON/YAML)
  - Todos os 150 salmos com versículos
  - Usar tradução LOC 2015
- [ ] Criar helper para formatar salmos com antífonas
- [ ] Criar helper para salmos responsivos (leader/congregation)

### 1.3 Modelo de Saltério (Psalm Cycle)

**Arquivo**: `app/models/psalm_cycle.rb`

#### TODOs:

- [ ] Criar migration `create_psalm_cycles`
  - Campos: `cycle_type` (string: 'weekly' ou 'monthly'), `week_number` (integer), `day_of_week` (integer 0-6), `office_type` (string: 'morning', 'evening'), `psalm_numbers` (array/jsonb), `notes` (text)
- [ ] Criar model `PsalmCycle`
- [ ] Criar seed file `db/seeds/psalm_cycle.rb`
  - Implementar ciclo semanal do LOC (comum em algumas tradições anglicanas)
  - OU ciclo de 30 dias (mais tradicional)
  - Definir quais salmos para cada dia e ofício

### 1.4 Integração com Textos Bíblicos

**Opções de implementação**:

A. Usar API externa (ex: Bible API, YouVersion API)
B. Importar textos para banco de dados local
C. Híbrido (cache local + API externa)

#### TODOs:

- [ ] Decidir estratégia de implementação
- [ ] Se API externa:
  - [ ] Criar service `BibleApiClient`
  - [ ] Implementar cache de leituras
  - [ ] Tratar erros de API
- [ ] Se banco local:
  - [ ] Criar migration `create_bible_texts`
  - [ ] Importar tradução NVI ou NTLH
  - [ ] Criar seeds
- [ ] Criar service `BibleTextService`
  - Método: `fetch_passage(reference, version: 'nvi')`
  - Retornar HTML formatado com poesia, parágrafos, etc.

### 1.5 Service: DailyOfficeService

**Arquivo**: `app/services/daily_office_service.rb`

Este é o coração do sistema - monta o ofício completo.

#### TODOs:

- [ ] Criar `DailyOfficeService` com estrutura base
  - Initialize com: `date`, `office_type` (:morning, :midday, :evening, :compline), `preferences` (hash)
  - Método principal: `call` retorna JSON completo do ofício
- [ ] Implementar `assemble_morning_prayer`
  - [ ] Sentença de abertura
  - [ ] Confissão de pecados
  - [ ] Invocação (Senhor, abre os nossos lábios)
  - [ ] Invitatório (Venite ou Jubilate) baseado na temporada
  - [ ] Salmos do dia
  - [ ] Primeira leitura (com texto completo da Bíblia)
  - [ ] Primeiro cântico (Te Deum ou Benedictus es Domine) baseado na temporada
  - [ ] Segunda leitura
  - [ ] Segundo cântico (Benedictus)
  - [ ] Credo Apostólico
  - [ ] Orações (Kyrie, Pai Nosso, Sufrágios)
  - [ ] Coletas (do dia, pela paz, pela graça)
  - [ ] Oração de São Crisóstomo
  - [ ] Despedida
- [ ] Implementar `assemble_evening_prayer`
  - [ ] Sentença de abertura
  - [ ] Confissão
  - [ ] Invocação
  - [ ] Salmos do dia (diferentes da manhã)
  - [ ] Primeira leitura
  - [ ] Magnificat
  - [ ] Segunda leitura (se houver)
  - [ ] Nunc Dimittis
  - [ ] Credo Apostólico
  - [ ] Orações
  - [ ] Coletas
  - [ ] Despedida
- [ ] Implementar `assemble_midday_prayer`
  - Estrutura mais simples (sentença, salmo, leitura breve, orações, despedida)
- [ ] Implementar `assemble_compline`
  - Estrutura própria (confissão, salmos fixos 4, 31, 91, 134, hino, leitura breve, Nunc Dimittis, orações)
- [ ] Implementar builders auxiliares:
  - [ ] `build_opening_sentence` - busca sentença da temporada
  - [ ] `build_confession` - versão longa ou curta baseada em preferências
  - [ ] `build_invitatory` - escolhe Venite ou Jubilate
  - [ ] `build_psalms` - busca salmos do ciclo + texto completo
  - [ ] `build_reading(reference)` - busca texto bíblico
  - [ ] `build_canticle(slug)` - busca cântico do banco
  - [ ] `build_creed` - Apostólico ou Niceno
  - [ ] `build_prayers` - monta seção de orações
  - [ ] `build_collects` - busca coletas do dia
  - [ ] `build_dismissal` - despedida
- [ ] Implementar `line_item` helper para estruturar cada linha com:
  - `content`: texto
  - `line_type`: 'heading', 'rubric', 'leader', 'congregation', 'reader', 'citation', 'html', 'spacer'
  - `reference`: referência bíblica (opcional)
  - `audio_id`: ID de áudio (futuro)

### 1.6 Endpoints da API para Ofícios

**Arquivo**: `app/controllers/api/v1/daily_office_controller.rb`

#### TODOs:

- [ ] Criar controller `DailyOfficeController`
- [ ] Endpoint `GET /api/v1/daily_office/today/:office_type`
  - Params: `office_type` (morning, midday, evening, compline)
  - Query params opcionais: `version`, `bible_version`, `language`
  - Retorna JSON completo do ofício
- [ ] Endpoint `GET /api/v1/daily_office/:year/:month/:day/:office_type`
  - Busca ofício de data específica
- [ ] Endpoint `GET /api/v1/daily_office/preferences`
  - Retorna opções disponíveis (versões de LOC, traduções bíblicas, etc.)
- [ ] Adicionar cache (1 dia)
- [ ] Adicionar documentação Swagger/RSwag
- [ ] Criar testes para os endpoints

### 1.7 Testes

#### TODOs:

- [ ] Criar `test/services/daily_office_service_test.rb`
  - Testar montagem de cada ofício
  - Testar diferentes datas e temporadas
  - Testar preferências (versões, traduções)
- [ ] Criar `test/controllers/api/v1/daily_office_controller_test.rb`
- [ ] Criar `test/models/liturgical_text_test.rb`
- [ ] Criar `test/models/psalm_test.rb`

---

## 📍 FASE 2: REGRAS DE VIDA (Backend)

**Objetivo**: Sistema de Regras de Vida espiritual

### 2.1 Modelos

#### TODOs:

- [ ] Criar migration `create_rules_of_life`
  - Campos: `name`, `slug`, `description`, `origin` (string: ex. "Comunidade Anglicana"), `full_text`, `icon_url`, `created_at`, `updated_at`
- [ ] Criar model `RuleOfLife`
- [ ] Criar migration `create_rule_practices`
  - Campos: `rule_of_life_id`, `category` (string: 'prayer', 'study', 'service', 'rest'), `title`, `description`, `frequency` (string: 'daily', 'weekly', 'monthly'), `order`
- [ ] Criar model `RulePractice` com `belongs_to :rule_of_life`
- [ ] Criar seeds com regras conhecidas:
  - [ ] Regra da Comunidade Franciscana Anglicana
  - [ ] Regra de São Bento (adaptada)
  - [ ] Via Contemplativa (Ordem Terceira da Sociedade de São Francisco)
  - [ ] Regra Simples (para iniciantes)

### 2.2 API de Regras

**Arquivo**: `app/controllers/api/v1/rules_of_life_controller.rb`

#### TODOs:

- [ ] Endpoint `GET /api/v1/rules_of_life` - lista todas as regras
- [ ] Endpoint `GET /api/v1/rules_of_life/:id` - detalhes de uma regra
- [ ] Endpoint `GET /api/v1/rules_of_life/:id/practices` - práticas de uma regra
- [ ] Criar serializer para formatar resposta JSON
- [ ] Adicionar testes

### 2.3 Sistema de Adoção de Regras (para usuários futuros)

**Nota**: Requer autenticação de usuários

#### TODOs (para depois):

- [ ] Criar sistema de usuários (Devise ou similar)
- [ ] Criar `UserRuleAdoption` para associar usuário à regra adotada
- [ ] Criar `UserPracticeProgress` para tracking de práticas

---

## 📍 FASE 3: DIÁRIO ESPIRITUAL (Backend)

**Objetivo**: Sistema de journaling espiritual

**Nota**: Requer autenticação de usuários

### 3.1 Modelos

#### TODOs:

- [ ] Implementar autenticação (Devise + JWT)
- [ ] Criar migration `create_journal_entries`
  - Campos: `user_id`, `date`, `title`, `content`, `mood` (enum: peaceful, joyful, troubled, etc.), `linked_office_date`, `linked_reading`, `is_private`, `tags` (array), `created_at`, `updated_at`
- [ ] Criar model `JournalEntry`
- [ ] Criar migration `create_journal_tags`
- [ ] Relacionamento many-to-many com tags

### 3.2 API do Diário

**Arquivo**: `app/controllers/api/v1/journal_entries_controller.rb`

#### TODOs:

- [ ] Endpoint `POST /api/v1/journal_entries` - criar entrada
- [ ] Endpoint `GET /api/v1/journal_entries` - listar entradas do usuário
- [ ] Endpoint `GET /api/v1/journal_entries/:id` - detalhes
- [ ] Endpoint `PUT /api/v1/journal_entries/:id` - atualizar
- [ ] Endpoint `DELETE /api/v1/journal_entries/:id` - deletar
- [ ] Endpoint `GET /api/v1/journal_entries/search` - buscar por data, tag, conteúdo
- [ ] Implementar paginação
- [ ] Implementar autorização (usuário só vê suas próprias entradas)

---

## 📍 FASE 4: PREFERÊNCIAS E CONFIGURAÇÕES (Backend)

**Objetivo**: Sistema de preferências do usuário

### 4.1 Modelos de Preferências

#### TODOs:

- [ ] Criar migration `create_user_preferences`
  - Campos: `user_id`, `loc_version` (string: 'loc_2015'), `bible_version` (string: 'nvi', 'ntlh', 'arc'), `lords_prayer_version` (string: 'traditional', 'contemporary'), `creed_version`, `language` (string: 'pt-BR', 'en'), `notification_morning`, `notification_evening`, `notification_midday`, `notification_compline`, `notification_times` (jsonb), `offline_cache_enabled`
- [ ] Criar model `UserPreference`
- [ ] Endpoint `GET /api/v1/user/preferences` - obter preferências
- [ ] Endpoint `PUT /api/v1/user/preferences` - atualizar preferências

### 4.2 Sistema de Notificações

#### TODOs:

- [ ] Criar migration `create_notification_schedules`
- [ ] Integrar com Firebase Cloud Messaging (para Flutter)
- [ ] Criar job para enviar notificações nos horários configurados
- [ ] Endpoint para registrar device token

---

## 📍 FASE 5: GAMIFICAÇÃO (Backend)

**Objetivo**: Engajar usuário com conquistas e streaks

### 5.1 Sistema de Conquistas

#### TODOs:

- [ ] Criar migration `create_achievements`
  - Campos: `slug`, `name`, `description`, `icon`, `category` (string: 'prayer', 'consistency', 'study'), `criteria` (jsonb)
  - Exemplos de conquistas:
    - "Primeira Oração" - completar primeiro ofício
    - "Semana Santa" - completar todos os ofícios da Semana Santa
    - "Guerreiro de Oração" - 7 dias consecutivos
    - "Fiel e Constante" - 30 dias consecutivos
    - "Maratonista Espiritual" - 100 dias consecutivos
    - "Explorador da Bíblia" - ler todas as leituras de um ciclo
- [ ] Criar model `Achievement`
- [ ] Criar migration `create_user_achievements`
  - Campos: `user_id`, `achievement_id`, `earned_at`, `progress` (jsonb)
- [ ] Criar service `AchievementService` para calcular conquistas

### 5.2 Sistema de Streaks

#### TODOs:

- [ ] Criar migration `create_prayer_logs`
  - Campos: `user_id`, `date`, `office_type`, `completed`, `duration_seconds`, `created_at`
- [ ] Criar model `PrayerLog`
- [ ] Criar service `StreakCalculator`
  - Calcular dias consecutivos
  - Calcular longest streak
  - Calcular total de orações
- [ ] Endpoint `GET /api/v1/user/stats` - estatísticas do usuário

### 5.3 Sistema de Pontos

#### TODOs:

- [ ] Criar migration `create_user_points`
- [ ] Definir sistema de pontos:
  - Completar ofício: 10 pontos
  - Completar os 4 ofícios do dia: 50 pontos (bônus)
  - Entrada no diário: 5 pontos
  - Manter streak de 7 dias: 100 pontos
- [ ] Endpoint `GET /api/v1/user/points`

---

## 📍 FASE 6: FLUTTER APP - SETUP E ARQUITETURA

**Objetivo**: Estruturar projeto Flutter com arquitetura limpa

### 6.1 Setup Inicial

#### TODOs:

- [ ] Criar projeto Flutter: `flutter create daily_office_app`
- [ ] Configurar `pubspec.yaml` com dependências:
  - [ ] `http` ou `dio` - requisições HTTP
  - [ ] `provider` ou `riverpod` - state management
  - [ ] `shared_preferences` - persistência local
  - [ ] `sqflite` - banco de dados local (cache offline)
  - [ ] `intl` - internacionalização
  - [ ] `flutter_local_notifications` - notificações
  - [ ] `firebase_messaging` - notificações push
  - [ ] `google_fonts` - fontes
  - [ ] `flutter_secure_storage` - armazenamento seguro (tokens)
  - [ ] `freezed` - immutable classes
  - [ ] `json_serializable` - serialização JSON
  - [ ] `go_router` - navegação
  - [ ] `cached_network_image` - cache de imagens
- [ ] Configurar estrutura de pastas:
  ```
  lib/
  ├── core/
  │   ├── constants/
  │   ├── theme/
  │   ├── utils/
  │   └── widgets/
  ├── data/
  │   ├── models/
  │   ├── repositories/
  │   └── services/
  ├── domain/
  │   ├── entities/
  │   └── repositories/
  ├── presentation/
  │   ├── screens/
  │   ├── widgets/
  │   └── providers/
  └── main.dart
  ```
- [ ] Configurar temas (cores litúrgicas)
- [ ] Configurar rotas

### 6.2 Camada de Dados

#### TODOs:

- [ ] Criar models (com freezed):
  - [ ] `DayInfo`
  - [ ] `DailyOffice`
  - [ ] `OfficeModule` (representa cada seção do ofício)
  - [ ] `OfficeLine` (representa cada linha)
  - [ ] `RuleOfLife`
  - [ ] `JournalEntry`
  - [ ] `UserPreferences`
- [ ] Criar `ApiService` - client HTTP
  - [ ] Configurar base URL
  - [ ] Implementar interceptors (auth, logging)
  - [ ] Tratar erros
- [ ] Criar repositories:
  - [ ] `CalendarRepository`
  - [ ] `DailyOfficeRepository`
  - [ ] `RulesOfLifeRepository`
  - [ ] `JournalRepository`
  - [ ] `UserRepository`

### 6.3 Cache Offline

#### TODOs:

- [ ] Criar schema do banco SQLite local
- [ ] Criar `CacheService`
- [ ] Implementar estratégia de cache:
  - Cache de 7 dias de ofícios
  - Cache de preferências
  - Cache de regras de vida
  - Sincronização quando online
- [ ] Implementar indicador de modo offline

---

## 📍 FASE 7: FLUTTER APP - TELAS PRINCIPAIS

### 7.1 Tela de Onboarding

#### TODOs:

- [ ] Criar tela de boas-vindas
- [ ] Criar wizard de configuração inicial:
  - Escolher LOC version
  - Escolher tradução da Bíblia
  - Escolher versões de orações
  - Configurar notificações
- [ ] Salvar preferências

### 7.2 Tela "Hoje"

**Baseado nos mockups**

#### TODOs:

- [ ] Criar `TodayScreen`
- [ ] Header com:
  - [ ] Data formatada
  - [ ] Dia da semana
  - [ ] Temporada litúrgica com cor
- [ ] Card de Santo do Dia
- [ ] Grid de acesso aos ofícios:
  - [ ] Matutino
  - [ ] Meio-Dia
  - [ ] Vespertino
  - [ ] Completas
  - Mostrar status (completado/pendente)
- [ ] Seção de Leituras do Dia (RCL)
  - [ ] Primeira leitura
  - [ ] Salmo
  - [ ] Segunda leitura
  - [ ] Evangelho
- [ ] Botão de acesso rápido ao Diário Espiritual
- [ ] Indicador de streak
- [ ] Implementar pull-to-refresh

### 7.3 Tela de Ofício Diário

#### TODOs:

- [ ] Criar `OfficeScreen`
- [ ] Implementar scroll suave do texto litúrgico
- [ ] Implementar formatação de texto:
  - [ ] Headings (títulos de seções)
  - [ ] Rubrics (instruções em itálico/vermelho)
  - [ ] Leader (texto do oficiante)
  - [ ] Congregation (texto da congregação - negrito)
  - [ ] Reader (leitor)
  - [ ] Citations (referências bíblicas)
  - [ ] HTML content (leituras bíblicas com formatação)
  - [ ] Spacers (espaçamento)
- [ ] Barra de progresso (% do ofício completado)
- [ ] Botão "Marcar como Completo"
- [ ] Opção de ajustar tamanho da fonte
- [ ] Opção de modo noturno
- [ ] Implementar auto-scroll (opcional)

### 7.4 Tela de Configurações

#### TODOs:

- [ ] Criar `SettingsScreen`
- [ ] Seções:
  - [ ] Preferências Litúrgicas
    - LOC version
    - Pai Nosso (tradicional/contemporâneo)
    - Credo (Apostólico/Niceno)
  - [ ] Bíblia
    - Tradução (NVI, NTLH, ARC)
  - [ ] Notificações
    - Ativar/desativar
    - Horários customizados
  - [ ] Aparência
    - Tamanho da fonte
    - Tema (claro/escuro/auto)
  - [ ] Offline
    - Ativar cache
    - Limpar cache
  - [ ] Conta
    - Login/Logout
    - Excluir conta

### 7.5 Tela de Regras de Vida

#### TODOs:

- [ ] Criar `RulesOfLifeScreen` (lista/explorar)
- [ ] Card para cada regra com:
  - Nome
  - Origem
  - Breve descrição
  - Ícone
- [ ] Criar `RuleDetailScreen`
  - Descrição completa
  - Lista de práticas categorizadas
  - Botão "Adotar esta Regra"
- [ ] Criar `MyRuleScreen` (regra adotada do usuário)
  - Checklist de práticas
  - Progresso semanal/mensal

### 7.6 Tela de Diário Espiritual

#### TODOs:

- [ ] Criar `JournalScreen` (lista de entradas)
  - Ordenar por data (mais recente primeiro)
  - Preview de cada entrada
  - Filtro por data/tag
  - Busca
- [ ] Criar `JournalEntryScreen` (criar/editar)
  - Campo de título
  - Editor de texto rico
  - Seletor de humor/mood
  - Tags
  - Link para leitura/ofício do dia
  - Botão de salvar
- [ ] Criar `JournalDetailScreen` (visualizar entrada)

---

## 📍 FASE 8: FLUTTER APP - UX E REFINAMENTOS

### 8.1 Melhorias de UX

#### TODOs:

- [ ] Implementar animações de transição suaves
- [ ] Implementar skeleton loaders durante carregamento
- [ ] Implementar error states elegantes
- [ ] Implementar empty states
- [ ] Adicionar haptic feedback
- [ ] Adicionar sound effects (opcional)
- [ ] Implementar gestos (swipe para navegar entre ofícios, etc.)

### 8.2 Gamificação (UI)

#### TODOs:

- [ ] Criar tela de Conquistas
  - Grid de conquistas
  - Progresso de cada conquista
  - Animação quando ganhar conquista
- [ ] Criar tela de Estatísticas
  - Gráfico de streaks
  - Total de orações
  - Tempo total de oração
  - Calendário de atividade (estilo GitHub)
- [ ] Implementar notificação in-app de conquista desbloqueada
- [ ] Criar widget de streak na tela "Hoje"

### 8.3 Acessibilidade

#### TODOs:

- [ ] Implementar suporte a leitores de tela
- [ ] Adicionar labels semânticos
- [ ] Garantir contraste adequado de cores
- [ ] Suporte a fontes grandes (acessibilidade)
- [ ] Testar com TalkBack (Android) e VoiceOver (iOS)

---

## 📍 FASE 9: RECURSOS AVANÇADOS

### 9.1 Áudio

#### TODOs Backend:

- [ ] Criar migration `create_audio_files`
  - Campos: `liturgical_text_id`, `url`, `duration`, `narrator`, `version`
- [ ] Upload de áudios para S3 ou similar
- [ ] Endpoint para buscar áudio por texto

#### TODOs Flutter:

- [ ] Integrar `audioplayers` ou `just_audio`
- [ ] Criar player de áudio inline no ofício
- [ ] Opção de ouvir o ofício inteiro
- [ ] Download de áudios para offline

### 9.2 Compartilhamento

#### TODOs Flutter:

- [ ] Implementar share de:
  - Leitura do dia
  - Versículo específico
  - Entrada do diário (se não privada)
  - Conquista desbloqueada
- [ ] Gerar imagens bonitas para share (quote cards)

### 9.3 Widget do iOS/Android

#### TODOs Flutter:

- [ ] Criar widget de home screen mostrando:
  - Santo do dia
  - Próximo ofício
  - Streak atual
- [ ] Atualizar widget diariamente

### 9.4 Apple Watch / Wear OS (futuro)

- [ ] Companion app para relógios
- [ ] Lembrete de oração
- [ ] Visualização de próximo ofício

---

## 📍 FASE 10: POLISH E LANÇAMENTO

### 10.1 Testes

#### TODOs Backend:

- [ ] Alcançar 90%+ cobertura de testes
- [ ] Testes de integração end-to-end
- [ ] Testes de performance
- [ ] Testes de segurança (SQL injection, XSS, etc.)

#### TODOs Flutter:

- [ ] Unit tests para models e repositories
- [ ] Widget tests para componentes
- [ ] Integration tests para fluxos críticos
- [ ] Testes em diferentes tamanhos de tela
- [ ] Testes em Android e iOS

### 10.2 Performance

#### TODOs Backend:

- [ ] Otimizar queries N+1
- [ ] Implementar eager loading
- [ ] Adicionar indices necessários
- [ ] Configurar CDN para assets estáticos
- [ ] Implementar rate limiting

#### TODOs Flutter:

- [ ] Otimizar build dos widgets
- [ ] Lazy loading de listas longas
- [ ] Comprimir imagens
- [ ] Reduzir tamanho do APK/IPA

### 10.3 Documentação

#### TODOs:

- [ ] Documentar API (Swagger completo)
- [ ] Criar guia de contribuição
- [ ] Criar changelog
- [ ] Documentar arquitetura do Flutter app
- [ ] Criar user manual / help center

### 10.4 Deploy

#### TODOs Backend:

- [ ] Deploy para produção (Render, Heroku, ou VPS)
- [ ] Configurar domínio
- [ ] Configurar SSL
- [ ] Configurar monitoring (Sentry, New Relic)
- [ ] Configurar backups automáticos do banco

#### TODOs Flutter:

- [ ] Configurar CI/CD (Codemagic, Bitrise, GitHub Actions)
- [ ] Publicar na Google Play Store
  - [ ] Criar listing
  - [ ] Screenshots
  - [ ] Descrição
  - [ ] Ícone e banner
- [ ] Publicar na Apple App Store
  - [ ] App Store Connect
  - [ ] Review guidelines
  - [ ] Screenshots
  - [ ] Descrição

### 10.5 Marketing e Lançamento

#### TODOs:

- [ ] Criar landing page
- [ ] Criar presskit
- [ ] Contatar comunidades anglicanas
- [ ] Submeter para blogs/podcasts de tecnologia cristã
- [ ] Criar redes sociais do app (Instagram, Twitter)
- [ ] Lançar versão beta fechada
- [ ] Coletar feedback
- [ ] Lançamento público (v1.0)

---

## 📊 MÉTRICAS DE SUCESSO

- [ ] 1000 downloads no primeiro mês
- [ ] 4.5+ estrelas nas lojas
- [ ] 30% de retenção em 7 dias
- [ ] 20% de retenção em 30 dias
- [ ] Feedback positivo de dioceses/paróquias anglicanas

---

## 🔄 PÓS-LANÇAMENTO (Roadmap Futuro)

### Funcionalidades Futuras

- [ ] Modo comunitário (rezar com outros)
- [ ] Grupos de estudo bíblico
- [ ] Integração com calendários locais (diocesanos)
- [ ] Suporte a outros ritos (Rito Romano, LOC Portugal, BCP inglês)
- [ ] Versão web (PWA)
- [ ] Integração com Spotify/Apple Music (música litúrgica)
- [ ] IA para sugestões de reflexão baseadas nas leituras
- [ ] Multi-idioma (inglês, espanhol)

---

## 📝 NOTAS IMPORTANTES

### Priorização

O roadmap está ordenado por dependências e importância. Sugestão de ordem:

1. **FASE 1** (crítico) - sem isso, não há ofício
2. **FASE 6 e 7** (crítico) - app básico funcional
3. **FASE 4** (importante) - preferências melhoram UX
4. **FASE 2 e 3** (importante) - diferenciais do app
5. **FASE 5 e 8** (desejável) - engajamento
6. **FASE 9** (futuro) - recursos avançados
7. **FASE 10** (essencial antes do lançamento)

### Estimativas de Tempo (muito aproximadas)

- **FASE 1**: 3-4 semanas (backend)
- **FASE 2**: 1 semana (backend)
- **FASE 3**: 1 semana (backend)
- **FASE 4**: 1 semana (backend)
- **FASE 5**: 1-2 semanas (backend)
- **FASE 6**: 1 semana (setup Flutter)
- **FASE 7**: 4-6 semanas (telas principais)
- **FASE 8**: 2-3 semanas (refinamentos)
- **FASE 9**: 3-4 semanas (recursos avançados)
- **FASE 10**: 2-3 semanas (polish)

**Total estimado: 5-7 meses** para MVP completo (trabalhando full-time)

### Stack Técnica Recomendada

**Backend**:
- Rails 8.1
- PostgreSQL
- Redis (cache)
- Sidekiq (jobs)
- AWS S3 (áudios/imagens)

**Frontend**:
- Flutter 3.x
- Riverpod (state management)
- GoRouter (navegação)
- Freezed (models)
- Dio (HTTP)
- Sqflite (cache local)

### Considerações Teológicas/Litúrgicas

- Consultar com sacerdote anglicano para validação litúrgica
- Garantir fidelidade aos textos do LOC
- Respeitar variações entre dioceses
- Permitir customização sem comprometer ortodoxia

---

**Última atualização**: 2025-11-22
**Versão do roadmap**: 1.0
