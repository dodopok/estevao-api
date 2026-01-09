# ================================================================================
# COLETAS DA QUARESMA - LOCB 2008
# Cor litúrgica: Roxo
# ================================================================================

Rails.logger.info "🙏 Criando Coletas da Quaresma - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

lent_collects = [
  # QUARTA-FEIRA DE CINZAS
  {
    sunday_reference: "ash_wednesday",
    text: "Onipotente e Eterno Deus, que amas tudo quanto criaste, e que perdoas a todos os penitentes; cria em nós corações novos e contritos, para que, lamentando deveras os nossos pecados e confessando a nossa miséria, alcancemos de ti, Deus de suma piedade, perfeita remissão e perdão; por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # 1º DOMINGO DA QUARESMA
  {
    sunday_reference: "1st_sunday_in_lent",
    text: "Onipotente Deus, cujo bendito Filho foi conduzido pelo Espírito para ser tentado pelo demônio, apressa-te em socorrer a nós, que somos assaltados por muitas tentações, nós te rogamos. E, assim como conheces as fraquezas de cada um de nós, permite que cada qual encontre em ti o poder de salvação. Por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # 2º DOMINGO DA QUARESMA
  {
    sunday_reference: "2nd_sunday_in_lent",
    text: "Ó Deus, cuja glória é sempre ser misericordioso, sê benigno para com todos os que se afastaram dos teus caminhos, conduze-os de novo a ti, com corações penitentes e viva fé, para que se firmem na verdade imutável da tua Palavra, Jesus Cristo, teu Filho, que, contigo e com o Espírito Santo, vive e reina, um só Deus, agora e sempre. Amém." },
  # 3º DOMINGO DA QUARESMA
  {
    sunday_reference: "3rd_sunday_in_lent",
    text: "Ó Deus, que sabes quão frágeis somos, guarda-nos a nós, teus servos, defendendo exteriormente nossos corpos de toda a adversidade e purificando interiormente nossas almas de todo mau pensamento; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # 4º DOMINGO DA QUARESMA
  {
    sunday_reference: "4th_sunday_in_lent",
    text: "Bendito Pai, cujo Filho Jesus Cristo desceu do céu para ser o verdadeiro Pão que vivifica o mundo; concede-nos sempre esse Pão, para que Ele viva em nós e nós nele, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." },
  # 5º DOMINGO DA QUARESMA
  {
    sunday_reference: "5th_sunday_in_lent",
    text: "Onipotente Deus, Tu somente podes colocar em ordem a vontade e as afeições desordenadas dos pecadores. Concede ao teu povo a graça de amar o que ordenas e desejar o que prometes; para que, entre as inconstâncias do mundo, permaneçam nossos corações firmados lá onde se acha a verdadeira alegria, por nosso Senhor Jesus Cristo, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém." }
]

lent_collects.each do |collect|
  Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{lent_collects.count} coletas da Quaresma criadas"
