class ElevenlabsAudioService
  class RateLimitError < StandardError; end

  # Voice configuration with ElevenLabs voice IDs
  VOICES = {
    male_1: {
      id: "YNOujSUmHtgN6anjqXPf",
      name: "Victor Power",
      gender: "male"
    },
    female_1: {
      id: "lRbfoJL2IRJBT7ma6o7n",
      name: "Rita",
      gender: "female"
    },
    male_2: {
      id: "h96v1HCJtcisNNeagp0R",
      name: "Will",
      gender: "male"
    }
  }.freeze

  # ElevenLabs API configuration
  API_BASE_URL = "https://api.elevenlabs.io/v1"
  MODEL_ID = "eleven_multilingual_v2"
  LANGUAGE_CODE = "pt"

  def initialize
    @api_key = ENV.fetch("ELEVENLABS_API_KEY", nil)
    raise "ELEVENLABS_API_KEY not configured" if @api_key.blank?
  end

  # Generate audio for given text using specified voice
  # Returns audio file content as binary string
  def generate_audio(text, voice_key)
    voice_key = voice_key.to_sym
    raise ArgumentError, "Invalid voice_key: #{voice_key}" unless VOICES.key?(voice_key)

    # Sanitize text before sending to API
    sanitized_text = sanitize_text_for_audio(text)

    voice_id = VOICES[voice_key][:id]
    url = "#{API_BASE_URL}/text-to-speech/#{voice_id}"

    response = HTTP
      .headers(
        "xi-api-key" => @api_key,
        "Content-Type" => "application/json"
      )
      .post(url, json: {
        text: sanitized_text,
        model_id: MODEL_ID,
        language_code: LANGUAGE_CODE,
        voice_settings: {
          stability: 0.5,
          similarity_boost: 0.75,
          style: 0.0,
          use_speaker_boost: true
        },
        output_format: "mp3_44100_64"
      })

    case response.code
    when 200
      response.body.to_s
    when 429
      raise RateLimitError, "ElevenLabs rate limit exceeded. Please try again later."
    else
      error_message = parse_error(response)
      raise "ElevenLabs API error (#{response.code}): #{error_message}"
    end
  end

  # Estimate cost based on character count
  # ElevenLabs pricing is approximately $0.30 per 1000 characters
  def estimate_cost(total_characters)
    cost_per_1000 = 0.30
    estimated_cost = (total_characters / 1000.0) * cost_per_1000

    {
      total_characters: total_characters,
      estimated_cost_usd: estimated_cost.round(2),
      cost_per_1000_chars: cost_per_1000
    }
  end

  # Generate voice sample using morning_welcome_traditional text
  # Returns hash with voice metadata and generated audio
  def generate_voice_sample(voice_key)
    sample_text = LiturgicalText.find_text("morning_welcome_traditional", prayer_book_code: "loc_2015")
    raise "Sample text 'morning_welcome_traditional' not found" unless sample_text

    audio_data = generate_audio(sample_text.content, voice_key)

    {
      voice_key: voice_key,
      voice_name: VOICES[voice_key.to_sym][:name],
      gender: VOICES[voice_key.to_sym][:gender],
      audio_data: audio_data,
      sample_text: sample_text.content
    }
  end

  # Get all voice information
  def self.voice_info
    VOICES.transform_values { |v| v.except(:id) }
  end

  private

  # Sanitize text for audio generation by removing Markdown formatting
  # and biblical references that shouldn't be read aloud
  def sanitize_text_for_audio(text)
    return "" if text.blank?

    sanitized = text.dup

    # Remove biblical references in format: __(Reference)__
    # Examples: __(Sl 113.4)__, __(I Co 15.57)__, __(Jo 4.23-24)__
    sanitized.gsub!(/\s*__\([^)]+\)__/, "")

    # Remove bold markers: **text** -> text
    sanitized.gsub!(/\*\*([^*]+)\*\*/, '\1')

    # Remove italic/underline markers: __text__ -> text
    sanitized.gsub!(/__([^_]+)__/, '\1')

    # Remove single asterisks (if any): *text* -> text
    sanitized.gsub!(/\*([^*]+)\*/, '\1')

    # Clean up multiple newlines (keep max 2)
    sanitized.gsub!(/\n{3,}/, "\n\n")

    # Clean up multiple spaces (but not newlines)
    sanitized.gsub!(/ {2,}/, " ")

    sanitized.strip
  end

  def parse_error(response)
    JSON.parse(response.body.to_s)["detail"] || response.body.to_s
  rescue JSON::ParserError
    response.body.to_s
  end
end
