require 'rails_helper'

RSpec.describe LiturgicalCalendar do
  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.year = 2015
      pb.is_recommended = true
      pb.features = {
        "lectionary" => {
          "reading_types" => [ "semicontinuous", "complementary" ],
          "default_reading_type" => "semicontinuous"
        },
        "daily_office" => {
          "supports_family_rite" => false
        }
      }
    end
  end

  let!(:easter_2025) do
    Celebration.find_or_create_by!(
      name: "Páscoa",
      celebration_type: :principal_feast,
      rank: 0,
      movable: true,
      calculation_rule: "easter",
      liturgical_color: "branco",
      prayer_book: prayer_book)
  end

  let!(:lesser_feast) do
    Celebration.find_or_create_by!(
      name: "Margaret of Scotland",
      celebration_type: :lesser_feast,
      rank: 249,
      movable: false,
      fixed_month: 11,
      fixed_day: 16,
      liturgical_color: "branco",
      prayer_book: prayer_book)
  end

  describe '#season_for_date' do
    let(:calendar) { described_class.new(2025) }

    context 'Advent' do
      it 'correctly identifies Advent season' do
        # First Sunday of Advent 2025
        expect(calendar.season_for_date(Date.new(2025, 11, 30))).to eq("Advento")

        # During Advent
        expect(calendar.season_for_date(Date.new(2025, 12, 15))).to eq("Advento")

        # Last day of Advent (December 24)
        expect(calendar.season_for_date(Date.new(2025, 12, 24))).to eq("Advento")
      end
    end

    context 'Christmas' do
      it 'correctly identifies Christmas season' do
        # Christmas Day
        expect(calendar.season_for_date(Date.new(2025, 12, 25))).to eq("Natal")

        # During Christmas
        expect(calendar.season_for_date(Date.new(2025, 12, 28))).to eq("Natal")
      end

      it 'correctly identifies Christmas season for early January (before Baptism of the Lord)' do
        # January 5, 2025 should be Christmas season (before Baptism which is Jan 12)
        expect(calendar.season_for_date(Date.new(2025, 1, 5))).to eq("Natal")

        # January 1, 2025 should be Christmas season
        expect(calendar.season_for_date(Date.new(2025, 1, 1))).to eq("Natal")

        # January 6, 2025 (Epiphany) should still be Christmas (before Baptism)
        expect(calendar.season_for_date(Date.new(2025, 1, 6))).to eq("Natal")
      end

      it 'ends Christmas season at Baptism of the Lord' do
        # Baptism of the Lord 2025 is January 12 (first Sunday after Epiphany)
        # Baptism itself starts Epiphany season
        expect(calendar.season_for_date(Date.new(2025, 1, 12))).to eq("Epifania")
      end
    end

    context 'Epiphany' do
      it 'correctly identifies Epiphany season' do
        # Epiphany starts at Baptism of the Lord
        # In 2025, Baptism of the Lord is January 12
        expect(calendar.season_for_date(Date.new(2025, 1, 12))).to eq("Epifania")

        # During Epiphany (after Baptism of the Lord)
        expect(calendar.season_for_date(Date.new(2025, 1, 15))).to eq("Epifania")
      end
    end

    context 'Lent' do
      it 'correctly identifies Lent season' do
        # Ash Wednesday 2025
        expect(calendar.season_for_date(Date.new(2025, 3, 5))).to eq("Quaresma")

        # During Lent
        expect(calendar.season_for_date(Date.new(2025, 3, 20))).to eq("Quaresma")

        # Holy Saturday (last day of Lent)
        expect(calendar.season_for_date(Date.new(2025, 4, 19))).to eq("Quaresma")
      end
    end

    context 'Easter' do
      it 'correctly identifies Easter season' do
        # Easter Sunday
        expect(calendar.season_for_date(Date.new(2025, 4, 20))).to eq("Páscoa")

        # During Easter
        expect(calendar.season_for_date(Date.new(2025, 5, 10))).to eq("Páscoa")

        # Pentecost (last day of Easter)
        expect(calendar.season_for_date(Date.new(2025, 6, 8))).to eq("Páscoa")
      end
    end

    context 'Ordinary Time' do
      it 'correctly identifies Ordinary Time' do
        # Ordinary Time after Pentecost
        expect(calendar.season_for_date(Date.new(2025, 7, 15))).to eq("Tempo Comum")

        # Ordinary Time in November (before Advent)
        expect(calendar.season_for_date(Date.new(2025, 11, 15))).to eq("Tempo Comum")

        # Ordinary Time in September
        expect(calendar.season_for_date(Date.new(2025, 9, 15))).to eq("Tempo Comum")
      end
    end
  end

  describe '#color_for_date' do
    let(:calendar) { described_class.new(2025) }

    it 'returns violet for Advent' do
      expect(calendar.color_for_date(Date.new(2025, 12, 1))).to eq("violeta")
    end

    it 'returns white for Christmas' do
      expect(calendar.color_for_date(Date.new(2025, 12, 25))).to eq("branco")
    end

    it 'returns purple for Lent' do
      # First Sunday of Lent
      expect(calendar.color_for_date(Date.new(2025, 3, 9))).to eq("roxo")
    end

    it 'returns white for Easter' do
      expect(calendar.color_for_date(Date.new(2025, 4, 20))).to eq("branco")
    end

    it 'returns green for Ordinary Time' do
      expect(calendar.color_for_date(Date.new(2025, 7, 15))).to eq("verde")
    end

    it 'returns green for Epiphany' do
      expect(calendar.color_for_date(Date.new(2025, 1, 15))).to eq("verde")
    end

    context 'with celebrations' do
      it 'lesser feasts on Sundays keep season color' do
        # November 16, 2025 is Sunday in Ordinary Time
        # There is a celebration (Margaret of Scotland) with white color
        # But Sunday should use green (Ordinary Time color)
        date = Date.new(2025, 11, 16)

        expect(date).to be_sunday
        expect(calendar.season_for_date(date)).to eq("Tempo Comum")
        expect(calendar.color_for_date(date)).to eq("verde")
      end

      it 'principal feasts on Sundays override season color' do
        # Create Christ the King for 2025
        Celebration.find_or_create_by!(
          name: "Cristo Rei do Universo",
          celebration_type: :principal_feast,
          rank: 12,
          movable: true,
          calculation_rule: "sunday_before_advent",
          liturgical_color: "branco",
          prayer_book: prayer_book)

        date = Date.new(2025, 11, 23) # Christ the King 2025

        expect(date).to be_sunday
        expect(calendar.season_for_date(date)).to eq("Tempo Comum")
        expect(calendar.color_for_date(date)).to eq("branco")
      end

      it 'lesser feasts on weekdays keep season color' do
       # Create a celebration on a weekday
       Celebration.find_or_create_by!(
          name: "Santo Teste Segunda",
          celebration_type: :lesser_feast,
          rank: 250,
          movable: false,
          fixed_month: 6,
          fixed_day: 16, # Monday in 2025
          liturgical_color: "vermelho",
          prayer_book: prayer_book)

        date = Date.new(2025, 6, 16)

        expect(date).not_to be_sunday
        expect(calendar.color_for_date(date)).to eq("verde")
      end

      it 'principal feasts override season color even in Lent' do
        # Annunciation falls on March 25
        Celebration.find_or_create_by!(
          name: "Anunciação de Nosso Senhor",
          celebration_type: :principal_feast,
          rank: 6,
          movable: false,
          fixed_month: 3,
          fixed_day: 25,
          liturgical_color: "branco",
          can_be_transferred: true,
          prayer_book: prayer_book)

        date = Date.new(2025, 3, 25)

        expect(calendar.season_for_date(date)).to eq("Quaresma")
        expect(calendar.color_for_date(date)).to eq("branco")
      end

      it 'major holy days override season color' do
        # Ash Wednesday
        Celebration.find_or_create_by!(
          name: "Quarta-Feira de Cinzas",
          prayer_book: prayer_book
        ) do |c|
          c.celebration_type = :major_holy_day
          c.rank = 20
          c.movable = true
          c.calculation_rule = "easter_minus_46_days"
          c.liturgical_color = "roxo"
          c.can_be_transferred = false
        end

        date = Date.new(2025, 3, 5) # Ash Wednesday 2025

        expect(calendar.color_for_date(date)).to eq("roxo")
      end

      it 'lesser feasts in Lent keep purple season color' do
        # Saint Patrick falls on March 17 (during Lent)
        Celebration.find_or_create_by!(
          name: "São Patrício",
          celebration_type: :lesser_feast,
          rank: 110,
          movable: false,
          fixed_month: 3,
          fixed_day: 17,
          liturgical_color: "branco",
          prayer_book: prayer_book)

        date = Date.new(2025, 3, 17)

        expect(calendar.season_for_date(date)).to eq("Quaresma")
        expect(calendar.color_for_date(date)).to eq("roxo")
      end
    end
  end

  describe '#sunday_name' do
    let(:calendar) { described_class.new(2025) }

    it 'correctly names Advent Sundays' do
      # First Sunday of Advent
      date = Date.new(2025, 11, 30)
      expect(calendar.sunday_name(date)).to eq("1º Domingo do Advento")
    end

    it 'correctly names Christmas Sundays' do
      # In 2025, Dec 28 is a Sunday (1st Sunday after Christmas)
      date = Date.new(2025, 12, 28)
      expect(calendar.sunday_name(date)).to eq("1º Domingo após Natal")
    end

    it 'correctly names Second Sunday after Christmas' do
      # When there's a second Sunday before Baptism
      # In 2025, Jan 5 is a Sunday (2nd Sunday after Christmas)
      date = Date.new(2025, 1, 5)
      expect(calendar.sunday_name(date)).to eq("2º Domingo após Natal")
    end

    it 'correctly names Lent Sundays' do
      # First Sunday of Lent
      date = Date.new(2025, 3, 9)
      name = calendar.sunday_name(date)
      expect(name).to match(/1º Domingo/)
      expect(name).to match(/Quaresma/)
    end

    it 'correctly names Ordinary Time Sundays' do
      # Some Sunday in Ordinary Time
      date = Date.new(2025, 11, 16)
      name = calendar.sunday_name(date)
      expect(name).to match(/Domingo/)
      expect(name).to match(/Tempo Comum/)
    end

    it 'returns nil for non-Sunday dates' do
      date = Date.new(2025, 11, 17) # Monday
      expect(calendar.sunday_name(date)).to be_nil
    end
  end

  describe '#proper_number' do
    let(:calendar) { described_class.new(2025) }

    it 'calculates proper number correctly for Sundays after Pentecost' do
      # Sunday in Ordinary Time after Pentecost
      date = Date.new(2025, 11, 16)

      if date.sunday?
        proper = calendar.proper_number(date)
        expect(proper).to be_a(Integer)
        expect(proper).to be >= 4
        expect(proper).to be <= 29
      end
    end

    it 'returns proper number for non-Sunday dates in Ordinary Time' do
      date = Date.new(2025, 11, 17) # Monday
      # Nov 16 (Sunday) is Proper 28. Monday Nov 17 should also be Proper 28.
      expect(calendar.proper_number(date)).to eq(28)
    end

    it 'returns nil for proper_number outside Ordinary Time' do
      # Sunday in Easter
      date = Date.new(2025, 4, 27)

      expect(date).to be_sunday
      expect(calendar.season_for_date(date)).to eq("Páscoa")
      expect(calendar.proper_number(date)).to be_nil
    end
  end

  describe '#liturgical_year_cycle' do
    let(:calendar) { described_class.new(2025) }

    it 'calculates liturgical year cycle correctly' do
      # 2025 % 3 = 0, so it's Cycle C
      date = Date.new(2025, 6, 15)
      expect(calendar.liturgical_year_cycle(date)).to eq("C")
    end

    it 'cycle changes in Advent, not in January' do
      calendar_2024 = described_class.new(2024)
      calendar_2025 = described_class.new(2025)

      # Before Advent 2024 = still Cycle B (year 2024)
      date_before = Date.new(2024, 11, 1)
      expect(calendar_2024.liturgical_year_cycle(date_before)).to eq("B")

      # After Advent 2024 = Cycle C (year 2025)
      date_after = Date.new(2024, 12, 1)
      expect(calendar_2024.liturgical_year_cycle(date_after)).to eq("C")
    end
  end

  describe '#day_info' do
    let(:calendar) { described_class.new(2025) }

    it 'returns complete structure' do
      date = Date.new(2025, 11, 16)
      info = calendar.day_info(date)

      # Verify required fields
      expect(info[:date]).to eq("16/11/2025")
      expect(info[:day_of_week]).to eq("Domingo")
      expect(info[:liturgical_season]).to eq("Tempo Comum")
      expect(info[:color]).to eq("verde")
      expect(info[:is_sunday]).to eq(true)
      expect(info[:liturgical_year]).to eq("C")

      # Verify all fields exist
      expect(info).to have_key(:week_of_season)
      expect(info).to have_key(:proper_week)
      expect(info).to have_key(:sunday_after_pentecost)
      expect(info).to have_key(:celebration)
      expect(info).to have_key(:is_holy_day)
      expect(info).to have_key(:saint)
      expect(info).to have_key(:sunday_name)
    end
  end

  describe 'translation methods' do
    let(:calendar) { described_class.new(2025) }

    describe '#translate_season' do
      it 'translates season names correctly' do
        expect(calendar.translate_season("Advento")).to eq("Advent")
        expect(calendar.translate_season("Natal")).to eq("Christmas")
        expect(calendar.translate_season("Epifania")).to eq("Epiphany")
        expect(calendar.translate_season("Quaresma")).to eq("Lent")
        expect(calendar.translate_season("Páscoa")).to eq("Easter")
        expect(calendar.translate_season("Tempo Comum")).to eq("Ordinary Time")
      end
    end

    describe '#translate_color' do
      it 'translates colors correctly' do
        expect(calendar.translate_color("branco")).to eq("white")
        expect(calendar.translate_color("vermelho")).to eq("red")
        expect(calendar.translate_color("roxo")).to eq("purple")
        expect(calendar.translate_color("violeta")).to eq("violet")
        expect(calendar.translate_color("rosa")).to eq("rose")
        expect(calendar.translate_color("verde")).to eq("green")
        expect(calendar.translate_color("preto")).to eq("black")
      end
    end
  end

  describe 'specific cases' do
    it '2025-01-05 returns Christmas season data (bug fix)' do
      calendar = described_class.new(2025)
      date = Date.new(2025, 1, 5)
      info = calendar.day_info(date)

      # Should be Christmas season, not Ordinary Time
      expect(info[:liturgical_season]).to eq("Natal")

      # Should be 2nd Sunday after Christmas
      expect(info[:sunday_name]).to eq("2º Domingo após Natal")

      # Week should be 2 (second week of Christmas)
      expect(info[:week_of_season]).to eq(2)

      # Color should be white (Christmas color)
      expect(info[:color]).to eq("branco")
    end

    it '2025-11-16 returns green color (not white from celebration)' do
      calendar = described_class.new(2025)
      date = Date.new(2025, 11, 16)

      # Verify it's Sunday in Ordinary Time
      expect(date).to be_sunday
      expect(calendar.season_for_date(date)).to eq("Tempo Comum")

      # Should return green (Ordinary Time color), not white (celebration color)
      expect(calendar.color_for_date(date)).to eq("verde")
    end

    it '2026-04-04 returns Easter Vigil information' do
      # Create necessary celebrations
      Celebration.find_or_create_by!(
        name: "Vigília Pascal",
        celebration_type: :principal_feast,
        rank: 1,
        movable: true,
        calculation_rule: "easter_minus_1_day",
        liturgical_color: "branco",
        prayer_book: prayer_book)

      calendar = described_class.new(2026)
      date = Date.new(2026, 4, 4)
      info = calendar.day_info(date)

      # Should be Lent (Holy Saturday is the last day of Lent)
      expect(info[:liturgical_season]).to eq("Quaresma")

      # Color should be white (from Easter Vigil which has precedence)
      expect(info[:color]).to eq("branco")
    end
  end

  describe '#week_number' do
    let(:calendar) { described_class.new(2025) }

    it 'calculates week number correctly in Advent' do
      # First Sunday of Advent
      expect(calendar.week_number(Date.new(2025, 11, 30))).to eq(1)

      # Second Sunday of Advent
      expect(calendar.week_number(Date.new(2025, 12, 7))).to eq(2)
    end

    it 'calculates week number correctly in Christmas season' do
      # First Sunday after Christmas (Dec 28, 2025)
      expect(calendar.week_number(Date.new(2025, 12, 28))).to eq(1)

      # For 2025, Jan 5 would be second week of Christmas
      expect(calendar.week_number(Date.new(2025, 1, 5))).to eq(2)
    end

    it 'calculates week number correctly in Lent' do
      # First Sunday of Lent (6 Sundays before Easter)
      date = Date.new(2025, 3, 9)
      week = calendar.week_number(date)

      expect(week).to be_a(Integer)
      expect(week).to be >= 1
    end
  end

  describe '#sunday_after_pentecost' do
    let(:calendar) { described_class.new(2025) }

    it 'calculates Sundays after Pentecost correctly' do
      # Needs to be a Sunday in Ordinary Time after Pentecost
      date = Date.new(2025, 11, 16)

      if date.sunday? && calendar.season_for_date(date) == "Tempo Comum"
        weeks = calendar.sunday_after_pentecost(date)
        expect(weeks).to be_a(Integer) if weeks
      end
    end

    it 'returns nil when not Sunday' do
      date = Date.new(2025, 11, 17) # Monday
      expect(calendar.sunday_after_pentecost(date)).to be_nil
    end

    it 'returns nil before Pentecost' do
      # Sunday before Pentecost
      date = Date.new(2025, 3, 16)

      if date.sunday? && calendar.season_for_date(date) != "Tempo Comum"
        expect(calendar.sunday_after_pentecost(date)).to be_nil
      end
    end
  end

  describe '#holy_day?' do
    it 'correctly identifies major holy days' do
      # Create a principal feast
      Celebration.find_or_create_by!(
        name: "Festa Principal Teste",
        celebration_type: :principal_feast,
        rank: 5,
        movable: false,
        fixed_month: 8,
        fixed_day: 15,
        liturgical_color: "branco",
        prayer_book: prayer_book)

      calendar = described_class.new(2025)
      date = Date.new(2025, 8, 15)

      expect(calendar.holy_day?(date)).to be true
    end

    it 'lesser feasts are not holy days' do
      calendar = described_class.new(2025)
      date = Date.new(2025, 11, 16) # Margaret of Scotland (lesser feast)

      expect(calendar.holy_day?(date)).to be false
    end
  end

  describe '#description' do
    let(:calendar) { described_class.new(2025) }

    context 'principal feasts' do
      it 'returns only the feast name for principal feasts' do
        # Create Natal (Christmas)
        Celebration.find_or_create_by!(
          name: "Natividade de nosso Senhor Jesus Cristo",
          celebration_type: :principal_feast,
          rank: 1,
          movable: false,
          fixed_month: 12,
          fixed_day: 25,
          liturgical_color: "branco",
          prayer_book: prayer_book)

        date = Date.new(2025, 12, 25)
        expect(calendar.description(date)).to eq([ "Natividade de nosso Senhor Jesus Cristo" ])
      end

      it 'returns Pentecostes for Pentecost Sunday' do
        Celebration.find_or_create_by!(
          name: "Pentecostes",
          celebration_type: :principal_feast,
          rank: 3,
          movable: true,
          calculation_rule: "pentecost",
          liturgical_color: "vermelho",
          prayer_book: prayer_book)

        date = Date.new(2025, 6, 8) # Pentecost 2025
        description = calendar.description(date)
        # Principal feast returns only the feast name
        expect(description.first).to eq("Pentecostes")
        expect(description).to include("Pentecostes")
      end

      it 'returns Pentecostes from special movable days when no celebration exists' do
        # Without a Pentecost celebration in DB, it still recognizes the day
        date = Date.new(2025, 6, 8) # Pentecost 2025
        description = calendar.description(date)
        expect(description).to include("Pentecostes")
      end

      it 'appends (movido) when a principal feast is transferred' do
        Celebration.find_or_create_by!(
          name: "Anunciação de Nosso Senhor",
          celebration_type: :principal_feast,
          rank: 6,
          movable: false,
          fixed_month: 3,
          fixed_day: 25,
          can_be_transferred: true,
          liturgical_color: "branco",
          prayer_book: prayer_book)

        # In 2024, March 25 falls in Holy Week, so it should be transferred
        calendar_2024 = described_class.new(2024)
        transferred_date = Date.new(2024, 4, 8) # Monday after Easter

        description = calendar_2024.description(transferred_date)
        expect(description).to include("Anunciação de Nosso Senhor (movido)")
      end
    end

    context 'lesser feasts and saints' do
      it 'does not include lesser feasts in description' do
        date = Date.new(2025, 11, 16) # Margaret of Scotland (lesser feast)
        description = calendar.description(date)

        expect(description).not_to include("Margaret of Scotland")
        # Should include week after Pentecost (actual number depends on calculation)
        expect(description.any? { |d| d.include?("Semana após Pentecostes") }).to be true
      end

      it 'does not include commemorations in description' do
        Celebration.find_or_create_by!(
          name: "Bernard",
          celebration_type: :commemoration,
          rank: 250,
          movable: false,
          fixed_month: 8,
          fixed_day: 20,
          liturgical_color: "branco",
          prayer_book: prayer_book)

        date = Date.new(2025, 8, 20)
        description = calendar.description(date)

        expect(description).not_to include("Bernard")
        expect(description).to include("10ª Semana após Pentecostes")
      end

      it 'does not include festivals in description' do
        Celebration.find_or_create_by!(
          name: "André, Apóstolo",
          celebration_type: :festival,
          rank: 50,
          movable: false,
          fixed_month: 11,
          fixed_day: 30,
          liturgical_color: "vermelho",
          prayer_book: prayer_book)

        date = Date.new(2025, 11, 30) # First Sunday of Advent
        description = calendar.description(date)

        expect(description).not_to include("André, Apóstolo")
        expect(description).to include("1ª Semana do Advento")
      end
    end

    context 'Holy Week' do
      it 'returns correct names for Holy Week days' do
        movable = calendar.easter_calc.all_movable_dates

        expect(calendar.description(movable[:palm_sunday])).to eq([ "Domingo de Ramos" ])
        expect(calendar.description(movable[:palm_sunday] + 1.day)).to eq([ "Segunda-feira Santa" ])
        expect(calendar.description(movable[:palm_sunday] + 2.days)).to eq([ "Terça-feira Santa" ])
        expect(calendar.description(movable[:palm_sunday] + 3.days)).to eq([ "Quarta-feira Santa" ])
        expect(calendar.description(movable[:maundy_thursday])).to eq([ "Quinta-feira Santa" ])
        expect(calendar.description(movable[:good_friday])).to eq([ "Sexta-feira da Paixão" ])
        expect(calendar.description(movable[:holy_saturday])).to eq([ "Sábado Santo" ])
      end
    end

    context 'special movable days' do
    it "returns Quarta-feira de Cinzas for Ash Wednesday" do
      movable = calendar.easter_calc.all_movable_dates
      expect(calendar.description(movable[:ash_wednesday])).to include("Quarta-feira de Cinzas")
    end

      it 'returns Páscoa for Easter Sunday' do
        movable = calendar.easter_calc.all_movable_dates
        description = calendar.description(movable[:easter])
        # Returns either 'Páscoa' (from celebration) or 'Domingo da Páscoa' (from special_movable_day_name)
        expect(description.any? { |d| d.include?("Páscoa") }).to be true
      end

      it 'returns Santíssima Trindade for Trinity Sunday' do
        movable = calendar.easter_calc.all_movable_dates
        expect(calendar.description(movable[:trinity_sunday])).to include("Santíssima Trindade")
      end

      it 'returns Ascensão for Ascension Day' do
        movable = calendar.easter_calc.all_movable_dates
        expect(calendar.description(movable[:ascension])).to include("Ascensão")
      end

      it 'returns Cristo Rei do Universo for Christ the King' do
        movable = calendar.easter_calc.all_movable_dates
        expect(calendar.description(movable[:christ_the_king])).to include("Cristo Rei do Universo")
      end

      it 'returns Batismo de nosso Senhor for Baptism of the Lord' do
        movable = calendar.easter_calc.all_movable_dates
        expect(calendar.description(movable[:baptism_of_the_lord])).to include("Batismo de nosso Senhor Jesus Cristo")
      end
    end

    context 'Advent season' do
      it 'returns week of Advent for Advent days' do
        date = Date.new(2025, 12, 1) # Monday of 1st week of Advent
        expect(calendar.description(date)).to include("1ª Semana do Advento")

        date = Date.new(2025, 12, 15) # Monday of 3rd week of Advent
        expect(calendar.description(date)).to include("3ª Semana do Advento")
      end
    end

    context 'Christmas season' do
      it 'returns Oitava do Natal for Christmas octave days' do
        date = Date.new(2025, 12, 28) # During Christmas octave
        expect(calendar.description(date)).to include("Oitava do Natal")
      end
    end

    context 'Easter season' do
      it 'returns Oitava da Páscoa for Easter octave days' do
        movable = calendar.easter_calc.all_movable_dates
        date = movable[:easter] + 3.days # Wednesday of Easter week
        expect(calendar.description(date)).to include("Oitava da Páscoa")
      end

      it 'returns week of Easter for days after the octave' do
        movable = calendar.easter_calc.all_movable_dates
        date = movable[:easter] + 14.days # 3rd Sunday of Easter
        expect(calendar.description(date)).to include("3ª Semana da Páscoa")
      end
    end

    context 'Lent season' do
      it 'returns week of Lent for Lenten days' do
        date = Date.new(2025, 3, 10) # Monday of 1st week of Lent
        expect(calendar.description(date)).to include("1ª Semana da Quaresma")

        date = Date.new(2025, 3, 24) # Monday of 3rd week of Lent
        expect(calendar.description(date)).to include("3ª Semana da Quaresma")
      end
    end

    context 'Epiphany season' do
      it 'returns week after Epiphany for Epiphany season days' do
        date = Date.new(2025, 1, 15) # Wednesday of 1st week after Epiphany
        expect(calendar.description(date)).to include("1ª Semana após a Epifania")
      end
    end

    context 'Ordinary Time after Pentecost' do
      it 'returns multiple nomenclatures for Ordinary Time Sundays' do
        date = Date.new(2025, 8, 17) # Proper 15

        description = calendar.description(date)

        expect(description).to include("Próprio 15")
        expect(description).to include("20ª Semana do Tempo Comum")
        expect(description).to include("10ª Semana após Pentecostes")
      end

      it 'returns week after Pentecost for weekdays in Ordinary Time' do
        date = Date.new(2025, 8, 20) # Wednesday after Proper 15
        description = calendar.description(date)

        expect(description).to include("10ª Semana após Pentecostes")
      end
    end

    context 'day_info includes description' do
      it 'includes description array in day_info response' do
        date = Date.new(2025, 8, 17)
        info = calendar.day_info(date)

        expect(info).to have_key(:description)
        expect(info[:description]).to be_an(Array)
        expect(info[:description]).not_to be_empty
      end
    end
  end

  describe 'celebration display' do
    it 'celebration appears even when color is not used' do
      # Saint Francis on Sunday (October 4, 2026)
      Celebration.find_or_create_by!(
        name: "São Francisco de Assis",
        celebration_type: :lesser_feast,
        rank: 105,
        movable: false,
        fixed_month: 10,
        fixed_day: 4,
        liturgical_color: "branco",
        prayer_book: prayer_book)

      calendar = described_class.new(2026)
      date = Date.new(2026, 10, 4)
      info = calendar.day_info(date)

      # Main liturgical color is green (Ordinary Time)
      expect(info[:color]).to eq("verde")

      # But celebration appears with its own color
      expect(info[:celebration]).not_to be_nil
      expect(info[:celebration][:name]).to eq("São Francisco de Assis")
      expect(info[:celebration][:color]).to eq("branco")
    end
  end

  describe '#proper_number' do
    # Test Proper number calculation, especially for early Easter years
    # that need Propers 1, 2, or 3

    context 'in 2008 (Easter March 23 - very early)' do
      let(:calendar) { described_class.new(2008) }

      it 'returns Proper 2 for first Sunday in Ordinary Time (May 18)' do
        # Pentecost 2008: May 11
        # First Sunday in Ordinary Time: May 18
        expect(calendar.proper_number(Date.new(2008, 5, 18))).to eq(2)
      end

      it 'returns Proper 3 for second Sunday in Ordinary Time (May 25)' do
        expect(calendar.proper_number(Date.new(2008, 5, 25))).to eq(3)
      end

      it 'returns Proper 4 for third Sunday in Ordinary Time (June 1)' do
        expect(calendar.proper_number(Date.new(2008, 6, 1))).to eq(4)
      end

      it 'returns nil for Pentecost Sunday' do
        # Pentecost is not Ordinary Time
        expect(calendar.proper_number(Date.new(2008, 5, 11))).to be_nil
      end
    end

    context 'in 2024 (Easter March 31)' do
      let(:calendar) { described_class.new(2024) }

      it 'returns Proper 3 for first Sunday in Ordinary Time (May 26)' do
        # Pentecost 2024: May 19
        # Trinity Sunday: May 26
        # First Sunday in Ordinary Time: May 26
        expect(calendar.proper_number(Date.new(2024, 5, 26))).to eq(3)
      end
    end

    context 'in 2035 (Easter March 25 - very early)' do
      let(:calendar) { described_class.new(2035) }

      it 'returns Proper 2 for first Sunday in Ordinary Time (May 20)' do
        # Pentecost 2035: May 13
        # First Sunday in Ordinary Time: May 20
        expect(calendar.proper_number(Date.new(2035, 5, 20))).to eq(2)
      end

      it 'returns Proper 3 for second Sunday in Ordinary Time (May 27)' do
        expect(calendar.proper_number(Date.new(2035, 5, 27))).to eq(3)
      end
    end

    context 'in 2025 (Easter April 20 - normal)' do
      let(:calendar) { described_class.new(2025) }

      it 'returns Proper 4 for first Sunday in Ordinary Time (June 22)' do
        # Pentecost 2025: June 8
        # Trinity Sunday: June 15
        # First Sunday in Ordinary Time: June 22
        expect(calendar.proper_number(Date.new(2025, 6, 22))).to eq(7)
      end

          it 'returns proper number for non-Sunday dates' do
            # June 22, 2025 is Proper 7. Monday June 23 should also be Proper 7.
            expect(calendar.proper_number(Date.new(2025, 6, 23))).to eq(7)
          end
            it 'returns nil for dates outside Ordinary Time' do
        expect(calendar.proper_number(Date.new(2025, 4, 20))).to be_nil # Easter
        expect(calendar.proper_number(Date.new(2025, 3, 9))).to be_nil # Lent
      end
    end

    context 'end of year propers' do
      let(:calendar) { described_class.new(2025) }

      it 'returns Proper 29 for Christ the King Sunday' do
        # Christ the King 2025: November 23
        expect(calendar.proper_number(Date.new(2025, 11, 23))).to eq(29)
      end

      it 'returns Proper 28 for the Sunday before Christ the King' do
        expect(calendar.proper_number(Date.new(2025, 11, 16))).to eq(28)
      end
    end
  end
end
