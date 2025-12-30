require 'rails_helper'

RSpec.describe ReadingService do
  describe 'initialization and calendar coordination' do
    let(:date) { Date.new(2025, 12, 29) }

    # Create the two prayer books
    let!(:pb_2015) do
      PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
        pb.name = 'LOC 2015'
      end
    end

    let!(:pb_2019) do
      PrayerBook.find_or_create_by!(code: 'loc_2019_en') do |pb|
        pb.name = 'ACNA 2019'
      end
    end

    # Create celebrations with different ranks for the same day
    # In 2015, Dec 28 is Holy Innocents, but transferred to Dec 29 if Dec 28 is Sunday.
    # 2025-12-28 is a Sunday.

    let!(:cel_2015) do
      create(:celebration,
        name: "Santos Inocentes 2015",
        celebration_type: :festival,
        rank: 100, # Lower rank
        fixed_month: 12,
        fixed_day: 28,
        prayer_book: pb_2015
      )
    end

    let!(:cel_2019) do
      create(:celebration,
        name: "The Holy Innocents 2019",
        celebration_type: :major_holy_day,
        rank: 10, # Higher rank (smaller number)
        fixed_month: 12,
        fixed_day: 28,
        prayer_book: pb_2019
      )
    end

    let!(:reading_2019) do
      create(:lectionary_reading,
        celebration: cel_2019,
        prayer_book: pb_2019,
        date_reference: 'the_holy_innocents',
        first_reading: 'Jeremiah 31:15-17',
        cycle: 'all'
      )
    end

    it 'uses the correct calendar when initialized with a specific prayer book code' do
      # When we use loc_2019_en, the internal calendar should also be for loc_2019_en
      service = described_class.new(date, prayer_book_code: 'loc_2019_en')

      expect(service.calendar.prayer_book_code).to eq('loc_2019_en')

      # It should find the celebration according to 2019 rules (Major Holy Day)
      celebration = service.calendar.celebration_for_date(date)
      expect(celebration[:type]).to eq('major_holy_day')
      expect(celebration[:name]).to eq("The Holy Innocents 2019")

      # And find the readings
      readings = service.find_readings
      expect(readings).not_to be_nil
      expect(readings[:first_reading][:reference]).to eq('Jeremiah 31:15-17')
    end

    it 'uses the provided calendar regardless of prayer_book_code' do
      # If we provide a calendar, it should use it even if it "mismatches" the code
      # (Though this shouldn't happen in normal app flow, it's good to ensure it's respected)
      custom_calendar = LiturgicalCalendar.new(2025, prayer_book_code: 'loc_2015')
      service = described_class.new(date, prayer_book_code: 'loc_2019_en', calendar: custom_calendar)

      expect(service.calendar).to eq(custom_calendar)
      expect(service.calendar.prayer_book_code).to eq('loc_2015')
    end
  end
end
