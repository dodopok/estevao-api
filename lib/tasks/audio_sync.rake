# frozen_string_literal: true

namespace :audio do
  desc "Sync local audio files to Railway and update database"
  task sync_to_railway: :environment do
    puts "🎵 Audio Sync to Railway Started"
    puts "=" * 60

    # Get prayer book
    prayer_book = PrayerBook.find_by(code: 'loc_2015')
    unless prayer_book
      puts "❌ Prayer book 'loc_2015' not found. Run db:seed first."
      exit 1
    end

    # Scan local audio files
    audio_files = Dir.glob("public/audio/**/*.mp3")
    puts "📁 Found #{audio_files.count} audio files locally"

    synced_count = 0
    updated_count = 0
    failed_count = 0

    audio_files.each_with_index do |file_path, index|
      # Extract info from path: public/audio/loc_2015/male_1/loc_2015_3171_morning_invocation.mp3
      # Pattern: public/audio/{prayer_book}/{voice}/{prayer_book}_{id}_{slug}.mp3
      filename = File.basename(file_path, '.mp3')
      parts = filename.split('_')
      
      # Skip if filename doesn't have at least 3 parts (prayer_book_id_slug)
      if parts.length < 3
        puts "⚠️  Skipping malformed path: #{file_path}"
        failed_count += 1
        next
      end

      # Extract voice from directory path
      voice_key = file_path.split('/')[-2]
      
      # Slug is everything after the second underscore (loc_2015_morning_invocation → morning_invocation)
      slug = parts[2..-1].join('_')
      
      # Find liturgical text by slug
      text = LiturgicalText.find_by(slug: slug, prayer_book: prayer_book)
      unless text
        puts "⚠️  Text '#{slug}' not found, skipping: #{file_path}"
        failed_count += 1
        next
      end

      # Generate URL (relative path for serving)
      audio_url = "/#{file_path.sub('public/', '')}"

      # Update database if not already set
      current_url = text.audio_urls[voice_key]
      if current_url != audio_url
        text.set_audio_url(voice_key, audio_url)
        updated_count += 1
        
        if (index + 1) % 50 == 0
          puts "✅ Updated #{updated_count}/#{index + 1} texts..."
        end
      else
        synced_count += 1
      end
    end

    puts "\n" + "=" * 60
    puts "🎉 Audio Sync Completed!"
    puts "   📊 Total files: #{audio_files.count}"
    puts "   ✅ Updated in DB: #{updated_count}"
    puts "   ✓  Already synced: #{synced_count}"
    puts "   ⚠️  Failed/Skipped: #{failed_count}"
    puts "=" * 60
  end

  desc "Verify audio files match database records"
  task verify: :environment do
    puts "🔍 Verifying Audio Files"
    puts "=" * 60

    prayer_book = PrayerBook.find_by(code: 'loc_2015')
    texts_with_audio = LiturgicalText.where(prayer_book: prayer_book)
                                     .where.not(audio_urls: {})

    missing_files = []
    verified_count = 0

    texts_with_audio.find_each do |text|
      text.audio_urls.each do |voice_key, url|
        file_path = "public#{url}"
        
        if File.exist?(file_path)
          verified_count += 1
        else
          missing_files << { text_id: text.id, voice: voice_key, path: file_path }
        end
      end
    end

    puts "✅ Verified: #{verified_count} audio files exist"
    
    if missing_files.any?
      puts "❌ Missing: #{missing_files.count} files"
      puts "\nFirst 10 missing files:"
      missing_files.first(10).each do |item|
        puts "  - Text ##{item[:text_id]} (#{item[:voice]}): #{item[:path]}"
      end
    else
      puts "🎉 All audio files verified successfully!"
    end

    puts "=" * 60
  end

  desc "Upload audio files to Railway volume"
  task upload_to_railway: :environment do
    puts "📤 Uploading Audio Files to Railway"
    puts "=" * 60
    puts ""
    puts "⚠️  This task should be run LOCALLY (not on Railway)"
    puts "   It will compress and upload files via Railway CLI"
    puts ""
    puts "Prerequisites:"
    puts "  1. Railway CLI installed: brew install railway"
    puts "  2. Railway CLI logged in: railway login"
    puts "  3. Railway project linked: railway link"
    puts ""
    puts "Steps to execute:"
    puts ""
    puts "  # 1. Compress audio files locally"
    puts "  cd /Users/douglas/projects/estevao-api"
    puts "  tar -czf audios.tar.gz -C public audio/"
    puts ""
    puts "  # 2. Upload to temporary storage (choose one option):"
    puts ""
    puts "  # Option A: Upload to Railway container and extract"
    puts "  # Note: Railway CLI doesn't support direct file upload"
    puts "  # You'll need to use a temporary hosting service"
    puts ""
    puts "  # Upload to transfer.sh (temporary, 14 days)"
    puts "  curl --upload-file audios.tar.gz https://transfer.sh/audios.tar.gz"
    puts "  # Copy the returned URL"
    puts ""
    puts "  # 3. Download and extract on Railway"
    puts "  railway run bash"
    puts "  # Inside Railway container:"
    puts "  cd /rails/public"
    puts "  wget <URL_FROM_TRANSFER_SH>"
    puts "  tar -xzf audios.tar.gz"
    puts "  rm audios.tar.gz"
    puts "  ls -lah audio/loc_2015/"
    puts ""
    puts "  # Option B: Use Cloudflare R2 / AWS S3 as intermediate"
    puts "  # (See RAILWAY_MIGRATION.md for CDN setup)"
    puts ""
    puts "  # 4. Verify upload"
    puts "  railway run bash -c 'find /rails/public/audio -name \"*.mp3\" | wc -l'"
    puts "  # Should show: 326 files"
    puts ""
    puts "  # 5. Update database on Railway"
    puts "  railway run rake audio:sync_to_railway"
    puts ""
    puts "=" * 60
  end

  desc "Show audio generation statistics"
  task stats: :environment do
    puts "📊 Audio Generation Statistics"
    puts "=" * 60

    LiturgicalText::AVAILABLE_VOICES.each do |voice|
      total = LiturgicalText.for_audio_generation.count
      generated = LiturgicalText.for_audio_generation
                                .where("audio_urls->? IS NOT NULL", voice)
                                .count
      percentage = total > 0 ? (generated.to_f / total * 100).round(1) : 0

      puts "#{voice.ljust(10)} : #{generated}/#{total} (#{percentage}%)"
    end

    puts "=" * 60
  end
end
