# Firebase Authentication Setup

Este documento descreve como configurar Firebase Authentication para a API Estevão.

## 1. Criar Projeto Firebase

1. Acesse [Firebase Console](https://console.firebase.google.com/)
2. Clique em "Adicionar projeto"
3. Dê um nome ao projeto (ex: "estevao-app")
4. Siga os passos e crie o projeto

## 2. Configurar Authentication

1. No menu lateral, clique em "Authentication"
2. Clique em "Começar"
3. Na aba "Sign-in method", habilite os provedores:
   - **Email/Password** (para cadastro com email/senha)
   - **Google** (para login com Google)
   - **Facebook** (para login com Facebook)
   - **Apple** (para login com Apple ID)

### 2.1 Configurar Google Sign-In

1. Ative o provedor Google
2. Defina um email de suporte
3. Salve

### 2.2 Configurar Facebook Sign-In

1. Crie um app no [Facebook Developers](https://developers.facebook.com/)
2. Copie o App ID e App Secret
3. Cole no Firebase
4. Configure OAuth redirect URI no Facebook (fornecido pelo Firebase)

### 2.3 Configurar Apple Sign-In

1. Configure Apple Sign-In no [Apple Developer](https://developer.apple.com/)
2. Crie um Service ID
3. Configure no Firebase com os dados do Apple

## 3. Obter Project ID

1. Nas configurações do projeto (ícone de engrenagem)
2. Copie o **Project ID** (ex: "estevao-app-12345")

## 4. Configurar Aplicação Flutter

No seu app Flutter, adicione o Firebase:

```yaml
# pubspec.yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  google_sign_in: ^6.1.6
```

```dart
// Inicialize o Firebase
await Firebase.initializeApp();

// Exemplo de login com Google
final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
);

final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

// Pegue o ID Token para enviar pro backend
final idToken = await userCredential.user!.getIdToken();

// Envie para a API
final response = await http.get(
  Uri.parse('https://api.estevao.com/api/v1/users/me'),
  headers: {
    'Authorization': 'Bearer $idToken',
  },
);
```

## 5. Configurar Backend Rails

### 5.1 Definir variável de ambiente

Crie um arquivo `.env` (ou configure no seu hosting):

```bash
FIREBASE_PROJECT_ID=estevao-app-12345
```

### 5.2 Exemplo de Uso

```bash
# Teste com curl (substitua TOKEN pelo ID Token real do Firebase)
curl -X GET https://api.estevao.com/api/v1/users/me \
  -H "Authorization: Bearer TOKEN"
```

## 6. Fluxo de Autenticação

### 6.1 Endpoints Públicos (sem autenticação)
- `GET /api/v1/calendar/*` - Calendário litúrgico
- `GET /api/v1/celebrations/*` - Celebrações
- `GET /api/v1/lectionary/*` - Lecionário

### 6.2 Endpoints com Autenticação Opcional
- `GET /api/v1/daily_office/today/:office_type`
- `GET /api/v1/daily_office/:year/:month/:day/:office_type`

**Sem autenticação**: Retorna apenas os dados do ofício
**Com autenticação**: Retorna dados do ofício + dados do usuário (streak, completions)

### 6.3 Endpoints Privados (autenticação obrigatória)
- `GET /api/v1/users/me` - Perfil do usuário
- `PATCH /api/v1/users/preferences` - Atualizar preferências
- `GET /api/v1/users/completions` - Histórico de completions
- `POST /api/v1/completions` - Marcar ofício como completo
- `DELETE /api/v1/completions/:id` - Remover completion

## 7. Sistema de Streaks

### Como funciona:
1. Usuário completa um ofício (POST /api/v1/completions)
2. Sistema incrementa o streak se completou no dia anterior
3. Job diário (ResetMissedStreaksJob) roda à 1h da manhã e zera streaks de quem não completou no dia anterior
4. Regra: precisa completar pelo menos 1 ofício por dia (qualquer tipo: morning, midday, evening ou compline)

### Configurar Job Diário:

#### Opção 1: Heroku Scheduler
```bash
# No Heroku, adicione o comando:
rails runner "ResetMissedStreaksJob.perform_now"
# Agende para rodar diariamente às 1h (UTC)
```

#### Opção 2: Cron (servidor próprio)
```bash
# crontab -e
0 1 * * * cd /path/to/estevao-api && rails runner "ResetMissedStreaksJob.perform_now"
```

#### Opção 3: Gem Whenever
```ruby
# Gemfile
gem 'whenever', require: false

# config/schedule.rb
every 1.day, at: '1:00 am' do
  runner "ResetMissedStreaksJob.perform_now"
end
```

## 8. Exemplo de Resposta com Usuário Autenticado

```json
{
  "office": {
    "date": "2025-11-22",
    "office_type": "morning",
    "opening": { ... },
    "psalms": [ ... ],
    // ... resto do ofício
  },
  "user": {
    "current_streak": 7,
    "longest_streak": 15,
    "completed": false,
    "completed_at": null
  }
}
```

## 9. Estrutura de Preferências do Usuário

```json
{
  "version": "loc_2015",           // loc_2015, locb_2008, loc_1662, loc_2019
  "language": "pt-BR",             // pt-BR, en
  "bible_version": "nvi",          // nvi, nvt, naa, ara, acf, ntlh, arc
  "lords_prayer_version": "traditional",  // traditional, contemporary
  "creed_type": "apostles",        // apostles, nicene
  "confession_type": "long",       // long, short
  "notifications": true            // true, false
}
```

## Troubleshooting

### Erro: "Token verification error"
- Verifique se o FIREBASE_PROJECT_ID está configurado corretamente
- Verifique se o token não expirou (tokens Firebase expiram após 1 hora)
- No app, pegue um novo token: `await user.getIdToken(true)`

### Erro: "Public key not found"
- Cache de chaves públicas pode ter expirado
- As chaves são cacheadas por 1 hora
- Aguarde alguns minutos e tente novamente

### Erro: "Unauthorized"
- Verifique se o header está correto: `Authorization: Bearer TOKEN`
- Certifique-se de que o endpoint requer autenticação
- Verifique se o usuário está autenticado no Firebase
