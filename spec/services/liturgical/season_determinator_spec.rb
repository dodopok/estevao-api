# frozen_string_literal: true

require "rails_helper"

RSpec.describe Liturgical::SeasonDeterminator do
  describe "#season_for_date" do
    let(:year) { 2024 }
    let(:determinator) { described_class.new(year) }

    context "Advent season" do
      it "returns Advento for first Sunday of Advent" do
        # First Sunday of Advent 2024 is Dec 1
        date = Date.new(2024, 12, 1)
        expect(determinator.season_for_date(date)).to eq("Advento")
      end

      it "returns Advento for Christmas Eve" do
        date = Date.new(2024, 12, 24)
        expect(determinator.season_for_date(date)).to eq("Advento")
      end
    end

    context "Christmas season" do
      it "returns Natal for Christmas Day" do
        date = Date.new(2024, 12, 25)
        expect(determinator.season_for_date(date)).to eq("Natal")
      end

      it "returns Natal for January dates before Baptism of the Lord" do
        date = Date.new(2024, 1, 5)
        expect(determinator.season_for_date(date)).to eq("Natal")
      end
    end

    context "Epiphany season" do
      it "returns Epifania for dates after Baptism and before Ash Wednesday" do
        # In 2024, Baptism is Jan 7, Ash Wednesday is Feb 14
        date = Date.new(2024, 1, 20)
        expect(determinator.season_for_date(date)).to eq("Epifania")
      end
    end

    context "Lent season" do
      it "returns Quaresma for Ash Wednesday" do
        # Ash Wednesday 2024 is Feb 14
        date = Date.new(2024, 2, 14)
        expect(determinator.season_for_date(date)).to eq("Quaresma")
      end

      it "returns Quaresma for Holy Saturday" do
        # Holy Saturday 2024 is Mar 30
        date = Date.new(2024, 3, 30)
        expect(determinator.season_for_date(date)).to eq("Quaresma")
      end
    end

    context "Easter season" do
      it "returns Páscoa for Easter Sunday" do
        # Easter 2024 is Mar 31
        date = Date.new(2024, 3, 31)
        expect(determinator.season_for_date(date)).to eq("Páscoa")
      end

      it "returns Páscoa for Pentecost" do
        # Pentecost 2024 is May 19
        date = Date.new(2024, 5, 19)
        expect(determinator.season_for_date(date)).to eq("Páscoa")
      end
    end

    context "Ordinary Time" do
      it "returns Tempo Comum for dates after Pentecost" do
        date = Date.new(2024, 6, 15)
        expect(determinator.season_for_date(date)).to eq("Tempo Comum")
      end
    end
  end

  describe "#in_major_season?" do
    let(:year) { 2024 }
    let(:determinator) { described_class.new(year) }

    it "returns true for Advent" do
      date = Date.new(2024, 12, 8)
      expect(determinator.in_major_season?(date)).to be true
    end

    it "returns true for Christmas" do
      date = Date.new(2024, 12, 26)
      expect(determinator.in_major_season?(date)).to be true
    end

    it "returns true for Lent" do
      date = Date.new(2024, 3, 15)
      expect(determinator.in_major_season?(date)).to be true
    end

    it "returns true for Easter" do
      date = Date.new(2024, 4, 15)
      expect(determinator.in_major_season?(date)).to be true
    end

    it "returns false for Ordinary Time" do
      date = Date.new(2024, 7, 15)
      expect(determinator.in_major_season?(date)).to be false
    end

    it "returns false for Epiphany" do
      date = Date.new(2024, 2, 1)
      expect(determinator.in_major_season?(date)).to be false
    end
  end

  describe "#in_protected_period?" do
    let(:year) { 2024 }
    let(:determinator) { described_class.new(year) }

    it "returns true for Palm Sunday" do
      # Palm Sunday 2024 is Mar 24
      date = Date.new(2024, 3, 24)
      expect(determinator.in_protected_period?(date)).to be true
    end

    it "returns true for Good Friday" do
      date = Date.new(2024, 3, 29)
      expect(determinator.in_protected_period?(date)).to be true
    end

    it "returns true for Second Sunday of Easter" do
      # Second Sunday of Easter 2024 is Apr 7
      date = Date.new(2024, 4, 7)
      expect(determinator.in_protected_period?(date)).to be true
    end

    it "returns false for dates before Palm Sunday" do
      date = Date.new(2024, 3, 20)
      expect(determinator.in_protected_period?(date)).to be false
    end

    it "returns false for dates after Second Sunday of Easter" do
      date = Date.new(2024, 4, 10)
      expect(determinator.in_protected_period?(date)).to be false
    end
  end

  describe "MAJOR_SEASONS constant" do
    it "contains Advento, Natal, Quaresma, Páscoa" do
      expect(Liturgical::SeasonDeterminator::MAJOR_SEASONS).to contain_exactly(
        "Advento", "Natal", "Quaresma", "Páscoa"
      )
    end
  end
end
