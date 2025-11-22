#!/usr/bin/env ruby
# Script para traduzir referências bíblicas de inglês para português

# Mapeamento de traduções (ordem importa - mais específicos primeiro)
TRANSLATIONS = {
  # Antigo Testamento - múltiplas palavras primeiro
  "1 Chronicles" => "1 Crônicas",
  "2 Chronicles" => "2 Crônicas",
  "1 Samuel" => "1 Samuel",
  "2 Samuel" => "2 Samuel",
  "1 Kings" => "1 Reis",
  "2 Kings" => "2 Reis",
  "Song of Solomon" => "Cântico dos Cânticos",
  
  # Antigo Testamento - ordem alfabética
  "Amos" => "Amós",
  "Baruch" => "Baruque",
  "Daniel" => "Daniel",
  "Deuteronomy" => "Deuteronômio",
  "Ezekiel" => "Ezequiel",
  "Exodus" => "Êxodo",
  "Genesis" => "Gênesis",
  "Habakkuk" => "Habacuque",
  "Hosea" => "Oséias",
  "Isaiah" => "Isaías",
  "Jeremiah" => "Jeremias",
  "Job" => "Jó",
  "Joel" => "Joel",
  "Jonah" => "Jonas",
  "Joshua" => "Josué",
  "Judges" => "Juízes",
  "Leviticus" => "Levítico",
  "Malachi" => "Malaquias",
  "Micah" => "Miqueias",
  "Nehemiah" => "Neemias",
  "Numbers" => "Números",
  "Proverbs" => "Provérbios",
  "Psalm" => "Salmo",
  "Sirach" => "Eclesiástico",
  "Tobit" => "Tobias",
  "Wisdom" => "Sabedoria",
  "Zechariah" => "Zacarias",
  "Zephaniah" => "Sofonias",
  
  # Novo Testamento - múltiplas palavras primeiro
  "1 Corinthians" => "1 Coríntios",
  "2 Corinthians" => "2 Coríntios",
  "1 Thessalonians" => "1 Tessalonicenses",
  "2 Thessalonians" => "2 Tessalonicenses",
  "1 Timothy" => "1 Timóteo",
  "2 Timothy" => "2 Timóteo",
  "1 Peter" => "1 Pedro",
  "2 Peter" => "2 Pedro",
  "1 John" => "1 João",
  "2 John" => "2 João",
  "3 John" => "3 João",
  
  # Novo Testamento - ordem alfabética
  "Acts" => "Atos",
  "Colossians" => "Colossenses",
  "Ephesians" => "Efésios",
  "Galatians" => "Gálatas",
  "Hebrews" => "Hebreus",
  "James" => "Tiago",
  "John" => "João",
  "Luke" => "Lucas",
  "Mark" => "Marcos",
  "Matthew" => "Mateus",
  "Philippians" => "Filipenses",
  "Revelation" => "Apocalipse",
  "Romans" => "Romanos",
  "Titus" => "Tito"
}

# Arquivos para processar
files = Dir.glob("db/seeds/readings/*.rb")

puts "🔄 Iniciando tradução de referências bíblicas..."
puts "=" * 80

total_changes = 0

files.each do |file|
  puts "\n📄 Processando: #{File.basename(file)}"
  
  content = File.read(file)
  original_content = content.dup
  file_changes = 0
  
  # Aplicar traduções
  TRANSLATIONS.each do |english, portuguese|
    # Contar ocorrências
    count = content.scan(/\b#{Regexp.escape(english)}\b/).length
    
    if count > 0
      # Fazer substituição (word boundary para evitar substituições parciais)
      content.gsub!(/\b#{Regexp.escape(english)}\b/, portuguese)
      file_changes += count
      puts "  ✓ #{english.ljust(20)} → #{portuguese.ljust(25)} (#{count}x)"
    end
  end
  
  # Salvar apenas se houve mudanças
  if content != original_content
    File.write(file, content)
    puts "  💾 Total: #{file_changes} traduções aplicadas!"
    total_changes += file_changes
  else
    puts "  ⏭️  Já em português"
  end
end

puts "\n" + "=" * 80
puts "✅ Tradução concluída!"
puts "📊 Total: #{total_changes} traduções em #{files.length} arquivos"
puts "\n💡 Próximo passo: execute 'rails db:seed' para carregar as leituras"