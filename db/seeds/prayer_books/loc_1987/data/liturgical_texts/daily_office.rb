# Find the LOC 1987 prayer book
loc_1987 = PrayerBook.find_by(code: "loc_1987")

# ================================================================================
# DAILY OFFICE TEXTS
# ================================================================================

texts = [
  # ============================================================================
  # OPENING SENTENCES
  # ============================================================================
  { slug: "morning_opening_sentence_minister", title: "Sentença da Manhã (Oficiante)", content: "Graça e Paz a vós, da parte de Deus nosso Pai e do Senhor Jesus Cristo." },
  { slug: "morning_opening_sentence_people", title: "Sentença da Manhã (Povo)", content: "Graças a Deus que nos dá a vitória por meio de nosso Senhor Jesus Cristo." },

  { slug: "evening_opening_sentence_minister", title: "Sentença da Tarde (Oficiante)", content: "Senhor, eu amo a casa onde vives, o lugar onde a tua glória está." },
  { slug: "evening_opening_sentence_people", title: "Sentença da Tarde (Povo)", content: "Recebe a minha oração como incenso, e que minhas mãos levantadas sejam como a oferenda da tarde." },

  { slug: "opening_sentence_general_1_minister", title: "Sentença Geral 1 (Oficiante)", content: "Aceita as minhas palavras e os meus pensamentos, ó Deus, meu refúgio e meu protetor!" },
  { slug: "opening_sentence_general_1_people", title: "Sentença Geral 1 (Povo)", content: "Manda a tua luz e a tua verdade, para que elas me ensinem o caminho." },

  { slug: "opening_sentence_general_2_minister", title: "Sentença Geral 2 (Oficiante)", content: "Este é o dia que o Senhor fez." },
  { slug: "opening_sentence_general_2_people", title: "Sentença Geral 2 (Povo)", content: "Regozijemo-nos e alegremo-nos nele." },
  { slug: "opening_sentence_general_2_minister_2", title: "Sentença Geral 2 (Oficiante - cont)", content: "Desde o oriente até o ocidente, seja louvado o nome do Senhor." },
  { slug: "opening_sentence_general_2_people_2", title: "Sentença Geral 2 (Povo - cont)", content: "Deus, o Senhor, governa todas as nações, a sua glória está acima dos céus." },

  # Seasonal Sentences
  { slug: "opening_sentence_advent_minister", title: "Sentença Advento (Oficiante)", content: "Estejam sempre alegres em suas vidas no Senhor. Repito: Alegrem-se. O Senhor virá logo." },
  { slug: "opening_sentence_advent_people", title: "Sentença Advento (Povo)", content: "Amém. Vem, Senhor Jesus." },

  { slug: "opening_sentence_christmas_minister", title: "Sentença Natal (Oficiante)", content: "Foi assim que Ele mostrou o seu amor por nós: Ele mandou seu único Filho ao mundo para termos vida por meio dele." },
  { slug: "opening_sentence_christmas_people", title: "Sentença Natal (Povo)", content: "A Palavra se fez homem e morou entre nós, cheia de graça e de verdade." },

  { slug: "opening_sentence_epiphany_minister", title: "Sentença Epifania (Oficiante)", content: "As nações se encaminharão para a tua luz, e os reis para o resplendor da tua aurora." },
  { slug: "opening_sentence_epiphany_people", title: "Sentença Epifania (Povo)", content: "Também te dei como luz para os gentios, para seres a minha salvação até as extremidades da terra." },

  { slug: "opening_sentence_lent_minister", title: "Sentença Quaresma (Oficiante)", content: "Lava-me de toda a maldade e limpa-me do meu pecado." },
  { slug: "opening_sentence_lent_people", title: "Sentença Quaresma (Povo)", content: "Dá-me novamente a alegria da tua salvação, e faze que o meu espírito seja obediente." },

  { slug: "opening_sentence_holy_week_minister", title: "Sentença Semana Santa (Oficiante)", content: "Se alguém quer me seguir, deve esquecer-se de si mesmo, carregar a sua cruz e seguir-me." },
  { slug: "opening_sentence_holy_week_people", title: "Sentença Semana Santa (Povo)", content: "Porque quem quiser salvar a sua vida, vai perdê-la. Mas quem perder a sua vida por minha causa, vai salvá-la." },

  { slug: "opening_sentence_passion_minister", title: "Sentença Paixão (Oficiante)", content: "Deus nos mostrou o quanto nos ama: quando ainda éramos pecadores, Cristo morreu por nós." },
  { slug: "opening_sentence_passion_people", title: "Sentença Paixão (Povo)", content: "E agora, já que fomos aceitos por Deus por meio da morte de Cristo na cruz, com muito mais razão ficaremos livres, por meio dele, do castigo de Deus." },

  { slug: "opening_sentence_easter_minister", title: "Sentença Páscoa (Oficiante)", content: "Aleluia! Ele ressuscitou!" },
  { slug: "opening_sentence_easter_people", title: "Sentença Páscoa (Povo)", content: "Verdadeiramente o Senhor ressuscitou. Aleluia!" },
  { slug: "opening_sentence_easter_minister_2", title: "Sentença Páscoa (Oficiante - cont)", content: "Louvemos ao Deus e Pai de nosso Senhor Jesus Cristo! Por causa da sua grande misericórdia, ele nos deu uma nova vida pela ressurreição de Jesus Cristo. Por isso nosso coração está cheio de uma esperança viva." },
  { slug: "opening_sentence_easter_people_2", title: "Sentença Páscoa (Povo - cont)", content: "Graças a Deus que nos dá a vitória por intermédio de nosso Senhor Jesus Cristo." },

  { slug: "opening_sentence_ascension_minister", title: "Sentença Ascensão (Oficiante)", content: "Deus lhe deu a mais alta honra, e um nome que é superior a qualquer outro nome." },
  { slug: "opening_sentence_ascension_people", title: "Sentença Ascensão (Povo)", content: "E, assim em honra ao nome de Jesus, todos, no céu, na terra e no mundo dos mortos, dobram os joelhos, e para glória de Deus Pai proclamam: Jesus é o Senhor!" },

  { slug: "opening_sentence_pentecost_minister", title: "Sentença Pentecostes (Oficiante)", content: "Deus tem derramado o seu amor em nossos corações, por meio do Espírito Santo que ele nos deu." },
  { slug: "opening_sentence_pentecost_people", title: "Sentença Pentecostes (Povo)", content: "Pois todos os que são guiados pelo Espírito de Deus são filhos de Deus." },

  { slug: "opening_sentence_trinity_minister", title: "Sentença Trindade (Oficiante)", content: "Como são grandes as riquezas de Deus! Como são profundos o seu conhecimento e a sua sabedoria!" },
  { slug: "opening_sentence_trinity_people", title: "Sentença Trindade (Povo)", content: "Quem pode explicar as suas decisões? Quem pode entender os seus planos?" },

  { slug: "opening_sentence_saints_minister", title: "Sentença Santos (Oficiante)", content: "Quanto a nós, temos esta grande multidão de testemunhas ao nosso redor. Corramos com coragem a corrida que está à nossa frente." },
  { slug: "opening_sentence_saints_people", title: "Sentença Santos (Povo)", content: "Continuemos com os nossos olhos fixos em Jesus, pois dele depende a nossa fé, e está sentado à direita do trono de Deus." },

  { slug: "opening_sentence_thanksgiving_minister", title: "Sentença Ação de Graças (Oficiante)", content: "Agradeçam a Deus, anunciem a sua grandeza, e contem seus feitos às nações." },
  { slug: "opening_sentence_thanksgiving_people", title: "Sentença Ação de Graças (Povo)", content: "Cantem a Deus, cantem louvores a ele; raiem das coisas maravilhosas que ele tem feito!" },

  # ============================================================================
  # CONFESSION AND ABSOLUTION
  # ============================================================================
  { slug: "confession_invitation_1", title: "Convite à Confissão 1", content: "Amados irmãos em Cristo: Aqui, na presença do Deus Onipotente, ajoelhados em silêncio, e com humildes e sinceros corações, confessemos-lhe nossos pecados, de maneira que obtenhamos perdão e alívio por sua infinita bondade e misericórdia, e nos sintamos plenamente reconciliados com Ele." },
  { slug: "confession_invitation_2", title: "Convite à Confissão 2", content: "Confessemos humildemente os nossos pecados a Deus Todo-poderoso." },

  { slug: "confession_prayer_1", title: "Confissão 1", content: "Misericordioso Deus, confessamos que temos pecado contra ti, em pensamentos, palavras e ações; não Te amamos de todo o nosso coração, nem a nosso próximo como a nós mesmos. Imploramos a Tua compaixão; esquece o que fomos, emenda o que somos, dirige o que seremos; de modo que nos alegremos em tua vontade e andemos em teus caminhos, por Jesus Cristo nosso Senhor. Amém." },
  { slug: "confession_prayer_2", title: "Confissão 2", content: "Ó Deus Onipotente e Pai Misericordioso; temos errado e temo-nos apartado dos teus caminhos quais ovelhas desgarradas. Temos por demais seguido os caprichos e desejos de nossos corações. Pecamos contra as tuas santas leis. Deixamos de fazer o que devíamos ter feito. E temos feito o que não devíamos fazer. Nada há em nós que esteja são. Tu, porém, ó Senhor, tem misericórdia de nós, pobres pecadores. Perdoa, ó Deus, aos que confessam as suas culpas. Restaura os que são penitentes, segundo as tuas promessas declaradas ao gênero humano, em Cristo Jesus nosso Senhor. E concede por amor dele, ó Pai de misericórdia que de hoje em diante levemos vida sóbria, justa e pia. À glória do teu santo Nome. Amém." },
  { slug: "confession_prayer_3", title: "Confissão 3", content: "Tem misericórdia de nós, é Deus, segundo a tua benignidade; apaga as nossas transgressões segundo a multidão de tuas misericórdias. Lava-nos completamente de nossa iniquidade e purifica-nos do nosso pecado. Cria em nós, ó Deus, um coração puro, e renova em nós um espírito reto. Não nos lances fora de tua presença e não retires de nós o teu Santo Espírito. Torna a dar-nos a alegria da tua salvação e sustenta-nos com a graça de teu Filho Jesus Cristo. Amém." },

  { slug: "absolution_prayer_deacon", title: "Oração de Perdão (Diácono/Leigo)", content: "Ó Senhor, suplicamos-te que escutes compassivo nossas orações, e perdoes a todos os que a ti confessam os seus pecados; para que aqueles que são acusados por suas consciências, sejam absolvidos por teu perdão; mediante Jesus Cristo nosso Senhor. Amém." },
  { slug: "absolution_prayer_deacon_2_minister", title: "Oração de Perdão 2 (Oficiante)", content: "Deus Todo-poderoso tenha misericórdia de vós, perdoe os vossos pecados e vos mantenha no caminho da vida eterna." },
  { slug: "absolution_prayer_deacon_2_people", title: "Oração de Perdão 2 (Povo)", content: "Deus Todo-poderoso tenha misericórdia de ti, perdoe os teus pecados e te mantenha no caminho da vida eterna. Amém." },

  { slug: "absolution_priest", title: "Absolvição (Sacerdote)", content: "Deus Onipotente, nosso Pai Celestial, que, por sua grande misericórdia, promete o perdão a todos quantos, com sincero arrependimento e viva fé, a Ele se convertem, vos perdoe e liberte de todos os vossos pecados, vos confirme e fortaleça em todo o bem, e vos preserve no caminho da vida eterna; mediante Jesus Cristo, nosso Senhor." },

  # ============================================================================
  # INVITATORY
  # ============================================================================
  { slug: "invitatory_opening_minister", title: "Abre os lábios (Oficiante)", content: "Abre, ó Senhor, os nossos lábios." },
  { slug: "invitatory_opening_people", title: "Abre os lábios (Povo)", content: "E a nossa boca proclamará o teu louvor." },
  { slug: "invitatory_glory_minister", title: "Glória (Oficiante)", content: "Glória a Deus nas alturas!" },
  { slug: "invitatory_glory_people", title: "Glória (Povo)", content: "E na terra paz, boa-vontade entre os homens." },
  { slug: "invitatory_praise_minister", title: "Louvemos (Oficiante)", content: "Louvemos ao Senhor." },
  { slug: "invitatory_praise_people", title: "Louvemos (Povo)", content: "Aleluia!" },

  # Seasonal Antiphons
  { slug: "invitatory_antiphon_advent", title: "Antífona Advento", content: "Nosso Rei e Salvador aproxima-se; * Vinde adorêmo-lo." },
  { slug: "invitatory_antiphon_christmas", title: "Antífona Natal", content: "Aleluia. Porque a nós nos é nascido um menino; * Vinde adorêmo-lo. Aleluia!" },
  { slug: "invitatory_antiphon_epiphany", title: "Antífona Epifania", content: "Aleluia. O Senhor manifestou a sua glória; * Vinde adorêmo-lo. Aleluia!" },
  { slug: "invitatory_antiphon_lent", title: "Antífona Quaresma", content: "O Senhor é cheio de compaixão e misericórdia; * Vinde adorêmo-lo." },
  { slug: "invitatory_antiphon_easter", title: "Antífona Páscoa", content: "Aleluia. Ressuscitou verdadeiramente o Senhor; * Vinde adorêmo-lo. Aleluia!" },
  { slug: "invitatory_antiphon_ascension", title: "Antífona Ascensão", content: "Aleluia. Cristo Senhor subiu ao céu; * Vinde adorêmo-lo. Aleluia!" },
  { slug: "invitatory_antiphon_pentecost", title: "Antífona Pentecostes", content: "Aleluia. O Espírito do Senhor enche o mundo; * Vinde adorêmo-lo. Aleluia!" },
  { slug: "invitatory_antiphon_trinity", title: "Antífona Trindade", content: "Aleluia. Pai, Filho e Espírito Santo, um só Deus; * Vinde adorêmo-lo. Aleluia!" },
  { slug: "invitatory_antiphon_incarnation", title: "Antífona Encarnação", content: "Aleluia. O Verbo se fez carne e habitou entre nós; * Vinde adorêmo-lo. Aleluia!" },
  { slug: "invitatory_antiphon_saints", title: "Antífona Santos", content: "Aleluia. O Senhor é glorioso nos seus Santos; * Vinde adorêmo-lo. Aleluia!" },

  # ============================================================================
  # CREED
  # ============================================================================
  { slug: "apostles_creed", title: "Credo Apostólico", content: "Creio em Deus Pai Todo-poderoso, Criador do céu e da terra: E em Jesus Cristo, seu único Filho, nosso Senhor: o qual foi concebido por obra do Espírito Santo. Nasceu da Virgem Maria: padeceu sob o poder de Pôncio Pilatos, foi crucificado, morto, e sepultado: desceu ao Hades; ressuscitou ao terceiro dia: subiu ao Céu, e está sentado à mão direita de Deus Pai Todo-poderoso: donde há de vir a julgar os vivos e os mortos. Creio no Espírito Santo: na santa Igreja Católica: na Comunhão dos Santos: na remissão dos pecados: na ressurreição do corpo: e na Vida eterna. Amém." },

  # Paraphrase Creed
  { slug: "creed_paraphrase_1_minister", title: "Paráfrase (Oficiante)", content: "Bendigamos a Deus, Pai, Filho e Espírito Santo." },
  { slug: "creed_paraphrase_1_people", title: "Paráfrase (Povo)", content: "Nós o louvamos e exaltamos para todo o sempre." },
  { slug: "creed_paraphrase_2_minister", title: "Paráfrase (Oficiante)", content: "Damos graças ao Senhor, porque Ele nos ama desde a eternidade." },
  { slug: "creed_paraphrase_2_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_3_minister", title: "Paráfrase (Oficiante)", content: "Na plenitude dos tempos, Ele desceu do céu para nos trazer salvação." },
  { slug: "creed_paraphrase_3_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_4_minister", title: "Paráfrase (Oficiante)", content: "E encarnou por obra do Espírito Santo da Virgem Maria e foi feito homem." },
  { slug: "creed_paraphrase_4_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_5_minister", title: "Paráfrase (Oficiante)", content: "E nos remiu dos nossos pecados, sofrendo morte de cruz." },
  { slug: "creed_paraphrase_5_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_6_minister", title: "Paráfrase (Oficiante)", content: "Ao terceiro dia ressurgiu dentre os mortos." },
  { slug: "creed_paraphrase_6_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_7_minister", title: "Paráfrase (Oficiante)", content: "E, também, nos deu a vitória sobre a morte." },
  { slug: "creed_paraphrase_7_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_8_minister", title: "Paráfrase (Oficiante)", content: "Subiu às alturas, e nos abriu os portais da eternidade." },
  { slug: "creed_paraphrase_8_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_9_minister", title: "Paráfrase (Oficiante)", content: "Está em posição de honra, junto ao Pai." },
  { slug: "creed_paraphrase_9_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_10_minister", title: "Paráfrase (Oficiante)", content: "E vive eternamente para interceder por nós." },
  { slug: "creed_paraphrase_10_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_11_minister", title: "Paráfrase (Oficiante)", content: "Nele temos comunhão com todos os santos, inclusive com aqueles que já partiram." },
  { slug: "creed_paraphrase_11_people", title: "Paráfrase (Povo)", content: "Porque sua misericórdia dura para sempre." },
  { slug: "creed_paraphrase_12_minister", title: "Paráfrase (Oficiante)", content: "Glória ao Pai e ao Filho, e ao Espírito Santo." },
  { slug: "creed_paraphrase_12_people", title: "Paráfrase (Povo)", content: "Como era no princípio, é agora e será sempre, por todos os séculos. Amém." },

  { slug: "gloria_patri_minister", content: "Glória ao Pai e ao Filho, e ao Espírito Santo." },
  { slug: "gloria_patri_people", content: "Como era no princípio, é agora e será sempre, por todos os séculos. Amém." },

  # ============================================================================
  # OFFERTORY
  # ============================================================================
  { slug: "offertory_sentence", title: "Ofertório", content: "Tudo vem de ti, Senhor, e do quê é teu to damos. Amém." },

  # ============================================================================
  # PRAYERS
  # ============================================================================
  { slug: "prayers_greeting_minister", title: "Saudação (Oficiante)", content: "O Senhor seja convosco" },
  { slug: "prayers_greeting_people", title: "Saudação (Povo)", content: "Seja também contigo" },
  { slug: "prayers_let_us_pray", title: "Oremos", content: "Oremos" },

  # Lord's Prayer (Should be shared but defined here for completeness if needed, or reused)
  # I'll rely on shared 'our_father' usually, but this version has "dividas/devedores" which is traditional
  { slug: "lords_prayer_traditional", title: "Pai Nosso", content: "Pai nosso, que estás nos céus, Santificado seja o teu Nome, Venha o teu Reino, Seja feita a tua vontade, assim na terra como no céu. O pão nosso de cada dia nos dá hoje. E perdoa-nos as nossas dívidas, Assim como nós também perdoamos aos nossos devedores. E não nos deixes cair em tentação, Mas livra-nos do mal; Pois teu é o Reino, e o poder, e a glória para sempre. Amém." },

  # Suffrages 1
  { slug: "suffrages_1_v1", title: "Sufrágio 1 V1", content: "Ó Senhor, mostra-nos a tua misericórdia." },
  { slug: "suffrages_1_r1", title: "Sufrágio 1 R1", content: "E concede-nos a tua salvação." },
  { slug: "suffrages_1_v2", title: "Sufrágio 1 V2", content: "Reveste de santidade os teus ministros." },
  { slug: "suffrages_1_r2", title: "Sufrágio 1 R2", content: "E cante o teu povo de alegria." },
  { slug: "suffrages_1_v3", title: "Sufrágio 1 V3", content: "Derrama paz sobre o mundo inteiro." },
  { slug: "suffrages_1_r3", title: "Sufrágio 1 R3", content: "Pois só em ti podemos viver em segurança." },
  { slug: "suffrages_1_v4", title: "Sufrágio 1 V4", content: "Guarda a Nação sob os teus cuidados." },
  { slug: "suffrages_1_r4", title: "Sufrágio 1 R4", content: "E guia-nos pelos caminhos da justiça e da verdade." },
  { slug: "suffrages_1_v5", title: "Sufrágio 1 V5", content: "Sejam teus mandamentos conhecidos em toda a terra." },
  { slug: "suffrages_1_r5", title: "Sufrágio 1 R5", content: "E vivam as nações em harmonia." },
  { slug: "suffrages_1_v6", title: "Sufrágio 1 V6", content: "Não sejam os necessitados esquecidos." },
  { slug: "suffrages_1_r6", title: "Sufrágio 1 R6", content: "Nem se apague a esperança dos pobres." },
  { slug: "suffrages_1_v7", title: "Sufrágio 1 V7", content: "Cria em nós um coração novo." },
  { slug: "suffrages_1_r7", title: "Sufrágio 1 R7", content: "E sustenta-nos com teu Espírito Santo." },

  # Suffrages 2
  { slug: "suffrages_2_v1", title: "Sufrágio 2 V1", content: "Salva, Senhor, o teu povo." },
  { slug: "suffrages_2_r1", title: "Sufrágio 2 R1", content: "Governa-o e protege-o, agora e sempre" },
  { slug: "suffrages_2_v2", title: "Sufrágio 2 V2", content: "De dia em dia te bendizemos." },
  { slug: "suffrages_2_r2", title: "Sufrágio 2 R2", content: "E louvamos teu nome para sempre." },
  { slug: "suffrages_2_v3", title: "Sufrágio 2 V3", content: "Guarda-nos, hoje, do pecado." },
  { slug: "suffrages_2_r3", title: "Sufrágio 2 R3", content: "Tem piedade de nós, Senhor, tem piedade." },
  { slug: "suffrages_2_v4", title: "Sufrágio 2 V4", content: "Mostra-nos teu amor e bondade." },
  { slug: "suffrages_2_r4", title: "Sufrágio 2 R4", content: "Pois em ti pomos nossa confiança." },
  { slug: "suffrages_2_v5", title: "Sufrágio 2 V5", content: "Em ti, Senhor, está nossa esperança." },
  { slug: "suffrages_2_r5", title: "Sufrágio 2 R5", content: "Não sejamos jamais confundidos." },

  # Collects
  { slug: "collect_peace", title: "Pela Paz", content: "Ó Deus, que és o autor da paz, a quem conhecer é possuir a vida eterna e a quem servir é reinar, conserva sob tua proteção os que humildes invocam teu nome, a fim de que, confiados em teu amparo, jamais temamos as forças do mal; mediante o poder de Jesus Cristo, nosso Senhor. Amém." },
  { slug: "collect_peace_2", title: "Pela Paz (Vespertina?)", content: "Ó Deus, de quem procedem os desejos santos, os retos conselhos e os atos de justiça: concede a nós, teus servos, a paz que o mundo não nos pode dar, a fim de que nossos corações se dediquem a cumprir teus mandamentos, e, livres de temores, vivamos em paz e tranquilidade; pelos merecimentos de Jesus Cristo, nosso Senhor. Amém." }, # Usually Evening
  { slug: "collect_grace", title: "Pela Graça", content: "Ó Senhor, nosso Pai Celestial, Todo-poderoso e Eterno Deus, que nos trouxeste em segurança até o presente, defende-nos com teu imenso poder, não permitindo que caiamos em pecado ou que de ti nos afastemos, e concede que nossos pensamentos e ações, inspirados por ti, sejam sempre aceitáveis a teus olhos; mediante Jesus Cristo nosso Senhor. Amém." },

  # Other Prayers
  { slug: "prayer_authorities", title: "Pelas Autoridades", content: "Ó Senhor, que nos governas, e de quem a glória enche toda a terra; ao teu misericordioso cuidado encomendamos nossa Pátria, a fim de que, guiados por tua providência, habitemos em tua paz e em segurança. Concede ao Presidente da República, e a todas as outras Autoridades, sabedoria e força para conhecer e praticar a tua vontade. Enche-os de amor à verdade e à justiça. Faze-os sempre zelosos da sua missão para servirem este povo no temor do teu santo Nome; mediante Jesus Cristo nosso Senhor, que vive e reina contigo e o Espírito Santo, um só Deus, pelos séculos sem fim. Amém." },
  { slug: "prayer_clergy_people", title: "Pelo Clero e Povo", content: "Onipotente e sempiterno Deus, do qual procede toda a boa dádiva e dom perfeito; envia lá do alto sobre os nossos bispos, todo o clero e as congregações confiadas a seus cuidados, o poder do Santo Espírito, e para que deveras te agradem, espalha continuamente sobre eles o orvalho de tua bênção. Concede-nos isto, ó Senhor, à honra de teu Filho que se fez nosso irmão, Jesus Cristo. Amém." },
  { slug: "prayer_parish_family", title: "Pela Família Paroquial", content: "Ó Deus, Espírito Santo, Santificador dos fiéis, visita, te rogamos, nossa congregação com teu amor e favor; ilumina nossos entendimentos mais e mais com a luz de teu eterno Evangelho; implanta em nossos corações o amor à verdade; nutre-nos com toda a bondade; aumenta em nós a verdadeira religião; e nela nos guarda por tua misericórdia, ó bendito Espírito, que, com o Pai e o Filho, juntos adoramos e glorificamos como um só Deus, por séculos sem fim. Amém." },
  { slug: "prayer_all_humanity", title: "Por Toda a Humanidade", content: "Ó Deus, Criador e Protetor de todo o gênero humano, intercedemos humildemente pelos homens de todas as classes e condições: digna-te fazer-lhes conhecidos os teus caminhos, e manifesta a todas as nações a tua eterna salvação. Pedimos especialmente a favor de tua santa Igreja Universal; a fim de que ela seja de tal maneira guiada e governada por teu Santo Espírito, que todos os que professam a religião de teu Filho sejam conduzidos no caminho da verdade e fé, em unidade, paz e retidão. Confiamos, finalmente, à tua paternal bondade todos os que de qualquer modo se achem aflitos ou perturbados na consciência, no corpo ou na situação da vida; particularmente aqueles por quem as nossas orações são desejadas. Suplicamos que os confortes e alivies, em todos os seus problemas, dando-lhes paciência no sofrimento e força para vencer as suas aflições. E isto nós te rogamos por amor de Jesus. Amém." },

  { slug: "general_thanksgiving_1", title: "Ação de Graças Geral 1", content: "Onipotente Deus, Pai de toda a misericórdia, nós, teus indignos servos, rendemos-te os mais humildes e sinceros agradecimentos por toda a tua benevolência e carinhosa bondade para conosco e para com todos. Nós te bendizemos por nossa criação, preservação e por todas as bênçãos desta vida; principalmente por teu inestimável amor na redenção do mundo por nosso Senhor Jesus Cristo, pelos meios de graça e esperança da glória. A Ti rogamos nos concedas tal apreciação de tuas misericórdias, que nossos corações exultem de sincera gratidão, e, que, proclamemos teus louvores não somente com os nossos lábios, mas com as nossas vidas, entregando-nos inteiramente ao teu serviço, e andando na tua presença em santidade e retidão todos os nossos dias. Por Jesus Cristo nosso Senhor, a quem contigo e o Espírito Santo, seja toda a honra e glória, por séculos sem fim. Amém." },

  # Litany Thanksgiving
  { slug: "general_thanksgiving_2_v1", title: "Ação de Graças 2 V1", content: "Pelo dom de teu Espírito." },
  { slug: "general_thanksgiving_2_r1", title: "Ação de Graças 2 R1", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v2", title: "Ação de Graças 2 V2", content: "Pela Santa Igreja Universal." },
  { slug: "general_thanksgiving_2_r2", title: "Ação de Graças 2 R2", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v3", title: "Ação de Graças 2 V3", content: "Pelos Sacramentos e outros meios de graça." },
  { slug: "general_thanksgiving_2_r3", title: "Ação de Graças 2 R3", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v4", title: "Ação de Graças 2 V4", content: "Pela esperança da glória de Deus." },
  { slug: "general_thanksgiving_2_r4", title: "Ação de Graças 2 R4", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v5", title: "Ação de Graças 2 V5", content: "Pelas vitórias do Evangelho." },
  { slug: "general_thanksgiving_2_r5", title: "Ação de Graças 2 R5", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v6", title: "Ação de Graças 2 V6", content: "Pelo testemunho de todos os teus santos." },
  { slug: "general_thanksgiving_2_r6", title: "Ação de Graças 2 R6", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v7", title: "Ação de Graças 2 V7", content: "Na alegria e na tristeza." },
  { slug: "general_thanksgiving_2_r7", title: "Ação de Graças 2 R7", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v8", title: "Ação de Graças 2 V8", content: "Na vida e na morte." },
  { slug: "general_thanksgiving_2_r8", title: "Ação de Graças 2 R8", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_v9", title: "Ação de Graças 2 V9", content: "Hoje e todo o sempre." },
  { slug: "general_thanksgiving_2_r9", title: "Ação de Graças 2 R9", content: "Bendito sejas, ó Cristo." },
  { slug: "general_thanksgiving_2_all", title: "Ação de Graças 2 Todos", content: "Honra, louvor e ações de graças te sejam dadas, ó santa e gloriosa Trindade, Pai, Filho e Espírito Santo, por todos os seres humanos, para todo o sempre. Amém." },

  { slug: "prayer_chrysostom", title: "Oração de São João Crisóstomo", content: "Deus Todo-poderoso, que nos deste hoje a graça de, concordemente reunidos, te dirigirmos as nossas preces prometendo que, onde se congregassem dois ou três em Teu Nome, atenderias aos seus rogos; cumpre agora, ó Senhor, os desejos e orações de teus servos, segundo a estes mais convier, concedendo-nos neste mundo conhecimento da tua verdade e, no vindouro a vida eterna. Amém." },

  # ============================================================================
  # CONCLUSION
  # ============================================================================
  { slug: "conclusion_grace", title: "A Graça", content: "A Graça de nosso Senhor Jesus Cristo, e o amor de Deus, e a comunhão do Espírito Santo sejam com todos nós para sempre. Amém." },
  { slug: "conclusion_blessing", title: "A Bênção", content: "O Senhor nos abençoe e nos guarde. O Senhor faça resplandecer o seu semblante sobre nós, e tenha misericórdia de nós. O Senhor sobre nós levante sua face, e nos dê a paz, agora e sempre. Amém." },
  { slug: "conclusion_protection_minister", title: "Proteção Divina (Oficiante)", content: "A divina proteção permaneça conosco para sempre." },
  { slug: "conclusion_protection_people", title: "Proteção Divina (Povo)", content: "E com nossos irmãos ausentes. Amém." },
  { slug: "conclusion_protection_minister_2", title: "Descanso (Oficiante)", content: "Que as almas dos fiéis, pela misericórdia de Deus, descansem em paz." },
  { slug: "conclusion_protection_people_2", title: "Descanso (Povo)", content: "Amém." },

  # ============================================================================
  # RUBRICS
  # ============================================================================
  { slug: "rubric_confession_intro", title: "Rubrica Confissão", content: "Então o Oficiante dirá:" },
  { slug: "rubric_confession_short", title: "Rubrica Confissão Breve", content: "Ou dirá:" },
  { slug: "rubric_confession_silence", title: "Rubrica Silêncio Confissão", content: "Haverá um instante de silêncio, estando todos ajoelhados." },
  { slug: "rubric_confession_options", title: "Rubrica Opções Confissão", content: "Ou esta:" },
  { slug: "rubric_absolution_intro", title: "Rubrica Absolvição", content: "O Oficiante, ainda ajoelhado, lerá uma das orações seguintes. Estando presente, porém, um Bispo ou Presbítero, deverá ser usada a Absolvição em lugar das orações abaixo:" },
  { slug: "rubric_absolution_priest", title: "Rubrica Absolvição Sacerdote", content: "Para ser usada unicamente pelo Bispo ou Presbítero:" },
  { slug: "rubric_invitatory_stand", title: "Rubrica De Pé", content: "Então levantam-se todos." },
  { slug: "rubric_antiphons", title: "Rubrica Antífonas", content: "Nos dias abaixo indicados, logo antes do Venite ou Jubilate Deo poderá ser cantado ou dito:" },
  { slug: "rubric_venite", title: "Rubrica Venite", content: "Seguir-se-á o Venite ou o Jubilate, que poderão ser substituídos por qualquer hino de louvor." },
  { slug: "rubric_pascha_nostrum", title: "Rubrica Pascha Nostrum", content: "Durante a Quadra Pascal poderá ser usado o cântico Pascha Nostrum, nº12, na página 49 em lugar do Venite ou do Jubilate." },
  { slug: "rubric_psalms", title: "Rubrica Salmos", content: "Haverá, então, a leitura do Salmo ou de Salmos, após o que, será dito ou cantado o Glória Patri:" },
  { slug: "rubric_readings_sit", title: "Rubrica Sentados", content: "Sentando-se todos, haverá, então, a leitura do Antigo e do Novo Testamento, sendo que uma delas poderá ser omitida." },
  { slug: "rubric_readings_announcement", title: "Rubrica Anúncio Leitura", content: "As leituras serão anunciadas da seguinte maneira: A Palavra de Deus escrita no Livro (Epístola ou Evangelho) de {{book_name}}, capitulo {{chapter}}, começando com o versículo {{verse}}." },
  { slug: "rubric_readings_end", title: "Rubrica Fim Leitura", content: "No fim da leitura será dito." },
  { slug: "rubric_readings_silence", title: "Rubrica Silêncio/Cântico", content: "Após cada leitura poder-se-á guardar uns instantes de silêncio; e a seguir será entoado ou dito um Cântico das páginas 42s ou um hino." },
  { slug: "rubric_sermon", title: "Rubrica Sermão", content: "Seguir-se-á o Sermão, que deverá ser substituído pela leitura de trechos de livros autorizados, sempre que o Oficiante não tiver licença do Bispo para pregar sermões próprios. O Sermão, porém, poderá ser pregado após o ofício ou ser omitido." },
  { slug: "rubric_creed_stand", title: "Rubrica Credo", content: "Seguir-se-á o Credo dos Apóstolos, estando de pé o Oficiante e o Povo." },
  { slug: "rubric_creed_paraphrase", title: "Rubrica Paráfrase", content: "Ou dirá a seguinte Paráfrase, desde que o Credo seja dito, ao menos, uma vez por semana:" },
  { slug: "rubric_offertory", title: "Rubrica Ofertório", content: "Quando não for celebrada a Santa Eucaristia aqui poderá haver o levantamento das ofertas, após o que será dito ou cantado:" },
  { slug: "rubric_prayers_intro", title: "Rubrica Orações", content: "Será dito então:" },
  { slug: "rubric_suffrages_intro", title: "Rubrica Sufrágios", content: "Será dita uma das seguintes orações:" },
  { slug: "rubric_collects_intro", title: "Rubrica Coletas", content: "Será dita a Coleta do Dia e da Quadra, quando houver." },
  { slug: "rubric_prayers_general", title: "Rubrica Orações Gerais", content: "Então, serão feitas algumas das orações que seguem, e que poderão ser substituídas por orações extemporâneas, a cargo de pessoas da congregação. Também poderão ser dados pelo Oficiante tópicos para orações, seguidos de orações silenciosas." },
  { slug: "rubric_thanksgiving_joint", title: "Rubrica Ação de Graças Conjunta", content: "Para ser dita conjuntamente pela Congregação e pelo Oficiante:" },
  { slug: "rubric_conclusion_options", title: "Rubrica Opções Conclusão", content: "Ou:" },
  { slug: "rubric_communion_bridge", title: "Rubrica Ponte Comunhão", content: "Quando, porém, se desejar unir o presente ofício ao da Santa Comunhão, passar-se-á daqui diretamente para o Ofertório." },
  { slug: "rubric_sermon_end", title: "Rubrica Fim Sermão", content: "Se o sermão for proferido depois da leitura do ofício, haverá orações finais seguidas de uma das fórmulas de encerramento. Estando, porém, presente um Bispo ou Presbítero o povo será despedido com uma Bênção." }
]

texts.each do |text_data|
  text = LiturgicalText.find_or_initialize_by(
    prayer_book: loc_1987,
    slug: text_data[:slug]
  )
  
  category = if text_data[:slug].start_with?("rubric_")
               "rubric"
             elsif text_data[:slug].include?("opening_sentence")
               "opening_sentence"
             elsif text_data[:slug].include?("confession")
               "confession"
             elsif text_data[:slug].include?("absolution")
               "absolution"
             elsif text_data[:slug].include?("invitatory")
               "invocation"
             elsif text_data[:slug].include?("creed")
               "creed"
             elsif text_data[:slug].include?("suffrage")
               "suffrage"
             else
               "prayer"
             end

  text.update!(
    title: text_data[:title],
    content: text_data[:content],
    category: category,
    language: "pt-BR"
  )
end

puts "✅ Seeded #{texts.size} daily office texts"
