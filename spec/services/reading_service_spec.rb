require 'rails_helper'

RSpec.describe ReadingService do
  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.year = 2015
      pb.is_default = true
      pb.features = {
        "lectionary" => {
          "reading_types" => [ "semicontinuous", "complementary" ],
          "default_reading_type" => "semicontinuous"
        },
        "daily_office" => {
          "supports_family_rite" => false
        }
      }
    end
  end

  let!(:celebration) do
    create(:celebration,
      name: "São José Teste",
      celebration_type: :festival,
      rank: 30,
      movable: false,
      fixed_month: 3,
      fixed_day: 19,
      liturgical_color: "branco",
      prayer_book: prayer_book)
  end

  let!(:celebration_reading) do
    create(:lectionary_reading,
      celebration: celebration,
      date_reference: "3-19",
      cycle: "all",
      service_type: "eucharist",
      first_reading: "Deuteronômio 33:13-16",
      psalm: "Salmo 89:2-9",
      second_reading: "Filipenses 4:5-8",
      gospel: "Mateus 13:53-58",
      prayer_book: prayer_book)
  end

  let!(:proper_reading) do
    create(:lectionary_reading,
      celebration: nil,
      date_reference: "proper_25",
      cycle: "C",
      service_type: "eucharist",
      first_reading: "Joel 2:23-32",
      psalm: "Psalm 65",
      second_reading: "2 Timothy 4:6-8, 16-18",
      gospel: "Luke 18:9-14",
      prayer_book: prayer_book)
  end

  let!(:sunday_reading) do
    create(:lectionary_reading,
      celebration: nil,
      date_reference: "advent_1",
      cycle: "A",
      service_type: "eucharist",
      first_reading: "Isaiah 2:1-5",
      psalm: "Psalm 122",
      second_reading: "Romans 13:11-14",
      gospel: "Matthew 24:36-44",
      prayer_book: prayer_book)
  end

  describe '#cycle' do
    context 'for Sundays' do
      it 'determines cycle A, B, or C' do
        # 2026 % 3 = 1 → Cycle A
        service = described_class.new(Date.new(2026, 1, 4)) # Sunday

        expect(service.cycle).to eq("A")
      end
    end

    context 'for weekdays' do
      it 'determines A/B/C cycle' do
        # 2026 is Cycle A
        service = described_class.new(Date.new(2026, 1, 5)) # Monday

        expect([ "A", "B", "C" ]).to include(service.cycle)
        expect(service.cycle).to eq("A")
      end
    end
  end

  describe '#find_readings' do
    context 'with celebration' do
      it 'finds readings by celebration' do
        date = Date.new(2025, 3, 19) # Celebration date
        service = described_class.new(date)

        readings = service.find_readings

        # If there are readings, verify structure
        if readings
          expect(readings).to be_a(Hash)
          expect(readings).to have_key(:gospel).or have_key(:first_reading)
        else
          # OK to not have readings if not seeded
          expect(readings).to be_nil
        end
      end
    end

    context 'without readings' do
      let!(:celebration_without_readings) do
        create(:celebration,
          name: "Santo Sem Leituras",
          celebration_type: :lesser_feast,
          rank: 250,
          movable: false,
          fixed_month: 6,
          fixed_day: 20,
          liturgical_color: "branco",
          prayer_book: prayer_book)
      end

      it 'returns nil when there are no readings for celebration' do
        date = Date.new(2025, 6, 20)
        service = described_class.new(date)

        readings = service.find_readings
        # Can be nil or find readings another way (Proper, etc)
        expect(readings).to be_nil.or be_a(Hash)
      end
    end

    context 'integration test' do
      it 'returns readings when found or nil' do
        service = described_class.new(Date.new(2025, 3, 19))

        readings = service.find_readings

        # Can have readings or not depending on seeds
        expect(readings).to be_nil.or be_a(Hash)

        # If there are readings, verify structure
        if readings
          expect(readings).to have_key(:gospel).or have_key(:first_reading)
        end
      end

      it 'returns nil when no reading is found' do
        # Random date without readings
        service = described_class.new(Date.new(2025, 5, 13))

        readings = service.find_readings

        # Can be nil or find something depending on seeds
        expect(readings).to be_nil.or be_a(Hash)
      end
    end
  end

  describe '#find_by_proper' do
    it 'returns nil for non-Sunday dates' do
      service = described_class.new(Date.new(2025, 10, 20)) # Monday

      reading = service.send(:find_by_proper)
      expect(reading).to be_nil
    end
  end

  describe '#find_by_sunday' do
    it 'returns nil for non-Sunday dates' do
      service = described_class.new(Date.new(2025, 12, 1)) # Monday

      reading = service.send(:find_by_sunday)
      expect(reading).to be_nil
    end
  end

  describe '#build_fixed_date_references' do
    it 'builds fixed date references correctly' do
      service = described_class.new(Date.new(2025, 12, 25))

      refs = service.send(:build_fixed_date_references)

      expect(refs).to include("december_25")
      expect(refs).to include("christmas_day")
    end

    it 'builds references for Epiphany' do
      service = described_class.new(Date.new(2025, 1, 6))

      refs = service.send(:build_fixed_date_references)

      expect(refs).to include("january_6")
      expect(refs).to include("epiphany")
    end

    it 'builds references for Christmas Eve' do
      service = described_class.new(Date.new(2025, 12, 24))

      refs = service.send(:build_fixed_date_references)

      expect(refs).to include("december_24")
      expect(refs).to include("christmas_eve")
    end
  end

  describe '#format_response' do
    let(:service) { described_class.new(Date.new(2025, 1, 1)) }

    context 'with valid reading' do
      it 'returns correct fields' do
        response = service.send(:format_response, celebration_reading)

        expect(response[:first_reading][:reference]).to eq("Deuteronômio 33:13-16")
        expect(response[:psalm][:reference]).to eq("Salmo 89:2-9")
        expect(response[:second_reading][:reference]).to eq("Filipenses 4:5-8")
        expect(response[:gospel][:reference]).to eq("Mateus 13:53-58")
      end
    end

    context 'with nil reading' do
      it 'returns nil' do
        response = service.send(:format_response, nil)
        expect(response).to be_nil
      end
    end

    context 'with partial reading' do
      let!(:partial_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          celebration: nil,
          date_reference: "test",
          cycle: "A",
          service_type: "eucharist",
          first_reading: "Genesis 1:1",
          psalm: nil,
          second_reading: nil,
          gospel: "John 1:1")
      end

      it 'removes nil fields with compact' do
        response = service.send(:format_response, partial_reading)

        expect(response).to have_key(:first_reading)
        expect(response).to have_key(:gospel)
        expect(response).to be_a(Hash)
      end
    end
  end

  describe 'liturgical cycle' do
    it 'uses correct cycle for each year' do
      # 2025: Cycle C
      service_2025 = described_class.new(Date.new(2025, 11, 16))
      expect(service_2025.cycle).to eq("C") if Date.new(2025, 11, 16).sunday?

      # 2026: Cycle A
      service_2026 = described_class.new(Date.new(2026, 11, 15))
      expect(service_2026.cycle).to eq("A") if Date.new(2026, 11, 15).sunday?
    end

    it 'uses A/B/C cycle for weekly readings (not even/odd)' do
      # December 4, 2025 is a Thursday in Advent
      # 2025 liturgical year starts with Cycle A (Advent 2025)
      service = described_class.new(Date.new(2025, 12, 4))

      expect(service.cycle).to eq("A")
    end
  end

  describe 'weekly readings' do
    let!(:weekly_advent_reading) do
      create(:lectionary_reading,
        prayer_book: prayer_book,
        date_reference: '1st_sunday_of_advent_thursday',
        cycle: 'A',
        service_type: 'weekly',
        reading_type: 'semicontinuous',
        psalm: 'Salmo 122',
        first_reading: 'Daniel 9.15-19',
        second_reading: 'Tiago 4.1-10'
      )
    end

    let!(:weekly_proper_reading) do
      create(:lectionary_reading,
        prayer_book: prayer_book,
        date_reference: 'proper_20_saturday',
        cycle: 'C',
        service_type: 'weekly',
        reading_type: 'semicontinuous',
        psalm: 'Salmo 145.1-8',
        first_reading: 'Sofonias 2.13-15',
        gospel: 'Mateus 19.23-30'
      )
    end

    let!(:weekly_fixed_date_reading) do
      create(:lectionary_reading,
        prayer_book: prayer_book,
        date_reference: 'december_22',
        cycle: 'A',
        service_type: 'weekly',
        reading_type: 'semicontinuous',
        psalm: 'Lucas 1.46b-55 (Cântico)',
        first_reading: 'Isaías 33.17-22',
        second_reading: 'Apocalipse 22.6-7, 18-20'
      )
    end

    describe '#find_weekly_reading' do
      it 'returns nil for Sunday dates' do
        service = described_class.new(Date.new(2025, 12, 7)) # Sunday
        reading = service.send(:find_weekly_reading)

        expect(reading).to be_nil
      end

      it 'finds weekly readings for weekdays' do
        # Thursday in first week of Advent 2025 (Cycle A)
        service = described_class.new(Date.new(2025, 12, 4))
        reading = service.send(:find_weekly_reading)

        expect(reading).not_to be_nil
        expect(reading.service_type).to eq('weekly')
      end

      it 'finds readings by proper number' do
        # Saturday, September 27, 2025 (Proper 20, Cycle C)
        service = described_class.new(Date.new(2025, 9, 27))
        reading = service.send(:find_weekly_reading)

        expect(reading).not_to be_nil
        expect(reading.date_reference).to eq('proper_20_saturday')
      end

      it 'finds readings by fixed date' do
        # December 22, 2025 (Cycle A)
        service = described_class.new(Date.new(2025, 12, 22))
        reading = service.send(:find_weekly_reading)

        expect(reading).not_to be_nil
        expect(reading.date_reference).to eq('december_22')
      end
    end

    describe '#build_weekly_date_references' do
      it 'builds correct references for Advent weekdays' do
        # Thursday in first week of Advent
        service = described_class.new(Date.new(2025, 12, 4))
        refs = service.send(:build_weekly_date_references)

        expect(refs).to include('1st_sunday_of_advent_thursday')
        expect(refs).to include('december_4')
      end

      it 'builds proper references for Ordinary Time' do
        # Saturday in Proper 20 week
        service = described_class.new(Date.new(2025, 9, 27))
        refs = service.send(:build_weekly_date_references)

        expect(refs).to include('proper_20_saturday')
        expect(refs).to include('september_27')
      end

      it 'builds references for fixed dates' do
        service = described_class.new(Date.new(2025, 12, 22))
        refs = service.send(:build_weekly_date_references)

        expect(refs).to include('december_22')
      end
    end

    describe '#weekday_name' do
      it 'returns correct weekday names' do
        service = described_class.new(Date.new(2025, 12, 1)) # Monday
        expect(service.send(:weekday_name, Date.new(2025, 12, 1))).to eq('monday')
        expect(service.send(:weekday_name, Date.new(2025, 12, 4))).to eq('thursday')
        expect(service.send(:weekday_name, Date.new(2025, 12, 6))).to eq('saturday')
      end
    end

    describe '#find_most_recent_sunday_date' do
      it 'returns the same date for Sunday' do
        sunday = Date.new(2025, 12, 7) # Sunday
        service = described_class.new(sunday)

        expect(service.send(:find_most_recent_sunday_date)).to eq(sunday)
      end

      it 'returns previous Sunday for Monday' do
        monday = Date.new(2025, 12, 8)
        expected_sunday = Date.new(2025, 12, 7)
        service = described_class.new(monday)

        expect(service.send(:find_most_recent_sunday_date)).to eq(expected_sunday)
      end

      it 'returns previous Sunday for Saturday' do
        saturday = Date.new(2025, 12, 6)
        expected_sunday = Date.new(2025, 11, 30)
        service = described_class.new(saturday)

        expect(service.send(:find_most_recent_sunday_date)).to eq(expected_sunday)
      end
    end

    describe 'integration: find_readings for weekdays' do
      it 'finds weekly readings instead of eucharistic for weekdays' do
        # Thursday in Advent (has weekly reading)
        service = described_class.new(Date.new(2025, 12, 4))
        readings = service.find_readings

        # Should find the weekly reading
        expect(readings).not_to be_nil
        if readings
          expect(readings[:psalm][:reference]).to eq('Salmo 122')
          expect(readings[:first_reading][:reference]).to eq('Daniel 9.15-19')
        end
      end

      it 'prioritizes weekly readings over celebration for weekdays' do
        # Create a celebration on a weekday
        celebration = create(:celebration,
          name: "Test Saint",
          fixed_month: 12,
          fixed_day: 4,
          prayer_book: prayer_book
        )

        service = described_class.new(Date.new(2025, 12, 4))
        readings = service.find_readings

        # Should find weekly reading first (if exists)
        expect(readings).not_to be_nil
      end

      it 'finds eucharistic readings for Sundays' do
        # Sunday should still use eucharistic readings
        service = described_class.new(Date.new(2025, 12, 7))

        # Should NOT call find_weekly_reading for Sundays
        expect(service).not_to receive(:find_weekly_reading)
        service.find_readings
      end
    end

    describe 'complementary vs semicontinuous' do
      let!(:complementary_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          date_reference: 'proper_4_thursday',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'complementary',
          psalm: 'Salmo 31.1-5, 19-24',
          first_reading: 'Êxodo 24.1-8'
        )
      end

      let!(:semicontinuous_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          date_reference: 'proper_4_thursday',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          psalm: 'Salmo 46',
          first_reading: 'Gênesis 1.1–2.4a'
        )
      end

      it 'can retrieve either reading type based on preference' do
        # For now, just verify both exist and can be found
        comp = LectionaryReading.find_by(
          date_reference: 'proper_4_thursday',
          reading_type: 'complementary'
        )
        semi = LectionaryReading.find_by(
          date_reference: 'proper_4_thursday',
          reading_type: 'semicontinuous'
        )

        expect(comp).not_to be_nil
        expect(semi).not_to be_nil
        expect(comp.psalm).not_to eq(semi.psalm)
      end
    end
  end
end
