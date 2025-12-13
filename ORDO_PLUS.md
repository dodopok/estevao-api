# Ordo+ (Premium Features)

Documentação técnica para implementação das funcionalidades premium no aplicativo Flutter.

## 📋 Visão Geral

**Ordo+** é a assinatura premium que desbloqueia recursos exclusivos:

- 🎵 **Áudio dos Ofícios**: Ofícios completos narrados com vozes naturais de IA
- 🎙️ **Escolha de Voz**: 3 vozes em português brasileiro (2 masculinas, 1 feminina) - por enquanto só está completo a male_1
- 📱 **Sincronização**: Preferências sincronizadas entre dispositivos

## 🏗️ Arquitetura da Assinatura

### Fluxo Completo

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   App iOS   │         │  RevenueCat  │         │ Estêvão API │
│  / Android  │────────▶│   Platform   │◀────────│   Backend   │
└─────────────┘         └──────────────┘         └─────────────┘
      │                        │                         │
      │  1. Compra/Restaura    │                         │
      │───────────────────────▶│                         │
      │                        │                         │
      │  2. Retorna User ID    │                         │
      │◀───────────────────────│                         │
      │                        │                         │
      │  3. Verifica Premium   │                         │
      │────────────────────────┼────────────────────────▶│
      │                        │  4. Consulta RevenueCat │
      │                        │◀────────────────────────│
      │                        │  5. Retorna Status      │
      │                        │─────────────────────────▶│
      │  6. Status Premium     │                         │
      │◀────────────────────────────────────────────────│
      │                        │                         │
      │  7. Requisita Ofício   │                         │
      │─────────────────────────────────────────────────▶│
      │                        │                         │
      │  8. JSON + audio_urls  │                         │
      │◀─────────────────────────────────────────────────│
```

## 🔧 Implementação no App

### 1. Setup do RevenueCat

#### iOS (Podfile)
```ruby
pod 'RevenueCat', '~> 4.0'
```

#### Android (build.gradle)
```gradle
implementation 'com.revenuecat.purchases:purchases:7.0.0'
```

#### Flutter (pubspec.yaml)
```yaml
dependencies:
  purchases_flutter: ^6.0.0
```

### 2. Inicialização

```dart
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static const String _apiKeyIOS = 'appl_xxxxxxxxxxxxx';
  static const String _apiKeyAndroid = 'goog_xxxxxxxxxxxxx';
  
  static Future<void> initialize() async {
    await Purchases.setLogLevel(LogLevel.debug);
    
    PurchasesConfiguration configuration;
    if (Platform.isIOS) {
      configuration = PurchasesConfiguration(_apiKeyIOS);
    } else if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(_apiKeyAndroid);
    }
    
    await Purchases.configure(configuration);
  }
}
```

### 3. Verificação de Premium

Após compra ou restauração, enviar para o backend:

```dart
Future<PremiumStatus> verifyPremium() async {
  try {
    // 1. Obter informações do RevenueCat
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    String revenueCatUserId = customerInfo.originalAppUserId;
    
    // 2. Enviar para o backend
    final response = await http.post(
      Uri.parse('${baseUrl}/api/v1/subscription/verify'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $firebaseToken',
      },
      body: jsonEncode({
        'revenue_cat_user_id': revenueCatUserId,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PremiumStatus(
        isPremium: data['premium'],
        expiresAt: data['expires_at'] != null 
          ? DateTime.parse(data['expires_at']) 
          : null,
      );
    }
    
    throw Exception('Failed to verify premium status');
  } catch (e) {
    print('Error verifying premium: $e');
    return PremiumStatus(isPremium: false);
  }
}
```

### 4. Compra de Assinatura

```dart
Future<bool> purchaseSubscription() async {
  try {
    // 1. Listar produtos disponíveis
    Offerings offerings = await Purchases.getOfferings();
    
    if (offerings.current == null) {
      throw Exception('No offerings available');
    }
    
    // 2. Selecionar o plano (ex: mensal)
    Package? monthlyPackage = offerings.current!.monthly;
    
    if (monthlyPackage == null) {
      throw Exception('Monthly package not found');
    }
    
    // 3. Iniciar compra
    CustomerInfo customerInfo = await Purchases.purchasePackage(monthlyPackage);
    
    // 4. Verificar se a assinatura está ativa
    if (customerInfo.entitlements.all['ordo_plus']?.isActive == true) {
      // 5. Sincronizar com backend
      await verifyPremium();
      return true;
    }
    
    return false;
  } on PlatformException catch (e) {
    var errorCode = PurchasesErrorHelper.getErrorCode(e);
    
    if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
      print('User cancelled purchase');
    } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
      print('Payment pending');
    } else {
      print('Error purchasing: ${e.message}');
    }
    
    return false;
  }
}
```

### 5. Restaurar Compras

```dart
Future<bool> restorePurchases() async {
  try {
    CustomerInfo customerInfo = await Purchases.restorePurchases();
    
    if (customerInfo.entitlements.all['ordo_plus']?.isActive == true) {
      await verifyPremium();
      return true;
    }
    
    return false;
  } catch (e) {
    print('Error restoring purchases: $e');
    return false;
  }
}
```

## 🎵 Áudio dos Ofícios

### 1. Modelo de Dados

```dart
class AudioSection {
  final String textId;
  final String title;
  final String content;
  final String? audioUrl;  // Null se não premium ou não disponível
  final String? voiceKey;
  final String? voiceName;
  
