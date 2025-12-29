# Seeds for Liturgical Texts - LOC 2019 EN
prayer_book = PrayerBook.find_by!(code: 'loc_2019_en')

Rails.logger.info "Creating liturgical texts for LOC 2019 English..."

## Morning Prayer

# Opening Sentences
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "Grace to you and peace from God our Father and the Lord Jesus Christ."
  lt.reference = "Philippians 1:2"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "I was glad when they said unto me, \"We will go into the house of the LORD.\""
  lt.reference = "Psalm 122:1"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "Let the words of my mouth and the meditation of my heart be always acceptable in your sight, O LORD, my rock and my redeemer."
  lt.reference = "Psalm 19:14"
  lt.language = 'en'
end

# Seasonal Opening Sentences
LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_advent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "In the wilderness prepare the way of the LORD; make straight in the desert a highway for our God."
  lt.reference = "Isaiah 40:3"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_christmas', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "Fear not, for behold, I bring you good news of great joy that will be for all the people. For unto you is born this day in the city of David a Savior, who is Christ the Lord."
  lt.reference = "Luke 2:10-11"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_epiphany', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "From the rising of the sun to its setting my name will be great among the nations, and in every place incense will be offered to my name, and a pure offering. For my name will be great among the nations, says the LORD of hosts."
  lt.reference = "Malachi 1:11"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "Repent, for the kingdom of heaven is at hand."
  lt.reference = "Matthew 3:2"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_holy_week', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "Is it nothing to you, all you who pass by? Look and see if there is any sorrow like my sorrow, which was brought upon me, which the LORD inflicted on the day of his fierce anger."
  lt.reference = "Lamentations 1:12"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_easter', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "If then you have been raised with Christ, seek the things that are above, where Christ is, seated at the right hand of God."
  lt.reference = "Colossians 3:1"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_ascension', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "Since then we have a great high priest who has passed through the heavens, Jesus, the Son of God, let us hold fast our confession. Let us then with confidence draw near to the throne of grace, that we may receive mercy and find grace to help in time of need."
  lt.reference = "Hebrews 4:14, 16"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_pentecost', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "You will receive power when the Holy Spirit has come upon you, and you will be my witnesses in Jerusalem and in all Judea and Samaria, and to the end of the earth."
  lt.reference = "Acts 1:8"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_opening_sentence_trinity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'opening_sentence'
  lt.content = "Holy, holy, holy, is the Lord God Almighty, who was and is and is to come!"
  lt.reference = "Revelation 4:8"
  lt.language = 'en'
end

