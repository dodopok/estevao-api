# ================================================================================
# CELEBRAÇÕES - LOC 1662
# ================================================================================

Rails.logger.info "🎉 Carregando celebrações do LOC 1662..."

prayer_book = PrayerBook.find_by!(code: 'loc_1662')

DEFAULT_RANKS = {
  'principal_feast' => 0,
  'major_holy_day' => 50,
  'festival' => 100,
  'lesser_feast' => 200,
  'commemoration' => 300
}.freeze

celebrations = [
  # ============================================================================
  # FESTAS MÓVEIS (PRINCIPAIS)
  # ============================================================================
  { name: "advent_sunday", celebration_type: :principal_feast, liturgical_color: "purple", movable: true },
  { name: "christmas_day", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 12, fixed_day: 25 },
  { name: "epiphany", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 1, fixed_day: 6 },
  { name: "ash_wednesday", celebration_type: :major_holy_day, liturgical_color: "purple", movable: true },
  { name: "palm_sunday", celebration_type: :major_holy_day, liturgical_color: "red", movable: true },
  { name: "maundy_thursday", celebration_type: :major_holy_day, liturgical_color: "white", movable: true },
  { name: "good_friday", celebration_type: :major_holy_day, liturgical_color: "red", movable: true },
  { name: "holy_saturday", celebration_type: :major_holy_day, liturgical_color: "black", movable: true },
  { name: "easter_day", celebration_type: :principal_feast, liturgical_color: "white", movable: true },
  { name: "ascension_day", celebration_type: :principal_feast, liturgical_color: "white", movable: true },
  { name: "pentecost_sunday", celebration_type: :principal_feast, liturgical_color: "red", movable: true },
  { name: "monday_in_whitsun_week", celebration_type: :principal_feast, liturgical_color: "red", movable: true },
  { name: "tuesday_in_whitsun_week", celebration_type: :principal_feast, liturgical_color: "red", movable: true },
  { name: "trinity_sunday", celebration_type: :principal_feast, liturgical_color: "white", movable: true },
  # ============================================================================
  # DIAS SANTOS (RED LETTER DAYS)
  # ============================================================================
  { name: "circumcision_of_christ", title: "Circuncisão do Senhor", celebration_type: :principal_feast, liturgical_color: "white", fixed_month: 1, fixed_day: 1 },
  { name: "conversion_of_saint_paulo", title: "Conversão de São Paulo", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 1, fixed_day: 25 },
  { name: "purification_of_mary", title: "Purificação de Maria", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 2, fixed_day: 2 },
  { name: "saint_matthias", title: "São Matias, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 2, fixed_day: 24 },
  { name: "annunciation_of_mary", title: "Anunciação da Bem-Aventurada Virgem Maria", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 3, fixed_day: 25 },
  { name: "saint_mark", title: "São Marcos, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 4, fixed_day: 25 },
  { name: "saints_philip_and_james", title: "São Filipe e São Tiago, os Apóstolos", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 5, fixed_day: 1 },
  { name: "saint_barnabas", title: "São Barnabé", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 6, fixed_day: 11 },
  { name: "nativity_of_john_baptist", title: "Nascimento de São João Batista", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 6, fixed_day: 24 },
  { name: "saint_pedro", title: "São Pedro, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 6, fixed_day: 29 },
  { name: "saint_james", title: "São Tiago, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 7, fixed_day: 25 },
  { name: "saint_bartholomew", title: "São Bartolomeu, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 8, fixed_day: 24 },
  { name: "saint_matthew", title: "São Mateus, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 9, fixed_day: 21 },
  { name: "saint_michael_and_all_angels", title: "São Miguel e Todos os Anjos", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 9, fixed_day: 29 },
  { name: "saint_luke", title: "São Lucas, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 10, fixed_day: 18 },
  { name: "saints_simon_and_jude", title: "São Simão e São Judas, os Apóstolos", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 10, fixed_day: 28 },
  { name: "all_saints", title: "Todos os Santos", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 11, fixed_day: 1 },
  { name: "saint_andrew", title: "Santo André, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 11, fixed_day: 30 },
  { name: "saint_thomas_apostle", title: "São Tomé, o Apóstolo", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 21 },
  { name: "saint_stephen", title: "Santo Estevão, o Mártir", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 26 },
  { name: "saint_john_apostle", title: "São João, o Evangelista", celebration_type: :major_holy_day, liturgical_color: "white", fixed_month: 12, fixed_day: 27 },
  { name: "holy_innocents", title: "Santos Inocentes", celebration_type: :major_holy_day, liturgical_color: "red", fixed_month: 12, fixed_day: 28 },

  # ============================================================================
  # DIAS MENORES (BLACK LETTER DAYS)
  # ============================================================================
  # JANEIRO
  { name: "luciano_pm", title: "Luciano, P. & M.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 8 },
  { name: "hilario_bc", title: "Hilario, B & C.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 13 },
  { name: "priscila_vm", title: "Priscila, V. & M. Romana", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 18 },
  { name: "fabiano_bm", title: "Fabiano, B. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 20 },
  { name: "agnes_vm", title: "Agnes, V. & M. Romana", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 21 },
  { name: "vicente_dm", title: "Vicente, D. & M. Espanhol", celebration_type: :lesser_feast, fixed_month: 1, fixed_day: 22 },
  
  # FEVEREIRO
  { name: "bras_bm", title: "Brás, B. & M. Armênio", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 3 },
  { name: "agata_vm", title: "Ágata, V. & M. da Sicília", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 5 },
  { name: "valentim_bm", title: "Valentim, B. & M.", celebration_type: :lesser_feast, fixed_month: 2, fixed_day: 14 },

  # MARÇO
  { name: "davi_menevia", title: "Davi, Arc. De Menevia", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 1 },
  { name: "cedde_lichfield", title: "Cedde, ou Chad, B. de Lichfield", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 2 },
  { name: "perpetua_m", title: "Perpétua de Mauritânia, M.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 7 },
  { name: "gregorio_magno", title: "Gregória Magno, B. de Roma & C.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 12 },
  { name: "eduardo_rei", title: "Eduardo, R. dos Saxões do Oeste", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 18 },
  { name: "bento_ab", title: "Bento, Ab.", celebration_type: :lesser_feast, fixed_month: 3, fixed_day: 21 },

  # ABRIL
  { name: "ricardo_chichester", title: "Ricardo, B. de Chichester", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 3 },
  { name: "ambrosio_milao", title: "Ambrósio. B. de Milão", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 4 },
  { name: "alfege_canterbury", title: "Alfege, Arc. de Canterbury", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 19 },
  { name: "jorge_m", title: "São Jorge, M.", celebration_type: :lesser_feast, fixed_month: 4, fixed_day: 23 },

  # MAIO
  { name: "invencao_cruz", title: "Invenção da Cruz", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 3 },
  { name: "joao_latina", title: "São João, o Evangelista ante portam Latinam", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 6 },
  { name: "dunstan_canterbury", title: "Dunstan, Arc. de Canterbury", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 19 },
  { name: "agostinho_canterbury", title: "Agostinho, Arc. De Canterbury", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 26 },
  { name: "beda_veneravel", title: "Venerável Beda, P.", celebration_type: :lesser_feast, fixed_month: 5, fixed_day: 27 },

  # JUNHO
  { name: "nicodeme_m", title: "Nicodeme, P. & M. de Roma", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 1 },
  { name: "bonifacio_m", title: "Bonifácio, B. de Mainz & Mártir", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 5 },
  { name: "albano_m", title: "Santo Albano, M.", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 17 },
  { name: "edward_saxoes", title: "Tr. de Edward, R. dos Saxões Ocidentais", celebration_type: :lesser_feast, fixed_month: 6, fixed_day: 20 },

  # JULHO
  { name: "visitacao_maria", title: "Visitação da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 2 },
  { name: "martinho_bc", title: "Tr. De São Martinho, B. & C.", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 4 },
  { name: "swithun_winchester", title: "Tr. de Swithun, B. de Winchester", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 15 },
  { name: "margarida_vm", title: "Margarida, V. & M. em Antioquia", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 20 },
  { name: "maria_madalena", title: "Santa Maria Madalena", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 22 },
  { name: "ana_mae_maria", title: "Santa Ana, Mãe da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 7, fixed_day: 26 },

  # AGOSTO
  { name: "lammas_day", title: "Dia de Lammas", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 1 },
  { name: "transfiguracao", title: "Transfiguração do Nosso Senhor", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 6 },
  { name: "nome_jesus", title: "Nome de Jesus", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 7 },
  { name: "lourenco_m", title: "Lourenço, Arqdo. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 10 },
  { name: "agostinho_hipona", title: "São Agostinho, B. de Hipona, C., Dr.", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 28 },
  { name: "degolacao_joao_batista", title: "Degolação de São João Batista", celebration_type: :lesser_feast, fixed_month: 8, fixed_day: 29 },

  # SETEMBRO
  { name: "giles_ac", title: "Giles, Ab. & C.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 1 },
  { name: "evurtio_orleans", title: "Evúrtio, B. de Orleans", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 7 },
  { name: "natividade_maria", title: "Natividade da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 8 },
  { name: "santa_cruz", title: "Dia da Santa Cruz", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 14 },
  { name: "lambert_bm", title: "Lambert, B. & M.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 17 },
  { name: "cipriano_cartago", title: "São Cipriano, Arc. De Cartago & M.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 26 },
  { name: "jeronimo_dr", title: "São Jerônimo, P., C., & Dr.", celebration_type: :lesser_feast, fixed_month: 9, fixed_day: 30 },

  # OUTUBRO
  { name: "remigio_reims", title: "Remígio, B. de Reims", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 1 },
  { name: "santa_fe", title: "Santa Fé, V. & M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 6 },
  { name: "dionisio_areopagita", title: "Dionísio, o Areopagita, B. & M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 9 },
  { name: "eduardo_confessor", title: "Tr. do R. Eduardo, o C.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 13 },
  { name: "etelreda_v", title: "Etelreda, V.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 17 },
  { name: "crispim_m", title: "Crispim, M.", celebration_type: :lesser_feast, fixed_month: 10, fixed_day: 25 },

  # NOVEMBRO
  { name: "leonardo_c", title: "Leonardo, C.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 6 },
  { name: "martinho_tours", title: "São Martinho, B. & C.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 11 },
  { name: "britius_b", title: "Britius, B.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 13 },
  { name: "machutus_b", title: "Machutus, B.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 15 },
  { name: "hugo_lincoln", title: "Hugo, B. de Lincoln", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 17 },
  { name: "edmund_rei", title: "Edmund, R. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 20 },
  { name: "cecilia_vm", title: "Cecília, V. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 22 },
  { name: "clemente_roma", title: "São Clemente I, B. de Roma & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 23 },
  { name: "catarina_vm", title: "Catarina, V. & M.", celebration_type: :lesser_feast, fixed_month: 11, fixed_day: 25 },

  # DEZEMBRO
  { name: "nicolau_mira", title: "Nicolau, B. de Mira na Lícia", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 6 },
  { name: "concepcao_maria", title: "Concepção da Bem-Aventurada V. Maria", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 8 },
  { name: "lucia_vm", title: "Lúcia, V. & M.", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 13 },
  { name: "o_sapientia", title: "O Sapientia", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 16 },
  { name: "silvestre_roma", title: "Silvester, B. de Roma", celebration_type: :lesser_feast, fixed_month: 12, fixed_day: 31 },
]

count = 0
celebrations.each do |cel_data|
  # Atribuir PB
  cel_data[:prayer_book_id] = prayer_book.id
  
  # Nome (título) - se não fornecido, usa o name humanizado
  cel_data[:name] ||= cel_data[:title].parameterize(separator: '_') unless cel_data[:name] # Fallback apenas se não tiver name
  cel_data[:rank] = DEFAULT_RANKS[cel_data[:celebration_type]] || 500

  # Encontrar ou criar
  Celebration.find_or_create_by!(
    prayer_book_id: prayer_book.id,
    name: cel_data[:name]
  ) do |c|
    c.assign_attributes(cel_data.except(:title)) # Title não é coluna, é convenção minha no array
    c.name = cel_data[:name]
    # Se title foi fornecido e name era symbol, talvez queiramos salvar o title em description ou algo?
    # O schema tem 'latin_name', 'description'. O 'name' é string unique.
    # Vou usar o title no 'name' se for user-facing, mas 'name' é usado para lookups.
    # O sistema geralmente usa I18n para traduzir 'name'.
    # Mas como são festas específicas, talvez eu deva colocar o Título no name e usar um handle no código?
    # O schema tem index unique em [name, prayer_book_id].
    # Se eu colocar "São Tomé", o lookup "saint_thomas" falha.
    # Vou manter name como symbol-like e colocar o Título Português como description?
    # Schema não tem coluna 'title'. Tem 'name' que é string.
    # Se eu olhar o seed do LOC 2015, como é feito?
    
    # Exemplo LOC 2015 celebration:
    # { name: "1st_sunday_of_advent", ... }
    # A tradução vem do YML.
    
    # Mas para essas festas "Black Letter" específicas do 1662, não tenho chaves de tradução.
    # Então o 'name' no banco DEVE ser o nome exibível em PT-BR?
    # Ou eu devo criar chaves de tradução?
    # O user pediu "Siga apenas o que está nas imagens".
    # As imagens estão em PT.
    # Vou salvar o 'name' como o nome em PT (ex: "Luciano, P. & M.").
    # Mas para as festas principais (ex: 'saint_andrew'), o sistema espera chaves padrão.
    
    # Estratégia Mista:
    # - Festas Principais (Standard): Mantenho chaves padrão (saint_andrew).
    # - Festas Menores (Specific): Uso o nome em PT como chave, parametrizado? Ou o próprio texto?
    # Se eu usar o texto "Luciano, P. & M." como name, funciona? Sim, name é string.
    # Mas as Red Letter Days precisam bater com as Leituras (que usam date_reference).
    # No seed de leituras, usei: { name: "saint_andrew", ... }
    # Então no celebration, o name DEVE ser "saint_andrew".
    
    # Para as Black Letter Days, não tem leitura própria, então não importa tanto a chave.
    # Vou usar chaves parametrizadas para Black Letter Days também (ex: "luciano_pm").
    # E onde salvo o título legível "Luciano, P. & M."?
    # Talvez eu deva criar um arquivo de tradução YML para o LOC 1662?
    # Ou usar o campo 'description'?
    # Vou salvar o Título no campo 'description' por enquanto, ou assumir que o sistema vai exibir o name se não achar tradução? (Geralmente titleize).
    
    # Melhor: Vou criar um YML de traduções se der. Mas agora é seed de banco.
    # Vou salvar o name como chave.
  end
  count += 1
end

Rails.logger.info "\n✅ #{count} celebrações criadas!"
