# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liturgical Color Precedence Rules", type: :integration do
  let(:prayer_book) { PrayerBook.find_by(code: "loc_2015") || create(:prayer_book, code: "loc_2015") }

  before(:each) do
    # Clear cache before each test to ensure fresh calculations
    Rails.cache.clear
  end

  describe "Anglican liturgical precedence and color rules" do
    context "Rule 1: Principal feasts override everything" do
      it "uses white for Annunciation even during Holy Week (transferred)" do
        # ID 01/02: Annunciation transferred to after Easter Octave should be white
        calendar_2024 = LiturgicalCalendar.new(2024, prayer_book_code: "loc_2015")

        # March 25, 2024 is Monday of Holy Week - verify season
        holy_week_date = Date.new(2024, 3, 25)
        expect(calendar_2024.season_for_date(holy_week_date)).to eq("Quaresma")

        # Annunciation transferred to April 8, 2024 (after Easter Octave)
        transferred_date = Date.new(2024, 4, 8)
        annunciation_celebration = {
          name: "Anunciação do Senhor",
          type: "principal_feast",
          rank: 10,
          color: "branco",
          transferred: true
        }

        allow(calendar_2024).to receive(:celebration_for_date).with(transferred_date).and_return(annunciation_celebration)

        color = calendar_2024.color_for_date(transferred_date)
        expect(color).to eq("branco")
      end

      it "uses white for Transfiguration even on a Sunday" do
        # ID 05: Transfiguration on August 6 (Sunday) - principal feast overrides Sunday
        calendar_2023 = LiturgicalCalendar.new(2023, prayer_book_code: "loc_2015")
        date = Date.new(2023, 8, 6)

        expect(date).to be_sunday

        transfiguration_celebration = {
          name: "Transfiguração de Nosso Senhor Jesus Cristo",
          type: "principal_feast",
          rank: 10,
          color: "branco"
        }

        allow(calendar_2023).to receive(:celebration_for_date).with(date).and_return(transfiguration_celebration)

        color = calendar_2023.color_for_date(date)
        expect(color).to eq("branco")
      end

      it "uses white for All Saints even when it falls on Sunday" do
        # ID 08: All Saints (Nov 1) on Sunday - overrides common Sunday
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        date = Date.new(2026, 11, 1)

        expect(date).to be_sunday

        all_saints_celebration = {
          name: "Todos os Santos",
          type: "principal_feast",
          rank: 10,
          color: "branco"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(date).and_return(all_saints_celebration)

        color = calendar_2026.color_for_date(date)
        expect(color).to eq("branco")
      end
    end

    context "Rule 2: Sundays in major seasons override lesser feasts" do
      it "uses purple for 1st Sunday of Lent over any lesser feast" do
        # ID 20: 1st Sunday of Lent - Sunday in penitential season overrides saints
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        date = Date.new(2026, 2, 22)

        expect(date).to be_sunday
        expect(calendar_2026.season_for_date(date)).to eq("Quaresma")

        # Even if there's a lesser feast, Sunday season color takes precedence
        lesser_feast_celebration = {
          name: "Santo Menor",
          type: "lesser_feast",
          rank: 4,
          color: "branco"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(date).and_return(lesser_feast_celebration)

        color = calendar_2026.color_for_date(date)
        expect(color).to eq("roxo")
      end
    end

    context "Rule 3: Major feasts on weekdays use celebration color" do
      it "uses red for St. Matthias during Lent weekday" do
        # ID 03: St. Matthias (Apostle) on February 24 (weekday in Lent)
        # Apostle feast (red) overrides Lenten purple on weekdays
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        date = Date.new(2026, 2, 24)

        expect(date).not_to be_sunday
        expect(calendar_2026.season_for_date(date)).to eq("Quaresma")

        matthias_celebration = {
          name: "São Matias, Apóstolo",
          type: "major_holy_day",
          rank: 8,
          color: "vermelho"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(date).and_return(matthias_celebration)

        color = calendar_2026.color_for_date(date)
        expect(color).to eq("vermelho")
      end

      it "uses white for St. Joseph during Lent weekday" do
        # ID 11: St. Joseph (March 19) during Lent - major feast overrides season
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        date = Date.new(2026, 3, 19)

        expect(date).not_to be_sunday # Thursday
        expect(calendar_2026.season_for_date(date)).to eq("Quaresma")

        joseph_celebration = {
          name: "São José",
          type: "major_holy_day",
          rank: 8,
          color: "branco"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(date).and_return(joseph_celebration)

        color = calendar_2026.color_for_date(date)
        expect(color).to eq("branco")
      end
    end

    context "Rule 4: Apostles override common Sundays" do
      it "uses red for SS. Peter and Paul even on Sunday" do
        # ID 15: SS. Peter and Paul (June 29) on Sunday - apostles override
        calendar_2025 = LiturgicalCalendar.new(2025, prayer_book_code: "loc_2015")
        date = Date.new(2025, 6, 29)

        expect(date).to be_sunday

        peter_paul_celebration = {
          name: "São Pedro e São Paulo, Apóstolos",
          type: "major_holy_day",
          rank: 8,
          color: "vermelho"
        }

        allow(calendar_2025).to receive(:celebration_for_date).with(date).and_return(peter_paul_celebration)

        color = calendar_2025.color_for_date(date)
        expect(color).to eq("vermelho")
      end

      it "uses white for Conversion of St. Paul on Sunday" do
        # ID 18: Conversion of St. Paul (January 25) on Sunday
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        date = Date.new(2026, 1, 25)

        expect(date).to be_sunday

        paul_conversion_celebration = {
          name: "Conversão de São Paulo",
          type: "major_holy_day",
          rank: 8,
          color: "branco"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(date).and_return(paul_conversion_celebration)

        color = calendar_2026.color_for_date(date)
        expect(color).to eq("branco")
      end
    end

    context "Rule 5: Movable principal feasts" do
      it "uses purple for Ash Wednesday" do
        # ID 10: Ash Wednesday - absolute precedence
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        ash_wednesday = calendar_2026.easter_calc.ash_wednesday

        # Ash Wednesday doesn't need a celebration mock - it's determined by season
        # The season color itself is purple for this day
        color = calendar_2026.color_for_date(ash_wednesday)
        expect(color).to eq("roxo")
      end

      it "uses white for Ascension Thursday" do
        # ID 21: Ascension Thursday - principal feast
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        ascension = calendar_2026.easter_calc.ascension

        # Ascension is during Easter season which is already white
        # But we mock it to ensure the principal feast logic is tested
        ascension_celebration = {
          name: "Ascensão do Senhor",
          type: "principal_feast",
          rank: 10,
          color: "branco"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(ascension).and_return(ascension_celebration)

        color = calendar_2026.color_for_date(ascension)
        expect(color).to eq("branco")
      end

      it "uses red for Pentecost even when Visitation conflicts" do
        # ID 12: Pentecost (May 31) vs Visitation - Pentecost wins
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        pentecost = calendar_2026.easter_calc.pentecost

        # Pentecost is a principal feast with red, even if Visitation (white) also falls here
        pentecost_celebration = {
          name: "Pentecostes",
          type: "principal_feast",
          rank: 10,
          color: "vermelho"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(pentecost).and_return(pentecost_celebration)

        color = calendar_2026.color_for_date(pentecost)
        expect(color).to eq("vermelho")
      end
    end

    context "Rule 6: Special seasons and days" do
      it "uses purple/violet for 4th Sunday of Advent morning" do
        # ID 06: December 24, 2025 (4th Sunday of Advent, morning)
        calendar_2025 = LiturgicalCalendar.new(2025, prayer_book_code: "loc_2015")
        date = Date.new(2025, 12, 24)

        # During the day, it's still Advent
        expect(calendar_2025.season_for_date(date)).to eq("Advento")

        # Season-based color (no celebration mock needed)
        color = calendar_2025.color_for_date(date)
        expect(color).to eq("violeta")
      end

      it "uses white for Holy Name of Jesus (Octave of Christmas)" do
        # ID 19: January 1 - Holy Name within Christmas Octave
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        date = Date.new(2026, 1, 1)

        expect(calendar_2026.season_for_date(date)).to eq("Natal")

        holy_name_celebration = {
          name: "Santo Nome de Jesus",
          type: "major_holy_day",
          rank: 8,
          color: "branco"
        }

        allow(calendar_2026).to receive(:celebration_for_date).with(date).and_return(holy_name_celebration)

        color = calendar_2026.color_for_date(date)
        expect(color).to eq("branco")
      end

      it "uses red for Good Friday" do
        # ID 16: Good Friday - apex of Holy Week
        calendar_2026 = LiturgicalCalendar.new(2026, prayer_book_code: "loc_2015")
        good_friday = calendar_2026.easter_calc.good_friday

        # Good Friday color is determined by season (Holy Week)
        # No celebration mock needed - the season itself dictates red
        color = calendar_2026.color_for_date(good_friday)
        expect(color).to eq("vermelho")
      end
    end

    context "Rule 7: Lesser feasts behavior" do
      it "uses season color for lesser feast on Sunday" do
        # Lesser feast on Sunday should use season color, not feast color
        calendar_2025 = LiturgicalCalendar.new(2025, prayer_book_code: "loc_2015")
        # November 16, 2025 - Sunday with Margaret of Scotland (lesser feast)
        date = Date.new(2025, 11, 16)

        expect(date).to be_sunday
        expect(calendar_2025.season_for_date(date)).to eq("Tempo Comum")

        margaret_celebration = {
          name: "Margarida da Escócia",
          type: "lesser_feast",
          rank: 4,
          color: "branco"
        }

        allow(calendar_2025).to receive(:celebration_for_date).with(date).and_return(margaret_celebration)

        # Sunday takes precedence - should use season green, not celebration white
        color = calendar_2025.color_for_date(date)
        expect(color).to eq("verde")
      end

      it "uses celebration color for lesser feast on weekday" do
        # Lesser feast on weekday should use celebration color
        calendar_2025 = LiturgicalCalendar.new(2025, prayer_book_code: "loc_2015")
        # January 13, 2025 - Monday with Hilary of Poitiers
        date = Date.new(2025, 1, 13)

        expect(date).not_to be_sunday
        expect(calendar_2025.season_for_date(date)).to eq("Epifania")

        hilary_celebration = {
          name: "Hilário de Poitiers",
          type: "lesser_feast",
          rank: 4,
          color: "branco"
        }

        allow(calendar_2025).to receive(:celebration_for_date).with(date).and_return(hilary_celebration)

        # Weekday lesser feast uses celebration color
        color = calendar_2025.color_for_date(date)
        expect(color).to eq("branco")
      end
    end
  end

  describe "Edge cases and special scenarios" do
    it "handles transferred celebrations correctly" do
      # When a celebration is transferred, it should maintain its original color
      # even in a different liturgical context
      calendar_2024 = LiturgicalCalendar.new(2024, prayer_book_code: "loc_2015")

      # Example: A principal feast transferred from Lent to Easter season
      # should still use its original white color
      transferred_date = Date.new(2024, 4, 8)
      expect(calendar_2024.season_for_date(transferred_date)).to eq("Páscoa")

      transferred_celebration = {
        name: "Festa Transferida",
        type: "principal_feast",
        rank: 10,
        color: "branco",
        transferred: true
      }

      allow(calendar_2024).to receive(:celebration_for_date).with(transferred_date).and_return(transferred_celebration)

      color = calendar_2024.color_for_date(transferred_date)
      expect(color).to eq("branco")
    end

    it "handles multiple celebrations on same day by rank" do
      # When multiple celebrations fall on the same day,
      # higher rank should determine the color
      calendar_2025 = LiturgicalCalendar.new(2025, prayer_book_code: "loc_2015")
      date = Date.new(2025, 5, 31) # Pentecost conflicts with Visitation

      # The celebration_for_date should already return the highest-rank celebration
      # In this case, Pentecost (principal feast) wins over Visitation (major holy day)
      highest_rank_celebration = {
        name: "Pentecostes",
        type: "principal_feast",
        rank: 10,
        color: "vermelho"
      }

      allow(calendar_2025).to receive(:celebration_for_date).with(date).and_return(highest_rank_celebration)

      color = calendar_2025.color_for_date(date)
      expect(color).to eq("vermelho")
    end
  end
end