# Confession of Sin
LiturgicalText.find_or_create_by!(slug: 'morning_confession_exhortation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Dearly beloved, the Scriptures teach us to acknowledge our many sins and offenses, not concealing them from our heavenly Father, but confessing them with humble and obedient hearts that we may obtain forgiveness by his infinite goodness and mercy. We ought at all times humbly to acknowledge our sins before Almighty God, but especially when we come together in his presence to give thanks for the great benefits we have received at his hands, to declare his most worthy praise, to hear his holy Word, and to ask, for ourselves and on behalf of others, those things which are necessary for our life and our salvation. Therefore, draw near with me to the throne of heavenly grace.
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_confession_invitation_short', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = "Let us humbly confess our sins to Almighty God."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_confession', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = <<~TEXT
    Almighty and most merciful Father,
    we have erred and strayed from your ways like lost sheep.
    We have followed too much the devices and desires
    of our own hearts.
    We have offended against your holy laws.
    We have left undone those things which we ought to have done,
    and we have done those things which we ought not to have done;
    and apart from your grace, there is no health in us.
    O Lord, have mercy upon us.
    Spare all those who confess their faults.
    Restore all those who are penitent, according to your promises
    declared to all people in Christ Jesus our Lord.
    And grant, O most merciful Father, for his sake,
    that we may now live a godly, righteous, and sober life,
    to the glory of your holy Name. Amen.
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'absolution', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'absolution'
  lt.content = <<~TEXT
    Almighty God, the Father of our Lord Jesus Christ, desires not the death of sinners, but that they may turn from their wickedness and live. He has empowered and commanded his ministers to pronounce to his people, being penitent, the absolution and remission of their sins. He pardons and absolves all who truly repent and genuinely believe his holy Gospel. For this reason, we beseech him to grant us true repentance and his Holy Spirit, that our present deeds may please him, the rest of our lives may be pure and holy, and that at the last we may come to his eternal joy; through Jesus Christ our Lord. Amen.
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'absolution_short', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'absolution'
  lt.content = "The Almighty and merciful Lord grant you absolution and remission of all your sins, true repentance, amendment of life, and the grace and consolation of his Holy Spirit. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'prayer_for_pardon_lay', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'confession'
  lt.content = "Grant to your faithful people, merciful Lord, pardon and peace; that we may be cleansed from all our sins, and serve you with a quiet mind; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

# Invitatory
LiturgicalText.find_or_create_by!(slug: 'morning_invocation', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'invocation'
  lt.content = <<~TEXT
    Officiant: O Lord, open our lips;
    People: And our mouth shall proclaim your praise.
    Officiant: O God, make speed to save us;
    People: O Lord, make haste to help us.
    Officiant: Glory be to the Father, and to the Son, and to the Holy Spirit;
    People: As it was in the beginning, is now, and ever shall be, world without end. Amen.
    Officiant: Praise the Lord.
    People: The Lord’s Name be praised.
  TEXT
  lt.language = 'en'
end

# Seasonal Antiphons
LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_advent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "Our King and Savior now draws near: * O come, let us adore him."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_christmas', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "Alleluia, to us a child is born: * O come, let us adore him. Alleluia."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_epiphany', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "The Lord has shown forth his glory: * O come, let us adore him."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_lent', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "The Lord is full of compassion and mercy: * O come, let us adore him."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_easter', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "Alleluia. The Lord is risen indeed: * O come, let us adore him. Alleluia."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_ascension', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "Alleluia. Christ the Lord has ascended into heaven: * O come, let us adore him. Alleluia."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_pentecost', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "Alleluia. The Spirit of the Lord renews the face of the earth: * O come, let us adore him. Alleluia."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_trinity', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "Father, Son, and Holy Spirit, one God: * O come, let us adore him."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_antiphon_saints', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'antiphon'
  lt.content = "The Lord is glorious in his saints: * O come, let us adore him."
  lt.language = 'en'
end

# Invitatory Psalms
LiturgicalText.find_or_create_by!(slug: 'venite', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Venite'
  lt.content = <<~TEXT
    O come, let us sing unto the LORD; *
    let us heartily rejoice in the strength of our salvation.
    Let us come before his presence with thanksgiving *
    and show ourselves glad in him with psalms.
    For the LORD is a great God *
    and a great King above all gods.
    In his hand are all the depths of the earth, *
    and the heights of the hills are his also.
    The sea is his, for he made it, *
    and his hands prepared the dry land.
    O come, let us worship and fall down, *
    and kneel before the LORD our Maker.
    For he is our God, *
    and we are the people of his pasture,
    and the sheep of his hand.
    [Today, if you will hear his voice, harden not your hearts *
    as in the provocation, and as in the day of temptation in the wilderness,
    When your fathers tested me, *
    and put me to the proof, though they had seen my works.
    Forty years long was I grieved with this generation and said, *
    “It is a people that err in their hearts, for they have not known my ways,”
    Of whom I swore in my wrath *
    that they should not enter into my rest.]
  TEXT
  lt.reference = "Psalm 95:1-7, 8-11"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'jubilate', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Jubilate'
  lt.content = <<~TEXT
    O be joyful in the LORD, all you lands; *
    serve the LORD with gladness, and come before his presence with a song.
    Be assured that the LORD, he is God; *
    it is he that has made us, and not we ourselves;
    we are his people, and the sheep of his pasture.
    O go your way into his gates with thanksgiving, and into his courts with praise; *
    be thankful unto him, and speak good of his Name.
    For the LORD is gracious, his mercy is everlasting, *
    and his truth endures from generation to generation.
  TEXT
  lt.reference = "Psalm 100"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'pascha_nostrum', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Pascha Nostrum'
  lt.content = <<~TEXT
    Alleluia. Christ our Passover has been sacrificed for us; *
    therefore let us keep the feast,
    Not with the old leaven, the leaven of malice and evil, *
    but with the unleavened bread of sincerity and truth. Alleluia.
    Christ being raised from the dead will never die again; *
    death no longer has dominion over him.
    The death that he died, he died to sin, once for all; *
    but the life he lives, he lives to God.
    So also consider yourselves dead to sin, *
    and alive to God in Jesus Christ our LORD. Alleluia.
    Christ has been raised from the dead, *
    the firstfruits of those who have fallen asleep.
    For since by a man came death, *
    by a man has come also the resurrection of the dead.
    For as in Adam all die, *
    so also in Christ shall all be made alive. Alleluia.
  TEXT
  lt.reference = "1 CORINTHIANS 5:7-8; ROMANS 6:9-11; 1 CORINTHIANS 15:20-22"
  lt.language = 'en'
end

# Gloria Patri
LiturgicalText.find_or_create_by!(slug: 'gloria_patri', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.content = <<~TEXT
    Glory be to the Father, and to the Son, and to the Holy Spirit; *
    as it was in the beginning, is now, and ever shall be, world without end. Amen.
  TEXT
  lt.language = 'en'
end

# Canticles after Lessons
LiturgicalText.find_or_create_by!(slug: 'te_deum_laudamus', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Te Deum Laudamus'
  lt.content = <<~TEXT
    We praise you, O God; we acclaim you as Lord; *
    all creation worships you, the Father everlasting.
    To you all angels, all the powers of heaven, *
    the cherubim and seraphim, sing in endless praise:
    Holy, Holy, Holy, Lord God of power and might, *
    heaven and earth are full of your glory.
    The glorious company of apostles praise you. *
    The noble fellowship of prophets praise you.
    The white-robed army of martyrs praise you. *
    Throughout the world the holy Church acclaims you:
    Father, of majesty unbounded,
    your true and only Son, worthy of all praise, *
    and the Holy Spirit, advocate and guide.
    You, Christ, are the king of glory, *
    the eternal Son of the Father.
    When you took our flesh to set us free *
    you humbly chose the Virgin’s womb.
    You overcame the sting of death *
    and opened the kingdom of heaven to all believers.
    You are seated at God’s right hand in glory. *
    We believe that you will come to be our judge.
    Come then, Lord, and help your people, *
    bought with the price of your own blood,
    and bring us with your saints *
    to glory everlasting.
    [Save your people, Lord, and bless your inheritance; *
    govern and uphold them now and always.
    Day by day we bless you; *
    we praise your Name for ever.
    Keep us today, Lord, from all sin; *
    have mercy on us, Lord, have mercy.
    Lord, show us your love and mercy, *
    for we have put our trust in you.
    In you, Lord, is our hope; *
    let us never be put to shame.]
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'benedictus_es_domine', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Benedictus es, Domine'
  lt.content = <<~TEXT
    Glory to you, Lord God of our fathers; *
    you are worthy to be praised; glory to you.
    Glory to you for the radiance of your holy Name; *
    we will praise you and highly exalt you for ever.
    Glory to you in the splendor of your temple; *
    on the throne of your majesty, glory to you.
    Glory to you, seated between the Cherubim; *
    we will praise you and highly exalt you for ever.
    Glory to you, beholding the depths; *
    in the high vault of heaven, glory to you.
    Glory to you, Father, Son, and Holy Spirit; *
    we will praise you and highly exalt you for ever.
  TEXT
  lt.reference = "SONG OF THE THREE YOUNG MEN, 29-34"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'benedictus', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'canticle'
  lt.title = 'Benedictus'
  lt.content = <<~TEXT
    Blessed be the Lord, the God of Israel; *
    he has come to his people and set them free.
    He has raised up for us a mighty savior, *
    born of the house of his servant David.
    Through his holy prophets he promised of old
    that he would save us from our enemies, *
    from the hands of all who hate us.
    He promised to show mercy to our fathers *
    and to remember his holy covenant.
    This was the oath he swore to our father Abraham, *
    to set us free from the hands of our enemies,
    Free to worship him without fear, *
    holy and righteous in his sight all the days of our life.
    You, my child, shall be called the prophet of the Most High, *
    for you will go before the Lord to prepare his way,
    To give his people knowledge of salvation *
    by the forgiveness of their sins.
    In the tender compassion of our God *
    the dawn from on high shall break upon us,
    To shine on those who dwell in darkness and in the shadow of death, *
    and to guide our feet into the way of peace.
    Glory be to the Father, and to the Son, and to the Holy Spirit; *
    as it was in the beginning, is now, and ever shall be, world without end. Amen.
  TEXT
  lt.reference = "LUKE 1:68-79"
  lt.language = 'en'
end

# Apostles' Creed
LiturgicalText.find_or_create_by!(slug: 'apostles_creed', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'creed'
  lt.content = <<~TEXT
    I believe in God, the Father almighty,
    creator of heaven and earth.
    I believe in Jesus Christ, his only Son, our Lord.
    He was conceived by the Holy Spirit
    and born of the Virgin Mary.
    He suffered under Pontius Pilate,
    was crucified, died, and was buried.
    He descended to the dead.
    On the third day he rose again.
    He ascended into heaven,
    and is seated at the right hand of the Father.
    He will come again to judge the living and the dead.
    I believe in the Holy Spirit,
    the holy catholic Church,
    the communion of saints,
    the forgiveness of sins,
    the resurrection of the body,
    and the life everlasting. Amen.
  TEXT
  lt.language = 'en'
end

# The Prayers
LiturgicalText.find_or_create_by!(slug: 'kyrie', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Lord, have mercy upon us.
    Christ, have mercy upon us.
    Lord, have mercy upon us.
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'our_father_traditional', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Our Father, who art in heaven,
    hallowed be thy Name,
    thy kingdom come,
    thy will be done,
    on earth as it is in heaven.
    Give us this day our daily bread.
    And forgive us our trespasses,
    as we forgive those who trespass against us.
    And lead us not into temptation,
    but deliver us from evil.
    For thine is the kingdom, and the power, and the glory,
    for ever and ever. Amen.
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'our_father_contemporary', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Our Father in heaven,
    hallowed be your Name,
    your kingdom come,
    your will be done,
    on earth as it is in heaven.
    Give us today our daily bread.
    And forgive us our sins
    as we forgive those who sin against us.
    Save us from the time of trial,
    and deliver us from evil.
    For the kingdom, the power, and the glory are yours,
    now and for ever. Amen.
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'suffrages', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = <<~TEXT
    Officiant: O Lord, show your mercy upon us;
    People: And grant us your salvation.
    Officiant: O Lord, guide those who govern us;
    People: And lead us in the way of justice and truth.
    Officiant: Clothe your ministers with righteousness;
    People: And let your people sing with joy.
    Officiant: O Lord, save your people;
    People: And bless your inheritance.
    Officiant: Give peace in our time, O Lord;
    People: And defend us by your mighty power.
    Officiant: Let not the needy, O Lord, be forgotten;
    People: Nor the hope of the poor be taken away.
    Officiant: Create in us clean hearts, O God;
    People: And take not your Holy Spirit from us.
  TEXT
  lt.language = 'en'
end

# Fixed Collects
LiturgicalText.find_or_create_by!(slug: 'morning_collect_sunday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A COLLECT FOR STRENGTH TO AWAIT CHRIST’S RETURN'
  lt.content = "O God our King, by the resurrection of your Son Jesus Christ on the first day of the week, you conquered sin, put death to flight, and gave us the hope of everlasting life: Redeem all our days by this victory; forgive our sins, banish our fears, make us bold to praise you and to do your will; and steel us to wait for the consummation of your kingdom on the last great Day; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_collect_monday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A COLLECT FOR THE RENEWAL OF LIFE'
  lt.content = "O God, the King eternal, whose light divides the day from the night and turns the shadow of death into the morning: Drive far from us all wrong desires, incline our hearts to keep your law, and guide our feet into the way of peace; that, having done your will with cheerfulness during the day, we may, when night comes, rejoice to give you thanks; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_collect_tuesday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A COLLECT FOR PEACE'
  lt.content = "O God, the author of peace and lover of concord, to know you is eternal life and to serve you is perfect freedom: Defend us, your humble servants, in all assaults of our enemies; that we, surely trusting in your defense, may not fear the power of any adversaries, through the might of Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_collect_wednesday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A COLLECT FOR GRACE'
  lt.content = "O Lord, our heavenly Father, almighty and everlasting God, you have brought us safely to the beginning of this day: Defend us by your mighty power, that we may not fall into sin nor run into any danger; and that, guided by your Spirit, we may do what is righteous in your sight; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_collect_thursday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A COLLECT FOR GUIDANCE'
  lt.content = "Heavenly Father, in you we live and move and have our being: We humbly pray you so to guide and govern us by your Holy Spirit, that in all the cares and occupations of our life we may not forget you, but may remember that we are ever walking in your sight; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_collect_friday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A COLLECT FOR ENDURANCE'
  lt.content = "Almighty God, whose most dear Son went not up to joy but first he suffered pain, and entered not into glory before he was crucified: Mercifully grant that we, walking in the way of the Cross, may find it none other than the way of life and peace; through Jesus Christ your Son our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'morning_collect_saturday', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A COLLECT FOR SABBATH REST'
  lt.content = "Almighty God, who after the creation of the world rested from all your works and sanctified a day of rest for all your creatures: Grant that we, putting away all earthly anxieties, may be duly prepared for the service of your sanctuary, and that our rest here upon earth may be a preparation for the eternal rest promised to your people in heaven; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

# Mission Prayers
LiturgicalText.find_or_create_by!(slug: 'prayer_for_mission_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = "Almighty and everlasting God, who alone works great marvels: Send down upon our clergy and the congregations committed to their charge the life-giving Spirit of your grace, shower them with the continual dew of your blessing, and ignite in them a zealous love of your Gospel; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'prayer_for_mission_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = "O God, you have made of one blood all the peoples of the earth, and sent your blessed Son to preach peace to those who are far off and to those who are near: Grant that people everywhere may seek after you and find you; bring the nations into your fold; pour out your Spirit upon all flesh; and hasten the coming of your kingdom; through Jesus Christ our Lord. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'prayer_for_mission_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.content = "Lord Jesus Christ, you stretched out your arms of love on the hard wood of the Cross that everyone might come within the reach of your saving embrace: So clothe us in your Spirit that we, reaching forth our hands in love, may bring those who do not know you to the knowledge and love of you; for the honor of your Name. Amen."
  lt.language = 'en'
end

# Closing Prayers
LiturgicalText.find_or_create_by!(slug: 'general_thanksgiving', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'THE GENERAL THANKSGIVING'
  lt.content = <<~TEXT
    Almighty God, Father of all mercies,
    we your unworthy servants give you humble thanks
    for all your goodness and loving-kindness
    to us and to all whom you have made.
    We bless you for our creation, preservation,
    and all the blessings of this life;
    but above all for your immeasurable love
    in the redemption of the world by our Lord Jesus Christ;
    for the means of grace, and for the hope of glory.
    And, we pray, give us such an awareness of your mercies,
    that with truly thankful hearts
    we may show forth your praise,
    not only with our lips, but in our lives,
    by giving up our selves to your service,
    and by walking before you
    in holiness and righteousness all our days;
    Through Jesus Christ our Lord,
    to whom, with you and the Holy Spirit,
    be honor and glory throughout all ages. Amen.
  TEXT
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'chrysostom_prayer', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'prayer'
  lt.title = 'A PRAYER OF ST. JOHN CHRYSOSTOM'
  lt.content = "Almighty God, you have given us grace at this time, with one accord to make our common supplications to you; and you have promised through your well-beloved Son that when two or three are gathered together in his Name you will grant their requests: Fulfill now, O Lord, our desires and petitions as may be best for us; granting us in this world knowledge of your truth, and in the age to come life everlasting. Amen."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'dismissal', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = "Officiant: Let us bless the Lord.\nPeople: Thanks be to God."
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'concluding_sentence_1', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = "The grace of our Lord Jesus Christ, and the love of God, and the fellowship of the Holy Spirit, be with us all evermore. Amen."
  lt.reference = "2 CORINTHIANS 13:14"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'concluding_sentence_2', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = "May the God of hope fill us with all joy and peace in believing through the power of the Holy Spirit. Amen."
  lt.reference = "ROMANS 15:13"
  lt.language = 'en'
end

LiturgicalText.find_or_create_by!(slug: 'concluding_sentence_3', prayer_book_id: prayer_book.id) do |lt|
  lt.category = 'dismissal'
  lt.content = "Glory to God whose power, working in us, can do infinitely more than we can ask or imagine: Glory to him from generation to generation in the Church, and in Christ Jesus for ever and ever. Amen."
  lt.reference = "EPHESIANS 3:20-21"
  lt.language = 'en'
end

Rails.logger.info "✅ LOC 2019 English liturgical texts created!"
