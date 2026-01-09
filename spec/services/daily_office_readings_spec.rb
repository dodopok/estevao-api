require 'rails_helper'

RSpec.describe "Daily Office Readings Integration" do
  let!(:loc_2019) do
    PrayerBook.find_or_create_by!(code: 'loc_2019') do |pb|
      pb.name = 'Livro de Oração Comum 2019'
      pb.language = 'pt-BR'
    end
  end

  let!(:loc_2019_en) do
    PrayerBook.find_or_create_by!(code: 'loc_2019_en') do |pb|
      pb.name = 'Book of Common Prayer 2019'
      pb.language = 'en'
    end
  end

  # Helper to ensure readings exist
  before do
    # Load LOC 2019 readings for testing if not already loaded
    if LectionaryReading.where(prayer_book: loc_2019).count == 0
      # This is just a fallback, usually seeds are loaded
      create_sample_readings(loc_2019, 'pt-BR')
    end

    if LectionaryReading.where(prayer_book: loc_2019_en).count == 0
      create_sample_readings(loc_2019_en, 'en')
    end
  end

  def create_sample_readings(pb, lang)
    if lang == 'pt-BR'
      LectionaryReading.create!(prayer_book: pb, date_reference: 'janeiro_1', service_type: 'morning_prayer', psalm: '1, 2', first_reading: 'Gênesis 1', cycle: 'all')
      LectionaryReading.create!(prayer_book: pb, date_reference: 'janeiro_1', service_type: 'evening_prayer', psalm: '3, 4', first_reading: 'Gálatas 1', cycle: 'all')

      # Ensure Celebration exists for Maundy Thursday logic
      Celebration.create!(
        prayer_book: pb,
        name: 'Quinta-feira Santa',
        celebration_type: 'major_holy_day',
        rank: 20,
        movable: true,
        calculation_rule: 'easter_minus_3_days',
        liturgical_color: 'roxo'
      )

      LectionaryReading.create!(prayer_book: pb, date_reference: 'maundy_thursday', service_type: 'morning_prayer', psalm: '41', first_reading: 'Daniel 9', cycle: 'all')
    else
      LectionaryReading.create!(prayer_book: pb, date_reference: 'january_1', service_type: 'morning_prayer', psalm: '1, 2', first_reading: 'Gen 1', cycle: 'all')
      LectionaryReading.create!(prayer_book: pb, date_reference: 'january_1', service_type: 'evening_prayer', psalm: '3, 4', first_reading: 'Gal 1', cycle: 'all')
    end
  end

  describe "LOC 2019 (Portuguese)" do
    it "finds correct Morning Prayer readings for Jan 1" do
      date = Date.new(2026, 1, 1)
      service = ReadingService.for(date, prayer_book_code: 'loc_2019', service_type: 'morning_prayer')
      readings = service.find_readings

      expect(readings).to be_present
      expect(readings[:psalm][:reference]).to include('1')
      expect(readings[:first_reading][:reference]).to include('Gênesis 1')
    end

    it "finds correct Evening Prayer readings for Jan 1" do
      date = Date.new(2026, 1, 1)
      service = ReadingService.for(date, prayer_book_code: 'loc_2019', service_type: 'evening_prayer')
      readings = service.find_readings

      expect(readings).to be_present
      expect(readings[:psalm][:reference]).to include('3')
      expect(readings[:first_reading][:reference]).to include('Gálatas 1')
    end

    it "finds proper readings for Maundy Thursday Morning Prayer" do
      # Maundy Thursday 2026 is April 2
      date = Date.new(2026, 4, 2)
      service = ReadingService.for(date, prayer_book_code: 'loc_2019', service_type: 'morning_prayer')

      # DEBUG
      puts "Cycle: #{service.cycle}"
      puts "Celebration: #{service.calendar.celebration_for_date(date).inspect}"

      readings = service.find_readings

      expect(readings).to be_present
      # Should find the specific Maundy Thursday reading, not the daily one for April 2
      # Note: April 2 daily reading would be Exod 40
      expect(readings[:first_reading][:reference]).to include('Daniel 9')
    end
  end

  describe "LOC 2019 EN (English)" do
    it "finds correct Morning Prayer readings for Jan 1" do
      date = Date.new(2026, 1, 1)
      service = ReadingService.for(date, prayer_book_code: 'loc_2019_en', service_type: 'morning_prayer')
      readings = service.find_readings

      expect(readings).to be_present
      expect(readings[:psalm][:reference]).to include('1')
      expect(readings[:first_reading][:reference]).to include('Gen 1')
    end

    it "finds correct Evening Prayer readings for Jan 1" do
      date = Date.new(2026, 1, 1)
      service = ReadingService.for(date, prayer_book_code: 'loc_2019_en', service_type: 'evening_prayer')
      readings = service.find_readings

      expect(readings).to be_present
      expect(readings[:psalm][:reference]).to include('3')
      expect(readings[:first_reading][:reference]).to include('Gal 1')
    end
  end

  describe "Reading Service Logic" do
    it "correctly identifies PT month names for LOC 2019" do
      calendar = LiturgicalCalendar.new(2026, prayer_book_code: 'loc_2019')
      date = Date.new(2026, 3, 15)
      builder = Reading::ReferenceBuilder.new(date, calendar: calendar)

      # Should use marco_15, not march_15
      refs = builder.weekly_references
      expect(refs).to include('marco_15')
      expect(refs).not_to include('march_15')
    end

    it "correctly identifies EN month names for LOC 2019 EN" do
      calendar = LiturgicalCalendar.new(2026, prayer_book_code: 'loc_2019_en')
      date = Date.new(2026, 3, 15)
      builder = Reading::ReferenceBuilder.new(date, calendar: calendar)

      # Should use march_15
      refs = builder.weekly_references
      expect(refs).to include('march_15')
      expect(refs).not_to include('marco_15')
    end
  end
end
