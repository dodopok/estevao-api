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

      it 'uses BaseBuilder for loc_1987' do
        service = described_class.new(
          date: date,
          office_type: :morning,
          preferences: { prayer_book_code: 'loc_1987' }
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

  describe 'family rite support' do
    it 'passes office_type preference to builder' do
      service = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { office_type: 'family' }
      )

      result = service.call
      expect(result[:modules].length).to be < 15
    end
  end
end
