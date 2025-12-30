# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cacheable do
  let(:test_class) do
    Class.new do
      include Cacheable

      attr_reader :prayer_book_code

      def initialize(prayer_book_code: "loc_2015")
        @prayer_book_code = prayer_book_code
      end

      def fetch_data
        cache_fetch("test_key", expires_in: 1.hour, prayer_book_code: prayer_book_code) do
          "expensive_result"
        end
      end
    end
  end

  let(:service) { test_class.new }

  # Use memory store for cache tests
  around do |example|
    original_cache = Rails.cache
    Rails.cache = ActiveSupport::Cache::MemoryStore.new
    example.run
    Rails.cache = original_cache
  end

  before do
    Rails.cache.clear
  end

  describe "#build_cache_key" do
    it "includes v5 version prefix" do
      key = service.send(:build_cache_key, "test", "subkey")
      expect(key).to start_with("v5/")
    end

    it "joins parts with slashes" do
      key = service.send(:build_cache_key, "category", "subcategory", "item")
      expect(key).to eq("v5/category/subcategory/item")
    end

    context "with prayer_book_code" do
      let!(:pb) do
        PrayerBook.find_by(code: "loc_2015") ||
          create(:prayer_book, code: "loc_2015")
      end

      it "includes prayer_book updated_at in key" do
        key = service.send(:build_cache_key, "test", prayer_book_code: "loc_2015")
        expect(key).to match(/pb_\d+$/)
      end
    end
  end

  describe "#cache_fetch" do
    it "caches the result" do
      call_count = 0

      2.times do
        service.send(:cache_fetch, "counter_key", expires_in: 1.hour) do
          call_count += 1
          "result"
        end
      end

      expect(call_count).to eq(1)
    end

    it "returns cached value on subsequent calls" do
      result1 = service.send(:cache_fetch, "value_key", expires_in: 1.hour) { "first" }
      result2 = service.send(:cache_fetch, "value_key", expires_in: 1.hour) { "second" }

      expect(result1).to eq("first")
      expect(result2).to eq("first")
    end

    it "uses versioned key" do
      service.send(:cache_fetch, "my_key", expires_in: 1.hour) { "data" }

      expect(Rails.cache.exist?("v5/my_key")).to be true
    end
  end

  describe "#cache_delete" do
    it "deletes cached entry" do
      service.send(:cache_fetch, "delete_test", expires_in: 1.hour) { "data" }
      expect(Rails.cache.exist?("v5/delete_test")).to be true

      service.send(:cache_delete, "delete_test")
      expect(Rails.cache.exist?("v5/delete_test")).to be false
    end
  end

  describe "#extract_cache_category" do
    it "extracts category from cache key" do
      expect(service.send(:extract_cache_category, "v5/daily_office/2025-01-01/morning")).to eq("daily_office")
      expect(service.send(:extract_cache_category, "v5/readings/2025-01-01")).to eq("readings")
    end

    it "returns unknown for invalid keys" do
      expect(service.send(:extract_cache_category, "invalid")).to eq("unknown")
    end
  end

  describe "TTL constants" do
    it "defines expected TTL values" do
      expect(Cacheable::TTL::STATIC_DATA).to eq(30.days)
      expect(Cacheable::TTL::CALENDAR_YEAR).to eq(1.year)
      expect(Cacheable::TTL::DAILY_OFFICE).to eq(1.day)
      expect(Cacheable::TTL::READINGS).to eq(1.day)
      expect(Cacheable::TTL::PRAYER_BOOK).to eq(1.day)
      expect(Cacheable::TTL::USER_DATA).to eq(5.minutes)
    end
  end
end
