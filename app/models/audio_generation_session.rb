class AudioGenerationSession < ApplicationRecord
  # Validations
  validates :prayer_book_code, presence: true
  validates :status, presence: true, inclusion: { in: %w[running completed failed cancelled] }
  validate :no_concurrent_sessions, on: :create

  # Scopes
  scope :running, -> { where(status: "running") }
  scope :for_prayer_book, ->(code) { where(prayer_book_code: code) }

  # Update progress after processing each text
  def update_progress(voice_key, text_id, processed, failed)
    update!(
      current_voice_key: voice_key,
      current_text_id: text_id,
      processed_count: processed,
      failed_count: failed
    )
  end

  # Mark session as completed
  def mark_completed
    update!(
      status: "completed",
      completed_at: Time.current,
      current_voice_key: nil,
      current_text_id: nil
    )
  end

  # Mark session as failed with error message
  def mark_failed(error)
    update!(
      status: "failed",
      completed_at: Time.current,
      error_log: [ error_log, error ].compact.join("\n")
    )
  end

  # Get resume point for interrupted sessions
  def resume_from
    return nil unless status == "running"

    {
      voice_key: current_voice_key,
      text_id: current_text_id
    }
  end

  private

  # Prevent concurrent running sessions for the same prayer book
  def no_concurrent_sessions
    if AudioGenerationSession.running.for_prayer_book(prayer_book_code).exists?
      errors.add(:base, "A generation session is already running for #{prayer_book_code}")
    end
  end
end
