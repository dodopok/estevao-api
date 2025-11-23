# frozen_string_literal: true

namespace :notifications do
  desc "Envia lembretes de streak para usuários que não completaram ofícios hoje"
  task send_streak_reminders: :environment do
    puts "🔔 Iniciando envio de lembretes de streak..."

    # Busca usuários que:
    # 1. Têm notificações habilitadas
    # 2. Têm pelo menos 1 token FCM ativo (atualizado nos últimos 60 dias)
    # 3. Não completaram nenhum ofício hoje
    users_to_notify = User
      .joins(:fcm_tokens)
      .where("fcm_tokens.updated_at > ?", 60.days.ago)
      .where.not(id: Completion.where(date_reference: Date.today).select(:user_id))
      .distinct

    # Filtra apenas usuários com notificações habilitadas
    users_with_notifications = users_to_notify.select do |user|
      user.preferences.dig("notifications") != false
    end

    puts "📊 Total de usuários encontrados: #{users_with_notifications.count}"

    success_count = 0
    error_count = 0

    users_with_notifications.each do |user|
      begin
        result = NotificationService.send_streak_reminder(user)
        if result[:sent]
          success_count += 1
          print "✓"
        else
          error_count += 1
          print "✗"
        end
      rescue StandardError => e
        error_count += 1
        print "✗"
        Rails.logger.error("Erro ao enviar lembrete para user #{user.id}: #{e.message}")
      end

      # Adiciona quebra de linha a cada 50 notificações para melhor visualização
      puts "" if (success_count + error_count) % 50 == 0
    end

    puts "\n"
    puts "✅ Lembretes enviados com sucesso: #{success_count}"
    puts "❌ Falhas no envio: #{error_count}" if error_count > 0
    puts "🏁 Processo concluído!"
  end

  desc "Remove tokens FCM inativos (não atualizados há mais de 60 dias)"
  task cleanup_old_tokens: :environment do
    puts "🧹 Removendo tokens FCM antigos..."

    old_tokens = FcmToken.where("updated_at < ?", 60.days.ago)
    count = old_tokens.count

    if count > 0
      old_tokens.destroy_all
      puts "✅ #{count} tokens antigos removidos com sucesso!"
    else
      puts "✨ Nenhum token antigo encontrado. Tudo limpo!"
    end
  end

  desc "Teste: envia notificação de teste para um usuário específico"
  task :test_notification, [ :user_email ] => :environment do |_t, args|
    unless args[:user_email]
      puts "❌ Uso: rake notifications:test_notification[email@example.com]"
      exit 1
    end

    user = User.find_by(email: args[:user_email])

    unless user
      puts "❌ Usuário com email '#{args[:user_email]}' não encontrado"
      exit 1
    end

    if user.fcm_tokens.active.empty?
      puts "⚠️  Usuário não possui tokens FCM ativos"
      exit 1
    end

    puts "📱 Enviando notificação de teste para #{user.email}..."

    result = NotificationService.send_announcement(
      user,
      "Teste de Notificação 🔔",
      "Esta é uma notificação de teste do sistema Ordo!"
    )

    if result[:sent]
      puts "✅ Notificação enviada com sucesso!"
    else
      puts "❌ Erro ao enviar notificação: #{result[:error]}"
    end
  end
end
