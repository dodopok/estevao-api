# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reading::Loc2015Service do
  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: "loc_2015") do |pb|
      pb.name = "Livro de Oração Comum 2015"
      pb.year = 2015
      pb.is_recommended = true
      pb.features = {
        "lectionary" => {
          "reading_types" => %w[semicontinuous complementary],
          "default_reading_type" => "semicontinuous"
        }
      }
    end
  end

  describe "IEAB lectionary logic" do
    # The IEAB lectionary follows a specific pattern:
    # - Thu/Fri/Sat: PREPARATION readings for the NEXT Sunday
    # - Mon/Tue/Wed: REFLECTION readings on the PREVIOUS Sunday

    describe "#find_ieab_reference_sunday" do
      context "on preparation days (Thu/Fri/Sat)" do
        it "returns the NEXT Sunday for Thursday" do
          # Thursday 2025-12-04 -> Next Sunday is 2025-12-07
          date = Date.new(2025, 12, 4)
          service = described_class.new(date)

          reference_sunday = service.send(:find_ieab_reference_sunday)

          expect(reference_sunday).to eq(Date.new(2025, 12, 7))
        end

        it "returns the NEXT Sunday for Friday" do
          # Friday 2025-12-05 -> Next Sunday is 2025-12-07
          date = Date.new(2025, 12, 5)
          service = described_class.new(date)

          reference_sunday = service.send(:find_ieab_reference_sunday)

          expect(reference_sunday).to eq(Date.new(2025, 12, 7))
        end

        it "returns the NEXT Sunday for Saturday" do
          # Saturday 2025-12-06 -> Next Sunday is 2025-12-07
          date = Date.new(2025, 12, 6)
          service = described_class.new(date)

          reference_sunday = service.send(:find_ieab_reference_sunday)

          expect(reference_sunday).to eq(Date.new(2025, 12, 7))
        end
      end

      context "on reflection days (Mon/Tue/Wed)" do
        it "returns the PREVIOUS Sunday for Monday" do
          # Monday 2025-12-08 -> Previous Sunday is 2025-12-07
          date = Date.new(2025, 12, 8)
          service = described_class.new(date)

          reference_sunday = service.send(:find_ieab_reference_sunday)

          expect(reference_sunday).to eq(Date.new(2025, 12, 7))
        end

        it "returns the PREVIOUS Sunday for Tuesday" do
          # Tuesday 2025-12-09 -> Previous Sunday is 2025-12-07
          date = Date.new(2025, 12, 9)
          service = described_class.new(date)

          reference_sunday = service.send(:find_ieab_reference_sunday)

          expect(reference_sunday).to eq(Date.new(2025, 12, 7))
        end

        it "returns the PREVIOUS Sunday for Wednesday" do
          # Wednesday 2025-12-10 -> Previous Sunday is 2025-12-07
          date = Date.new(2025, 12, 10)
          service = described_class.new(date)

          reference_sunday = service.send(:find_ieab_reference_sunday)

          expect(reference_sunday).to eq(Date.new(2025, 12, 7))
        end
      end
    end

    describe "#build_weekly_date_references" do
      context "on Thursday of 1st week of Advent (preparation for 2nd Sunday)" do
        it "generates references for 2nd Sunday of Advent" do
          # Thursday 2025-12-04 is after 1st Sunday of Advent (Nov 30)
          # and before 2nd Sunday of Advent (Dec 7)
          # So it should reference the 2nd Sunday (preparation)
          date = Date.new(2025, 12, 4)
          service = described_class.new(date)

          refs = service.send(:build_weekly_date_references)

          expect(refs).to include("2nd_sunday_of_advent_thursday")
        end
      end

      context "on Monday after 2nd Sunday of Advent (reflection)" do
        it "generates references for 2nd Sunday of Advent" do
          # Monday 2025-12-08 is after 2nd Sunday of Advent (Dec 7)
          # So it should reference the 2nd Sunday (reflection)
          date = Date.new(2025, 12, 8)
          service = described_class.new(date)

          refs = service.send(:build_weekly_date_references)

          expect(refs).to include("2nd_sunday_of_advent_monday")
        end
      end
    end

    describe "#find_readings with test data" do
      let!(:advent_2nd_sunday_thursday_reading) do
        create(:lectionary_reading,
               prayer_book: prayer_book,
               date_reference: "2nd_sunday_of_advent_thursday",
               cycle: "A",
               service_type: "weekly",
               reading_type: "semicontinuous",
               psalm: "Salmo 72.1-7; 18-19",
               first_reading: "Isaías 4.2-6",
               second_reading: "Atos 1.12-17, 21-26")
      end

      it "finds correct readings for Thursday Dec 4, 2025 (preparation for 2nd Advent)" do
        date = Date.new(2025, 12, 4)
        service = described_class.new(date)

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:psalm][:reference]).to eq("Salmo 72.1-7; 18-19")
        expect(readings[:first_reading][:reference]).to eq("Isaías 4.2-6")
        expect(readings[:second_reading][:reference]).to eq("Atos 1.12-17, 21-26")
      end
    end
  end

  describe "preparation vs reflection days" do
    it "correctly identifies Thursday as preparation day" do
      service = described_class.new(Date.new(2025, 12, 4)) # Thursday
      expect(service.send(:preparation_day?)).to be true
      expect(service.send(:reflection_day?)).to be false
    end

    it "correctly identifies Friday as preparation day" do
      service = described_class.new(Date.new(2025, 12, 5)) # Friday
      expect(service.send(:preparation_day?)).to be true
      expect(service.send(:reflection_day?)).to be false
    end

    it "correctly identifies Saturday as preparation day" do
      service = described_class.new(Date.new(2025, 12, 6)) # Saturday
      expect(service.send(:preparation_day?)).to be true
      expect(service.send(:reflection_day?)).to be false
    end

    it "correctly identifies Monday as reflection day" do
      service = described_class.new(Date.new(2025, 12, 8)) # Monday
      expect(service.send(:preparation_day?)).to be false
      expect(service.send(:reflection_day?)).to be true
    end

    it "correctly identifies Tuesday as reflection day" do
      service = described_class.new(Date.new(2025, 12, 9)) # Tuesday
      expect(service.send(:preparation_day?)).to be false
      expect(service.send(:reflection_day?)).to be true
    end

    it "correctly identifies Wednesday as reflection day" do
      service = described_class.new(Date.new(2025, 12, 10)) # Wednesday
      expect(service.send(:preparation_day?)).to be false
      expect(service.send(:reflection_day?)).to be true
    end

    it "Sunday is neither preparation nor reflection" do
      service = described_class.new(Date.new(2025, 12, 7)) # Sunday
      expect(service.send(:preparation_day?)).to be false
      expect(service.send(:reflection_day?)).to be false
    end
  end
end
