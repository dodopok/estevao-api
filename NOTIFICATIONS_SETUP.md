# Sistema de Notificações Push - Configuração e Uso

## ✅ Implementação Completa

O sistema de notificações push foi implementado com sucesso! Aqui está um resumo do que foi criado:

### 📦 Arquivos Criados/Modificados

#### Modelos
- ✅ `app/models/fcm_token.rb` - Gerencia tokens FCM dos usuários
- ✅ `app/models/notification_log.rb` - Registra histórico de notificações
- ✅ `app/models/user.rb` - Atualizado com novas relações e preferências

#### Migrations
- ✅ `db/migrate/20251123000001_create_fcm_tokens.rb` - Tabela de tokens FCM
- ✅ `db/migrate/20251123000002_create_notification_logs.rb` - Tabela de logs

#### Services
- ✅ `app/services/fcm_service.rb` - Integração com Firebase Cloud Messaging
- ✅ `app/services/notification_service.rb` - Lógica de negócio de notificações

#### Controllers
- ✅ `app/controllers/api/v1/users_controller.rb` - Atualizado com endpoints de FCM token
- ✅ `app/controllers/api/v1/notifications_controller.rb` - Endpoints admin de notificações

#### Jobs
- ✅ `app/jobs/broadcast_notification_job.rb` - Processa broadcast em background

#### Rake Tasks
- ✅ `lib/tasks/notifications.rake` - Tarefas de notificação (lembretes, limpeza, testes)

#### Configuração
- ✅ `config/initializers/fcm.rb` - Inicializador do FCM
- ✅ `config/routes.rb` - Novas rotas adicionadas

#### Testes
- ✅ `spec/models/fcm_token_spec.rb`
- ✅ `spec/models/notification_log_spec.rb`
- ✅ `spec/services/notification_service_spec.rb`
- ✅ `spec/requests/api/v1/fcm_tokens_spec.rb`
- ✅ `spec/requests/api/v1/notifications_spec.rb` (Swagger)
- ✅ `spec/requests/api/v1/users_spec.rb` - Atualizado com novos endpoints

---

## 🚀 Próximos Passos

### 1. Instalar Dependências

```bash
bundle install
```

### 2. Configurar Firebase

