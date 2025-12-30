## Compline

# Opening
create_text('compline_opening_sentence', 'opening_sentence', "The Lord Almighty grant us a peaceful night and a perfect end. Amen.")
create_text('compline_inv_v1', 'invocation', "Our help is in the Name of the Lord;")
create_text('compline_inv_r1', 'invocation', "The maker of heaven and earth.")

# Confession
create_text('compline_confession_invitation', 'confession', "Let us humbly confess our sins to Almighty God.")
create_text('compline_confession_body', 'confession',
  <<~TEXT
    **Almighty God and Father, we confess to you,
    to one another, and to the whole company of heaven,
    that we have sinned, through our own fault,
    in thought, and word, and deed,
    and in what we have left undone.
    For the sake of your Son our Lord Jesus Christ,
    have mercy upon us, forgive us our sins,
    and by the power of your Holy Spirit
    raise us up to serve you in newness of life,
    to the glory of your Name. Amen.**
  TEXT
)
create_text('compline_absolution', 'absolution', "May Almighty God grant us forgiveness of all our sins, and the grace and comfort of the Holy Spirit. Amen.")

# Invitatory
create_text('compline_inv_v2', 'invocation', "O God, make speed to save us;")
create_text('compline_inv_r2', 'invocation', "O Lord, make haste to help us.")
create_text('compline_inv_v3', 'invocation', "Glory be to the Father, and to the Son, and to the Holy Spirit;")
create_text('compline_inv_r3', 'invocation', "As it was in the beginning, is now, and ever shall be, world without end. Amen.")

# Psalms
psalm_4 = <<~TEXT
  **1 Hear me when I call, O God of my righteousness; *
    you set me free when I was in trouble; have mercy upon me,
    and hear my prayer.
  2 O you children of men, how long will you blaspheme
    my honor, *
    and have such pleasure in vanity, and seek after falsehood?
  3 Know this also, that the LORD has chosen for himself
    the one that is godly; *
    when I call upon the LORD, he will hear me.
  4 Stand in awe, and sin not; *
    commune with your own heart upon your bed, and be still.
  5 Offer the sacrifice of righteousness *
    and put your trust in the LORD.
  6 There are many that say, “Who will show us any good?” *
    LORD, lift up the light of your countenance upon us.
  7 You have put gladness in my heart, *
    more than when others’ grain and wine and oil increased.
  8 I will lay me down in peace, and take my rest; *
    for you, LORD, only, make me dwell in safety.**
TEXT
create_text('compline_psalm_4', 'psalm', psalm_4, title: "PSALM 4", reference: "Cum invocarem")

psalm_31 = <<~TEXT
  **1 In you, O LORD, have I put my trust; *
    let me never be put to confusion;
    deliver me in your righteousness.
  2 Bow down your ear to me, *
    make haste to deliver me,
  3 And be my strong rock and house of defense, *
    that you may save me.
  4 For you are my strong rock and my castle; *
    be also my guide, and lead me for your Name’s sake.
  5 Draw me out of the net that they have laid secretly for me, *
    for you are my strength.
  6 Into your hands I commend my spirit, *
    for you have redeemed me, O LORD, O God of truth.**
TEXT
create_text('compline_psalm_31', 'psalm', psalm_31, title: "PSALM 31:1-6", reference: "In te, Domine, speravi")

psalm_91 = <<~TEXT
  **1 Whoever dwells under the defense of the Most High *
    shall abide under the shadow of the Almighty.
  2 I will say unto the LORD, “You are my refuge and
    my stronghold, *
    my God in whom I will trust.”
  3 For he shall deliver you from the snare of the hunter *
    and from the deadly pestilence.
  4 He shall defend you under his wings, and you shall be safe
    under his feathers; *
    his faithfulness and truth shall be your shield and buckler.
  5 You shall not be afraid of any terror by night, *
    nor of the arrow that flies by day,
  6 Of the pestilence that walks in darkness, *
    nor of the sickness that destroys at noonday.
  7 A thousand shall fall beside you, and ten thousand
    at your right hand, *
    but it shall not come near you.
  8 Indeed, with your eyes you shall behold *
    and see the reward of the ungodly.
  9 Because you have said, “The LORD is my refuge,” *
    and have made the Most High your stronghold,
  10 There shall no evil happen to you, *
    neither shall any plague come near your dwelling.
  11 For he shall give his angels charge over you, *
    to keep you in all your ways.
  12 They shall bear you in their hands, *
    that you hurt not your foot against a stone.
  13 You shall tread upon the lion and adder; *
    the young lion and the serpent you shall trample
    under your feet.
  14 “Because he has set his love upon me, therefore I will
    deliver him; *
    I will lift him up, because he has known my Name.
  15 He shall call upon me, and I will hear him; *
    indeed, I am with him in trouble; I will deliver him
    and bring him honor.
  16 With long life I will satisfy him, *
    and show him my salvation.”**
TEXT
create_text('compline_psalm_91', 'psalm', psalm_91, title: "PSALM 91", reference: "Qui habitat")

psalm_134 = <<~TEXT
  **1 Behold now, praise the LORD, *
    all you servants of the LORD,
  2 You that stand by night in the house of the LORD, *
    even in the courts of the house of our God.
  3 Lift up your hands in the sanctuary *
    and sing praises unto the LORD.
  4 The LORD who made heaven and earth *
    give you blessing out of Zion.**
TEXT
create_text('compline_psalm_134', 'psalm', psalm_134, title: "PSALM 134", reference: "Ecce nunc")

