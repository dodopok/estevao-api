# frozen_string_literal: true

# Cache management tasks for Daily Office
#
# Usage:
#   rails cache:stats           # Show cache statistics
#   rails cache:warm            # Warm cache for today
#   rails cache:warm[2025-12-25] # Warm cache for specific date
#   rails cache:clear_daily_office # Clear all daily office cache
#   rails cache:clear_all       # Clear entire cache
#   rails cache:health          # Check cache health

namespace :cache do
  desc "Show cache statistics"
  task stats: :environment do
    puts "\n📊 Cache Statistics"
    puts "=" * 50

    # Check cache store type
    cache_store = Rails.cache.class.name
    puts "Cache Store: #{cache_store}"

    # For Redis, show additional info
    if cache_store.include?("Redis")
      begin
        redis_info = Rails.cache.redis.info
        puts "Redis Version: #{redis_info['redis_version']}"
        puts "Used Memory: #{redis_info['used_memory_human']}"
        puts "Connected Clients: #{redis_info['connected_clients']}"
        puts "Total Keys: #{redis_info['db0']&.match(/keys=(\d+)/)[1] || 'N/A'}"
      rescue StandardError => e
        puts "Redis Info Error: #{e.message}"
      end
    end

    puts "\n📦 Cached Data Summary:"
    puts "-" * 50

    # Count cached items by category
    categories = %w[prayer_book liturgical_texts psalms collects calendar readings daily_office]

    categories.each do |category|
      begin
        pattern = "v4/#{category}/*"
        if Rails.cache.respond_to?(:redis)
          count = Rails.cache.redis.keys(pattern).size
          puts "  #{category}: #{count} entries"
        else
          puts "  #{category}: N/A (memory store)"
        end
      rescue StandardError
        puts "  #{category}: Error"
      end
    end

    puts "\n"
  end

  desc "Warm cache for today (or specified date)"
  task :warm, [ :date ] => :environment do |_t, args|
    date = args[:date] ? Date.parse(args[:date]) : Date.current

    puts "\n🔥 Warming Daily Office Cache"
    puts "=" * 50
    puts "Date: #{date}"
    puts "Prayer Books: #{PrayerBook.all_cached.map(&:code).join(', ')}"
    puts "-" * 50

    start_time = Time.current

    result = DailyOfficeWarmerJob.perform_now(date: date.to_s)

    puts "\n✅ Cache Warming Complete!"
    puts "  Offices Warmed: #{result[:offices_warmed]}"
    puts "  Errors: #{result[:errors].size}"
    puts "  Duration: #{result[:duration_ms]}ms"

    if result[:errors].any?
      puts "\n⚠️  Errors:"
      result[:errors].each do |err|
        puts "    - #{err[:prayer_book]}/#{err[:office_type]}: #{err[:error]}"
      end
    end

    puts "\n"
  end

  desc "Clear all daily office cache entries"
  task clear_daily_office: :environment do
    puts "\n🧹 Clearing Daily Office Cache..."

    begin
      if Rails.cache.respond_to?(:delete_matched)
        Rails.cache.delete_matched("v4/daily_office/*")
        Rails.cache.delete_matched("v4/readings/*")
        Rails.cache.delete_matched("v4/collects/*")
        Rails.cache.delete_matched("v4/calendar/*")
        puts "✅ Daily office cache cleared!"
      else
        puts "⚠️  delete_matched not supported. Use cache:clear_all instead."
      end
    rescue StandardError => e
      puts "❌ Error: #{e.message}"
    end

    puts "\n"
  end

  desc "Clear all cached data"
  task clear_all: :environment do
    puts "\n🧹 Clearing ALL Cache..."

    Rails.cache.clear
    puts "✅ All cache cleared!"

    puts "\n"
  end

  desc "Check cache health"
  task health: :environment do
    puts "\n🏥 Cache Health Check"
    puts "=" * 50

    checks = []

    # Check 1: Cache store is working
    begin
      test_key = "health_check_#{Time.current.to_i}"
      Rails.cache.write(test_key, "ok", expires_in: 1.minute)
      result = Rails.cache.read(test_key)
      Rails.cache.delete(test_key)

      if result == "ok"
        checks << { name: "Write/Read/Delete", status: "✅ PASS" }
      else
        checks << { name: "Write/Read/Delete", status: "❌ FAIL - Unexpected value" }
      end
    rescue StandardError => e
      checks << { name: "Write/Read/Delete", status: "❌ FAIL - #{e.message}" }
    end

    # Check 2: Prayer book cache
    begin
      pb = PrayerBook.find_by_code("loc_2015")
      checks << { name: "PrayerBook Cache", status: pb ? "✅ PASS" : "⚠️  No prayer book found" }
    rescue StandardError => e
      checks << { name: "PrayerBook Cache", status: "❌ FAIL - #{e.message}" }
    end

    # Check 3: Liturgical texts cache
    begin
      texts = LiturgicalText.texts_cache_for("loc_2015")
      count = texts.size
      checks << { name: "LiturgicalText Cache", status: count > 0 ? "✅ PASS (#{count} texts)" : "⚠️  Empty" }
    rescue StandardError => e
      checks << { name: "LiturgicalText Cache", status: "❌ FAIL - #{e.message}" }
    end

    # Check 4: Daily office generation
    begin
      start = Time.current
      service = DailyOfficeService.new(
        date: Date.current,
        office_type: :morning,
        preferences: { prayer_book_code: "loc_2015" }
      )
      result = service.call
      duration = ((Time.current - start) * 1000).round(2)

      if result && result[:modules].present?
        checks << { name: "DailyOffice Generation", status: "✅ PASS (#{duration}ms)" }
      else
        checks << { name: "DailyOffice Generation", status: "⚠️  Empty response" }
      end
    rescue StandardError => e
      checks << { name: "DailyOffice Generation", status: "❌ FAIL - #{e.message}" }
    end

    # Print results
    puts "\nResults:"
    puts "-" * 50
    checks.each do |check|
      puts "  #{check[:name]}: #{check[:status]}"
    end

    all_passed = checks.all? { |c| c[:status].start_with?("✅") }
    puts "\n#{all_passed ? '✅ All checks passed!' : '⚠️  Some checks failed'}"
    puts "\n"
  end

  desc "Benchmark cache performance"
  task benchmark: :environment do
    require "benchmark"

    puts "\n⏱️  Cache Performance Benchmark"
    puts "=" * 50

    date = Date.current
    prayer_book_code = "loc_2015"
    iterations = 10

    # Clear cache first
    Rails.cache.delete_matched("v4/daily_office/*") if Rails.cache.respond_to?(:delete_matched)

    puts "\nBenchmarking #{iterations} iterations..."
    puts "-" * 50

    # Cold cache (first request)
    cold_time = Benchmark.realtime do
      DailyOfficeService.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: prayer_book_code }
      ).call
    end

    puts "Cold cache (first request): #{(cold_time * 1000).round(2)}ms"

    # Warm cache (subsequent requests)
    warm_times = []
    iterations.times do
      warm_times << Benchmark.realtime do
        DailyOfficeService.new(
          date: date,
          office_type: :morning,
          preferences: { prayer_book_code: prayer_book_code }
        ).call
      end
    end

    avg_warm = (warm_times.sum / warm_times.size * 1000).round(2)
    min_warm = (warm_times.min * 1000).round(2)
    max_warm = (warm_times.max * 1000).round(2)

    puts "\nWarm cache (#{iterations} requests):"
    puts "  Average: #{avg_warm}ms"
    puts "  Min: #{min_warm}ms"
    puts "  Max: #{max_warm}ms"

    improvement = ((1 - (avg_warm / (cold_time * 1000))) * 100).round(1)
    puts "\n📈 Cache improvement: #{improvement}%"
    puts "\n"
  end

  desc "Export Datadog dashboard JSON"
  task export_dashboard: :environment do
    puts DatadogCacheMetrics.export_dashboard_json
  end
end
