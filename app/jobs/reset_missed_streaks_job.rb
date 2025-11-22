# frozen_string_literal: true

class ResetMissedStreaksJob < ApplicationJob
  queue_as :default

  # Esse job deve rodar diariamente (ex: 1h da manhã)
  # Configure no scheduler (ex: Heroku Scheduler, cron, whenever gem)
  def perform
    Rails.logger.info("Starting ResetMissedStreaksJob")

    users_reset = 0

    User.find_each do |user|
      next unless user.missed_streak?

      # Zera o streak do usuário
      user.update!(
        current_streak: 0,
        longest_streak: [ user.current_streak, user.longest_streak ].max
      )

      users_reset += 1
    rescue StandardError => e
      Rails.logger.error("Error resetting streak for user #{user.id}: #{e.message}")
    end

    Rails.logger.info("ResetMissedStreaksJob completed. Reset #{users_reset} users.")
  end
end
