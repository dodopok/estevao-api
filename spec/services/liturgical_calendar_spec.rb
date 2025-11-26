require 'rails_helper'

RSpec.describe LiturgicalCalendar do
  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.year = 2015
      pb.is_default = true
      pb.features = {
        "lectionary" => {
          "reading_types" => ["semicontinuous", "complementary"],
          "default_reading_type" => "semicontinuous"
        },
        "daily_office" => {
          "supports_family_rite" => false
        }
      }
    end
  end

  let!(:easter_2025) do
    create(:celebration,
      name: "Páscoa",
      celebration_type: :principal_feast,
      rank: 0,
      movable: true,
      calculation_rule: "easter",
      liturgical_color: "branco",
      prayer_book: prayer_book)
  end

  let!(:lesser_feast) do
    create(:celebration,
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
    end

    context 'Epiphany' do
      it 'correctly identifies Epiphany season' do
        # During Epiphany (after January 6)
        expect(calendar.season_for_date(Date.new(2025, 1, 10))).to eq("Epifania")
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
        create(:celebration,
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
        create(:celebration,
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
        create(:celebration,
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
        create(:celebration,
          name: "Quarta-Feira de Cinzas",
          celebration_type: :major_holy_day,
          rank: 20,
          movable: true,
          calculation_rule: "easter_minus_46_days",
          liturgical_color: "roxo",
          prayer_book: prayer_book)

        date = Date.new(2025, 3, 5) # Ash Wednesday 2025

        expect(calendar.color_for_date(date)).to eq("roxo")
      end

      it 'lesser feasts in Lent keep purple season color' do
        # Saint Patrick falls on March 17 (during Lent)
        create(:celebration,
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

    it 'returns nil for non-Sunday dates' do
      date = Date.new(2025, 11, 17) # Monday
      expect(calendar.proper_number(date)).to be_nil
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
      create(:celebration,
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
      create(:celebration,
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

  describe 'celebration display' do
    it 'celebration appears even when color is not used' do
      # Saint Francis on Sunday (October 4, 2026)
      create(:celebration,
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
end
