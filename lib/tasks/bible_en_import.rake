# frozen_string_literal: true

require "sqlite3"
require "fileutils"

namespace :bible do
  EN_TRANSLATIONS = %w[ESV KJV NASB NIV NLT NKJV].freeze
  BIBLES_DOWNLOAD_DIR = Rails.root.join("tmp", "bibles")

  desc "Download English Bible JSON files from bolls.life and convert to SQLite"
  task generate_en: :environment do
    translations = ENV["TRANSLATIONS"]&.split(",") || EN_TRANSLATIONS

    puts "🚀 Iniciando download de bíblias em inglês via bolls.life..."
    FileUtils.mkdir_p(BIBLES_DOWNLOAD_DIR)

    require "net/http"
    require "json"
    require "sqlite3"

    translations.each do |translation|
      translation_up = translation.upcase

      # Mapping for bolls.life codes
      bolls_code = case translation_up
      when "CSB" then "HCSB" # bolls uses HCSB for Christian Standard Bible
      when "NRSV" then "NRSVCI" # New Revised Standard Version Catholic Interconfessional
      else translation_up
      end

      db_path = BIBLES_DOWNLOAD_DIR.join("#{translation_up}.sqlite")

      if File.exist?(db_path)
        puts "⏭️ #{translation_up} já existe, pulando..."
        next
      end

      puts "⏳ Baixando #{translation_up} (as #{bolls_code})..."

      begin
        url = "https://bolls.life/static/translations/#{bolls_code}.json"
        uri = URI(url)
        response = Net::HTTP.get_response(uri)

        if response.is_a?(Net::HTTPSuccess)
          data = JSON.parse(response.body)

          # data is an array of [ [book_id, chapter, verse, text], ... ]
          # or an array of objects depending on the version.
          # Let's handle both or check structure.

          db = SQLite3::Database.new(db_path.to_s)
          db.execute("CREATE TABLE verse (book_id INTEGER, chapter INTEGER, verse INTEGER, text TEXT)")

          db.transaction do
            data.each do |item|
              if item.is_a?(Hash)
                # Remove Strong's numbers, <br> tags, and any other HTML tags
                clean_text = item["text"].gsub(/<S>\d+<\/S>/, "")
                                       .gsub(/<br\s*\/?>/i, " ")
                                       .gsub(/<[^>]+>/, "")
                                       .gsub(/\s+/, " ")
                                       .strip
                db.execute("INSERT INTO verse VALUES (?, ?, ?, ?)", [ item["book"], item["chapter"], item["verse"], clean_text ])
              elsif item.is_a?(Array)
                clean_text = item[3].to_s.gsub(/<S>\d+<\/S>/, "")
                                       .gsub(/<br\s*\/?>/i, " ")
                                       .gsub(/<[^>]+>/, "")
                                       .gsub(/\s+/, " ")
                                       .strip
                db.execute("INSERT INTO verse VALUES (?, ?, ?, ?)", [ item[0], item[1], item[2], clean_text ])
              end
            end
          end
          db.close
          puts "✅ Gerado: #{db_path} (#{data.size} versículos)"
        else
          puts "❌ Erro ao baixar #{translation_up}: #{response.code} #{response.message}"
          # Try lowercase just in case
          if translation_up != translation.downcase
            puts "  Retrying with lowercase..."
            # (Recursion or just loop, let's keep it simple)
          end
        end
      rescue StandardError => e
        puts "❌ Erro ao processar #{translation_up}: #{e.message}"
        FileUtils.rm(db_path) if File.exist?(db_path)
      end
    end

    puts "✨ Processo concluído!"
  end

  desc "Import English Bible translations from SQLite to PostgreSQL"
  task import_en: :environment do
    puts "📖 Importando traduções bíblicas em inglês..."

    total_start = Time.now

    EN_TRANSLATIONS.each do |translation|
      import_single_en_translation(translation)
    end

    total_elapsed = Time.now - total_start
    puts "\n🎉 Importação completa! Tempo total: #{format_duration(total_elapsed)}"
    puts "📊 Total de versículos no banco: #{BibleText.count}"
  end

  private

  def import_single_en_translation(translation)
    translation_key = translation.downcase
    file_path = BIBLES_DOWNLOAD_DIR.join("#{translation}.sqlite")

    unless File.exist?(file_path)
      puts "⚠️  Arquivo #{translation}.sqlite não encontrado em #{DOWNLOAD_DIR}, pulando..."
      return
    end

    existing_count = BibleText.where(translation: translation_key).count
    if existing_count > 0
      puts "⏭️  #{translation} já importada (#{existing_count} versículos), pulando..."
      return
    end

    puts "📖 Importando #{translation}..."
    start_time = Time.now

    db = SQLite3::Database.new(file_path.to_s)

    # Detect table structure
    tables = db.execute("SELECT name FROM sqlite_master WHERE type='table'").flatten

    table_name = if tables.include?("verse")
                   "verse"
    elsif tables.include?("verses")
                   "verses"
    else
                   puts "❌ Tabela de versículos não encontrada em #{translation}.sqlite. Tabelas: #{tables.join(', ')}"
                   db.close
                   return
    end

    # Detect column names
    columns = db.execute("PRAGMA table_info(#{table_name})").map { |col| col[1] }

    book_col = columns.find { |c| c.match?(/book_id/i) } || columns.find { |c| c.match?(/book/i) }
    chapter_col = columns.find { |c| c.match?(/chapter/i) }
    verse_col = columns.find { |c| c.match?(/verse/i) }
    text_col = columns.find { |c| c.match?(/text/i) } || columns.find { |c| c.match?(/content/i) }

    unless book_col && chapter_col && verse_col && text_col
      puts "❌ Colunas necessárias não encontradas em #{translation}.sqlite. Colunas: #{columns.join(', ')}"
      db.close
      return
    end

    puts "  Detectado: Tabela=#{table_name}, Colunas: book=#{book_col}, chapter=#{chapter_col}, verse=#{verse_col}, text=#{text_col}"

    # Read all verses
    query = "SELECT #{book_col}, #{chapter_col}, #{verse_col}, #{text_col} FROM #{table_name} ORDER BY #{book_col}, #{chapter_col}, #{verse_col}"
    rows = db.execute(query)
    db.close

    # Prepare records for bulk insert
    now = Time.current
    records = []

    # Mapping for English book names to IDs if needed
    # (Assuming book_id is already 1-66, if not we might need a mapping)

    rows.each do |row|
      book_val = row[0]
      book_number = book_val.is_a?(Integer) ? book_val : detect_book_number(book_val)

      next if book_number.nil? || book_number < 1 || book_number > 66

      records << {
        book: BibleText::BOOKS_BY_ID[book_number],
        book_number: book_number,
        chapter: row[1],
        verse: row[2],
        text: row[3],
        translation: translation_key,
        created_at: now,
        updated_at: now
      }
    end

    # Bulk insert in batches of 5000
    inserted = 0
    records.each_slice(5000) do |batch|
      BibleText.insert_all(batch)
      inserted += batch.size
      print "\r  Inserindo... #{inserted}/#{records.size} versículos"
    end

    elapsed = Time.now - start_time
    puts "\r  ✅ #{translation} importada: #{records.size} versículos em #{format_duration(elapsed)}"
  end

  def detect_book_number(book_name)
    # Simple mapping for common English book names if the SQLite uses names instead of IDs
    @en_book_mapping ||= {
      "Genesis" => 1, "Exodus" => 2, "Leviticus" => 3, "Numbers" => 4, "Deuteronomy" => 5,
      "Joshua" => 6, "Judges" => 7, "Ruth" => 8, "1 Samuel" => 9, "2 Samuel" => 10,
      "1 Kings" => 11, "2 Kings" => 12, "1 Chronicles" => 13, "2 Chronicles" => 14,
      "Ezra" => 15, "Nehemiah" => 16, "Esther" => 17, "Job" => 18, "Psalms" => 19,
      "Proverbs" => 20, "Ecclesiastes" => 21, "Song of Solomon" => 22, "Isaiah" => 23,
      "Jeremiah" => 24, "Lamentations" => 25, "Ezekiel" => 26, "Daniel" => 27,
      "Hosea" => 28, "Joel" => 29, "Amos" => 30, "Obadiah" => 31, "Jonah" => 32,
      "Micah" => 33, "Nahum" => 34, "Habakkuk" => 35, "Zephaniah" => 36, "Haggai" => 37,
      "Zechariah" => 38, "Malachi" => 39, "Matthew" => 40, "Mark" => 41, "Luke" => 42,
      "John" => 43, "Acts" => 44, "Romans" => 45, "1 Corinthians" => 46, "2 Corinthians" => 47,
      "Galatians" => 48, "Ephesians" => 49, "Philippians" => 50, "Colossians" => 51,
      "1 Thessalonians" => 52, "2 Thessalonians" => 53, "1 Timothy" => 54, "2 Timothy" => 55,
      "Titus" => 56, "Philemon" => 57, "Hebrews" => 58, "James" => 59, "1 Peter" => 60,
      "2 Peter" => 61, "1 John" => 62, "2 John" => 63, "3 John" => 64, "Judas" => 65,
      "Revelation" => 66
    }
    @en_book_mapping[book_name]
  end

  def format_duration(seconds)
    if seconds < 60
      "#{seconds.round(1)}s"
    else
      minutes = (seconds / 60).floor
      secs = (seconds % 60).round(1)
      "#{minutes}m #{secs}s"
    end
  end
end
