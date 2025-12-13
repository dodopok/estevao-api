class GenerateLiturgicalAudioJob < ApplicationJob
  queue_as :default

  def perform(liturgical_text_id, voice_key, session_id)
    @text = LiturgicalText.find(liturgical_text_id)
    @voice_key = voice_key.to_s
    @session = AudioGenerationSession.find(session_id)
    @service = ElevenlabsAudioService.new

    Rails.logger.info "Generating audio for text ##{@text.id} (#{@text.slug}) with voice #{@voice_key}"

    # Check if audio already exists
    if @text.audio_url_for_voice(@voice_key).present?
      # Backup existing file before regenerating
      backup_existing_audio
    end

    # Generate audio
    audio_data = @service.generate_audio(@text.content, @voice_key)

    # Save audio file
    audio_url = save_audio_file(audio_data)

    # Update database
    @text.set_audio_url(@voice_key, audio_url)
    @text.update!(audio_generation_status: calculate_status)

    # Update session progress
    @session.update_progress(
      @voice_key,
      @text.id,
      @session.processed_count + 1,
      @session.failed_count
    )

    Rails.logger.info "Successfully generated audio: #{audio_url}"
  rescue ElevenlabsAudioService::RateLimitError => e
    # Re-raise rate limit errors to halt the batch
    Rails.logger.error "Rate limit error for text ##{@text.id}: #{e.message}"
    raise
  rescue StandardError => e
    # Log other errors and update session
    Rails.logger.error "Error generating audio for text ##{@text.id}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")

    @text.update!(audio_generation_status: "failed")
    @session.update!(failed_count: @session.failed_count + 1)

    raise
  end

  private

  def backup_existing_audio
    existing_path = audio_file_path(@text.audio_filename(@voice_key))
    return unless File.exist?(existing_path)

    backup_path = audio_file_path(@text.audio_filename_with_timestamp(@voice_key))

    FileUtils.mkdir_p(File.dirname(backup_path))
    FileUtils.cp(existing_path, backup_path)

    Rails.logger.info "Backed up existing audio to: #{backup_path}"
  end

  def save_audio_file(audio_data)
    filename = @text.audio_filename(@voice_key)
    file_path = audio_file_path(filename)

    # Create directory if it doesn't exist
    FileUtils.mkdir_p(File.dirname(file_path))

    # Write audio file
    File.binwrite(file_path, audio_data)

    # Return the public URL
    "/audio/#{@text.prayer_book.code}/#{@voice_key}/#{filename}"
  end

  def audio_file_path(filename)
    Rails.root.join("public", "audio", @text.prayer_book.code, @voice_key, filename)
  end

  def calculate_status
    generated_count = @text.voices_generated.count
    total_count = LiturgicalText::AVAILABLE_VOICES.count

    case generated_count
    when 0
      "pending"
    when total_count
      "completed"
    else
      "partial"
    end
  end
end
