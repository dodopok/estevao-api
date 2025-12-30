## Midday Prayer

# Opening
create_text('midday_inv_v1', 'invocation', "O God, make speed to save us;")
create_text('midday_inv_r1', 'invocation', "O Lord, make haste to help us.")
create_text('midday_inv_v2', 'invocation', "Glory be to the Father, and to the Son, and to the Holy Spirit;")
create_text('midday_inv_r2', 'invocation', "As it was in the beginning, is now, and ever shall be, world without end. Amen.")
create_text('midday_opening_lent_rubric', 'rubric', "Except in Lent, add Alleluia.")
create_text('midday_hymn_rubric', 'rubric', "A suitable hymn may be sung.")

# Psalms
create_text('midday_psalms_rubric', 'rubric', "One or more of the following, or some other suitable Psalm, is sung or said.")
create_text('midday_gloria_patri_rubric', 'rubric', "At the end of the Psalms the Gloria Patri (Glory be...) is sung or said")

psalm_119 = <<~TEXT
  **105 Your word is a lantern to my feet *
    and a light upon my path.
  106 I have sworn and am steadfastly purposed *
    to keep your righteous judgments.
  107 I am troubled above measure; *
    revive me, O LORD, according to your word.
  108 Let the freewill offerings of my mouth please you, O LORD; *
    and teach me your judgments.
  109 My life is always in my hand, *
    yet I do not forget your law.
  110 The ungodly have laid a snare for me, *
    yet I have not strayed from your commandments.
  111 Your testimonies have I claimed as my heritage for ever, *
    and why? They are the very joy of my heart.
  112 I have applied my heart to fulfill your statutes always, *
    even unto the end.**
TEXT
create_text('midday_psalm_119', 'psalm', psalm_119, title: "PSALM 119:105-112", reference: "Lucerna pedibus meis")

psalm_121 = <<~TEXT
  **1 I will lift up my eyes unto the hills; *
    from whence comes my help?
  2 My help comes from the LORD, *
    who has made heaven and earth.
  3 He will not let your foot be moved, *
    and he who keeps you will not sleep.
  4 Behold, he who keeps Israel *
    shall neither slumber nor sleep.
  5 The LORD himself is your keeper; *
    the LORD is your defense upon your right hand,
  6 So that the sun shall not burn you by day, *
    neither the moon by night.
  7 The LORD shall preserve you from all evil; *
    indeed, it is he who shall keep your soul.
  8 The LORD shall preserve your going out and your coming in, *
    from this time forth for evermore.**
TEXT
create_text('midday_psalm_121', 'psalm', psalm_121, title: "PSALM 121", reference: "Levavi oculos")

psalm_124 = <<~TEXT
  **1 If the LORD himself had not been on our side, now may Israel say: *
    if the LORD himself had not been on our side, when men rose up against us,
  2 Then would they have swallowed us up alive, *
    when they were so wrathfully displeased with us;
  3 Then the waters would have drowned us, and the torrent gone over us; *
    then the raging waters would have gone clean over us.
  4 But praised be the Lord, *
    who has not given us over to be prey for their teeth.
  5 We escaped like a bird out of the snare of the fowler; *
    the snare is broken, and we have been delivered.
  6 Our help is in the Name of the LORD, *
    the maker of height and earth.**
TEXT
create_text('midday_psalm_124', 'psalm', psalm_124, title: "PSALM 124", reference: "Nisi quia Dominus")

psalm_126 = <<~TEXT
  **1 When the LORD overturned the captivity of Zion, *
    then were we like those who dream.
  2 Then was our mouth filled with laughter *
    and our tongue with shouts of joy.
  3 Then they said among the nations, *
    “The LORD has done great things for them.”
  4 Indeed, the LORD has done great things for us already, *
    whereof we rejoice.
  5 Overturn our captivity, O LORD, *
    as when streams refresh the deserts of the south.
  6 Those who sow in tears *
    shall reap with songs of joy.
  7 He who goes on his way weeping and bears good seed *
    shall doubtless come again with joy, and bring his sheaves with him.**
