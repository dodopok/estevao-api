require 'rails_helper'

RSpec.describe CollectService do
  describe 'initialization and calendar coordination' do
    let(:date) { Date.new(2025, 12, 29) }

    let!(:pb_2019) do
      PrayerBook.find_or_create_by!(code: 'loc_2019_en') do |pb|
        pb.name = 'ACNA 2019'
      end
    end

    it 'uses the correct calendar when initialized with a specific prayer book code' do
      service = described_class.new(date, prayer_book_code: 'loc_2019_en')

      expect(service.calendar.prayer_book_code).to eq('loc_2019_en')
    end

    it 'uses the provided calendar regardless of prayer_book_code' do
      custom_calendar = LiturgicalCalendar.new(2025, prayer_book_code: 'loc_2015')
      service = described_class.new(date, prayer_book_code: 'loc_2019_en', calendar: custom_calendar)

      expect(service.calendar).to eq(custom_calendar)
      expect(service.calendar.prayer_book_code).to eq('loc_2015')
    end
  end
end