1. Acesse o [Firebase Console](https://console.firebase.google.com/)
2. Selecione seu projeto
3. Vá em **Project Settings** → **Cloud Messaging**
4. Copie o **Server Key** (Legacy server key)

### 3. Configurar Variáveis de Ambiente

Adicione ao seu `.env`:

```bash
FIREBASE_SERVER_KEY=your_firebase_server_key_here
FIREBASE_PROJECT_ID=your_project_id
```

### 4. Rodar Migrations

```bash
# Development
bin/rails db:migrate

# Production
RAILS_ENV=production bin/rails db:migrate
```

### 5. Verificar Schema

Após rodar as migrations, você terá as novas tabelas:

- **fcm_tokens**: Armazena tokens FCM dos usuários
- **notification_logs**: Registra histórico de notificações enviadas

---

## 📡 Endpoints Disponíveis

### Endpoints de Usuário (Autenticado)

#### Salvar Token FCM
```http
POST /api/v1/users/fcm_token
Authorization: Bearer <firebase_token>
Content-Type: application/json

{
  "fcm_token": "device_token_here",
  "platform": "android"  // ou "ios" ou "web"
}
```

#### Remover Token FCM
```http
DELETE /api/v1/users/fcm_token?fcm_token=device_token_here
Authorization: Bearer <firebase_token>
```

#### Atualizar Preferências de Notificação
```http
PATCH /api/v1/users/preferences
Authorization: Bearer <firebase_token>
Content-Type: application/json

{
  "preferences": {
    "notifications_enabled": true,
    "streak_reminder_enabled": true,
    "prayer_times": [
      {
        "office_id": "1",
        "office_name": "Matutino",
        "hour": 6,
        "minute": 0,
        "enabled": true
      }
    ]
  }
}
```

### Endpoints Admin (Requer admin=true em preferences)

#### Enviar Notificação para Usuários Específicos
```http
POST /api/v1/notifications/send
Authorization: Bearer <admin_firebase_token>
Content-Type: application/json

{
  "user_ids": [1, 2, 3],
  "title": "Título da notificação",
  "body": "Corpo da notificação",
  "data": {
    "type": "new_feature",
    "url": "/path/to/feature"
  }
}
```

#### Broadcast para Todos os Usuários
```http
POST /api/v1/notifications/broadcast
Authorization: Bearer <admin_firebase_token>
Content-Type: application/json

{
  "title": "Novo recurso disponível!",
  "body": "Confira as novas funcionalidades",
  "data": {
    "type": "announcement",
    "url": "/announcements/123"
  }
}
```

---

## 🔧 Rake Tasks

### Enviar Lembretes de Streak (22h)
```bash
# Envia lembretes para usuários que não completaram ofícios hoje
bundle exec rake notifications:send_streak_reminders
```

### Limpar Tokens Antigos
```bash
# Remove tokens não atualizados há mais de 60 dias
bundle exec rake notifications:cleanup_old_tokens
```

### Enviar Notificação de Teste
```bash
# Testa notificação para um usuário específico
bundle exec rake notifications:test_notification[user@example.com]
```

---

## ⏰ Configurar Cron Job (Opcional)

Para enviar lembretes de streak automaticamente às 22h:

### Usando Whenever (Recomendado)

1. Adicione ao `Gemfile`:
```ruby
gem 'whenever', require: false
```

2. Crie `config/schedule.rb`:
```ruby
set :output, "log/cron.log"

every 1.day, at: '10:00 pm' do
  rake "notifications:send_streak_reminders"
end

every 1.week, at: '3:00 am' do
  rake "notifications:cleanup_old_tokens"
end
```

3. Atualize crontab:
```bash
bundle exec whenever --update-crontab
```

### Usando Crontab Diretamente

```bash
# Editar crontab
crontab -e

# Adicionar linha (ajustar timezone conforme necessário)
0 22 * * * cd /path/to/estevao-api && RAILS_ENV=production bundle exec rake notifications:send_streak_reminders >> log/cron.log 2>&1
```

---

## 🧪 Testes

### Rodar Testes
```bash
# Todos os testes
bundle exec rspec

# Testes de notificações
bundle exec rspec spec/models/fcm_token_spec.rb
bundle exec rspec spec/models/notification_log_spec.rb
bundle exec rspec spec/services/notification_service_spec.rb
bundle exec rspec spec/requests/api/v1/fcm_tokens_spec.rb
```

### Gerar Swagger Documentation
```bash
bundle exec rake rswag:specs:swaggerize
```

Acesse a documentação em: `http://localhost:3000/api-docs`

---

## 🔐 Segurança

### Controle de Acesso Admin

O sistema verifica se `preferences["admin"] == true` para endpoints admin.

Para tornar um usuário admin:

```ruby
# Rails console
user = User.find_by(email: "admin@example.com")
user.update(preferences: user.preferences.merge("admin" => true))
```

### Rate Limiting (Recomendado)

Adicione rate limiting aos endpoints de notificação usando gems como:
- `rack-attack`
- `redis-throttle`

---

## 📊 Monitoramento

### Visualizar Logs de Notificações

```ruby
# Rails console

# Todas as notificações enviadas
NotificationLog.sent.recent.limit(10)

# Notificações falhadas
NotificationLog.failed.recent.limit(10)

# Por tipo
NotificationLog.by_type("streak_reminder").recent.limit(10)

# Por usuário
user.notification_logs.recent.limit(10)
```

### Estatísticas

```ruby
# Total de notificações enviadas hoje
NotificationLog.where("created_at >= ?", Date.today).sent.count

# Taxa de sucesso
total = NotificationLog.where("created_at >= ?", 1.week.ago).count
success = NotificationLog.where("created_at >= ?", 1.week.ago).sent.count
rate = (success.to_f / total * 100).round(2)
puts "Taxa de sucesso: #{rate}%"
```

---

## 🐛 Troubleshooting

### Notificações não estão sendo enviadas

1. ✅ Verificar se `FIREBASE_SERVER_KEY` está configurado
2. ✅ Verificar se o usuário tem tokens FCM ativos
3. ✅ Verificar se `preferences["notifications_enabled"]` não é `false`
4. ✅ Ver logs em `NotificationLog` para erros

### Token FCM inválido

Os tokens inválidos são automaticamente removidos quando o FCM retorna erro 404 ou "not-registered".

### Limpeza de Tokens Antigos

Execute periodicamente:
```bash
bundle exec rake notifications:cleanup_old_tokens
```

---

## 📚 Recursos Adicionais

- [Firebase Cloud Messaging Docs](https://firebase.google.com/docs/cloud-messaging)
- [FCM Gem Documentation](https://github.com/spacialdb/fcm)
- [Best Practices for FCM](https://firebase.google.com/docs/cloud-messaging/best-practices)

---

## 🎉 Pronto!

O sistema de notificações push está totalmente implementado e pronto para uso!

### Checklist Final

- [ ] Configurar `FIREBASE_SERVER_KEY` no ambiente
- [ ] Rodar `bundle install`
- [ ] Rodar `bin/rails db:migrate`
- [ ] Testar endpoint de salvar FCM token
- [ ] Configurar cron job para lembretes de streak
- [ ] Testar envio de notificação
- [ ] Gerar documentação Swagger
- [ ] Deploy para produção

---

**Desenvolvido para o Ordo App** 🙏
