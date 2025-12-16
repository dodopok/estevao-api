class BatchAudioGeneratorService
  attr_reader :session

  def initialize(prayer_book_code, voice_keys = nil)
    @prayer_book_code = prayer_book_code
    @voice_keys = voice_keys || LiturgicalText::AVAILABLE_VOICES
    @voice_keys = Array(@voice_keys).map(&:to_s)

    validate_inputs!
  end

  # Start or resume audio generation
  def generate
    @session = find_or_create_session

    if @session.status == "running"
      Rails.logger.info "Resuming generation session ##{@session.id}"
      resume_generation
    else
      Rails.logger.info "Starting new generation session ##{@session.id}"
      start_generation
    end
  end

  private

  def validate_inputs!
    prayer_book = PrayerBook.find_by(code: @prayer_book_code)
    raise ArgumentError, "Prayer book not found: #{@prayer_book_code}" unless prayer_book

    invalid_voices = @voice_keys - LiturgicalText::AVAILABLE_VOICES
    if invalid_voices.any?
      raise ArgumentError, "Invalid voice keys: #{invalid_voices.join(', ')}"
    end
  end

  def find_or_create_session
    # Check for existing running session
    existing_session = AudioGenerationSession.running.for_prayer_book(@prayer_book_code).first

    if existing_session
      return existing_session
    end

    # Create new session
    texts = LiturgicalText.for_prayer_book(@prayer_book_code).for_audio_generation

    AudioGenerationSession.create!(
      prayer_book_code: @prayer_book_code,
      voice_keys: @voice_keys,
      status: "running",
      total_texts: texts.count * @voice_keys.count,
      processed_count: 0,
      failed_count: 0,
      started_at: Time.current
    )
  end

  def start_generation
    @voice_keys.each do |voice_key|
      process_voice(voice_key, from_text_id: nil)
    end

    @session.mark_completed
  rescue StandardError => e
    @session.mark_failed(e.message)
    raise
  end

  def resume_generation
    resume_point = @session.resume_from

    if resume_point[:voice_key].present?
      # Resume from the interrupted voice
      resume_voice_index = @voice_keys.index(resume_point[:voice_key])

      # Process remaining texts for current voice
      process_voice(resume_point[:voice_key], from_text_id: resume_point[:text_id])

      # Process remaining voices
      @voice_keys[(resume_voice_index + 1)..-1]&.each do |voice_key|
        process_voice(voice_key, from_text_id: nil)
      end
    else
      # No specific resume point, process all voices
      start_generation
    end

    @session.mark_completed
  rescue StandardError => e
    @session.mark_failed(e.message)
    raise
  end

  def process_voice(voice_key, from_text_id:)
    Rails.logger.info "Processing voice: #{voice_key}"

    texts = fetch_texts_for_voice(voice_key, from_text_id)

    texts.find_each do |text|
      begin
        GenerateLiturgicalAudioJob.perform_now(text.id, voice_key, @session.id)
      rescue ElevenlabsAudioService::RateLimitError => e
        # Rate limit hit - abort and let user retry later
        @session.mark_failed("Rate limit exceeded: #{e.message}")
        raise
      rescue StandardError => e
        # Log error but continue with next text
        Rails.logger.error "Failed to generate audio for text #{text.id}, voice #{voice_key}: #{e.message}"
        @session.update!(failed_count: @session.failed_count + 1)
      end
    end
  end

  def fetch_texts_for_voice(voice_key, from_text_id)
    query = LiturgicalText.for_prayer_book(@prayer_book_code)
      .for_audio_generation
      .where("audio_urls->? IS NULL", voice_key)
      .order(:id)

    query = query.where("id >= ?", from_text_id) if from_text_id.present?

    query
  end
end
