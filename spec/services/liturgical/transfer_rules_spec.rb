# frozen_string_literal: true

require "rails_helper"

RSpec.describe Liturgical::TransferRules do
  let(:year) { 2025 }
  let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
  let(:transfer_rules) { described_class.new(year, easter_calc: easter_calc) }

  # Create a mock celebration for testing
  def mock_celebration(name:, festival: false, major_holy_day: false)
    double("Celebration", name: name, festival?: festival, major_holy_day?: major_holy_day)
  end

  describe "#transfer_if_needed" do
    context "with Annunciation" do
      let(:celebration) { mock_celebration(name: "Anunciação de nosso Senhor") }
      let(:original_date) { Date.new(2025, 3, 25) }

      it "keeps original date when not conflicting" do
        # 2025: March 25 is a Tuesday, not during Holy Week
        expect(transfer_rules.transfer_if_needed(celebration, original_date)).to eq(original_date)
      end

      context "when Annunciation falls on Sunday" do
        let(:year) { 2029 } # In 2029, March 25 is Sunday
        let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
        let(:transfer_rules) { described_class.new(year, easter_calc: easter_calc) }
        let(:original_date) { Date.new(2029, 3, 25) }

        it "transfers to Monday" do
          expect(transfer_rules.transfer_if_needed(celebration, original_date)).to eq(Date.new(2029, 3, 26))
        end
      end

      context "when Annunciation falls during Holy Week" do
        # Find a year where March 25 falls in Holy Week
        let(:year) { 2024 } # Easter 2024 is March 31, Palm Sunday is March 24
        let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
        let(:transfer_rules) { described_class.new(year, easter_calc: easter_calc) }
        let(:original_date) { Date.new(2024, 3, 25) }

        it "transfers to Monday after Second Sunday of Easter" do
          second_easter = easter_calc.second_sunday_of_easter
          expect(transfer_rules.transfer_if_needed(celebration, original_date)).to eq(second_easter + 1.day)
        end
      end
    end

    context "with All Saints" do
      let(:celebration) { mock_celebration(name: "Todos os Santos") }

      context "when November 1 is a Sunday" do
        let(:year) { 2026 } # In 2026, November 1 is Sunday
        let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
        let(:transfer_rules) { described_class.new(year, easter_calc: easter_calc) }
        let(:original_date) { Date.new(2026, 11, 1) }

        it "keeps original date" do
          expect(transfer_rules.transfer_if_needed(celebration, original_date)).to eq(original_date)
        end
      end

      context "when November 1 is not a Sunday" do
        let(:year) { 2025 } # Saturday in 2025
        let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
        let(:transfer_rules) { described_class.new(year, easter_calc: easter_calc) }
        let(:original_date) { Date.new(2025, 11, 1) }

        it "transfers to nearest Sunday in range Oct 30 - Nov 5" do
          result = transfer_rules.transfer_if_needed(celebration, original_date)
          expect(result.wday).to eq(0) # Sunday
          expect(result).to be >= Date.new(2025, 10, 30)
          expect(result).to be <= Date.new(2025, 11, 5)
        end
      end
    end

    context "with festivals on Sunday" do
      let(:celebration) { mock_celebration(name: "São Lucas, Evangelista", festival: true) }

      context "when festival falls on Sunday" do
        # Find a Sunday for testing
        let(:sunday_date) { Date.new(2025, 10, 19) } # A Sunday in 2025

        it "transfers to Monday" do
          expect(transfer_rules.transfer_if_needed(celebration, sunday_date)).to eq(sunday_date + 1.day)
        end
      end

      context "when festival falls on weekday" do
        let(:weekday_date) { Date.new(2025, 10, 18) } # October 18, 2025 (St. Luke's Day) is Saturday

        it "keeps original date" do
          expect(transfer_rules.transfer_if_needed(celebration, weekday_date)).to eq(weekday_date)
        end
      end
    end

    context "with José de Nazaré" do
      let(:celebration) { mock_celebration(name: "José de Nazaré") }

      context "when March 19 falls during Holy Week" do
        # In 2024, Palm Sunday is March 24, so March 19 is before Palm Sunday
        # Need a year where March 19 is during Holy Week
        let(:year) { 2027 } # Easter 2027 is March 28, Palm Sunday is March 21
        let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
        let(:transfer_rules) { described_class.new(year, easter_calc: easter_calc) }
        let(:original_date) { Date.new(2027, 3, 19) }

        it "keeps original date since it's before Palm Sunday" do
          palm_sunday = easter_calc.palm_sunday
          # March 19 is before March 21, so no transfer needed
          expect(original_date).to be < palm_sunday
          expect(transfer_rules.transfer_if_needed(celebration, original_date)).to eq(original_date)
        end
      end

      context "when March 19 is not during Holy Week" do
        let(:original_date) { Date.new(2025, 3, 19) }

        it "keeps original date" do
          expect(transfer_rules.transfer_if_needed(celebration, original_date)).to eq(original_date)
        end
      end
    end

    context "with regular celebrations" do
      let(:celebration) { mock_celebration(name: "Some Regular Celebration") }
      let(:original_date) { Date.new(2025, 6, 15) }

      it "keeps original date when no transfer rule applies" do
        expect(transfer_rules.transfer_if_needed(celebration, original_date)).to eq(original_date)
      end
    end
  end
end
