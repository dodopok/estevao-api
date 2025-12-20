# frozen_string_literal: true

namespace :cache do
  desc "Warm up application caches for better performance"
  task warm: :environment do
    puts "🔥 Warming up application caches..."

    # Warm up liturgical texts cache for all active prayer books
    PrayerBook.active.find_each do |prayer_book|
      print "  📖 #{prayer_book.name} (#{prayer_book.code})... "
      texts = LiturgicalText.texts_cache_for(prayer_book.code)
      puts "✓ (#{texts.size} texts cached)"
    end

    # Warm up today's daily office for common configurations
    today = Date.today
    PrayerBook.active.limit(1).each do |prayer_book|
      %i[morning evening].each do |office_type|
        print "  🙏 Daily Office #{office_type} (#{prayer_book.code})... "

        # Build cache key using same logic as DailyOfficeController
        # Note: Using simplified preferences hash for warmup
        prefs_hash = Digest::MD5.hexdigest({ prayer_book_code: prayer_book.code }.to_json)[0..7]
        cache_key = "daily_office/v2/#{today}/#{office_type}/#{prefs_hash}"

        Rails.cache.fetch(cache_key, expires_in: 1.day) do
          DailyOfficeService.new(
            date: today,
            office_type: office_type,
            preferences: { prayer_book_code: prayer_book.code }
          ).call
        end
        puts "✓"
      rescue StandardError => e
        puts "✗ (#{e.message})"
      end
    end

    # Warm up today's calendar data
    prayer_book = PrayerBook.active.first
    if prayer_book
      print "  📅 Liturgical calendar for today (#{prayer_book.code})... "
      cache_key = "calendar/today/#{today}/#{prayer_book.code}/nvi"
      Rails.cache.fetch(cache_key, expires_in: 1.day) do
        calendar = LiturgicalCalendar.new(today.year, prayer_book_code: prayer_book.code)
        calendar.day_info(today)
      end
      puts "✓"
    end

    puts "\n✨ Cache warming complete!"
  end

  desc "Clear all application caches"
  task clear: :environment do
    puts "🧹 Clearing application caches..."

    # Clear Rails cache
    Rails.cache.clear
    puts "  ✓ Rails cache cleared"

    puts "\n✨ Cache clearing complete!"
  end
end

namespace :db do
  desc "Verify data integrity and report statistics"
  task verify: :environment do
    puts "🔍 Verifying database integrity...\n"

    # Check prayer books
    prayer_books = PrayerBook.count
    active_prayer_books = PrayerBook.active.count
    puts "📚 Prayer Books: #{active_prayer_books}/#{prayer_books} active"

    # Check celebrations
    celebrations = Celebration.count
    celebrations_by_type = Celebration.group(:celebration_type).count
    puts "\n✝️  Celebrations: #{celebrations} total"
    celebrations_by_type.each do |type, count|
      puts "  - #{type}: #{count}"
    end

    # Check liturgical texts
    liturgical_texts = LiturgicalText.count
    texts_with_audio = LiturgicalText.where("audio_urls != '{}'::jsonb").count
    puts "\n📝 Liturgical Texts: #{liturgical_texts} total"
    puts "  - With audio: #{texts_with_audio} (#{(texts_with_audio.to_f / liturgical_texts * 100).round(1)}%)"

    # Check users and completions
    users = User.count
    completions = Completion.count
    recent_completions = Completion.where("created_at > ?", 7.days.ago).count
    puts "\n👥 Users: #{users} total"
    puts "  - Completions: #{completions} total"
    puts "  - Last 7 days: #{recent_completions}"

    # Check lectionary readings
    lectionary_readings = LectionaryReading.count
    puts "\n📖 Lectionary Readings: #{lectionary_readings} total"

    # Find potential issues
    puts "\n⚠️  Potential Issues:"

    # Celebrations without collects
    celebrations_without_collects = Celebration.left_joins(:collects)
                                               .where(collects: { id: nil })
                                               .where(celebration_type: [ :principal_feast, :major_holy_day ])
                                               .count
    if celebrations_without_collects > 0
      puts "  - #{celebrations_without_collects} major celebrations without collects"
    end

    # Check for orphaned records
    orphaned_completions = Completion.where.not(user_id: User.pluck(:id)).count
    if orphaned_completions > 0
      puts "  - #{orphaned_completions} completions with invalid user_id"
    end

    if celebrations_without_collects.zero? && orphaned_completions.zero?
      puts "  ✓ No issues found"
    end

    puts "\n✨ Verification complete!"
  end
end

namespace :performance do
  desc "Analyze query performance for common operations"
  task analyze: :environment do
    puts "📊 Analyzing query performance...\n"

    require "benchmark"

    # Test 1: Daily Office generation
    print "🙏 Daily Office generation (cold cache)... "
    Rails.cache.clear
    time = Benchmark.realtime do
      DailyOfficeService.new(
        date: Date.today,
        office_type: :morning,
        preferences: { prayer_book_code: "loc_2015" }
      ).call
    end
    puts "#{(time * 1000).round(0)}ms"

    # Test 2: Daily Office generation (warm cache)
    print "🙏 Daily Office generation (warm cache)... "
    time = Benchmark.realtime do
      DailyOfficeService.new(
        date: Date.today,
        office_type: :morning,
        preferences: { prayer_book_code: "loc_2015" }
      ).call
    end
    puts "#{(time * 1000).round(0)}ms"

    # Test 3: Calendar lookup
    print "📅 Calendar day lookup... "
    time = Benchmark.realtime do
      calendar = LiturgicalCalendar.new(Date.today.year, prayer_book_code: "loc_2015")
      calendar.day_info(Date.today)
    end
    puts "#{(time * 1000).round(0)}ms"

    # Test 4: Reading service
    print "📖 Reading service lookup... "
    time = Benchmark.realtime do
      ReadingService.for(Date.today, prayer_book_code: "loc_2015").find_readings
    end
    puts "#{(time * 1000).round(0)}ms"

    puts "\n✨ Performance analysis complete!"
    puts "\nℹ️  Note: Run 'rake cache:warm' to optimize production performance"
  end
end
