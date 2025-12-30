## Evening Prayer

# Opening Sentences
create_text('evening_opening_sentence_1', 'opening_sentence', "Jesus spoke to them, saying, \"I am the light of the world. Whoever follows me will not walk in darkness, but will have the light of life.\"", reference: "JOHN 8:12")
create_text('evening_opening_sentence_2', 'opening_sentence', "LORD, I have loved the habitation of your house and the place where your honor dwells.", reference: "PSALM 26:8")
create_text('evening_opening_sentence_3', 'opening_sentence', "Let my prayer be set forth in your sight as incense, and let the lifting up of my hands be an evening sacrifice.", reference: "PSALM 141:2")

# Seasonal Opening Sentences (Evening)
create_text('evening_opening_sentence_advent', 'opening_sentence', "Therefore stay awake—for you do not know when the master of the house will come, in the evening, or at midnight, or when the rooster crows, or in the morning—lest he come suddenly and find you asleep.", reference: "MARK 13:35-36")
create_text('evening_opening_sentence_christmas', 'opening_sentence', "Behold, the dwelling place of God is with man. He will dwell with them, and they will be his people, and God himself will be with them as their God.", reference: "REVELATION 21:3")
create_text('evening_opening_sentence_epiphany', 'opening_sentence', "Nations shall come to your light, and kings to the brightness of your rising.", reference: "ISAIAH 60:3")
create_text('evening_opening_sentence_lent', 'opening_sentence', "If we say we have no sin, we deceive ourselves, and the truth is not in us. If we confess our sins, he is faithful and just to forgive us our sins and to cleanse us from all unrighteousness.", reference: "1 JOHN 1:8-9")
create_text('evening_opening_sentence_holy_week', 'opening_sentence', "For Christ also suffered once for sins, the righteous for the unrighteous, that he might bring us to God, being put to death in the flesh but made alive in the spirit.", reference: "1 PETER 3:18")
create_text('evening_opening_sentence_easter', 'opening_sentence', "Thanks be to God, who gives us the victory through our Lord Jesus Christ.", reference: "1 CORINTHIANS 15:57")
create_text('evening_opening_sentence_ascension', 'opening_sentence', "For Christ has entered, not into holy places made with hands, which are copies of the true things, but into heaven itself, now to appear in the presence of God on our behalf.", reference: "HEBREWS 9:24")
create_text('evening_opening_sentence_pentecost', 'opening_sentence', "The Spirit and the Bride say, \"Come.\" And let the one who hears say, \"Come.\" And let the one who is thirsty come; let the one who desires take the water of life without price.", reference: "REVELATION 22:17")
create_text('evening_opening_sentence_trinity', 'opening_sentence', "Holy, holy, holy, is the Lord God Almighty, who was and is and is to come!", reference: "REVELATION 4:8")

phos_hilaron = <<~TEXT
  **O gladsome light,
  pure brightness of the everliving Father in heaven, *
    O Jesus Christ, holy and blessed!
  Now as we come to the setting of the sun,
  and our eyes behold the vesper light, *
    we sing your praises, O God: Father, Son, and Holy Spirit.
  You are worthy at all times to be praised by happy voices, *
    O Son of God, O Giver of Life,
    and to be glorified through all the worlds.**
TEXT

# Invitatory
create_text('phos_hilaron', 'canticle', phos_hilaron, title: "PHOS HILARON", reference: "O Gladsome Light")

# Canticles after Lessons
magnificat = <<~TEXT
  **My soul magnifies the Lord, *
    and my spirit rejoices in God my Savior;
  For he has regarded *
    the lowliness of his handmaiden.
  For behold, from now on, *
    all generations will call me blessed;
  For he that is mighty has magnified me, *
    and holy is his Name.
  And his mercy is on those who fear him, *
    throughout all generations.
  He has shown the strength of his arm; *
    he has scattered the proud in the imagination of their hearts.
  He has brought down the mighty from their thrones, *
    and has exalted the humble and meek.
  He has filled the hungry with good things, *
    and the rich he has sent empty away.
  He, remembering his mercy, has helped his servant Israel, *
    as he promised to our fathers, Abraham and his seed for ever.
  Glory be to the Father, and to the Son, and to the Holy Spirit; *
    as it was in the beginning, is now, and ever shall be,
    world without end. Amen.**
TEXT
create_text('magnificat', 'canticle', magnificat, title: "MAGNIFICAT", reference: "The Song of Mary (LUKE 1:46-55)")

nunc_dimittis = <<~TEXT
  **Lord, now let your servant depart in peace, *
    according to your word.
  For my eyes have seen your salvation, *
    which you have prepared before the face of all people;
  To be a light to lighten the Gentiles, *
    and to be the glory of your people Israel.
  Glory be to the Father, and to the Son, and to the Holy Spirit; *
    as it was in the beginning, is now, and ever shall be,
    world without end. Amen.**
TEXT
create_text('nunc_dimittis', 'canticle', nunc_dimittis, title: "NUNC DIMITTIS", reference: "The Song of Simeon (LUKE 2:29-32)")

# Suffrages B
create_text('evening_suff_b_rubric', 'rubric', "That this evening may be holy, good, and peaceful,")
create_text('evening_suff_b_response', 'prayer', "We entreat you, O Lord.")
create_text('evening_suff_b_1', 'prayer', "That your holy angels may lead us in paths of peace and goodwill,")
create_text('evening_suff_b_2', 'prayer', "That we may be pardoned and forgiven for our sins and offenses,")
create_text('evening_suff_b_3', 'prayer', "That there may be peace in your Church and in the whole world,")
create_text('evening_suff_b_4', 'prayer', "That we may depart this life in your faith and fear, and not be condemned before the great judgment seat of Christ,")
create_text('evening_suff_b_5', 'prayer', "That we may be bound together by your Holy Spirit in the communion of [ _________ and] all your saints, entrusting one another and all our life to Christ,")

