# ================================================================================
# LOCB 2008 - Daily Office Readings (Biannual Cycle)
# ================================================================================
#
# This file loads daily lectionary readings for the LOCB 2008 prayer book.
# The readings follow a biannual cycle (odd/even years).
#
# CSV columns: ciclo, semana, dia, salmo, antigo_testamento, novo_testamento
#
# ================================================================================

@prayer_book = PrayerBook.find_by_code('locb_2008')

csv_path = Rails.root.join('db/seeds/prayer_books/locb_2008/data/daily_readings.csv')

if File.exist?(csv_path)
  require Rails.root.join('db/seeds/prayer_books/locb_2008/data/readings/daily_readings.rb')

  importer = Locb2008DailyReadingsImporter.new(csv_path, @prayer_book)
  importer.import

  # Count readings by cycle
  odd_count = LectionaryReading.where(
    prayer_book_id: @prayer_book.id,
    service_type: 'weekly',
    cycle: 'odd'
  ).count

  even_count = LectionaryReading.where(
    prayer_book_id: @prayer_book.id,
    service_type: 'weekly',
    cycle: 'even'
  ).count

  Rails.logger.info "✓ #{odd_count} leituras diárias (anos ímpares) carregadas" if odd_count > 0
  Rails.logger.info "✓ #{even_count} leituras diárias (anos pares) carregadas" if even_count > 0
else
  Rails.logger.info "⚠️  CSV não encontrado: #{csv_path}"
end