  AudioSection({
    required this.textId,
    required this.title,
    required this.content,
    this.audioUrl,
    this.voiceKey,
    this.voiceName,
  });
  
  bool get hasAudio => audioUrl != null;
  
  factory AudioSection.fromJson(Map<String, dynamic> json) {
    return AudioSection(
      textId: json['id'].toString(),
      title: json['title'],
      content: json['content'],
      audioUrl: json['audio_url'],
      voiceKey: json['voice_key'],
      voiceName: json['voice_name'],
    );
  }
}
```

### 2. Preferência de Voz

Armazenar a voz preferida do usuário:

```dart
class VoicePreference {
  static const String male1 = 'male_1';    // Victor Power
  static const String female1 = 'female_1'; // Rita
  static const String male2 = 'male_2';    // Will
  
  static Future<void> setPreferredVoice(String voiceKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_voice', voiceKey);
  }
  
  static Future<String> getPreferredVoice() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('preferred_voice') ?? male1;
  }
}
```

Enviar ao backend nas preferências do usuário:

```dart
Future<void> updateVoicePreference(String voiceKey) async {
  await http.patch(
    Uri.parse('${baseUrl}/api/v1/users/preferences'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $firebaseToken',
    },
    body: jsonEncode({
      'preferences': {
        'preferred_voice': voiceKey,
      },
    }),
  );
}
```

### 3. Player de Áudio

```dart
import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  Future<void> playSection(AudioSection section) async {
    if (!section.hasAudio) {
      throw Exception('No audio available for this section');
    }
    
    try {
      final audioUrl = '${baseUrl}${section.audioUrl}';
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
      rethrow;
    }
  }
  
  Future<void> pause() async {
    await _audioPlayer.pause();
  }
  
  Future<void> stop() async {
    await _audioPlayer.stop();
  }
  
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  
  Duration? get duration => _audioPlayer.duration;
  
  void dispose() {
    _audioPlayer.dispose();
  }
}
```

### 4. UI - Seções com Áudio

```dart
class OfficeSectionCard extends StatelessWidget {
  final AudioSection section;
  final bool isPremium;
  final AudioPlayerService audioPlayer;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da seção
          ListTile(
            title: Text(
              section.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: section.hasAudio && isPremium
              ? IconButton(
                  icon: Icon(Icons.play_circle_outline),
                  onPressed: () => audioPlayer.playSection(section),
                )
              : (!isPremium 
                  ? Icon(Icons.lock_outline, color: Colors.grey)
                  : null
                ),
          ),
          
          // Conteúdo
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(section.content),
          ),
          
