# frozen_string_literal: true

require "rails_helper"

RSpec.describe Liturgical::ProperCalculator do
  describe "#calculate" do
    let(:year) { 2024 }
    let(:calculator) { described_class.new(year) }

    context "when not in Tempo Comum season" do
      it "returns nil for Advent" do
        date = Date.new(2024, 12, 1) # 1st Sunday of Advent 2024
        expect(calculator.calculate(date, season: "Advento")).to be_nil
      end

      it "returns nil for Lent" do
        date = Date.new(2024, 3, 10) # 4th Sunday in Lent 2024
        expect(calculator.calculate(date, season: "Quaresma")).to be_nil
      end

      it "returns nil for Easter" do
        date = Date.new(2024, 4, 7) # 2nd Sunday of Easter 2024
        expect(calculator.calculate(date, season: "Páscoa")).to be_nil
      end
    end

    context "when not a Sunday" do
      it "returns proper for weekdays" do
        date = Date.new(2024, 7, 15) # Monday
        # July 14, 2024 was Proper 10. Monday July 15 should also be Proper 10.
        expect(calculator.calculate(date, season: "Tempo Comum")).to eq(10)
      end
    end

    context "before Lent (forward counting from Baptism)" do
      let(:year) { 2024 }

      it "returns proper 1 for first Sunday in Ordinary Time" do
        # Baptism of the Lord 2024 is Jan 7 (Sunday), which is the start
        # First Sunday after Baptism would be Jan 14, which is week 2
        date = Date.new(2024, 1, 14)
        expect(calculator.calculate(date, season: "Tempo Comum")).to eq(2)
      end

      it "returns proper 3 for third Sunday in Ordinary Time" do
        date = Date.new(2024, 1, 21)
        expect(calculator.calculate(date, season: "Tempo Comum")).to eq(3)
      end
    end

    context "after Pentecost (reverse counting from Christ the King)" do
      let(:year) { 2024 }

      it "returns proper 29 for Christ the King Sunday" do
        # Christ the King 2024 is Nov 24
        date = Date.new(2024, 11, 24)
        expect(calculator.calculate(date, season: "Tempo Comum")).to eq(29)
      end

      it "returns proper 28 for Sunday before Christ the King" do
        date = Date.new(2024, 11, 17)
        expect(calculator.calculate(date, season: "Tempo Comum")).to eq(28)
      end

      it "returns a valid proper number for midsummer Sundays" do
        date = Date.new(2024, 7, 14) # Should be around Proper 10
        result = calculator.calculate(date, season: "Tempo Comum")
        expect(result).to be_between(9, 11)
      end
    end

    context "with different years" do
      it "handles 2025 correctly" do
        calculator_2025 = described_class.new(2025)
        # Christ the King 2025 is Nov 23 (Sunday)
        date = Date.new(2025, 11, 23)
        expect(calculator_2025.calculate(date, season: "Tempo Comum")).to eq(29)
      end
    end
  end

  describe "PROPER_TARGET_DATES constant" do
    it "has 29 entries" do
      expect(Liturgical::ProperCalculator::PROPER_TARGET_DATES.size).to eq(29)
    end

    it "starts with Proper 1 (May 11)" do
      expect(Liturgical::ProperCalculator::PROPER_TARGET_DATES[1]).to eq([ 5, 11 ])
    end

    it "ends with Proper 29 (Nov 23 - Christ the King)" do
      expect(Liturgical::ProperCalculator::PROPER_TARGET_DATES[29]).to eq([ 11, 23 ])
    end
  end
end
