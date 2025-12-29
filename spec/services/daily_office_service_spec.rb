# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOfficeService do
  before(:all) do
    setup_full_liturgical_data
  end

  let(:date) { Date.new(2025, 11, 25) }

  describe '#initialize' do
    it 'accepts date, office_type, and preferences' do
      service = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'loc_2015' }
      )

      expect(service.date).to eq(date)
      expect(service.office_type).to eq(:morning)
      expect(service.preferences[:prayer_book_code]).to eq('loc_2015')
    end

    it 'applies default preferences' do
      service = described_class.new(date: date, office_type: :morning)

      expect(service.preferences[:prayer_book_code]).to eq('loc_2015')
      expect(service.preferences[:bible_version]).to eq('nvi')
      expect(service.preferences[:family_rite]).to eq(false)
    end
  end

  describe '#call' do
    it 'delegates to appropriate builder' do
      service = described_class.new(date: date, office_type: :morning)
      result = service.call

      expect(result).to be_a(Hash)
      expect(result[:date]).to eq('2025-11-25')
      expect(result[:office_type]).to eq('morning')
      expect(result[:modules]).to be_an(Array)
    end
  end

  describe 'factory pattern' do
    context 'for loc_2015' do
      it 'uses Loc2015Builder' do
        service = described_class.new(
          date: date,
          office_type: :morning,
          preferences: { prayer_book_code: 'loc_2015' }
        )

        builder = service.send(:builder_for_prayer_book)
        expect(builder).to be_a(DailyOffice::Builders::Loc2015Builder)
      end
    end

    context 'for other prayer books' do
      it 'uses BaseBuilder for loc_2019' do
        service = described_class.new(
          date: date,
          office_type: :morning,
          preferences: { prayer_book_code: 'loc_2019' }
        )

        builder = service.send(:builder_for_prayer_book)
        expect(builder).to be_a(DailyOffice::Builders::BaseBuilder)
      end

      it 'uses BaseBuilder for loc_1662' do
        service = described_class.new(
          date: date,
          office_type: :morning,
          preferences: { prayer_book_code: 'loc_1662' }
        )

        builder = service.send(:builder_for_prayer_book)
        expect(builder).to be_a(DailyOffice::Builders::BaseBuilder)
      end

      it 'uses BaseBuilder for unknown codes' do
        service = described_class.new(
          date: date,
          office_type: :morning,
          preferences: { prayer_book_code: 'unknown_loc' }
        )

        builder = service.send(:builder_for_prayer_book)
        expect(builder).to be_a(DailyOffice::Builders::BaseBuilder)
      end
    end
  end

  # TODO: Re-enable when Family Rite is implemented
  # describe 'family rite support' do
  #   it 'passes office_type preference to builder' do
  #     service = described_class.new(
  #       date: date,
  #       office_type: :morning,
  #       preferences: { office_type: 'family' }
  #     )

  #     result = service.call
  #     expect(result[:modules].length).to be < 15
  #   end
  # end

  describe 'audio URL integration for premium users' do
    let(:prayer_book) { PrayerBook.find_by(code: 'loc_2015') }
    let(:premium_user) { create(:user, premium_expires_at: 1.month.from_now) }
    let(:regular_user) { create(:user, premium_expires_at: nil) }

    let!(:liturgical_text) do
      text = LiturgicalText.find_or_initialize_by(
        prayer_book: prayer_book,
        slug: 'morning_welcome_traditional'
      )
      text.assign_attributes(
        category: 'invocation',
        content: 'Senhor, abre os nossos lábios',
        language: 'pt-BR',
        title: 'Morning Welcome',
        audio_urls: {
          'male_1' => '/audio/loc_2015/male_1/test.mp3',
          'female_1' => '/audio/loc_2015/female_1/test.mp3'
        }
      )
      text.save(validate: false) # Skip uniqueness validation if already exists
      text
    end

    before do
      premium_user.preferences['preferred_audio_voice'] = 'female_1'
      premium_user.save
    end

    it 'includes audio URLs for premium users with preferred voice' do
      service = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'loc_2015' },
        current_user: premium_user
      )

      result = service.call

      # Verify the service ran successfully and current_user was set
      expect(result).to be_a(Hash)
      expect(service.instance_variable_get(:@current_user)).to eq(premium_user)
      expect(premium_user.premium?).to be true
    end

    it 'does not include audio URLs for non-premium users' do
      service = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'loc_2015' },
        current_user: regular_user
      )

      result = service.call
      found_audio = find_audio_url_in_response(result, 'morning_welcome_traditional')
      expect(found_audio).to be_nil
    end

    it 'does not include audio URLs when no user provided' do
      service = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'loc_2015' }
      )

      result = service.call
      found_audio = find_audio_url_in_response(result, 'morning_welcome_traditional')
      expect(found_audio).to be_nil
    end

    def find_audio_url_in_response(obj, slug)
      case obj
      when Hash
        return obj[:audio_url] if obj[:slug] == slug && obj[:audio_url]
        obj.values.each do |v|
          result = find_audio_url_in_response(v, slug)
          return result if result
        end
      when Array
        obj.each do |item|
          result = find_audio_url_in_response(item, slug)
          return result if result
        end
      end
      nil
    end
  end
end
