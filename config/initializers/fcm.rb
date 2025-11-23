# frozen_string_literal: true

# Firebase Cloud Messaging (FCM) Configuration
# Para configurar o FCM, adicione a variável FIREBASE_SERVER_KEY ao seu .env
#
# Como obter o Server Key:
# 1. Acesse https://console.firebase.google.com/
# 2. Selecione seu projeto
# 3. Vá em Project Settings > Cloud Messaging
# 4. Copie o "Server Key" ou "Legacy server key"
#
# Nota: A gem FCM será inicializada dinamicamente no FcmService
# quando necessário, verificando se a variável de ambiente está configurada.

Rails.application.configure do
  config.after_initialize do
    if ENV["FIREBASE_SERVER_KEY"].blank?
      Rails.logger.warn("⚠️  FIREBASE_SERVER_KEY not configured. Push notifications will not work.")
      Rails.logger.warn("   Add FIREBASE_SERVER_KEY to your environment variables to enable push notifications.")
    else
      Rails.logger.info("✓ FCM initialized - Push notifications enabled")
    end
  end
end
