# frozen_string_literal: true

namespace :celebrations do
  desc "Update celebration grammar fields (person_type and gender) based on analysis"
  task update_grammar: :environment do
    puts "🔄 Updating celebration grammar fields..."

    updated_count = 0
    skipped_count = 0

    Celebration.find_each do |celebration|
      # Skip if already updated (assuming default is event/neutral)
      next if celebration.person_type != "event" || celebration.gender != "neutral"

      person_type, gender = analyze_celebration(celebration)

      if person_type || gender
        celebration.update!(
          person_type: person_type || "event",
          gender: gender || "neutral"
        )
        updated_count += 1
        puts "✅ #{celebration.name}: #{person_type}/#{gender}"
      else
        skipped_count += 1
      end
    end

    puts "\n📊 Summary:"
    puts "Updated: #{updated_count}"
    puts "Skipped: #{skipped_count}"
    puts "\n⚠️  NOTE: This is a best-effort automatic classification."
    puts "Please review and manually correct as needed, especially for:"
    puts "- Mixed gender groups (e.g., 'Perpétua, Felicidade e seus companheiros')"
    puts "- Events vs. person celebrations"
  end

  # Analyzes celebration to determine person_type and gender
  # Returns [person_type, gender]
  def analyze_celebration(celebration)
    name = celebration.name.downcase
    desc = celebration.description&.downcase || ""

    # Events (não são sobre pessoas)
    event_patterns = [
      /batismo/, /confissão/, /conversão/, /martírio de /, /dia (mundial|internacional|do|da|dos)/,
      /fundação/, /celebração/, /origem/, /concílio/, /primeira confissão/,
      /descobrimento/, /abolição/, /criação/
    ]

    return [ "event", "neutral" ] if event_patterns.any? { |p| name.match?(p) || desc.match?(p) }

    # Plural (múltiplas pessoas)
    plural_patterns = [
      / e /, / , .* e /, /mártires/, /apóstolos/, /companheiros/, /cooperadoras/,
      /seus companheiros/, /e seus/
    ]

    is_plural = plural_patterns.any? { |p| name.match?(p) }

    # Gender detection
    feminine_patterns = [
      /^(inês|brígida|escolástica|perpétua|felicidade|mônica|lídia|dorcas|febe)/,
      /abadessa/, /mãe de/
    ]

    masculine_patterns = [
      /^(william|hilário|antão|fabiano|vicente|joão|tomás|brás|cornélio|gregório|patrício|cirilo|cuthbert|thomas|jonathan|isidoro|dietrich|felipe|anselmo|jorge|marcos|atanásio|brendan|alcuíno|beda|agostinho|jerônimo)/,
      /bispo/, /arcebispo/, /padre/, /frade/, /presbítero/, /monge/, /abade/, /missionário/
    ]

    # Check for mixed groups with female names
    has_female = feminine_patterns.any? { |p| name.match?(p) }
    has_male = masculine_patterns.any? { |p| name.match?(p) }

    if is_plural
      if has_female && has_male
        [ "plural", "mixed" ]
      elsif has_female
        [ "plural", "feminine" ]
      else
        [ "plural", "masculine" ]
      end
    else
      if has_female
        [ "singular", "feminine" ]
      elsif has_male
        [ "singular", "masculine" ]
      else
        # Default to singular masculine if unsure
        [ "singular", "masculine" ]
      end
    end
  end
end
