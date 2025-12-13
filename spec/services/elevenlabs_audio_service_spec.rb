require 'rails_helper'

RSpec.describe ElevenlabsAudioService do
  let(:service) { described_class.new }

  before do
    allow(ENV).to receive(:fetch).with("ELEVENLABS_API_KEY", nil).and_return('test_api_key')
  end

  describe 'initialization' do
    it 'raises error when API key is not configured' do
      allow(ENV).to receive(:fetch).with("ELEVENLABS_API_KEY", nil).and_return(nil)
      expect { described_class.new }.to raise_error(/ELEVENLABS_API_KEY not configured/)
    end
  end

  describe 'VOICES constant' do
    it 'has three voices configured' do
      expect(ElevenlabsAudioService::VOICES.keys).to match_array([ :male_1, :female_1, :male_2 ])
    end

    it 'has correct voice IDs' do
      expect(ElevenlabsAudioService::VOICES[:male_1][:id]).to eq('YNOujSUmHtgN6anjqXPf')
      expect(ElevenlabsAudioService::VOICES[:female_1][:id]).to eq('lRbfoJL2IRJBT7ma6o7n')
      expect(ElevenlabsAudioService::VOICES[:male_2][:id]).to eq('h96v1HCJtcisNNeagp0R')
    end

    it 'includes voice metadata' do
      expect(ElevenlabsAudioService::VOICES[:male_1][:name]).to eq('Victor Power')
      expect(ElevenlabsAudioService::VOICES[:female_1][:gender]).to eq('female')
    end
  end

  describe '#generate_audio' do
    it 'generates audio for valid voice key' do
      stub_request(:post, "https://api.elevenlabs.io/v1/text-to-speech/YNOujSUmHtgN6anjqXPf")
        .to_return(status: 200, body: 'audio_data')

      result = service.generate_audio('Test content', :male_1)
      expect(result).to eq('audio_data')
    end

    it 'accepts string voice key' do
      stub_request(:post, "https://api.elevenlabs.io/v1/text-to-speech/lRbfoJL2IRJBT7ma6o7n")
        .to_return(status: 200, body: 'audio_data')

      result = service.generate_audio('Test content', 'female_1')
      expect(result).to eq('audio_data')
    end

    it 'raises error for invalid voice key' do
      expect {
        service.generate_audio('Test', :invalid_voice)
      }.to raise_error(ArgumentError, /Invalid voice_key/)
    end

    it 'raises RateLimitError on 429 response' do
      stub_request(:post, "https://api.elevenlabs.io/v1/text-to-speech/YNOujSUmHtgN6anjqXPf")
        .to_return(status: 429, body: 'Rate limit')

      expect {
        service.generate_audio('Test', :male_1)
      }.to raise_error(ElevenlabsAudioService::RateLimitError, /rate limit exceeded/)
    end

    it 'raises error on other API errors' do
      stub_request(:post, "https://api.elevenlabs.io/v1/text-to-speech/YNOujSUmHtgN6anjqXPf")
        .to_return(status: 500, body: '{"message":"Server error"}')

      expect {
        service.generate_audio('Test', :male_1)
      }.to raise_error(/ElevenLabs API error/)
    end
  end

  describe '#estimate_cost' do
    it 'estimates cost based on character count' do
      result = service.estimate_cost(10000)

      expect(result[:total_characters]).to eq(10000)
      expect(result[:estimated_cost_usd]).to eq(3.0)
      expect(result[:cost_per_1000_chars]).to eq(0.30)
    end

    it 'rounds cost to 2 decimal places' do
      result = service.estimate_cost(5555)
      expect(result[:estimated_cost_usd]).to eq(1.67)
    end
  end

  describe '#generate_voice_sample' do
    let(:prayer_book) { PrayerBook.find_or_create_by!(code: 'loc_2015') { |pb| pb.name = 'Liturgia das Horas' } }
    let!(:sample_text) do
      LiturgicalText.find_or_create_by!(
        prayer_book: prayer_book,
        slug: 'morning_welcome_traditional'
      ) do |text|
        text.content = 'Senhor, abre os nossos lábios'
        text.category = 'invocation'
        text.language = 'pt-BR'
        text.title = 'Morning Welcome'
      end
    end

    it 'generates sample using morning_welcome_traditional text' do
      stub_request(:post, "https://api.elevenlabs.io/v1/text-to-speech/YNOujSUmHtgN6anjqXPf")
        .to_return(status: 200, body: 'sample_audio')

      result = service.generate_voice_sample(:male_1)

      expect(result[:voice_key]).to eq(:male_1)
      expect(result[:voice_name]).to eq('Victor Power')
      expect(result[:gender]).to eq('male')
      expect(result[:audio_data]).to eq('sample_audio')
      expect(result[:sample_text]).to be_present
      expect(result[:sample_text]).to include('Deus')
    end

    it 'raises error when sample text not found' do
      LiturgicalText.destroy_all

      expect {
        service.generate_voice_sample(:male_1)
      }.to raise_error(/Sample text.*not found/)
    end
  end

  describe '.voice_info' do
    it 'returns voice metadata without IDs' do
      info = ElevenlabsAudioService.voice_info

      expect(info[:male_1]).to include(name: 'Victor Power', gender: 'male')
      expect(info[:male_1]).not_to have_key(:id)
    end
  end

  describe '#sanitize_text_for_audio' do
    it 'removes biblical references in format __(Reference)__' do
      text = "**Excelso é o SENHOR** __(Sl 113.4)__"
      result = service.send(:sanitize_text_for_audio, text)
      
      expect(result).to eq("Excelso é o SENHOR")
      expect(result).not_to include("Sl 113.4")
      expect(result).not_to include("__")
    end

    it 'removes bold markers **text**' do
      text = "**Glória a ti**, ó santa e bendita Trindade"
      result = service.send(:sanitize_text_for_audio, text)
      
      expect(result).to eq("Glória a ti, ó santa e bendita Trindade")
      expect(result).not_to include("**")
    end

    it 'removes italic/underline markers __text__' do
      text = "Confio em __Deus__ sempre"
      result = service.send(:sanitize_text_for_audio, text)
      
      expect(result).to eq("Confio em Deus sempre")
      expect(result).not_to include("__")
    end

    it 'handles complex text with multiple formatting' do
      text = <<~TEXT
        **Graças a Deus que nos dá a vitória por meio
        de nosso Senhor Jesus Cristo.** __(I Co 15.57)__
      TEXT
      
      result = service.send(:sanitize_text_for_audio, text)
      
      expect(result).to include("Graças a Deus")
      expect(result).to include("Jesus Cristo")
      expect(result).not_to include("**")
      expect(result).not_to include("__")
      expect(result).not_to include("I Co 15.57")
    end

    it 'cleans up multiple spaces and newlines' do
      text = "Senhor,    abre  os nossos\n\n\n\nlábios"
      result = service.send(:sanitize_text_for_audio, text)
      
      expect(result).to eq("Senhor, abre os nossos\n\nlábios")
    end

    it 'returns empty string for blank input' do
      expect(service.send(:sanitize_text_for_audio, nil)).to eq("")
      expect(service.send(:sanitize_text_for_audio, "")).to eq("")
      expect(service.send(:sanitize_text_for_audio, "   ")).to eq("")
    end

    it 'preserves plain text without formatting' do
      text = "Senhor, abre os nossos lábios"
      result = service.send(:sanitize_text_for_audio, text)
      
      expect(result).to eq(text)
    end
  end
end