# Readings
create_text('compline_reading_1', 'reading', "You, O LORD, are in the midst of us, and we are called by your name; do not leave us.", reference: "JEREMIAH 14:9")
create_text('compline_reading_2', 'reading', "Come to me, all who labor and are heavy laden, and I will give you rest. Take my yoke upon you, and learn from me, for I am gentle and lowly in heart, and you will find rest for your souls. For my yoke is easy, and my burden is light.", reference: "MATTHEW 11:28-30")
create_text('compline_reading_3', 'reading', "Now may the God of peace who brought again from the dead our Lord Jesus, the great shepherd of the sheep, by the blood of the eternal covenant, equip you with everything good that you may do his will, working in us that which is pleasing in his sight, through Jesus Christ, to whom be glory forever and ever. Amen.", reference: "HEBREWS 13:20-21")
create_text('compline_reading_4', 'reading', "Be sober-minded; be watchful. Your adversary the devil prowls around like a roaring lion, seeking someone to devour. Resist him, firm in your faith.", reference: "1 PETER 5:8-9")

# Responsory
create_text('compline_resp_v1', 'prayer', "Into your hands, O Lord, I commend my spirit;")
create_text('compline_resp_r1', 'prayer', "For you have redeemed me, O Lord, O God of truth.")
create_text('compline_resp_v2', 'prayer', "Keep me, O Lord, as the apple of your eye;")
create_text('compline_resp_r2', 'prayer', "Hide me under the shadow of your wings.")

# Collects
create_text('compline_collect_1', 'prayer', "Visit this place, O Lord, and drive far from it all snares of the enemy; let your holy angels dwell with us to preserve us in peace; and let your blessing be upon us always; through Jesus Christ our Lord. Amen.")
create_text('compline_collect_2', 'prayer', "Lighten our darkness, we beseech you, O Lord; and by your great mercy defend us from all perils and dangers of this night; for the love of your only Son, our Savior Jesus Christ. Amen.")
create_text('compline_collect_3', 'prayer', "Be present, O merciful God, and protect us through the hours of this night, so that we who are wearied by the changes and chances of this life may rest in your eternal changelessness; through Jesus Christ our Lord. Amen.")
create_text('compline_collect_4', 'prayer', "Look down, O Lord, from your heavenly throne, illumine this night with your celestial brightness, and from the children of light banish the deeds of darkness; through Jesus Christ our Lord. Amen.")
create_text('compline_collect_saturday', 'prayer', "We give you thanks, O God, for revealing your Son Jesus Christ to us by the light of his resurrection: Grant that as we sing your glory at the close of this day, our joy may abound in the morning as we celebrate the Paschal mystery; through Jesus Christ our Lord. Amen.", title: "A COLLECT FOR SATURDAYS")

# Mission
create_text('compline_mission_1', 'prayer', "Keep watch, dear Lord, with those who work, or watch, or weep this night, and give your angels charge over those who sleep. Tend the sick, Lord Christ; give rest to the weary, bless the dying, soothe the suffering, pity the afflicted, shield the joyous; and all for your love’s sake. Amen.")
create_text('compline_mission_2', 'prayer', "O God, your unfailing providence sustains the world we live in and the life we live: Watch over those, both night and day, who work while others sleep, and grant that we may never forget that our common life depends upon each other’s toil; through Jesus Christ our Lord. Amen.")

# Nunc Dimittis Antiphon
create_text('compline_nunc_antiphon', 'antiphon', "Guide us waking, O Lord, and guard us sleeping; that awake we may watch with Christ, and asleep we may rest in peace.")
create_text('compline_nunc_antiphon_easter', 'antiphon', "Guide us waking, O Lord, and guard us sleeping; that awake we may watch with Christ, and asleep we may rest in peace. Alleluia, alleluia, alleluia.")

# Conclusion
create_text('compline_conclusion', 'dismissal', "The almighty and merciful Lord, Father, Son, and Holy Spirit, bless us and keep us, this night and evermore. Amen.")

# Rubrics
create_text('compline_opening_rubric', 'rubric', "The Officiant begins")
create_text('compline_confession_rubric', 'rubric', "The Officiant continues")
create_text('compline_silence_rubric', 'rubric', "Silence may be kept. The Officiant and People then say")
create_text('compline_absolution_rubric', 'rubric', "The Officiant alone says")
create_text('compline_psalms_rubric', 'rubric', "One or more of the following, or some other suitable Psalm, is sung or said.")
create_text('compline_reading_rubric', 'rubric', "One of the following, or some other suitable passage of Scripture, is read")
create_text('compline_meditation_rubric', 'rubric', "A period of silence may follow. A suitable hymn may be sung.")
create_text('compline_prayers_rubric', 'rubric', "The People kneel or stand.")
create_text('compline_collects_rubric', 'rubric', "The Officiant then says one or more of the following Collects. Other appropriate Collects may also be used.")
create_text('compline_mission_rubric', 'rubric', "One of the following prayers may be added")
create_text('compline_intercessions_rubric', 'rubric', "Silence may be kept, and other intercessions and thanksgivings may be offered.")
create_text('compline_nunc_rubric', 'rubric', "The Officiant and People say or sing the Song of Simeon with this Antiphon")
create_text('compline_nunc_easter_rubric', 'rubric', "In Easter Season, add Alleluia, alleluia, alleluia.")
create_text('compline_conclusion_rubric', 'rubric', "The Officiant concludes with the following")
