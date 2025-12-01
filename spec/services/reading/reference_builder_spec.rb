# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reading::ReferenceBuilder do
  let(:calendar) { LiturgicalCalendar.new(2025) }

  describe "#fixed_date_references" do
    it "builds fixed date references correctly" do
      builder = described_class.new(Date.new(2025, 12, 25), calendar: calendar)

      refs = builder.fixed_date_references

      expect(refs).to include("december_25")
      expect(refs).to include("christmas_day")
    end

    it "builds references for Epiphany" do
      builder = described_class.new(Date.new(2025, 1, 6), calendar: calendar)

      refs = builder.fixed_date_references

      expect(refs).to include("january_6")
      expect(refs).to include("epiphany")
    end

    it "builds references for Christmas Eve" do
      builder = described_class.new(Date.new(2025, 12, 24), calendar: calendar)

      refs = builder.fixed_date_references

      expect(refs).to include("december_24")
      expect(refs).to include("christmas_eve")
    end

    it "builds references for regular dates" do
      builder = described_class.new(Date.new(2025, 5, 15), calendar: calendar)

      refs = builder.fixed_date_references

      expect(refs).to include("may_15")
    end
  end

  describe "#weekly_references" do
    it "builds correct references for Advent weekdays" do
      # Thursday in first week of Advent
      builder = described_class.new(Date.new(2025, 12, 4), calendar: calendar)
      refs = builder.weekly_references

      expect(refs).to include("1st_sunday_of_advent_thursday")
      expect(refs).to include("december_4")
    end

    it "builds proper references for Ordinary Time" do
      # Saturday in Proper 20 week
      builder = described_class.new(Date.new(2025, 9, 27), calendar: calendar)
      refs = builder.weekly_references

      expect(refs).to include("proper_20_saturday")
      expect(refs).to include("september_27")
    end

    it "builds references for fixed dates" do
      builder = described_class.new(Date.new(2025, 12, 22), calendar: calendar)
      refs = builder.weekly_references

      expect(refs).to include("december_22")
    end
  end

  describe "#celebration_references" do
    let(:prayer_book) do
      PrayerBook.find_or_create_by!(code: "loc_2015") do |pb|
        pb.name = "Livro de Oração Comum 2015"
        pb.year = 2015
        pb.is_default = true
      end
    end

    context "for Holy Week celebrations" do
      let(:holy_monday_celebration) do
        create(:celebration,
          name: "Segunda-Feira Santa",
          calculation_rule: "easter_minus_6_days",
          movable: true,
          prayer_book: prayer_book)
      end

      let(:holy_tuesday_celebration) do
        create(:celebration,
          name: "Terça-Feira Santa",
          calculation_rule: "easter_minus_5_days",
          movable: true,
          prayer_book: prayer_book)
      end

      let(:holy_wednesday_celebration) do
        create(:celebration,
          name: "Quarta-Feira Santa",
          calculation_rule: "easter_minus_4_days",
          movable: true,
          prayer_book: prayer_book)
      end

      it "builds references for Holy Monday" do
        builder = described_class.new(Date.new(2025, 4, 14), calendar: calendar)
        refs = builder.celebration_references(holy_monday_celebration)

        expect(refs).to include("holy_monday")
      end

      it "builds references for Holy Tuesday" do
        builder = described_class.new(Date.new(2025, 4, 15), calendar: calendar)
        refs = builder.celebration_references(holy_tuesday_celebration)

        expect(refs).to include("holy_tuesday")
      end

      it "builds references for Holy Wednesday" do
        builder = described_class.new(Date.new(2025, 4, 16), calendar: calendar)
        refs = builder.celebration_references(holy_wednesday_celebration)

        expect(refs).to include("holy_wednesday")
      end
    end

    context "for Paschal Triduum and major celebrations" do
      let(:maundy_thursday) do
        create(:celebration,
          name: "Quinta-Feira Santa",
          calculation_rule: "easter_minus_3_days",
          movable: true,
          prayer_book: prayer_book)
      end

      let(:good_friday) do
        create(:celebration,
          name: "Sexta-Feira Santa",
          calculation_rule: "easter_minus_2_days",
          movable: true,
          prayer_book: prayer_book)
      end

      let(:holy_saturday) do
        create(:celebration,
          name: "Sábado Santo",
          calculation_rule: "easter_minus_1_days",
          movable: true,
          prayer_book: prayer_book)
      end

      let(:ascension) do
        create(:celebration,
          name: "Ascensão",
          calculation_rule: "easter_plus_39_days",
          movable: true,
          prayer_book: prayer_book)
      end

      let(:pentecost) do
        create(:celebration,
          name: "Pentecostes",
          calculation_rule: "easter_plus_49_days",
          movable: true,
          prayer_book: prayer_book)
      end

      let(:trinity) do
        create(:celebration,
          name: "Santíssima Trindade",
          calculation_rule: "easter_plus_56_days",
          movable: true,
          prayer_book: prayer_book)
      end

      it "builds references for Maundy Thursday" do
        builder = described_class.new(Date.new(2025, 4, 17), calendar: calendar)
        refs = builder.celebration_references(maundy_thursday)

        expect(refs).to include("maundy_thursday")
        expect(refs).to include("holy_thursday")
      end

      it "builds references for Good Friday" do
        builder = described_class.new(Date.new(2025, 4, 18), calendar: calendar)
        refs = builder.celebration_references(good_friday)

        expect(refs).to include("good_friday")
      end

      it "builds references for Holy Saturday" do
        builder = described_class.new(Date.new(2025, 4, 19), calendar: calendar)
        refs = builder.celebration_references(holy_saturday)

        expect(refs).to include("holy_saturday")
        expect(refs).to include("holy_saturday_vigil")
      end

      it "builds references for Ascension" do
        builder = described_class.new(Date.new(2025, 5, 29), calendar: calendar)
        refs = builder.celebration_references(ascension)

        expect(refs).to include("ascension")
        expect(refs).to include("ascension_day")
      end

      it "builds references for Pentecost" do
        builder = described_class.new(Date.new(2025, 6, 8), calendar: calendar)
        refs = builder.celebration_references(pentecost)

        expect(refs).to include("pentecost")
        expect(refs).to include("whitsunday")
      end

      it "builds references for Trinity Sunday" do
        builder = described_class.new(Date.new(2025, 6, 15), calendar: calendar)
        refs = builder.celebration_references(trinity)

        expect(refs).to include("trinity_sunday")
      end
    end

    context "for fixed date celebrations" do
      let(:christmas) do
        create(:celebration,
          name: "Natal",
          fixed_month: 12,
          fixed_day: 25,
          movable: false,
          prayer_book: prayer_book)
      end

      it "builds references for Christmas" do
        builder = described_class.new(Date.new(2025, 12, 25), calendar: calendar)
        refs = builder.celebration_references(christmas)

        expect(refs).to include("december_25")
        expect(refs).to include("christmas_day")
        expect(refs).to include("christmas")
      end
    end
  end

  describe "weekday name calculation" do
    it "returns correct weekday for Monday" do
      builder = described_class.new(Date.new(2025, 12, 1), calendar: calendar)
      refs = builder.weekly_references

      # Should contain a reference ending with _monday
      expect(refs.any? { |r| r.end_with?("_monday") }).to be true
    end

    it "returns correct weekday for Thursday" do
      builder = described_class.new(Date.new(2025, 12, 4), calendar: calendar)
      refs = builder.weekly_references

      expect(refs.any? { |r| r.end_with?("_thursday") }).to be true
    end

    it "returns correct weekday for Saturday" do
      builder = described_class.new(Date.new(2025, 12, 6), calendar: calendar)
      refs = builder.weekly_references

      expect(refs.any? { |r| r.end_with?("_saturday") }).to be true
    end
  end

  describe "most recent Sunday calculation" do
    it "uses same date for Sunday" do
      sunday = Date.new(2025, 12, 7)
      builder = described_class.new(sunday, calendar: calendar)

      # This is tested indirectly through weekly_references
      refs = builder.weekly_references

      # For Sunday, weekly_references might be empty or have Sunday-based refs
      expect(refs).to be_an(Array)
    end

    it "finds previous Sunday for Monday" do
      monday = Date.new(2025, 12, 8)
      builder = described_class.new(monday, calendar: calendar)

      refs = builder.weekly_references

      # Should have reference based on 2nd Sunday of Advent (Dec 7)
      expect(refs.any? { |r| r.include?("2nd_sunday_of_advent") }).to be true
    end

    it "finds previous Sunday for Saturday" do
      saturday = Date.new(2025, 12, 6)
      builder = described_class.new(saturday, calendar: calendar)

      refs = builder.weekly_references

      # Should have reference based on 1st Sunday of Advent (Nov 30)
      expect(refs.any? { |r| r.include?("1st_sunday_of_advent") }).to be true
    end
  end
end
