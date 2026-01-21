# frozen_string_literal: true

require 'json'

namespace :celebrations do
  desc "Update celebration JSON files with grammar fields (person_type and gender)"
  task update_json_grammar: :environment do
    puts "🔄 Updating celebration JSON files with grammar fields..."

    # Diretórios de prayer books para processar
    prayer_book_dirs = [
      'loc_2015',
      'loc_2019',
      'loc_2019_en',
      'loc_2021',
      'loc_1987',
      'loc_1662'
    ]

    total_updated = 0

    prayer_book_dirs.each do |pb_code|
      celebrations_path = Rails.root.join('db', 'seeds', 'prayer_books', pb_code, 'data', 'celebrations')
      next unless Dir.exist?(celebrations_path)

      puts "\n📁 Processing #{pb_code}..."

      Dir.glob(File.join(celebrations_path, '*.json')).each do |json_file|
        filename = File.basename(json_file)
        puts "  📄 #{filename}"

        begin
          data = JSON.parse(File.read(json_file))
          updated = false

          data.each do |celebration|
            # Pula se já tem os campos
            next if celebration['person_type'] && celebration['gender']

            person_type, gender = analyze_celebration_from_json(celebration)
            celebration['person_type'] = person_type
            celebration['gender'] = gender
            updated = true
          end

          if updated
            # Escreve de volta com formatação bonita
            File.write(json_file, JSON.pretty_generate(data))
            puts "    ✅ Updated #{data.length} celebrations"
            total_updated += data.length
          else
            puts "    ⏭️  Already up to date"
          end
        rescue JSON::ParserError => e
          puts "    ❌ Error parsing JSON: #{e.message}"
        rescue StandardError => e
          puts "    ❌ Error: #{e.message}"
        end
      end
    end

    puts "\n📊 Summary: Updated #{total_updated} celebrations across all files"
  end

  # Analyzes celebration to determine person_type and gender from JSON data
  # Returns [person_type, gender]
  def analyze_celebration_from_json(celebration)
    name = celebration['name'].to_s.downcase
    desc = celebration['description'].to_s.downcase

    # Eventos (não são sobre pessoas)
    event_patterns = [
      /batismo/, /confissão/, /conversão/, /martírio de /, /dia (mundial|internacional|nacional|do|da|dos)/,
      /fundação/, /celebração/, /origem/, /concílio/, /primeira (confissão|edição)/,
      /descobrimento/, /abolição/, /criação/, /vigília/, /páscoa/, /natal/, /epifania/,
      /apresentação/, /anunciação/, /ascensão/, /pentecostes/, /trindade/, /transfiguração/,
      /natividade de (nosso|jesus)/, /santo nome/, /circuncisão/, /visitação/,
      /exaltação/, /sagração/, /publicação/, /destruição/, /excomunhão/,
      /ação de graças/, /reforma/, /cristo rei/
    ]

    return [ "event", "neutral" ] if event_patterns.any? { |p| name.match?(p) || desc.match?(p) }

    # Casos especiais que devem ser tratados como eventos
    event_names = [
      'todos os santos', 'santos inocentes', 'fiéis falecidos', 'dia da santa cruz'
    ]
    return [ "event", "neutral" ] if event_names.any? { |en| name.include?(en) }

    # Plural (múltiplas pessoas)
    plural_patterns = [
      / e /, / , .* e /, /mártires/, /apóstolos/, /companheiros/, /cooperadoras?/,
      /seus companheiros/, /e seus/, /evangelistas/, /inocentes/, /anjos/,
      /^os /, /^as /
    ]

    is_plural = plural_patterns.any? { |p| name.match?(p) }

    # Gender detection
    feminine_patterns = [
      /^(inês|brígida|escolástica|perpétua|felicidade|mônica|lídia|dorcas|febe|hilda)/,
      /^(maria|madalena|marta|isabel|joana|priscila|áquila e priscila)/,
      /abadessa/, /mãe de/, /virgem/, /^bem-aventurada/, /santas/
    ]

    masculine_patterns = [
      /^(são |santo )/,
      /^(william|hilário|antão|fabiano|vicente|joão|tomás|brás|cornélio|gregório|patrício|cirilo|cuthbert|thomas|jonathan|isidoro|dietrich|felipe|anselmo|jorge|marcos|atanásio|brendan|alcuíno|beda|agostinho|jerônimo)/,
      /^(policarpo|pedro|paulo|andré|tiago|judas|simão|mateus|lucas|bartolomeu|matias)/,
      /bispo/, /arcebispo/, /padre/, /frade/, /presbítero/, /monge/, /abade/, /missionário/,
      /diácono/, /evangelista/
    ]

    # Check for mixed groups with female names
    has_female = feminine_patterns.any? { |p| name.match?(p) }
    has_male = masculine_patterns.any? { |p| name.match?(p) }

    if is_plural
      # Casos especiais de plural
      if name.include?('todos os santos')
        [ "plural", "mixed" ]
      elsif has_female && has_male
        [ "plural", "mixed" ]
      elsif has_female
        [ "plural", "feminine" ]
      else
        [ "plural", "masculine" ]
      end
    else
      if has_female
        [ "singular", "feminine" ]
      elsif has_male || name.start_with?('são ', 'santo ')
        [ "singular", "masculine" ]
      else
        # Default: se não conseguimos identificar claramente, assume singular masculino
        # para santos individuais, ou event se parece ser um evento
        if desc.match?(/santo|bispo|padre|mártir|presbítero/)
          [ "singular", "masculine" ]
        else
          [ "event", "neutral" ]
        end
      end
    end
  end
end