# Evening Collects
create_text('evening_collect_sunday', 'prayer', "Lord God, whose Son our Savior Jesus Christ triumphed over the powers of death and prepared for us our place in the new Jerusalem: Grant that we, who have this day given thanks for his resurrection, may praise you in that City of which he is the light, and where he lives and reigns for ever and ever. Amen.", title: "A COLLECT FOR RESURRECTION HOPE")
create_text('evening_collect_monday', 'prayer', "O God, the source of all holy desires, all good counsels, and all just works: Give to your servants that peace which the world cannot give, that our hearts may be set to obey your commandments, and that we, being defended from the fear of our enemies, may pass our time in rest and quietness; through the merits of Jesus Christ our Savior. Amen.", title: "A COLLECT FOR PEACE")
create_text('evening_collect_tuesday', 'prayer', "Lighten our darkness, we beseech you, O Lord; and by your great mercy defend us from all perils and dangers of this night; for the love of your only Son, our Savior Jesus Christ. Amen.", title: "A COLLECT FOR AID AGAINST PERILS")
create_text('evening_collect_wednesday', 'prayer', "O God, the life of all who live, the light of the faithful, the strength of those who labor, and the repose of the dead: We thank you for the blessings of the day that is past, and humbly ask for your protection through the coming night. Bring us in safety to the morning hours; through him who died and rose again for us, your Son our Savior Jesus Christ. Amen.", title: "A COLLECT FOR PROTECTION")
create_text('evening_collect_thursday', 'prayer', "Lord Jesus, stay with us, for evening is at hand and the day is past; be our companion in the way, kindle our hearts, and awaken hope, that we may know you as you are revealed in Scripture and the breaking of bread. Grant this for the sake of your love. Amen.", title: "A COLLECT FOR THE PRESENCE OF CHRIST")
create_text('evening_collect_friday', 'prayer', "Lord Jesus Christ, by your death you took away the sting of death: Grant to us your servants so to follow in faith where you have led the way, that we may at length fall asleep peacefully in you and wake up in your likeness; for your tender mercies’ sake. Amen.", title: "A COLLECT FOR FAITH")
create_text('evening_collect_saturday', 'prayer', "O God, the source of eternal light: Shed forth your unending day upon us who watch for you, that our lips may praise you, our lives may bless you, and our worship on the morrow give you glory; through Jesus Christ our Lord. Amen.", title: "A COLLECT FOR THE EVE OF WORSHIP")

# Evening Mission Prayers
create_text('evening_prayer_for_mission_1', 'prayer', "O God and Father of all, whom the whole heavens adore: Let the whole earth also worship you, all nations obey you, all tongues confess and bless you, and men, women, and children everywhere love you and serve you in peace; through Jesus Christ our Lord. Amen.")
create_text('evening_prayer_for_mission_2', 'prayer', "Keep watch, dear Lord, with those who work, or watch, or weep this night, and give your angels charge over those who sleep. Tend the sick, Lord Christ; give rest to the weary, bless the dying, soothe the suffering, pity the afflicted, shield the joyous; and all for your love’s sake. Amen.")
create_text('evening_prayer_for_mission_3', 'prayer', "O God, you manifest in your servants the signs of your presence: Send forth upon us the Spirit of love, that in companionship with one another your abounding grace may increase among us; through Jesus Christ our Lord. Amen.")

# Evening Rubrics
create_text('evening_opening_rubric', 'rubric', "The Officiant may begin Evening Prayer by reading an opening sentence of Scripture. One of the following, or a sentence from among those provided at the end of the Office (pages 54–56), is customary.")
create_text('evening_confession_rubric', 'rubric', "The Officiant says to the People")
create_text('evening_suffrages_rubric', 'rubric', "Then follows one of these sets of Suffrages")
create_text('evening_collects_rubric', 'rubric', "The Officiant then prays one or more of the following Collects, always beginning with the Collect of the Day (usually the Collect of the Sunday or Principal Feast and of any of the weekdays following, or of the Holy Day being observed) found on pages 598–640. It is traditional to pray the Collects for Peace and Aid against Perils daily. Alternatively, one may pray the Collects on a weekly rotation, using the suggestions in italics.")
create_text('evening_mission_rubric', 'rubric', "Unless the Great Litany or the Eucharist is to follow, one of the following prayers for mission is added. If the Great Litany is used, it follows here, or after a hymn or anthem, and concludes the Office.")
create_text('evening_thanksgiving_rubric', 'rubric', "Before the close of the Office one or both of the following prayers may be used.")
create_text('evening_conclusion_rubric', 'rubric', "The Officiant says one of these concluding sentences (and the People may be invited to join)")
create_text('evening_reading_first_rubric', 'rubric', "One or more Lessons, as appointed, are read, the Reader first saying")
create_text('evening_reading_citation_rubric', 'rubric', "A citation giving chapter and verse may be added.")
create_text('evening_reading_after_rubric', 'rubric', "After each Lesson the Reader may say")
create_text('evening_reading_end_rubric', 'rubric', "Or the Reader may say")
create_text('evening_canticle_rubric', 'rubric', "The following Canticles are normally sung or said after each of the lessons. The Officiant may also use a Canticle drawn from the Supplemental Canticles (pages 79–88) or an appropriate song of praise.")
create_text('evening_phos_hilaron_rubric', 'rubric', "The following or some other suitable hymn or Psalm may be sung or said.")
