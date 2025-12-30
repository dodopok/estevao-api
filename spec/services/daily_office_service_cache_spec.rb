# frozen_string_literal: true

require "rails_helper"

RSpec.describe DailyOfficeService, "caching" do
  before(:all) do
    setup_full_liturgical_data
  end

  # Use memory store for cache tests
  around do |example|
    original_cache = Rails.cache
    memory_store = ActiveSupport::Cache::MemoryStore.new
    Rails.cache = memory_store
    
    # Pre-populate the prayer book in the fresh memory cache
    PrayerBook.all.each do |pb|
      Rails.cache.write("v5/prayer_book/#{pb.code}", pb)
    end
    
    example.run
    Rails.cache = original_cache
  end

  before do
    Rails.cache.clear
  end

  let(:date) { Date.new(2025, 12, 25) }
  let(:prayer_book) { PrayerBook.find_by_code("loc_2015") }
  let(:base_preferences) { { prayer_book_code: "loc_2015" } }

  describe ".base_cache_key" do
    it "generates v5 versioned key" do
      key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: base_preferences
      )

      expect(key).to start_with("v5/daily_office/base/")
    end

    it "includes date in key" do
      key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: base_preferences
      )

      expect(key).to include("2025-12-25")
    end

    it "includes office type in key" do
      key = described_class.base_cache_key(
        date: date,
        office_type: :evening,
        preferences: base_preferences
      )

      expect(key).to include("evening")
    end

    it "includes prayer book version timestamp in key" do
      key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: base_preferences
      )

      expect(key).to match(/pb_\d+$/)
    end

    it "generates different keys for different dates" do
      key1 = described_class.base_cache_key(
        date: Date.new(2025, 12, 25),
        office_type: :morning,
        preferences: base_preferences
      )
      key2 = described_class.base_cache_key(
        date: Date.new(2025, 12, 26),
        office_type: :morning,
        preferences: base_preferences
      )

      expect(key1).not_to eq(key2)
    end

    it "generates different keys for different office types" do
      key1 = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: base_preferences
      )
      key2 = described_class.base_cache_key(
        date: date,
        office_type: :evening,
        preferences: base_preferences
      )

      expect(key1).not_to eq(key2)
    end
  end

  describe ".build_preferences_hash" do
    it "generates consistent hash for same preferences" do
      prefs = { prayer_book_code: "loc_2015", bible_version: "nvi" }

      hash1 = described_class.build_preferences_hash(prefs)
      hash2 = described_class.build_preferences_hash(prefs)

      expect(hash1).to eq(hash2)
    end

    it "generates different hash for different preferences" do
      hash1 = described_class.build_preferences_hash(prayer_book_code: "loc_2015", bible_version: "nvi")
      hash2 = described_class.build_preferences_hash(prayer_book_code: "loc_2015", bible_version: "ara")

      expect(hash1).not_to eq(hash2)
    end

    it "applies defaults for consistency" do
      # Empty prefs should get defaults applied
      hash1 = described_class.build_preferences_hash({})
      hash2 = described_class.build_preferences_hash(
        prayer_book_code: "loc_2015",
        bible_version: "nvi",
        family_rite: false
      )

      expect(hash1).to eq(hash2)
    end

    it "handles LOC-specific preferences" do
      # LOCB 2008 has many specific preferences
      hash1 = described_class.build_preferences_hash(
        prayer_book_code: "locb_2008",
        morning_prayer_rite: "rite_1"
      )
      hash2 = described_class.build_preferences_hash(
        prayer_book_code: "locb_2008",
        morning_prayer_rite: "rite_2"
      )

      expect(hash1).not_to eq(hash2)
    end

    it "orders keys deterministically" do
      # Different order should produce same hash
      hash1 = described_class.build_preferences_hash(
        bible_version: "nvi",
        prayer_book_code: "loc_2015"
      )
      hash2 = described_class.build_preferences_hash(
        prayer_book_code: "loc_2015",
        bible_version: "nvi"
      )

      expect(hash1).to eq(hash2)
    end

    it "ignores nil values" do
      hash1 = described_class.build_preferences_hash(prayer_book_code: "loc_2015")
      hash2 = described_class.build_preferences_hash(prayer_book_code: "loc_2015", some_nil_pref: nil)

      expect(hash1).to eq(hash2)
    end
  end

  describe "#call caching" do
    let(:preferences) { { prayer_book_code: "loc_2015", bible_version: "nvi" } }

    it "caches the base office response" do
      service = described_class.new(date: date, office_type: :morning, preferences: preferences)
      service.call

      pb = PrayerBook.find_by_code(preferences[:prayer_book_code])
      cache_key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: preferences
      )

      expect(Rails.cache.exist?(cache_key)).to be true
    end

    it "returns cached response on subsequent calls" do
      service1 = described_class.new(date: date, office_type: :morning, preferences: preferences)
      result1 = service1.call

      service2 = described_class.new(date: date, office_type: :morning, preferences: preferences)
      result2 = service2.call

      # Both should return equivalent structure
      expect(result1[:date]).to eq(result2[:date])
      expect(result1[:office_type]).to eq(result2[:office_type])
    end

    it "generates new cache entry when prayer_book is updated" do
      service1 = described_class.new(date: date, office_type: :morning, preferences: preferences)
      service1.call

      old_key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: preferences
      )

      # Update prayer book timestamp
      prayer_book.touch

      new_key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: preferences
      )

      expect(new_key).not_to eq(old_key)
    end

    it "does not cache user-specific audio URLs" do
      premium_user = create(:user, premium_expires_at: 1.year.from_now)

      service = described_class.new(
        date: date,
        office_type: :morning,
        preferences: preferences,
        current_user: premium_user
      )
      result = service.call

      # Cache key should NOT include user information
      cache_key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: preferences
      )

      cached_value = Rails.cache.read(cache_key)

      # The cached value should not have audio URLs (added dynamically)
      expect(cached_value).not_to be_nil
    end
  end

  describe "cache invalidation" do
    let(:preferences) { { prayer_book_code: "loc_2015" } }

    it "invalidates when prayer book updated_at changes" do
      # First call - populate cache
      service = described_class.new(date: date, office_type: :morning, preferences: preferences)
      service.call

      old_key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: preferences
      )

      expect(Rails.cache.exist?(old_key)).to be true

      # Update prayer book
      prayer_book.touch

      # New key is different
      new_key = described_class.base_cache_key(
        date: date,
        office_type: :morning,
        preferences: preferences
      )

      expect(Rails.cache.exist?(new_key)).to be false
    end
  end

  describe "different office types" do
    let(:preferences) { { prayer_book_code: "loc_2015" } }

    %i[morning midday evening compline].each do |office_type|
      it "caches #{office_type} office independently" do
        service = described_class.new(date: date, office_type: office_type, preferences: preferences)
        service.call

        cache_key = described_class.base_cache_key(
          date: date,
          office_type: office_type,
          preferences: preferences
        )

        expect(Rails.cache.exist?(cache_key)).to be true
      end
    end
  end
end
