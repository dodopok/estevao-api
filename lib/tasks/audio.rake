# Audio Generation Tasks
namespace :audio do
  desc "Estimate cost of generating audio for a prayer book"
  task :estimate, [ :prayer_book_code, :voice_keys ] => :environment do |t, args|
    prayer_book_code = args[:prayer_book_code] || "loc_2015"
    voice_keys = args[:voice_keys]&.split(",") || LiturgicalText::AVAILABLE_VOICES

    # Validate voice keys
    invalid_voices = voice_keys - LiturgicalText::AVAILABLE_VOICES
    if invalid_voices.any?
      puts "\nERROR: Invalid voice key(s): #{invalid_voices.join(', ')}"
      puts "Valid voices: #{LiturgicalText::AVAILABLE_VOICES.join(', ')}"
      exit 1
    end

    puts "\n==== Audio Generation Cost Estimate ===="
    puts "Prayer Book: #{prayer_book_code}"

    prayer_book = PrayerBook.find_by(code: prayer_book_code)
    unless prayer_book
      puts "ERROR: Prayer book '#{prayer_book_code}' not found"
      exit 1
    end

    texts = LiturgicalText.for_prayer_book(prayer_book_code).for_audio_generation
    rubrics = LiturgicalText.for_prayer_book(prayer_book_code).where(category: "rubric")
    total_characters = texts.sum { |t| t.content.length }
    voice_count = voice_keys.count

    service = ElevenlabsAudioService.new
    estimate = service.estimate_cost(total_characters * voice_count)

    puts "\nStatistics:"
    puts "  Total texts: #{texts.count}"
    puts "  Rubrics (skipped): #{rubrics.count}"
    puts "  Texts for audio: #{texts.count}"
    puts "  Total characters: #{total_characters.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
    puts "  Voices: #{voice_count} (#{voice_keys.join(', ')})"
    puts "  Total characters (all voices): #{(total_characters * voice_count).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
    puts "\nEstimated Cost:"
    puts "  Cost per 1000 chars: $#{estimate[:cost_per_1000_chars]}"
    puts "  Total estimated cost: $#{estimate[:estimated_cost_usd]}"
    puts "\nNote: This is an estimate. Actual costs may vary slightly."
    puts "      Rubrics are automatically excluded from audio generation."
    puts "========================================\n"
  end

  desc "Generate audio for liturgical texts"
  task :generate, [ :prayer_book_code, :voice_keys ] => :environment do |t, args|
    prayer_book_code = args[:prayer_book_code] || "loc_2015"
    voice_keys = args[:voice_keys]&.split(",") || LiturgicalText::AVAILABLE_VOICES

    # Validate voice keys
    invalid_voices = voice_keys - LiturgicalText::AVAILABLE_VOICES
    if invalid_voices.any?
      puts "\nERROR: Invalid voice key(s): #{invalid_voices.join(', ')}"
      puts "Valid voices: #{LiturgicalText::AVAILABLE_VOICES.join(', ')}"
      puts "\nUsage: rake audio:generate[prayer_book_code,voice_keys]"
      puts "Examples:"
      puts "  rake audio:generate[loc_2015]                    # All voices"
      puts "  rake audio:generate[loc_2015,male_1]             # Single voice"
      puts '  rake "audio:generate[loc_2015,male_1\,female_1]" # Multiple voices'
      exit 1
    end

    puts "\n==== Starting Audio Generation ===="
    puts "Prayer Book: #{prayer_book_code}"
    puts "Voices: #{voice_keys.join(', ')}"

    # Run estimate first with the same voice_keys
    Rake::Task["audio:estimate"].reenable
    Rake::Task["audio:estimate"].invoke(prayer_book_code, voice_keys.join(","))

    print "\nDo you want to proceed with generation? (yes/no): "
    confirmation = STDIN.gets.chomp.downcase

    unless confirmation == "yes" || confirmation == "y"
      puts "Generation cancelled."
      exit 0
    end

    puts "\nStarting generation..."
    start_time = Time.current

    begin
      generator = BatchAudioGeneratorService.new(prayer_book_code, voice_keys)
      generator.generate

      duration = Time.current - start_time
      session = generator.session

      puts "\n==== Generation Complete ===="
      puts "Duration: #{duration.to_i} seconds (#{(duration / 60).round(1)} minutes)"
      puts "Total processed: #{session.processed_count}"
      puts "Failed: #{session.failed_count}"
      puts "Success rate: #{((session.processed_count - session.failed_count).to_f / session.processed_count * 100).round(1)}%"
      puts "========================================\n"
    rescue StandardError => e
      puts "\n==== Generation Failed ===="
      puts "Error: #{e.message}"
      puts "Check logs for details."
      puts "You can resume generation by running this task again."
      puts "========================================\n"
      exit 1
    end
  end

  desc "Generate voice samples for all voices"
  task generate_samples: :environment do
    puts "\n==== Generating Voice Samples ===="

    service = ElevenlabsAudioService.new

    LiturgicalText::AVAILABLE_VOICES.each do |voice_key|
      puts "Generating sample for #{voice_key}..."

      begin
        sample = service.generate_voice_sample(voice_key)

        # Save sample file
        filename = "sample_#{voice_key}.mp3"
        file_path = Rails.root.join("public", "audio", "samples", filename)

        FileUtils.mkdir_p(File.dirname(file_path))
        File.binwrite(file_path, sample[:audio_data])

        puts "  ✓ Saved: /audio/samples/#{filename}"
        puts "    Voice: #{sample[:voice_name]} (#{sample[:gender]})"
      rescue StandardError => e
        puts "  ✗ Failed: #{e.message}"
      end
    end

    puts "========================================\n"
  end

  desc "Clean up old generation sessions"
  task :cleanup_sessions, [ :days ] => :environment do |t, args|
    days = (args[:days] || 30).to_i
    cutoff_date = days.days.ago

    puts "\n==== Cleaning Up Old Sessions ===="
    puts "Removing sessions older than #{days} days (before #{cutoff_date.to_date})"

    old_sessions = AudioGenerationSession
      .where(status: [ "completed", "failed", "cancelled" ])
      .where("created_at < ?", cutoff_date)

    count = old_sessions.count

    if count.zero?
      puts "No old sessions found."
    else
      old_sessions.destroy_all
      puts "Removed #{count} old session(s)."
    end

    puts "========================================\n"
  end

  desc "Clean up orphaned audio files (not referenced in database)"
  task :cleanup_orphaned_files, [ :days, :dry_run ] => :environment do |t, args|
    days = (args[:days] || 30).to_i
    dry_run = args[:dry_run] != "false"
    cutoff_date = days.days.ago

    puts "\n==== Cleaning Up Orphaned Audio Files ===="
    puts "Mode: #{dry_run ? 'DRY RUN (no files will be deleted)' : 'LIVE (files will be deleted)'}"
    puts "Only considering files older than #{days} days"

    audio_dir = Rails.root.join("public", "audio")

    unless Dir.exist?(audio_dir)
      puts "Audio directory not found: #{audio_dir}"
      exit 0
    end

    # Get all audio URLs from database
    all_audio_urls = LiturgicalText.pluck(:audio_urls).flat_map(&:values).compact
    referenced_files = all_audio_urls.map { |url| Rails.root.join("public#{url}").to_s }.to_set

    orphaned_files = []
    total_size = 0

    # Scan all audio files
    Dir.glob(audio_dir.join("**", "*.mp3")).each do |file_path|
      next if file_path.include?("/samples/") # Skip voice samples
      next if referenced_files.include?(file_path)
      next if File.mtime(file_path) > cutoff_date # Skip recent files

      file_size = File.size(file_path)
      orphaned_files << { path: file_path, size: file_size }
      total_size += file_size
    end

    if orphaned_files.empty?
      puts "No orphaned files found."
    else
      puts "\nFound #{orphaned_files.count} orphaned file(s):"
      puts "Total size: #{(total_size / 1024.0 / 1024.0).round(2)} MB"

      orphaned_files.first(10).each do |file|
        relative_path = file[:path].sub(Rails.root.to_s, "")
        puts "  - #{relative_path} (#{(file[:size] / 1024.0).round(1)} KB)"
      end

      puts "  ... and #{orphaned_files.count - 10} more" if orphaned_files.count > 10

      if dry_run
        puts "\nDRY RUN: No files were deleted."
        puts "Run with dry_run=false to actually delete files:"
        puts "  rake audio:cleanup_orphaned_files[#{days},false]"
      else
        print "\nAre you sure you want to delete these files? (yes/no): "
        confirmation = STDIN.gets.chomp.downcase

        if confirmation == "yes" || confirmation == "y"
          orphaned_files.each { |file| File.delete(file[:path]) }
          puts "Deleted #{orphaned_files.count} file(s)."
        else
          puts "Deletion cancelled."
        end
      end
    end

    puts "========================================\n"
  end

  desc "Generate audio for a specific liturgical text"
  task :generate_text, [ :prayer_book_code, :slug, :voice_keys ] => :environment do |t, args|
    unless args[:prayer_book_code] && args[:slug]
      puts "Usage: rake audio:generate_text[prayer_book_code,slug,voice_keys]"
      puts "Example: rake audio:generate_text[loc_2015,morning_invocation,male_1]"
      puts "         rake audio:generate_text[loc_2015,morning_invocation,male_1,female_1]"
      exit 1
    end

    prayer_book_code = args[:prayer_book_code]
    slug = args[:slug]
    voice_keys = args[:voice_keys]&.split(",") || LiturgicalText::AVAILABLE_VOICES

    puts "\n==== Generating Audio for Specific Text ===="
    puts "Prayer Book: #{prayer_book_code}"
    puts "Slug: #{slug}"
    puts "Voices: #{voice_keys.join(', ')}"

    # Find the text
    text = LiturgicalText.for_prayer_book(prayer_book_code).find_by(slug: slug)

    unless text
      puts "\nERROR: Liturgical text not found"
      puts "  Prayer book: #{prayer_book_code}"
      puts "  Slug: #{slug}"
      exit 1
    end

    # Check if it's a rubric
    if text.category == "rubric"
      puts "\nWARNING: This is a rubric (category: #{text.category})"
      puts "Rubrics are typically skipped in audio generation."
      print "Do you want to proceed anyway? (yes/no): "
      confirmation = STDIN.gets.chomp.downcase

      unless confirmation == "yes" || confirmation == "y"
        puts "Generation cancelled."
        exit 0
      end
    end

    puts "\nText Details:"
    puts "  Category: #{text.category}"
    puts "  Slug: #{text.slug}"
    puts "  Characters: #{text.content.length}"
    puts "  Current audio URLs: #{text.audio_urls.presence || 'none'}"

    # Estimate cost
    service = ElevenlabsAudioService.new
    total_chars = text.content.length * voice_keys.length
    estimate = service.estimate_cost(total_chars)

    puts "\nEstimated Cost:"
    puts "  Characters: #{total_chars}"
    puts "  Cost: $#{estimate[:estimated_cost_usd]}"

    print "\nDo you want to proceed with generation? (yes/no): "
    confirmation = STDIN.gets.chomp.downcase

    unless confirmation == "yes" || confirmation == "y"
      puts "Generation cancelled."
      exit 0
    end

    puts "\nGenerating audio..."
    success_count = 0
    failed_count = 0

    # Create a temporary session for tracking
    session = AudioGenerationSession.create!(
      prayer_book_code: prayer_book_code,
      voice_keys: voice_keys,
      total_texts: voice_keys.count,
      status: "running"
    )

    voice_keys.each do |voice_key|
      unless LiturgicalText::AVAILABLE_VOICES.include?(voice_key)
        puts "  ✗ Invalid voice key: #{voice_key}"
        failed_count += 1
        next
      end

      print "  Processing #{voice_key}... "

      begin
        GenerateLiturgicalAudioJob.perform_now(text.id, voice_key, session.id)
        puts "✓"
        success_count += 1
      rescue StandardError => e
        puts "✗ (#{e.message})"
        failed_count += 1
      end
    end

    # Mark session as completed
    session.update!(
      status: success_count > 0 ? "completed" : "failed",
      completed_at: Time.current
    )

    # Reload to get updated audio_urls
    text.reload

    puts "\n==== Generation Complete ===="
    puts "Success: #{success_count}"
    puts "Failed: #{failed_count}"
    puts "\nUpdated Audio URLs:"
    if text.audio_urls.present?
      text.audio_urls.each do |voice, url|
        puts "  #{voice}: #{url}"
      end
    else
      puts "  (none)"
    end
    puts "========================================\n"
  end
end
