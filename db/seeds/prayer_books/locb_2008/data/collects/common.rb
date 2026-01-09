# ================================================================================
# COLETAS COMUNS PARA OUTRAS COMEMORAÇÕES - LOCB 2008
# (Seguem o Lecionário Diário)
# ================================================================================

Rails.logger.info "🙏 Criando Coletas Comuns para Comemorações - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

common_collects = [
  {
    sunday_reference: "common_saints",
    text: "Deus Todo-poderoso, que nos manténs em unidade com todos os teus santos no céu e na terra, permite que fortalecidos pelo bom exemplo de teu servo N., e imitando a sua fé, sejamos continuamente sustentados por esta comunhão de fé e oração, sabedores que pela intercessão de Jesus Cristo teu Filho, nosso Senhor, as nossas orações são aceitáveis a ti, ó Pai, por meio do Espírito Santo, um só Deus agora e sempre. Amém." },
  {
    sunday_reference: "common_martyrs",
    text: "Deus Todo-poderoso, que deste ao teu servo N., a ousadia de confessar diante dos poderosos deste mundo o nome glorioso de teu Filho e de morrer como mártir pela fé cristã, ajuda-nos a seguir o seu supremo exemplo de renúncia e a viver nossa vida, prontos a dar a razão da esperança que há em nós e, se necessário, a morrer por esta esperança; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém." },
  {
    sunday_reference: "common_pastors",
    text: "Ó Senhor, tu que és Pastor e Bispo das nossas almas e que escolheste teu servo N. para ser [Bispo e] Pastor na tua Igreja, ajuda-o, com teu poder, a apascentar o teu rebanho; e concede, pelo teu Espírito, a todos os pastores, dons, talentos e habilidades, para que, como verdadeiros servos de Cristo e fiéis despenseiros dos teus divinos mistérios, ministrem ao teu povo; por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém." },
  {
    sunday_reference: "common_missionaries",
    text: "Deus Todo-poderoso e eterno, damos-te graças por teu servo N., a quem chamaste para pregar o Evangelho ao povo de N.; desperta, neste e em todos os povos, evangelistas e mensageiros do teu reino, para que a tua Igreja proclame as insondáveis riquezas de nosso Salvador Jesus Cristo teu Filho, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém." },
  {
    sunday_reference: "common_theologians",
    text: "Ó Deus, que pelo Espírito Santo concedes dons especiais para que possamos entender e ensinar a tua Palavra, louvamos o teu nome pela graça manifestada ao teu servo N., a quem capacitaste, e suplicamos que a tua Igreja seja sempre provida com esses dons; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém." },
  {
    sunday_reference: "common_religious_order",
    text: "Ó Deus, cujo bendito Filho viveu vida consagrada a ti, liberta-nos do amor indevido por este mundo, para que, inspirados na vida consagrada do teu servo N., te sirvamos alegremente e com ele alcancemos a herança da vida eterna; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus agora e sempre. Amém." }
]

# Criar coletas
count = 0
skipped = 0

common_collects.each do |collect|
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

Rails.logger.info "✅ Coletas Comuns criadas: #{count}"
Rails.logger.info "⏭️  Coletas já existentes: #{skipped}" if skipped > 0
