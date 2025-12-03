# frozen_string_literal: true

class CleanupExpiredSharedOfficesJob < ApplicationJob
  queue_as :default

  # Run this job periodically (e.g., daily via cron or Solid Queue recurring)
  # to clean up expired shared office links
  def perform
    deleted_count = SharedOffice.expired.delete_all

    Rails.logger.info("[CleanupExpiredSharedOfficesJob] Deleted #{deleted_count} expired shared offices")

    deleted_count
  end
end
