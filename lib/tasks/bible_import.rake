# frozen_string_literal: true

require "net/http"
require "uri"
require "fileutils"

namespace :bible do
  TRANSLATIONS = %w[ACF ARA ARC AS21 JFAA KJA KJF NAA NBV NTLH NVI NVT TB].freeze
  DOWNLOAD_BASE_URL = "https://github.com/damarals/biblias/raw/main/inst/sql"
  DOWNLOAD_DIR = Rails.root.join("tmp", "bibles")

  desc "Download all Bible translation SQLite files"
  task download: :environment do
    puts "📥 Baixando arquivos SQLite das traduções bíblicas..."

    FileUtils.mkdir_p(DOWNLOAD_DIR)

    TRANSLATIONS.each do |translation|
      file_path = DOWNLOAD_DIR.join("#{translation}.sqlite")

      if File.exist?(file_path)
        puts "  ⏭️  #{translation}.sqlite já existe, pulando..."
        next
      end

      url = "#{DOWNLOAD_BASE_URL}/#{translation}.sqlite?raw=true"
      puts "  ⬇️  Baixando #{translation}.sqlite..."

      begin
        download_file(url, file_path)
        puts "  ✅ #{translation}.sqlite baixado com sucesso!"
      rescue StandardError => e
        puts "  ❌ Erro ao baixar #{translation}.sqlite: #{e.message}"
      end
    end

    puts "📥 Download concluído!"
  end

  desc "Import a single Bible translation from SQLite to PostgreSQL"
  task :import_translation, [:translation] => :environment do |_t, args|
    translation = args[:translation]&.upcase

    unless TRANSLATIONS.include?(translation)
      puts "❌ Tradução inválida: #{translation}"
      puts "   Traduções disponíveis: #{TRANSLATIONS.join(', ')}"
      exit 1
    end

    import_single_translation(translation)
  end

  desc "Import all Bible translations from SQLite to PostgreSQL"
  task import: :environment do
    puts "📖 Importando todas as traduções bíblicas..."

    total_start = Time.now

    TRANSLATIONS.each do |translation|
      import_single_translation(translation)
    end

    total_elapsed = Time.now - total_start
    puts "\n🎉 Importação completa! Tempo total: #{format_duration(total_elapsed)}"
    puts "📊 Total de versículos no banco: #{BibleText.count}"
  end

  desc "Download and import all Bible translations"
  task setup: :environment do
    puts "🚀 Configurando traduções bíblicas..."
    puts ""

    Rake::Task["bible:download"].invoke
    puts ""
    Rake::Task["bible:import"].invoke

    puts "\n✨ Setup completo!"
  end

  desc "Clear all Bible texts from database"
  task clear: :environment do
    puts "🗑️  Removendo todos os textos bíblicos..."
    count = BibleText.count
    BibleText.delete_all
    puts "✅ #{count} versículos removidos!"
  end

  desc "Clear and re-import a specific translation"
  task :reimport_translation, [:translation] => :environment do |_t, args|
    translation = args[:translation]&.downcase

    unless BibleText::TRANSLATIONS.key?(translation)
      puts "❌ Tradução inválida: #{translation}"
      puts "   Traduções disponíveis: #{BibleText::TRANSLATIONS.keys.join(', ')}"
      exit 1
    end

    puts "🗑️  Removendo versículos da tradução #{translation.upcase}..."
    count = BibleText.where(translation: translation).delete_all
    puts "✅ #{count} versículos removidos!"

    import_single_translation(translation.upcase)
  end

  desc "Show import statistics"
  task stats: :environment do
    puts "📊 Estatísticas das traduções bíblicas:"
    puts ""

    BibleText::TRANSLATIONS.each do |key, meta|
      count = BibleText.where(translation: key).count
      status = count > 0 ? "✅ #{count} versículos" : "❌ Não importada"
      puts "  #{key.upcase.ljust(5)} - #{meta[:name].ljust(40)} #{status}"
    end

    puts ""
    puts "  Total: #{BibleText.count} versículos"
  end

  private

  def download_file(url, destination)
    uri = URI.parse(url)

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(uri)

      http.request(request) do |response|
        case response
        when Net::HTTPSuccess
          File.open(destination, "wb") do |file|
            response.read_body do |chunk|
              file.write(chunk)
            end
          end
        when Net::HTTPRedirection
          # Follow redirect
          download_file(response["location"], destination)
        else
          raise "HTTP Error: #{response.code} #{response.message}"
        end
      end
    end
  end

  def import_single_translation(translation)
    translation_key = translation.downcase
    file_path = DOWNLOAD_DIR.join("#{translation}.sqlite")

    unless File.exist?(file_path)
      puts "❌ Arquivo #{translation}.sqlite não encontrado em #{DOWNLOAD_DIR}"
      puts "   Execute 'rake bible:download' primeiro."
      return
    end

    existing_count = BibleText.where(translation: translation_key).count
    if existing_count > 0
      puts "⏭️  #{translation} já importada (#{existing_count} versículos), pulando..."
      return
    end

    puts "📖 Importando #{translation}..."
    start_time = Time.now

    require "sqlite3"
    db = SQLite3::Database.new(file_path.to_s)

    # Read all verses from SQLite
    rows = db.execute("SELECT book_id, chapter, verse, text FROM verse ORDER BY book_id, chapter, verse")
    db.close

    # Prepare records for bulk insert
    now = Time.current
    records = rows.map do |row|
      book_id = row[0]
      {
        book: BibleText::BOOKS_BY_ID[book_id],
        book_number: book_id,
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
