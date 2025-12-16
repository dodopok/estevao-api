# frozen_string_literal: true

require "rails_helper"
require "benchmark"

RSpec.describe "DailyOffice Performance" do
  let(:prayer_book) { create(:prayer_book, code: "loc_2015") }
  let(:date) { Date.new(2025, 12, 13) }
  let(:preferences) do
    {
      prayer_book_code: "loc_2015",
      bible_version: "nvi",
      language: "pt-BR",
      confession_type: "long",
      lords_prayer_version: "traditional",
      creed_type: :apostles
    }
  end

  before do
    # Ensure prayer book exists
    prayer_book
  end

  describe "DailyOfficeService" do
    it "completes morning office in reasonable time" do
      # Warm up
      service = DailyOfficeService.new(
        date: date,
        office_type: :morning,
        preferences: preferences
      )
      service.call

      # Benchmark
      time = Benchmark.realtime do
        10.times do
          service = DailyOfficeService.new(
            date: date,
            office_type: :morning,
            preferences: preferences
          )
          service.call
        end
      end

      average_time = time / 10
      puts "\n  Average DailyOfficeService time: #{(average_time * 1000).round(2)}ms"

      # Should complete in less than 500ms on average
      expect(average_time).to be < 0.5
    end

    it "completes multiple office types efficiently" do
      office_types = [ :morning, :midday, :evening, :compline ]

      time = Benchmark.realtime do
        office_types.each do |office_type|
          service = DailyOfficeService.new(
            date: date,
            office_type: office_type,
            preferences: preferences
          )
          service.call
        end
      end

      puts "\n  Time for all 4 office types: #{(time * 1000).round(2)}ms"

      # Should complete all 4 types in less than 2 seconds
      expect(time).to be < 2.0
    end
  end

  describe "LiturgicalCalendar" do
    it "generates day info efficiently" do
      calendar = LiturgicalCalendar.new(date.year, prayer_book_code: "loc_2015")

      # Warm up
      calendar.day_info(date)

      time = Benchmark.realtime do
        10.times do
          calendar.day_info(date)
        end
      end

      average_time = time / 10
      puts "\n  Average LiturgicalCalendar.day_info time: #{(average_time * 1000).round(2)}ms"

      # Should complete in less than 100ms on average
      expect(average_time).to be < 0.1
    end

    it "generates month calendar efficiently" do
      calendar = LiturgicalCalendar.new(date.year, prayer_book_code: "loc_2015")

      time = Benchmark.realtime do
        calendar.month_calendar(12)
      end

      puts "\n  Time to generate month calendar: #{(time * 1000).round(2)}ms"

      # Should complete a full month in less than 2 seconds
      expect(time).to be < 2.0
    end
  end

  describe "ReadingService" do
    it "finds readings efficiently" do
      # Warm up
      service = ReadingService.for(date, prayer_book_code: "loc_2015")
      service.find_readings

      time = Benchmark.realtime do
        10.times do
          service = ReadingService.for(date, prayer_book_code: "loc_2015")
          service.find_readings
        end
      end

      average_time = time / 10
      puts "\n  Average ReadingService.find_readings time: #{(average_time * 1000).round(2)}ms"

      # Should complete in less than 100ms on average
      expect(average_time).to be < 0.1
    end

    it "handles multiple consecutive dates efficiently" do
      dates = (0..6).map { |i| date + i.days }

      time = Benchmark.realtime do
        dates.each do |test_date|
          service = ReadingService.for(test_date, prayer_book_code: "loc_2015")
          service.find_readings
        end
      end

      puts "\n  Time for 7 consecutive days of readings: #{(time * 1000).round(2)}ms"

      # Should complete 7 days in less than 1 second
      expect(time).to be < 1.0
    end
  end

  describe "Database query efficiency" do
    it "uses minimal queries for daily office generation" do
      # Count queries for a single daily office call
      query_count = 0
      subscription = nil

      subscription = ActiveSupport::Notifications.subscribe("sql.active_record") do |*args|
        query_count += 1 unless args.last[:name] == "SCHEMA"
      end

      begin
        service = DailyOfficeService.new(
          date: date,
          office_type: :morning,
          preferences: preferences
        )
        service.call

        puts "\n  Database queries for one daily office: #{query_count}"

        # Should use less than 50 queries (reasonable threshold)
        # Lower is better - target would be < 20 queries
        expect(query_count).to be < 50
      ensure
        ActiveSupport::Notifications.unsubscribe(subscription) if subscription
      end
    end
  end
end
