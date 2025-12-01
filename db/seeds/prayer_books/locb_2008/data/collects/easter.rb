# ================================================================================
# COLETAS DO TEMPO PASCAL - LOCB 2008
# Cor litúrgica: Branco ou Dourado
# ================================================================================

Rails.logger.info "🙏 Criando Coletas do Tempo Pascal - LOCB 2008..."

prayer_book = PrayerBook.find_by_code('locb_2008')

easter_collects = [
  # VIGÍLIA PASCAL
  {
    sunday_reference: "easter_vigil",
    text: "Senhor Deus, Tu fizeste resplandecer esta noite com a glória da ressurreição de Cristo; faz com que a sua luz brilhe na tua Igreja para que sejamos renovados no corpo e na alma e nos entreguemos plenamente ao teu serviço. Amém.",
    language: "pt-BR"
  },
  # DOMINGO DE PÁSCOA
  {
    sunday_reference: "easter_sunday",
    text: "Ó Deus, que para a nossa redenção entregaste o teu unigênito Filho à morte de cruz, e pela tua gloriosa ressurreição nos libertaste do poder de nosso inimigo; concede que morramos diariamente para o pecado, a fim de que vivamos sempre com Ele na alegria de sua ressurreição; mediante Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "easter_sunday",
    text: "Ó Pai Celestial, que fizeste com que a aurora santa brilhasse com a glória da ressurreição do Senhor; aviva em tua Igreja o Espírito de adoção, que nos é dado no Batismo, a fim de que nós, sendo renovados tanto no corpo como na mente, te adoremos com sinceridade e verdade; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "easter_sunday",
    text: "Onipotente Deus, que por teu unigênito Filho Jesus Cristo venceste a morte e nos franqueaste as portas da vida eterna; concede que nós, que celebramos com alegria o dia da ressurreição do Senhor, ressuscitemos da morte do pecado, pelo teu Espírito vivificador; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # DOMINGO DE PÁSCOA - CELEBRAÇÃO VESPERTINA
  {
    sunday_reference: "easter_sunday_evening",
    text: "Senhor de toda a vida e de toda a força, pela poderosa ressurreição de teu Filho, venceste a velha ordem do pecado e da morte, e n'Ele renovaste todas as coisas; concede que, morrendo nós para o pecado, e estando vivos para Ti em Jesus Cristo, possamos participar com Ele da glória; ao qual, contigo e com o Espírito Santo, sejam dadas honra e glória, agora e pela eternidade. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "easter_sunday_evening",
    text: "Deus Todo-poderoso, por meio de teu Filho unigênito Jesus Cristo, venceste a morte e abriste-nos as portas da vida eterna; já que, pela tua graça preveniente implantaste em nossos corações desejos santos, ajuda-nos com a tua graça cooperante a levá-los a bom termo. Mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # SEGUNDA-FEIRA DA SEMANA DA PÁSCOA
  {
    sunday_reference: "easter_monday",
    text: "Concede, nós te rogamos, ó Deus Onipotente, que nós, que celebramos com reverência a festa pascal, nos tornemos dignos de alcançar as alegrias sempiternas; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # TERÇA-FEIRA DA SEMANA DA PÁSCOA
  {
    sunday_reference: "easter_tuesday",
    text: "Ó Deus, que pela gloriosa ressurreição de teu Filho Jesus Cristo destruíste a morte e trouxeste à luz vida e imortalidade; concede a nós, que fomos ressuscitados com Ele, permaneçamos na sua presença e nos alegremos na esperança da glória eterna; por Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # QUARTA-FEIRA DA SEMANA DA PÁSCOA
  {
    sunday_reference: "easter_wednesday",
    text: "Ó Deus, cujo bendito Filho se manifestou aos discípulos no partir do Pão; abre os olhos da nossa fé para reconhecê-lo em toda a sua obra redentora; pelo mesmo Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # QUINTA-FEIRA DA SEMANA DA PÁSCOA
  {
    sunday_reference: "easter_thursday",
    text: "Onipotente e sempiterno Deus que, no mistério pascal, estabeleceste a nova aliança da reconciliação; concede que todos os que renasceram na comunhão do Corpo de Cristo, demonstrem em suas vidas a fé que professam; mediante Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # SEXTA-FEIRA DA SEMANA DA PÁSCOA
  {
    sunday_reference: "easter_friday",
    text: "Pai Onipotente, que deste teu único Filho para morrer por nossos pecados e ressurgir para nossa justificação; concede que de tal maneira apartemos de nós o fermento da maldade e da malícia, que te sirvamos com sinceridade e pureza de vida; por Jesus Cristo teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # SÁBADO DA SEMANA DA PÁSCOA
  {
    sunday_reference: "easter_saturday",
    text: "Damos-te graças, ó Pai Celestial, porque nos libertaste do domínio do pecado e da morte, e nos trouxeste para o reino de teu Filho; rogamos-te que, assim como por meio de sua morte, Ele nos chamou de novo para a vida, assim por seu amor ressuscitemos para as alegrias eternas; pelo mesmo Jesus Cristo, nosso Senhor, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 2º DOMINGO DA PÁSCOA
  {
    sunday_reference: "2nd_sunday_of_easter",
    text: "Pai celestial, libertaste-nos do poder do pecado e trouxeste-nos para o reino de teu Filho; concede que Aquele cuja morte nos restaurou à vida, pela sua presença entre nós, nos erga até às alegrias eternas. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "2nd_sunday_of_easter_alt",
    text: "Pai Todo-poderoso, deste teu Filho para morrer pelos nossos pecados e ressuscitar para nossa justificação; permite que a malícia nos não afete nem a perversão nos corrompa, para te servirmos sempre em verdade e santidade. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # 3º DOMINGO DA PÁSCOA
  {
    sunday_reference: "3rd_sunday_of_easter",
    text: "Senhor de misericórdia, teu Filho é a ressurreição e a vida de todos os que n'Ele creem; ergue-nos da morte do pecado, para a vida da retidão. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "3rd_sunday_of_easter_alt",
    text: "Deus Todo-poderoso, tu mostras a luz da verdade aos que erram para que regressem ao caminho da retidão; ajuda os que são de Cristo a renunciar a tudo que se oponha à fé que professam e a andar nos passos do divino Mestre. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # 4º DOMINGO DA PÁSCOA
  {
    sunday_reference: "4th_sunday_of_easter",
    text: "Ó Deus, cujo Filho Jesus é o Bom Pastor do teu povo; concede que, quando ouvirmos sua voz, reconheçamos Aquele que nos chama cada um pelo nome e o sigamos para onde nos conduz; o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "4th_sunday_of_easter_alt",
    text: "Pai Todo-poderoso, entregaste teu Filho Jesus Cristo para ser sacrifício pelo nosso pecado e exemplo de piedade de vida; dá-nos graça para que recebamos em constante gratidão os imensos benefícios do seu sacrifício, e também nos esforcemos diariamente por seguir a sua santidade de vida. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # 5º DOMINGO DA PÁSCOA
  {
    sunday_reference: "5th_sunday_of_easter",
    text: "Ó Deus Onipotente, a quem verdadeiramente conhecer é a vida eterna; concede-nos que conheçamos perfeitamente que teu Filho Jesus Cristo é o caminho, a verdade e a vida; para que, seguindo seus passos, andemos com perseverança no caminho que conduz à vida eterna; mediante o mesmo teu Filho Jesus Cristo, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "5th_sunday_of_easter_alt",
    text: "Deus Todo-poderoso, só Tu podes dominar as nossas desregradas vontades e paixões; dá-nos a graça de amar os teus mandamentos e desejar veementemente as tuas promessas, para que, através das mudanças e desvarios deste mundo, os nossos corações se fixem onde estão as verdadeiras alegrias. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # 6º DOMINGO DA PÁSCOA
  {
    sunday_reference: "6th_sunday_of_easter",
    text: "Pai eterno, o teu reino vai além do espaço e do tempo; concede que neste mundo de constantes mutações nos fixemos naquilo que permanece para sempre. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "6th_sunday_of_easter_alt",
    text: "Pai amantíssimo, já que tudo quanto é bom provém de Ti, dá aos teus humildes servos a inspiração de procurarem a santidade nos pensamentos e nas ações. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  # VÉSPERA DA ASCENSÃO
  {
    sunday_reference: "eve_of_ascension",
    text: "Pai eterno, teu Filho subiu aos céus e tem autoridade neste e no mundo futuro; dá-nos a fé de saber que Ele vive na sua Igreja sobre a Terra, e que no fim dos tempos todo o mundo verá a sua glória; o qual vive e reina, contigo e com o Espírito Santo um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # DIA DA ASCENSÃO
  {
    sunday_reference: "ascension_day",
    text: "Senhor soberano, teu Filho ascendeu em triunfo para governar todo o universo em amor e glória; faz que todos os povos reconheçam a autoridade do seu reino. Mediante Jesus Cristo, nosso Senhor. Amém.",
    language: "pt-BR"
  },
  {
    sunday_reference: "ascension_day_alt",
    text: "Concede, nós te rogamos, Deus Onipotente, que, assim como cremos que teu unigênito Filho, nosso Senhor Jesus Cristo subiu aos céus, também lá subamos em coração e pensamento e habitemos sempre com aquele que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  },
  # 7º DOMINGO DA PÁSCOA
  {
    sunday_reference: "7th_sunday_of_easter",
    text: "Ó Deus, Rei da glória, que exaltaste o teu único Filho Jesus Cristo com grande triunfo ao teu celeste reino; suplicamos-te que não nos deixes desconsolados, mas nos envies o teu Santo Espírito para nos confortar e conduzir ao alto e santo lugar, onde nosso Senhor Jesus Cristo já nos precedeu, o qual vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    language: "pt-BR"
  }
]

easter_collects.each do |collect|
  Collect.create!(collect.merge(prayer_book_id: prayer_book&.id))
end

Rails.logger.info "  ✓ #{easter_collects.count} coletas do Tempo Pascal criadas"
