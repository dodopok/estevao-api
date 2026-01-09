# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Lectionary Validation", type: :service do
  before(:all) do
    # Clear DB before loading seeds in test to avoid duplicate errors
    LectionaryReading.destroy_all
    Collect.destroy_all
    Celebration.destroy_all
    LiturgicalColor.destroy_all
    LiturgicalSeason.destroy_all
    PrayerBook.destroy_all
    BibleVersion.destroy_all

    # Load fundamental data needed for all prayer books
    load Rails.root.join('db/seeds/bible_versions.rb')
    load Rails.root.join('db/seeds/colors.rb')
    load Rails.root.join('db/seeds/seasons.rb')
    load Rails.root.join('db/seeds/prayer_books.rb')

    # Load specific prayer books seeds that I fixed
    %w[loc_1662 loc_2019 loc_2019_en loc_1987 locb_2008].each do |code|
      load Rails.root.join("db/seeds/prayer_books/#{code}/seed.rb")
    end
  end

  describe "LOC 1662 (Traditional BCP)" do
    let(:pb_code) { "loc_1662" }

    it "correctly identifies Septuagésima" do
      date = Date.new(2025, 2, 16)
      calendar = LiturgicalCalendar.new(date.year, prayer_book_code: pb_code)
      expect(calendar.sunday_name(date)).to eq("Septuagésima")
    end

    it "correctly identifies Sundays after Trinity" do
      date = Date.new(2025, 6, 22)
      calendar = LiturgicalCalendar.new(date.year, prayer_book_code: pb_code)
      expect(calendar.sunday_name(date)).to eq("1º Domingo após a Trindade")

      ref = SundayReferenceMapper.map(date, calendar)
      expect(ref).to eq("1st_sunday_after_trinity")
    end

    it "has readings for Trinity Sunday" do
      date = Date.new(2025, 6, 15)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present

      collect_service = CollectService.new(date, prayer_book_code: pb_code)
      expect(collect_service.find_collects).to be_present
    end

    it "has readings for 4th Sunday in Lent" do
      date = Date.new(2025, 3, 30)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present

      collect_service = CollectService.new(date, prayer_book_code: pb_code)
      expect(collect_service.find_collects).to be_present
    end

    it "has readings for 2nd Sunday after Christmas" do
      date = Date.new(2025, 1, 5)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present

      collect_service = CollectService.new(date, prayer_book_code: pb_code)
      expect(collect_service.find_collects).to be_present
    end

    it "has readings for 25th Sunday after Trinity 2026" do
      date = Date.new(2026, 11, 22)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present

      collect_service = CollectService.new(date, prayer_book_code: pb_code)
      expect(collect_service.find_collects).to be_present
    end
  end

  describe "LOC 2019 (ACNA Portuguese)" do
    let(:pb_code) { "loc_2019" }

    it "has daily office readings for January" do
      date = Date.new(2025, 1, 2)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present
    end
  end

  describe "LOC 1987 (IEAB)" do
    let(:pb_code) { "loc_1987" }

    it "has readings for Holy Name (Jan 1st)" do
      date = Date.new(2025, 1, 1)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present
    end

    it "has readings for Palm Sunday" do
      date = Date.new(2025, 4, 13)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present
    end
  end

  describe "LOCb 2008" do
    let(:pb_code) { "locb_2008" }

    it "has readings for Epiphany" do
      date = Date.new(2025, 1, 6)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present
    end

    it "has readings for Ascension" do
      date = Date.new(2025, 5, 29)
      service = ReadingService.for(date, prayer_book_code: pb_code)
      expect(service.find_readings).to be_present
    end
  end
end
