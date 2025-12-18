# frozen_string_literal: true

# Firebase Cloud Messaging (FCM) Configuration
#
# Para configurar o FCM v1 API, você precisa de um Service Account do Firebase:
#
# 1. Acesse https://console.firebase.google.com/
# 2. Selecione seu projeto
# 3. Vá em Project Settings > Service accounts
# 4. Clique em "Generate new private key"
# 5. Salve o arquivo JSON
#
# Configuração via variável de ambiente (recomendado para produção):
#   FIREBASE_CREDENTIALS='{"type":"service_account",...}' # JSON inteiro
#
# Ou via arquivo:
#   GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json
#
# Opcionalmente, defina o project_id explicitamente:
#   FIREBASE_PROJECT_ID=your-project-id

Rails.application.configure do
  config.after_initialize do
    status = FcmService.configuration_status

    if status[:configured]
      Rails.logger.info("✓ FCM v1 API initialized - Push notifications enabled")
      Rails.logger.info("  Project ID: #{status[:project_id]}")
      Rails.logger.info("  Credentials: #{status[:credentials_source]}")
    else
      Rails.logger.warn("⚠️  FCM not configured. Push notifications will not work.")
      Rails.logger.warn("   Missing credentials: #{!status[:has_credentials]}")
      Rails.logger.warn("   Missing project_id: #{!status[:has_project_id]}")
      Rails.logger.warn("   Set FIREBASE_CREDENTIALS or GOOGLE_APPLICATION_CREDENTIALS")
    end
  end
end