          // Player inline (se estiver tocando)
          StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              if (snapshot.data?.playing == true) {
                return AudioProgressBar(
                  audioPlayer: audioPlayer,
                  section: section,
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
```

### 5. Amostras de Voz (Público)

Permitir ouvir amostras das vozes **antes** de assinar:

```dart
Future<List<VoiceSample>> getVoiceSamples() async {
  final response = await http.get(
    Uri.parse('${baseUrl}/api/v1/audio/voice_samples'),
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return (data['samples'] as List)
      .map((s) => VoiceSample.fromJson(s))
      .toList();
  }
  
  throw Exception('Failed to load voice samples');
}

class VoiceSample {
  final String voiceKey;
  final String voiceName;
  final String gender;
  final String sampleUrl;
  
  VoiceSample({
    required this.voiceKey,
    required this.voiceName,
    required this.gender,
    required this.sampleUrl,
  });
  
  factory VoiceSample.fromJson(Map<String, dynamic> json) {
    return VoiceSample(
      voiceKey: json['voice_key'],
      voiceName: json['voice_name'],
      gender: json['gender'],
      sampleUrl: json['sample_url'],
    );
  }
}
```

## 📱 Telas Sugeridas

### 1. Paywall

```dart
class OrdoPlusPaywall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ordo+')),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          // Logo/Badge premium
          Icon(Icons.stars, size: 80, color: Colors.amber),
          SizedBox(height: 16),
          
          // Título
          Text(
            'Ordo+',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          
          Text(
            'Aprimore sua experiência de oração',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          
          // Benefícios
          _FeatureItem(
            icon: Icons.headphones,
            title: 'Áudio dos Ofícios',
            description: 'Ofícios completos narrados com vozes naturais',
          ),
          _FeatureItem(
            icon: Icons.record_voice_over,
            title: 'Escolha sua Voz',
            description: '3 vozes profissionais em português',
          ),
          _FeatureItem(
            icon: Icons.sync,
            title: 'Sincronização',
            description: 'Preferências em todos os dispositivos',
          ),
          
          SizedBox(height: 32),
          
          // Botão de assinatura
          ElevatedButton(
            onPressed: () => _purchaseSubscription(context),
            child: Text('Assinar Ordo+'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Restaurar compras
          TextButton(
            onPressed: () => _restorePurchases(context),
            child: Text('Restaurar Compras'),
          ),
        ],
      ),
    );
  }
}
```

### 2. Seleção de Voz

```dart
class VoiceSelectionScreen extends StatefulWidget {
  @override
  _VoiceSelectionScreenState createState() => _VoiceSelectionScreenState();
}

class _VoiceSelectionScreenState extends State<VoiceSelectionScreen> {
  String? selectedVoice;
  List<VoiceSample> samples = [];
  final audioPlayer = AudioPlayerService();
  
  @override
  void initState() {
    super.initState();
    _loadSamples();
    _loadPreference();
  }
  
  Future<void> _loadSamples() async {
    final loadedSamples = await getVoiceSamples();
    setState(() => samples = loadedSamples);
  }
  
  Future<void> _loadPreference() async {
    final voice = await VoicePreference.getPreferredVoice();
    setState(() => selectedVoice = voice);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escolher Voz')),
      body: ListView.builder(
        itemCount: samples.length,
        itemBuilder: (context, index) {
          final sample = samples[index];
          return VoiceSampleTile(
            sample: sample,
            isSelected: selectedVoice == sample.voiceKey,
            onPlay: () => _playSample(sample),
            onSelect: () => _selectVoice(sample.voiceKey),
          );
        },
      ),
    );
  }
  
  Future<void> _playSample(VoiceSample sample) async {
    final url = '${baseUrl}${sample.sampleUrl}';
    await audioPlayer._audioPlayer.setUrl(url);
    await audioPlayer._audioPlayer.play();
  }
  
  Future<void> _selectVoice(String voiceKey) async {
    await VoicePreference.setPreferredVoice(voiceKey);
    await updateVoicePreference(voiceKey);
    setState(() => selectedVoice = voiceKey);
  }
}
```

## 🔐 Endpoints da API

### Verificar Assinatura
```http
POST /api/v1/subscription/verify
Authorization: Bearer {firebase_token}
Content-Type: application/json

{
  "revenue_cat_user_id": "rc_abc123..."
}

### Response
{
  "premium": true,
  "expires_at": "2026-01-13T15:30:00Z",
  "message": "Premium subscription active"
}
```

### Status Premium
```http
GET /api/v1/subscription/premium_status
Authorization: Bearer {firebase_token}

### Response
{
  "premium": true,
  "expires_at": "2026-01-13T15:30:00Z"
}
```

### Amostras de Voz (Público)
```http
GET /api/v1/audio/voice_samples

### Response
{
  "samples": [
    {
      "voice_key": "male_1",
      "voice_name": "Victor Power",
      "gender": "masculino",
      "sample_url": "/audio/samples/sample_male_1.mp3"
    },
    {
      "voice_key": "female_1",
      "voice_name": "Rita",
      "gender": "feminino",
      "sample_url": "/audio/samples/sample_female_1.mp3"
    },
    {
      "voice_key": "male_2",
      "voice_name": "Will",
      "gender": "masculino",
      "sample_url": "/audio/samples/sample_male_2.mp3"
    }
  ]
}
```

### Ofício com Áudio (Premium)
```http
GET /api/v1/daily_office/2025/12/13/morning
Authorization: Bearer {firebase_token}

### Response (usuário premium)
{
  "date": "2025-12-13",
  "office_type": "morning",
  "sections": [
    {
      "id": 123,
      "title": "Invocação",
      "content": "Senhor, abre os meus lábios...",
      "audio_url": "/audio/loc_2015/male_1/loc_2015_123_morning_invocation.mp3",
      "voice_key": "male_1",
      "voice_name": "Victor Power"
    },
    // ... outras seções
  ]
}

### Response (usuário free)
{
  "date": "2025-12-13",
  "office_type": "morning",
  "sections": [
    {
      "id": 123,
      "title": "Invocação",
      "content": "Senhor, abre os meus lábios...",
      "audio_url": null  // Sem áudio
    },
    // ... outras seções
  ]
}
```

## 📊 Entitlements no RevenueCat

Configure o entitlement no dashboard do RevenueCat:

- **Identifier**: `ordo_plus`
- **Display Name**: Ordo+
- **Products**: 
  - Monthly: `ordo_plus_monthly` (R$ 9,90/mês)
  - Yearly: `ordo_plus_yearly` (R$ 89,90/ano - 25% desconto)

## ✅ Checklist de Implementação

### Backend (API)
- [x] Endpoint de verificação de assinatura (`POST /subscription/verify`)
- [x] Endpoint de status premium (`GET /subscription/premium_status`)
- [x] Endpoint de amostras de voz (`GET /audio/voice_samples`)
- [x] Integração com RevenueCat API
- [x] Campo `revenue_cat_user_id` no modelo User
- [x] Campo `premium_expires_at` no modelo User
- [x] Áudio URLs nos ofícios para usuários premium
- [x] Rake tasks para geração de áudio

### App (Flutter)
- [ ] Integrar SDK do RevenueCat
- [ ] Tela de Paywall (Ordo+)
- [ ] Fluxo de compra de assinatura
- [ ] Fluxo de restauração de compras
- [ ] Verificação de premium ao iniciar app
- [ ] Tela de seleção de voz
- [ ] Player de áudio inline nas seções
- [ ] Preview das amostras de voz (público)
- [ ] Indicadores visuais de conteúdo premium
- [ ] Sincronização de preferências com backend
- [ ] Gerenciar estado premium globalmente (Provider/Riverpod)
- [ ] Cache de status premium
- [ ] Deep linking para restaurar compras

## 🎯 UX Recomendações

1. **Soft Paywall**: Mostrar prévia das vozes antes de pedir assinatura
2. **Restore Prominent**: Botão de restaurar compras visível (exigência da Apple)
3. **Feedback Visual**: Ícone de cadeado em conteúdo bloqueado
4. **Trial**: Considerar trial gratuito de 7 dias (configurar no RevenueCat)
5. **Onboarding**: Explicar benefícios do Ordo+ na primeira vez
6. **Player Persistente**: Player fixo na parte inferior durante reprodução
7. **Download Offline**: Considerar download de áudios para uso offline (fase futura)

## 📝 Notas Importantes

- **RevenueCat User ID**: É gerado automaticamente pelo SDK, não usar Firebase UID
- **Server-Side Validation**: Backend sempre valida na API do RevenueCat (não confiar apenas no app)
- **Expiração**: Backend verifica `premium_expires_at` em toda requisição de ofício
- **Sincronização**: Chamar `POST /subscription/verify` após cada compra/restauração
- **Cache**: App pode cachear status premium mas deve revalidar periodicamente
- **Testes**: RevenueCat possui sandbox para testar assinaturas sem cobrar

Importante: Não queria que a tela de Ofício Diário tivesse um play pra cada áudio, mas que fosse um play geral que fosse andando a tela conforme o áudio for avançando, seguindo o texto. Que pudesse pausar, também.

Quero uma UX bem clara, inteligente, bonita, seguindo o padrão do que já temos, e fácil de usar pra usuários não-experts.
---

**Desenvolvido para Estêvão API** 🙏