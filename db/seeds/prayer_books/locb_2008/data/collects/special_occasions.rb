# ================================================================================
# COLETAS PARA OCASIÕES ESPECIAIS - LOCB 2008
# ================================================================================

puts "🙏 Criando Coletas para Ocasiões Especiais - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

special_occasions_collects = [
  # ================================================================================
  # TÊMPORAS
  # As Quatro Têmporas são o Terceiro Domingo do Advento, o Segundo Domingo
  # da Quaresma, o Domingo da Trindade e o 26º Domingo do ano, juntamente com
  # as Quartas-feiras e os Sábados precedentes.
  # ================================================================================
  {
    sunday_reference: "ember_days",
    text: "Pai celestial, tu confiaste à tua Igreja a participação no ministério do teu Filho, nosso Sumo Sacerdote; através do teu Espírito Santo, chama muitos ao ministério ordenado da tua Igreja; abençoa aqueles (agora) chamados a ser Diáconos, Presbíteros e Bispos, e a todos inspira a resposta à tua chamada. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "ember_days_alt",
    text: "Pai celestial, tu confiaste à tua Igreja a participação no ministério do teu Filho, nosso Sumo Sacerdote; através do teu Espírito Santo, chama muitos ao ministério ordenado da tua Igreja; abençoa aqueles (agora) chamados a ser Diáconos, Presbíteros e Bispos, e a todos inspira a resposta à tua chamada. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # ROGAÇÕES
  # Os Dias de Rogações são segunda-feira, terça-feira e quarta-feira seguintes
  # ao 28º Domingo Comum. Rogam-se as bênçãos de Deus para os frutos da terra
  # e do mar e para todo o trabalho honesto.
  # ================================================================================
  {
    sunday_reference: "rogation_days",
    text: "Deus onipotente, é da tua vontade que terra e mar deem fruto na estação própria; abençoa os esforços de todos os que trabalham, concede-nos boas colheitas e a graça de nos alegrarmos no teu cuidado paternal. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # COLHEITAS
  # ================================================================================
  {
    sunday_reference: "harvest",
    text: "Deus eterno, coroas o ano com a tua bondade e dá-nos os frutos na estação própria; concede que os usemos para tua glória, para ajuda dos necessitados e para o nosso próprio bem-estar. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # SÍNODO, CONCÍLIO, CONSELHO, JUNTA, ASSEMBLÉIA
  # ================================================================================
  {
    sunday_reference: "synod",
    text: "Senhor Deus, deste o Espírito Santo à tua Igreja para que Ele nos guie em toda a verdade; abençoa com a tua graça e presença os membros do... guarda-nos firmes na fé e unidos no amor para que promovam a tua glória e a paz e a unidade da tua Igreja. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PELA DIREÇÃO DO ESPÍRITO SANTO
  # ================================================================================
  {
    sunday_reference: "guidance_holy_spirit",
    text: "Deus eterno, mediante o teu Espírito Santo iluminas os corações do teu povo; ensina-nos o que havemos de fazer e ajuda-nos a fazê-lo. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PELA UNIDADE DA IGREJA
  # ================================================================================
  {
    sunday_reference: "church_unity",
    text: "Pai celestial, teu Filho, nosso Senhor Jesus Cristo, disse aos seus apóstolos: \"A minha paz vos deixo, a minha paz vos dou\"; não olhes aos nossos pecados mas a fé da tua Igreja e concede-lhe paz e unidade conforme a tua vontade. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PELA MISSÃO DA IGREJA
  # ================================================================================
  {
    sunday_reference: "church_mission",
    text: "Pai celestial, revelaste-nos o teu amor enviando ao mundo o teu Filho Jesus Cristo, para que por meio d'Ele todos vivam; concede que, pelo poder do Espírito, a Igreja obedeça a sua vontade, fazendo discípulos em todas as nações. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },

  # ================================================================================
  # PELA JUSTIÇA E PELA PAZ
  # ================================================================================
  {
    sunday_reference: "justice_and_peace",
    text: "Pai de justiça, teu Filho virá a ser o nosso juiz; destrói as barreiras que nos dividem e elimina em nós toda a suspeita e ódio, para fazermos sempre justiça com misericórdia e vivermos reunidos na tua paz. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  }
]

# Criar coletas
count = 0
skipped = 0

special_occasions_collects.each do |collect|
  existing = Collect.find_by(
    sunday_reference: collect[:sunday_reference],
    prayer_book_id: prayer_book&.id
  )

  if existing.nil?
    Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
    count += 1
  else
    skipped += 1
  end
end

puts "✅ Coletas para Ocasiões Especiais criadas: #{count}"
puts "⏭️  Coletas já existentes: #{skipped}" if skipped > 0
