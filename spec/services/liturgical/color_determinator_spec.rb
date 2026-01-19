# frozen_string_literal: true

require "rails_helper"

RSpec.describe Liturgical::ColorDeterminator do
  let(:year) { 2025 }
  let(:easter_calc) { Liturgical::EasterCalculator.new(year) }
  let(:season_determinator) { Liturgical::SeasonDeterminator.new(year, easter_calc: easter_calc) }
  let(:color_determinator) do
    described_class.new(
      season_determinator: season_determinator,
      easter_calc: easter_calc
    )
  end

  describe "#color_for" do
    context "with principal celebration" do
      it "returns celebration color for principal_feast" do
        date = Date.new(2025, 12, 25)
        celebration = { color: "branco", type: "principal_feast" }

        expect(color_determinator.color_for(date, celebration: celebration)).to eq("branco")
      end

      it "returns celebration color for major_holy_day" do
        date = Date.new(2025, 6, 24)
        celebration = { color: "branco", type: "major_holy_day" }

        expect(color_determinator.color_for(date, celebration: celebration)).to eq("branco")
      end

      it "uses season color for festivals on Sundays" do
        # A festival on Sunday should use season's color, not festival's color
        # Only principal feasts and major holy days override Sundays
        date = Date.new(2025, 6, 15) # Sunday in Ordinary Time
        celebration = { color: "branco", type: "festival" }

        expect(date).to be_sunday
        expect(color_determinator.color_for(date, celebration: celebration)).to eq("verde")
      end

      it "uses celebration color for festivals on weekdays" do
        # A festival on weekday should use festival's color
        date = Date.new(2025, 6, 16) # Monday in Ordinary Time
        celebration = { color: "vermelho", type: "festival" }

        expect(date).not_to be_sunday
        expect(color_determinator.color_for(date, celebration: celebration)).to eq("vermelho")
      end

      it "uses celebration color for lesser_feast on weekdays" do
        # Lesser feast during Epiphany on a weekday - should use feast's white color
        date = Date.new(2025, 1, 13) # Monday in Epiphany
        celebration = { color: "branco", type: "lesser_feast" }

        expect(date).not_to be_sunday
        expect(color_determinator.color_for(date, celebration: celebration)).to eq("branco")
      end

      it "ignores lesser_feast color on Sundays" do
        # Lesser feast on Sunday - should use season's green color, not feast's white
        date = Date.new(2025, 11, 16) # Sunday in Ordinary Time with Margaret of Scotland
        celebration = { color: "branco", type: "lesser_feast" }

        expect(date).to be_sunday
        expect(color_determinator.color_for(date, celebration: celebration)).to eq("verde")
      end

      it "uses celebration color for commemoration on weekdays" do
        # Commemoration during Ordinary Time on weekday - should use commemoration's color
        date = Date.new(2025, 7, 15) # Tuesday in Ordinary Time
        celebration = { color: "branco", type: "commemoration" }

        expect(date).not_to be_sunday
        expect(color_determinator.color_for(date, celebration: celebration)).to eq("branco")
      end

      it "uses celebration color for transferred celebrations" do
        # Transferred celebration should maintain its original color
        date = Date.new(2025, 3, 25) # Annunciation during Lent
        celebration = { color: "branco", type: "principal_feast", transferred: true }

        expect(color_determinator.color_for(date, celebration: celebration)).to eq("branco")
      end
    end

    context "during Advent" do
      it "returns violet for most Advent days" do
        # First Sunday of Advent 2025
        date = Date.new(2025, 11, 30)
        expect(color_determinator.color_for(date)).to eq("violeta")
      end

      it "returns rose for Gaudete Sunday (Third Sunday of Advent)" do
        # Third Sunday of Advent 2025 (Gaudete Sunday)
        gaudete = easter_calc.first_sunday_of_advent + 14.days
        expect(color_determinator.color_for(gaudete)).to eq("rosa")
      end
    end

    context "during Christmas" do
      it "returns white for Christmas season" do
        date = Date.new(2025, 12, 25)
        expect(color_determinator.color_for(date)).to eq("branco")
      end

      it "returns white for days after Christmas" do
        date = Date.new(2025, 12, 28)
        expect(color_determinator.color_for(date)).to eq("branco")
      end
    end

    context "during Lent" do
      it "returns purple for regular Lent days" do
        # A day in Lent before Holy Week
        date = easter_calc.ash_wednesday + 10.days
        expect(color_determinator.color_for(date)).to eq("roxo")
      end

      it "returns rose for Laetare Sunday (Fourth Sunday in Lent)" do
        laetare = easter_calc.first_sunday_in_lent + 21.days
        expect(color_determinator.color_for(laetare)).to eq("rosa")
      end

      it "returns red for Palm Sunday" do
        expect(color_determinator.color_for(easter_calc.palm_sunday)).to eq("vermelho")
      end

      it "returns red for Holy Monday" do
        expect(color_determinator.color_for(easter_calc.holy_monday)).to eq("vermelho")
      end

      it "returns red for Good Friday" do
        expect(color_determinator.color_for(easter_calc.good_friday)).to eq("vermelho")
      end
    end

    context "during Easter" do
      it "returns white for Easter Day" do
        expect(color_determinator.color_for(easter_calc.easter_date)).to eq("branco")
      end

      it "returns white for Pentecost" do
        expect(color_determinator.color_for(easter_calc.pentecost)).to eq("branco")
      end
    end

    context "during Ordinary Time" do
      it "returns green for Ordinary Time" do
        # A day in Ordinary Time after Pentecost
        date = easter_calc.trinity_sunday + 7.days
        expect(color_determinator.color_for(date)).to eq("verde")
      end
    end

    context "during Epiphany season" do
      it "returns green for Epiphany season" do
        # A day after Baptism but before Lent
        date = easter_calc.baptism_of_the_lord + 7.days
        expect(color_determinator.color_for(date)).to eq("verde")
      end
    end

    context "with nil celebration" do
      it "returns season color when celebration is nil" do
        date = Date.new(2025, 12, 25)
        expect(color_determinator.color_for(date, celebration: nil)).to eq("branco")
      end
    end
  end
end
