require 'rails_helper'

RSpec.describe Liturgical::EasterCalculator do
  describe 'Easter date calculation' do
    it 'calculates Easter date correctly for known years' do
      known_easters = {
        2020 => Date.new(2020, 4, 12),
        2021 => Date.new(2021, 4, 4),
        2022 => Date.new(2022, 4, 17),
        2023 => Date.new(2023, 4, 9),
        2024 => Date.new(2024, 3, 31),
        2025 => Date.new(2025, 4, 20),
        2026 => Date.new(2026, 4, 5),
        2027 => Date.new(2027, 3, 28),
        2030 => Date.new(2030, 4, 21)
      }

      known_easters.each do |year, expected_date|
        calc = described_class.new(year)
        expect(calc.easter_date).to eq(expected_date),
          "Easter in #{year} should be #{expected_date}"
      end
    end

    it 'ensures Easter always falls between March 22 and April 25' do
      (2000..2050).each do |year|
        calc = described_class.new(year)
        easter = calc.easter_date

        earliest = Date.new(year, 3, 22)
        latest = Date.new(year, 4, 25)

        expect(easter).to be >= earliest
        expect(easter).to be <= latest
      end
    end

    it 'ensures Easter always falls on a Sunday' do
      (2000..2050).each do |year|
        calc = described_class.new(year)
        expect(calc.easter_date).to be_sunday,
          "Easter in #{year} should be a Sunday"
      end
    end
  end

  describe '#ash_wednesday' do
    it 'is 46 days before Easter' do
      calc = described_class.new(2025)
      expected = calc.easter_date - 46.days
      expect(calc.ash_wednesday).to eq(expected)
    end

    it 'always falls on a Wednesday' do
      (2020..2030).each do |year|
        calc = described_class.new(year)
        expect(calc.ash_wednesday.wday).to eq(3),
          "Ash Wednesday in #{year} should be a Wednesday"
      end
    end
  end

  describe 'Holy Week dates' do
    let(:calc) { described_class.new(2026) }

    describe '#palm_sunday' do
      it 'is 7 days before Easter' do
        expect(calc.palm_sunday).to eq(calc.easter_date - 7.days)
        expect(calc.palm_sunday).to be_sunday
      end
    end

    describe '#holy_monday' do
      it 'is 6 days before Easter' do
        expect(calc.holy_monday).to eq(calc.easter_date - 6.days)
        expect(calc.holy_monday.wday).to eq(1)
      end
    end

    describe '#holy_tuesday' do
      it 'is 5 days before Easter' do
        expect(calc.holy_tuesday).to eq(calc.easter_date - 5.days)
        expect(calc.holy_tuesday.wday).to eq(2)
      end
    end

    describe '#holy_wednesday' do
      it 'is 4 days before Easter' do
        expect(calc.holy_wednesday).to eq(calc.easter_date - 4.days)
        expect(calc.holy_wednesday.wday).to eq(3)
      end
    end

    describe '#maundy_thursday' do
      it 'is 3 days before Easter' do
        expect(calc.maundy_thursday).to eq(calc.easter_date - 3.days)
        expect(calc.maundy_thursday.wday).to eq(4)
      end
    end

    describe '#good_friday' do
      it 'is 2 days before Easter' do
        expect(calc.good_friday).to eq(calc.easter_date - 2.days)
        expect(calc.good_friday.wday).to eq(5)
      end
    end

    describe '#holy_saturday' do
      it 'is 1 day before Easter' do
        expect(calc.holy_saturday).to eq(calc.easter_date - 1.day)
        expect(calc.holy_saturday.wday).to eq(6)
      end
    end
  end

  describe 'Lent dates' do
    let(:calc) { described_class.new(2025) }

    describe '#first_sunday_in_lent' do
      it 'is 6 Sundays before Easter' do
        expect(calc.first_sunday_in_lent).to eq(calc.easter_date - 42.days)
        expect(calc.first_sunday_in_lent).to be_sunday
      end
    end

    it 'has approximately 40 weekdays' do
      start_date = calc.ash_wednesday
      end_date = calc.holy_saturday

      weekdays_count = 0
      (start_date..end_date).each do |date|
        weekdays_count += 1 unless date.sunday?
      end

      expect(weekdays_count).to be >= 37
      expect(weekdays_count).to be <= 44
    end
  end

  describe 'Easter season dates' do
    let(:calc) { described_class.new(2025) }

    describe '#ascension' do
      it 'is 39 days after Easter on a Thursday' do
        expect(calc.ascension).to eq(calc.easter_date + 39.days)
        expect(calc.ascension.wday).to eq(4)
      end
    end

    describe '#pentecost' do
      it 'is 49 days after Easter on a Sunday' do
        expect(calc.pentecost).to eq(calc.easter_date + 49.days)
        expect(calc.pentecost).to be_sunday
      end
    end

    describe '#trinity_sunday' do
      it 'is 7 days after Pentecost on a Sunday' do
        expect(calc.trinity_sunday).to eq(calc.pentecost + 7.days)
        expect(calc.trinity_sunday).to be_sunday
      end
    end
  end

  describe 'Advent dates' do
    let(:calc) { described_class.new(2025) }

    describe '#first_sunday_of_advent' do
      it 'is 4 Sundays before Christmas' do
        christmas = Date.new(2025, 12, 25)
        first_advent = calc.first_sunday_of_advent

        expect(first_advent).to be_sunday

        # Count Sundays between first Advent and Christmas
        sundays = 0
        date = first_advent
        while date <= christmas
          sundays += 1 if date.sunday?
          date += 1.day
        end

        expect(sundays).to be >= 4
      end
    end

    describe '#christ_the_king' do
      it 'is always the Sunday before Advent' do
        christ_king = calc.christ_the_king
        first_advent = calc.first_sunday_of_advent

        expect(christ_king).to be_sunday
        expect(christ_king).to eq(first_advent - 7.days)
      end
    end
  end

  describe 'Epiphany dates' do
    describe '#epiphany' do
      it 'is always January 6' do
        (2020..2030).each do |year|
          calc = described_class.new(year)
          expect(calc.epiphany).to eq(Date.new(year, 1, 6))
        end
      end
    end

    describe '#baptism_of_the_lord' do
      it 'is the first Sunday after Epiphany' do
        calc = described_class.new(2025)
        baptism = calc.baptism_of_the_lord

        expect(baptism).to be_sunday
        expect(baptism).to be > calc.epiphany

        # Verify there is no Sunday between Epiphany and Baptism
        date = calc.epiphany + 1.day
        while date < baptism
          expect(date).not_to be_sunday
          date += 1.day
        end
      end
    end

    describe '#last_sunday_after_epiphany' do
      it 'is the Sunday before Ash Wednesday' do
        calc = described_class.new(2025)
        last_epiphany = calc.last_sunday_after_epiphany

        expect(last_epiphany).to be_sunday
        expect(last_epiphany).to be < calc.ash_wednesday

        # Verify it's the Sunday immediately before
        next_sunday = last_epiphany + 7.days
        expect(next_sunday).to be > calc.ash_wednesday
      end
    end
  end

  describe '#all_movable_dates' do
    it 'returns all important liturgical dates' do
      calc = described_class.new(2025)
      dates = calc.all_movable_dates

      required_keys = [
        :easter, :ash_wednesday, :first_sunday_in_lent, :palm_sunday,
        :holy_monday, :holy_tuesday, :holy_wednesday,
        :maundy_thursday, :good_friday, :holy_saturday,
        :second_sunday_of_easter, :ascension, :pentecost, :trinity_sunday,
        :corpus_christi, :first_sunday_of_advent, :christ_the_king,
        :baptism_of_the_lord, :last_sunday_after_epiphany
      ]

      required_keys.each do |key|
        expect(dates).to have_key(key), "all_movable_dates should include :#{key}"
        expect(dates[key]).to be_a(Date), "#{key} should be a Date"
      end
    end
  end

  describe 'chronological order' do
    let(:calc) { described_class.new(2025) }

    it 'maintains correct order for Lent celebrations' do
      expect(calc.ash_wednesday).to be < calc.first_sunday_in_lent
      expect(calc.first_sunday_in_lent).to be < calc.palm_sunday
      expect(calc.palm_sunday).to be < calc.holy_monday
      expect(calc.holy_monday).to be < calc.holy_tuesday
      expect(calc.holy_tuesday).to be < calc.holy_wednesday
      expect(calc.holy_wednesday).to be < calc.maundy_thursday
      expect(calc.maundy_thursday).to be < calc.good_friday
      expect(calc.good_friday).to be < calc.holy_saturday
      expect(calc.holy_saturday).to be < calc.easter_date
    end

    it 'maintains correct order for Easter season celebrations' do
      expect(calc.easter_date).to be < calc.second_sunday_of_easter
      expect(calc.second_sunday_of_easter).to be < calc.ascension
      expect(calc.ascension).to be < calc.pentecost
      expect(calc.pentecost).to be < calc.trinity_sunday
    end
  end

  describe 'specific year 2026' do
    let(:calc) { described_class.new(2026) }

    it 'has correct dates' do
      expect(calc.easter_date).to eq(Date.new(2026, 4, 5))
      expect(calc.holy_saturday).to eq(Date.new(2026, 4, 4))
      expect(calc.good_friday).to eq(Date.new(2026, 4, 3))
      expect(calc.holy_monday).to eq(Date.new(2026, 3, 30))
      expect(calc.holy_tuesday).to eq(Date.new(2026, 3, 31))
      expect(calc.holy_wednesday).to eq(Date.new(2026, 4, 1))
    end
  end
end
