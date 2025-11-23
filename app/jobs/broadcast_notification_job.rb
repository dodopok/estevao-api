# frozen_string_literal: true

class BroadcastNotificationJob < ApplicationJob
  queue_as :default

  def perform(title, body, data = {})
    NotificationService.broadcast(title, body, data)
  end
end