TEXT
create_text('midday_psalm_126', 'psalm', psalm_126, title: "PSALM 126", reference: "In convertendo")

# Readings
create_text('midday_reading_rubric', 'rubric', "One of the following, or some other suitable passage of Scripture, is read")
create_text('midday_reading_end_rubric', 'rubric', "At the end of the reading is said")
create_text('midday_meditation_rubric', 'rubric', "A meditation, silent or spoken, may follow.")

create_text('midday_reading_1', 'reading', "Jesus said, “Now is the judgment of this world; now will the ruler of this world be cast out. And I, when I am lifted up from the earth, will draw all people to myself.”", reference: "JOHN 12:31-32")
create_text('midday_reading_2', 'reading', "If anyone is in Christ, he is a new creation. The old has passed away; behold, the new has come. All this is from God, who through Christ reconciled us to himself and gave us the ministry of reconciliation.", reference: "2 CORINTHIANS 5:17-18")
create_text('midday_reading_3', 'reading', "From the rising of the sun to its setting my name will be great among the nations, and in every place incense will be offered to my name, and a pure offering. For my name will be great among the nations, says the LORD of Hosts.", reference: "MALACHI 1:11")

# Prayers
create_text('midday_prayers_rubric', 'rubric', "The Officiant then begins the Prayers")
create_text('midday_officiant_people_rubric', 'rubric', "Officiant and People")

create_text('midday_pre_v', 'prayer', "I will bless the Lord at all times.")
create_text('midday_pre_r', 'prayer', "His praise shall continually be in my mouth.")

create_text('midday_kyrie_v1', 'prayer', "Lord, have mercy upon us.")
create_text('midday_kyrie_r1', 'prayer', "Christ, have mercy upon us.")
create_text('midday_kyrie_v2', 'prayer', "Lord, have mercy upon us.")

create_text('midday_kyrie_short_v1', 'prayer', "Lord, have mercy.")
create_text('midday_kyrie_short_r1', 'prayer', "Christ, have mercy.")
create_text('midday_kyrie_short_v2', 'prayer', "Lord, have mercy.")

create_text('midday_post_v', 'prayer', "O Lord, hear our prayer;")
create_text('midday_post_r', 'prayer', "And let our cry come to you.")

# Collects
create_text('midday_collects_rubric', 'rubric', "The Officiant then says one or more of the following Collects. Other appropriate Collects may also be used.")
create_text('midday_collect_1', 'prayer', "Blessed Savior, at this hour you hung upon the Cross, stretching out your loving arms: Grant that all the peoples of the earth may look to you and be saved; for your tender mercies’ sake. Amen.")
create_text('midday_collect_2', 'prayer', "Almighty Savior, who at mid-day called your servant Saint Paul to be an apostle to the Gentiles: We pray you to illumine the world with the radiance of your glory, that all nations may come and worship you; for you live and reign with the Father and the Holy Spirit, one God, for ever and ever. Amen.")
create_text('midday_collect_3', 'prayer', "Father of all mercies, you revealed your boundless compassion to your apostle Saint Peter in a three-fold vision: Forgive our unbelief, we pray, and so strengthen our hearts and enkindle our zeal, that we may fervently desire the salvation of all people, and diligently labor in the extension of your kingdom; through him who gave himself for the life of the world, your Son our Savior Jesus Christ. Amen.")
create_text('midday_collect_4', 'prayer', "Pour your grace into our hearts, O Lord, that we who have known the incarnation of your Son Jesus Christ, announced by an angel to the Virgin Mary, may by his Cross and passion be brought to the glory of his resurrection; who lives and reigns with you, in the unity of the Holy Spirit, one God, now and for ever. Amen.")

create_text('midday_intercessions_rubric', 'rubric', "Silence may be kept, and other intercessions and thanksgivings may be offered.")

create_text('midday_conclusion_rubric', 'rubric', "The Officiant may conclude with this, or one of the other concluding sentences from Morning and Evening Prayer.")
create_text('midday_dismissal_alleluia', 'rubric', "From Easter Day through the Day of Pentecost, “Alleluia, alleluia” may be added to the preceding versicle and response.")
