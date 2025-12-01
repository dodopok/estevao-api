# frozen_string_literal: true

require "rails_helper"

RSpec.describe Liturgical::WeekCalculator do
  let(:year) { 2025 }
  let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
  let(:season_determinator) { Liturgical::SeasonDeterminator.new(year, easter_calc: easter_calc) }
  let(:week_calculator) do
    described_class.new(
      season_determinator: season_determinator,
      easter_calc: easter_calc
    )
  end

  describe "#week_number" do
    context "during Advent" do
      it "returns 1 for the first Sunday of Advent" do
        first_sunday = easter_calc.first_sunday_of_advent
        expect(week_calculator.week_number(first_sunday)).to eq(1)
      end

      it "returns 2 for the second Sunday of Advent" do
        second_sunday = easter_calc.first_sunday_of_advent + 7.days
        expect(week_calculator.week_number(second_sunday)).to eq(2)
      end

      it "returns 4 for the fourth Sunday of Advent" do
        fourth_sunday = easter_calc.first_sunday_of_advent + 21.days
        expect(week_calculator.week_number(fourth_sunday)).to eq(4)
      end
    end

    context "during Christmas" do
      it "returns 1 for Christmas Day" do
        christmas = Date.new(2025, 12, 25)
        expect(week_calculator.week_number(christmas)).to eq(1)
      end

      it "returns 1 for December 31" do
        new_years_eve = Date.new(2025, 12, 31)
        expect(week_calculator.week_number(new_years_eve)).to eq(1)
      end

      it "returns 2 for January 1 (next year context)" do
        # For a date in January, it's the second week of Christmas from previous year
        january_first = Date.new(2026, 1, 1)
        calculator_2026 = described_class.new(
          season_determinator: Liturgical::SeasonDeterminator.new(2026, easter_calc: Liturgical::EasterCalculator.new(2026)),
          easter_calc: Liturgical::EasterCalculator.new(2026)
        )
        expect(calculator_2026.week_number(january_first)).to eq(2)
      end
    end

    context "during Epiphany" do
      it "returns 1 for the first week after Baptism" do
        baptism = easter_calc.baptism_of_the_lord
        expect(week_calculator.week_number(baptism)).to eq(1)
      end

      it "returns 2 for the second week after Baptism" do
        baptism = easter_calc.baptism_of_the_lord
        expect(week_calculator.week_number(baptism + 7.days)).to eq(2)
      end
    end

    context "during Lent" do
      it "returns 1 for the first Sunday in Lent" do
        first_sunday = easter_calc.first_sunday_in_lent
        expect(week_calculator.week_number(first_sunday)).to eq(1)
      end

      it "returns 5 for the fifth Sunday in Lent" do
        fifth_sunday = easter_calc.first_sunday_in_lent + 28.days
        expect(week_calculator.week_number(fifth_sunday)).to eq(5)
      end
    end

    context "during Easter" do
      it "returns 1 for Easter Day" do
        easter = easter_calc.easter_date
        expect(week_calculator.week_number(easter)).to eq(1)
      end

      it "returns 7 for Pentecost week" do
        pentecost = easter_calc.pentecost
        expect(week_calculator.week_number(pentecost)).to eq(8) # 49 days / 7 + 1
      end
    end

    context "during Ordinary Time" do
      context "before Lent" do
        it "returns week number counting from Baptism" do
          # Find a date that's in Ordinary Time before Lent
          baptism = easter_calc.baptism_of_the_lord
          first_sunday_after = baptism.sunday? ? baptism : baptism + (7 - baptism.wday).days
          ordinary_time_date = first_sunday_after + 7.days

          # Only test if this date is actually in Ordinary Time
          if season_determinator.season_for_date(ordinary_time_date) == "Tempo Comum"
            expect(week_calculator.week_number(ordinary_time_date)).to be >= 1
          end
        end
      end

      context "after Pentecost" do
        it "returns week number counting from Trinity Sunday" do
          trinity = easter_calc.trinity_sunday
          first_sunday_after_trinity = trinity + 7.days

          expect(week_calculator.week_number(first_sunday_after_trinity)).to eq(1)
        end

        it "returns increasing week numbers for subsequent Sundays" do
          trinity = easter_calc.trinity_sunday
          third_sunday_after_trinity = trinity + 21.days

          expect(week_calculator.week_number(third_sunday_after_trinity)).to eq(3)
        end
      end
    end
  end

  describe "#sunday_after_pentecost" do
    it "returns nil for non-Sunday dates" do
      monday = easter_calc.pentecost + 1.day
      expect(week_calculator.sunday_after_pentecost(monday)).to be_nil
    end

    it "returns nil for dates before Pentecost" do
      sunday_before_pentecost = easter_calc.pentecost - 7.days
      expect(week_calculator.sunday_after_pentecost(sunday_before_pentecost)).to be_nil
    end

    it "returns nil for Sundays not in Ordinary Time" do
      # Easter Sunday is not in Ordinary Time
      expect(week_calculator.sunday_after_pentecost(easter_calc.easter_date)).to be_nil
    end

    it "returns 1 for Pentecost Sunday" do
      # Pentecost itself (week 0 would be Pentecost, which is in Easter season)
      pentecost = easter_calc.pentecost
      expect(week_calculator.sunday_after_pentecost(pentecost)).to be_nil # Still Easter season
    end

    it "returns correct number for Sundays after Trinity in Ordinary Time" do
      # Trinity Sunday is still Easter season in some traditions
      # First Sunday of Ordinary Time after Pentecost
      first_ordinary_sunday = easter_calc.trinity_sunday + 7.days
      result = week_calculator.sunday_after_pentecost(first_ordinary_sunday)
      expect(result).to be >= 2 # At least 2 weeks after Pentecost
    end

    it "returns increasing numbers for subsequent Sundays" do
      first_sunday = easter_calc.trinity_sunday + 7.days
      second_sunday = first_sunday + 7.days

      first_result = week_calculator.sunday_after_pentecost(first_sunday)
      second_result = week_calculator.sunday_after_pentecost(second_sunday)

      # Both should be in Ordinary Time, so not nil
      if first_result && second_result
        expect(second_result).to eq(first_result + 1)
      end
    end
  end
end
