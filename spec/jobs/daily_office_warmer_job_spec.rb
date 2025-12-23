# frozen_string_literal: true

require "rails_helper"

RSpec.describe DailyOfficeWarmerJob, type: :job do
  before(:all) do
    setup_full_liturgical_data
  end

  # Use memory store for cache tests
  around do |example|
    original_cache = Rails.cache
    Rails.cache = ActiveSupport::Cache::MemoryStore.new
    example.run
    Rails.cache = original_cache
  end

  describe "#perform" do
    let(:date) { Date.new(2025, 12, 25) }

    before do
      Rails.cache.clear
    end

    it "warms cache for all office types" do
      result = described_class.perform_now(
        date: date.to_s,
        prayer_book_codes: [ "loc_2015" ]
      )

      expect(result[:offices_warmed]).to eq(4)
    end

    it "warms cache for specified prayer books" do
      result = described_class.perform_now(
        date: date.to_s,
        prayer_book_codes: [ "loc_2015" ]
      )

      expect(result[:offices_warmed]).to eq(4) # 4 office types
    end

    it "skips already cached offices on second run" do
      # Warm once
      first_result = described_class.perform_now(
        date: date.to_s,
        prayer_book_codes: [ "loc_2015" ]
      )
      expect(first_result[:offices_warmed]).to eq(4)

      # Warm again - should skip cached entries
      # (The cache key includes prayer_book.updated_at, so we need to ensure
      # no updates happen between runs)
      second_result = described_class.perform_now(
        date: date.to_s,
        prayer_book_codes: [ "loc_2015" ]
      )

      # All offices should be skipped (already cached)
      expect(second_result[:offices_warmed]).to eq(0)
    end

    it "returns timing information" do
      result = described_class.perform_now(
        date: date.to_s,
        prayer_book_codes: [ "loc_2015" ]
      )

      expect(result[:duration_ms]).to be_a(Numeric)
      expect(result[:duration_ms]).to be >= 0
    end

    context "with specific prayer_book_codes" do
      it "only warms specified prayer books" do
        result = described_class.perform_now(
          date: date.to_s,
          prayer_book_codes: [ "loc_2015" ]
        )

        expect(result[:offices_warmed]).to eq(4) # 4 office types
      end
    end

    context "with default date" do
      it "uses current date when not specified" do
        result = described_class.perform_now(prayer_book_codes: [ "loc_2015" ])

        expect(result[:date]).to eq(Date.current.to_s)
      end
    end
  end

  describe ".warm_tomorrow" do
    it "enqueues job for tomorrow" do
      expect {
        described_class.warm_tomorrow
      }.to have_enqueued_job(described_class).with(date: Date.tomorrow.to_s)
    end
  end

  describe ".warm_for_timezone" do
    it "enqueues job for today in specified timezone" do
      timezone = "Asia/Tokyo"
      today_in_tz = Time.current.in_time_zone(timezone).to_date

      expect {
        described_class.warm_for_timezone(timezone)
      }.to have_enqueued_job(described_class).with(date: today_in_tz.to_s)
    end
  end

  describe "error handling" do
    it "records errors but continues warming other offices" do
      call_count = 0
      allow_any_instance_of(DailyOfficeService).to receive(:call).and_wrap_original do |method, *args|
        call_count += 1
        if call_count == 1
          raise "Test error"
        else
          method.call(*args)
        end
      end

      result = described_class.perform_now(
        date: Date.current.to_s,
        prayer_book_codes: [ "loc_2015" ]
      )

      expect(result[:errors].size).to eq(1)
      expect(result[:offices_warmed]).to eq(3)
    end
  end

  describe "queue" do
    it "uses low priority queue" do
      expect(described_class.new.queue_name).to eq("low")
    end
  end
end
