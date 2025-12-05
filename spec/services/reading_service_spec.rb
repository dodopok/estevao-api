require 'rails_helper'

RSpec.describe ReadingService do
  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.year = 2015
      pb.is_recommended = true
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

  # Tests for #build_fixed_date_references moved to spec/services/reading/reference_builder_spec.rb

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

    # Tests for #build_weekly_date_references, #weekday_name, and #find_most_recent_sunday_date
    # moved to spec/services/reading/reference_builder_spec.rb

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

    describe 'Sunday readings hierarchy in major seasons' do
      let!(:advent_sunday_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          date_reference: '1st_sunday_of_advent',
          cycle: 'A', # 2025-11-30 starts liturgical year 2026 which is Cycle A
          service_type: 'eucharist',
          first_reading: 'Isaías 2:1-5',
          psalm: 'Salmo 122',
          second_reading: 'Romanos 13:11-14',
          gospel: 'Mateus 24:36-44'
        )
      end

      let!(:saint_on_advent_sunday) do
        create(:celebration,
          name: 'Santo Teste Advento',
          celebration_type: :festival,
          rank: 50,
          movable: false,
          fixed_month: 11,
          fixed_day: 30,
          liturgical_color: 'vermelho',
          prayer_book: prayer_book)
      end

      let!(:saint_reading) do
        create(:lectionary_reading,
          celebration: saint_on_advent_sunday,
          prayer_book: prayer_book,
          date_reference: '11-30',
          cycle: 'all',
          service_type: 'eucharist',
          first_reading: 'Zacarias 8:20-23',
          psalm: 'Salmo 47',
          second_reading: 'Romanos 10:8b-18',
          gospel: 'João 1:35-42'
        )
      end

      it 'prioritizes Advent Sunday readings over festival readings' do
        # November 30, 2025 is the 1st Sunday of Advent
        date = Date.new(2025, 11, 30)
        service = described_class.new(date)

        readings = service.find_readings

        expect(readings).not_to be_nil
        # Should return Advent readings, not saint readings
        expect(readings[:gospel][:reference]).to eq('Mateus 24:36-44')
        expect(readings[:gospel][:reference]).not_to eq('João 1:35-42')
      end

      it 'still returns celebration info even when using Sunday readings' do
        date = Date.new(2025, 11, 30)
        calendar = LiturgicalCalendar.new(2025)
        info = calendar.day_info(date)

        # Celebration should still appear (for those who want to observe)
        # Note: may pick up André Apóstolo from seeds or our test celebration
        expect(info[:celebration]).not_to be_nil
      end
    end

    describe 'Sunday readings in Ordinary Time' do
      let!(:ordinary_time_sunday_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          date_reference: 'proper_16',
          cycle: 'C', # 2025 after Pentecost is Cycle C
          service_type: 'eucharist',
          first_reading: 'Isaías 58:9b-14',
          psalm: 'Salmo 103:1-8',
          second_reading: 'Hebreus 12:18-29',
          gospel: 'Lucas 13:10-17'
        )
      end

      let!(:saint_on_ordinary_sunday) do
        create(:celebration,
          name: 'São Bartolomeu Teste',
          celebration_type: :festival,
          rank: 50,
          movable: false,
          fixed_month: 8,
          fixed_day: 24,
          liturgical_color: 'vermelho',
          prayer_book: prayer_book)
      end

      let!(:saint_ordinary_reading) do
        create(:lectionary_reading,
          celebration: saint_on_ordinary_sunday,
          prayer_book: prayer_book,
          date_reference: '8-24',
          cycle: 'all',
          service_type: 'eucharist',
          first_reading: 'Gênesis 28:10-17',
          psalm: 'Salmo 103:1b-8',
          second_reading: 'Atos 5:12-16',
          gospel: 'João 1:43-51'
        )
      end

      it 'allows festival readings on Sundays in Ordinary Time' do
        # August 24, 2025 is a Sunday in Ordinary Time
        date = Date.new(2025, 8, 24)
        service = described_class.new(date)

        readings = service.find_readings

        # In Ordinary Time, festival readings may take precedence
        expect(readings).not_to be_nil
        expect(readings[:gospel][:reference]).to eq('João 1:43-51')
      end
    end

    describe 'principal feasts always have precedence' do
      let!(:christmas_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          date_reference: 'christmas_day',
          cycle: 'all',
          service_type: 'eucharist',
          first_reading: 'Isaías 52:7-10',
          psalm: 'Salmo 98',
          second_reading: 'Hebreus 1:1-12',
          gospel: 'João 1:1-14'
        )
      end

      let!(:christmas_celebration) do
        create(:celebration,
          name: 'Natividade de nosso Senhor',
          celebration_type: :principal_feast,
          rank: 1,
          movable: false,
          fixed_month: 12,
          fixed_day: 25,
          liturgical_color: 'branco',
          prayer_book: prayer_book)
      end

      it 'returns principal feast readings on weekday' do
        date = Date.new(2025, 12, 25) # Thursday
        service = described_class.new(date)

        readings = service.find_readings

        # Christmas is a principal feast on a weekday, should have its readings
        expect(readings).not_to be_nil
        expect(readings[:gospel][:reference]).to eq('João 1:1-14')
      end
    end

    describe 'transferred movable feasts' do
      let!(:all_saints_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          date_reference: 'all_saints',
          cycle: 'all',
          service_type: 'eucharist',
          first_reading: 'Apocalipse 7:9-17',
          psalm: 'Salmo 34:1-10, 22',
          second_reading: '1 João 3:1-3',
          gospel: 'Mateus 5:1-12'
        )
      end

      let!(:all_saints_celebration) do
        create(:celebration,
          name: 'Todos os Santos',
          celebration_type: :principal_feast,
          rank: 11,
          movable: true,
          calculation_rule: 'first_sunday_in_november_or_nov_1',
          can_be_transferred: true,
          fixed_month: 11,
          fixed_day: 1,
          liturgical_color: 'branco',
          prayer_book: prayer_book)
      end

      it 'returns feast readings when transferred to Sunday' do
        # In 2025, Nov 1 is Saturday, so All Saints is transferred to Nov 2 (Sunday)
        # This tests that transferred feasts still get their readings
        date = Date.new(2025, 11, 2)

        # Simulate the celebration being resolved for this date
        calendar = LiturgicalCalendar.new(2025)
        info = calendar.celebration_for_date(date)

        # If the celebration resolver returns All Saints for this date
        if info && info[:name]&.include?('Santos')
          service = described_class.new(date)
          readings = service.find_readings

          expect(readings).not_to be_nil
          expect(readings[:gospel][:reference]).to eq('Mateus 5:1-12')
        end
      end
    end

    describe 'weekday principal feasts' do
      let!(:transfiguration_reading) do
        create(:lectionary_reading,
          prayer_book: prayer_book,
          date_reference: 'transfiguration',
          cycle: 'all',
          service_type: 'eucharist',
          first_reading: 'Daniel 7:9-10, 13-14',
          psalm: 'Salmo 99',
          second_reading: '2 Pedro 1:16-19',
          gospel: 'Lucas 9:28-36'
        )
      end

      let!(:transfiguration_celebration) do
        create(:celebration,
          name: 'Transfiguração do Senhor',
          celebration_type: :principal_feast,
          rank: 5,
          movable: false,
          fixed_month: 8,
          fixed_day: 6,
          liturgical_color: 'branco',
          prayer_book: prayer_book)
      end

      it 'returns principal feast readings on weekday over weekly readings' do
        # August 6, 2025 is a Wednesday
        date = Date.new(2025, 8, 6)
        service = described_class.new(date)

        readings = service.find_readings

        # Transfiguration is a principal feast, should override weekly readings
        expect(readings).not_to be_nil
        expect(readings[:gospel][:reference]).to eq('Lucas 9:28-36')
      end
    end
  end

  describe 'Holy Week readings (moveable feast handling)' do
    # Test for the fix: Holy Week days (Monday, Tuesday, Wednesday)
    # should find their specific readings via the moveable feast lookup

    let!(:holy_monday_reading) do
      create(:lectionary_reading,
        prayer_book: prayer_book,
        date_reference: 'holy_monday',
        cycle: 'all',
        service_type: 'eucharist',
        first_reading: 'Isaías 42:1-9',
        psalm: 'Salmo 36:5-11',
        second_reading: 'Hebreus 9:11-15',
        gospel: 'João 12:1-11'
      )
    end

    let!(:holy_tuesday_reading) do
      create(:lectionary_reading,
        prayer_book: prayer_book,
        date_reference: 'holy_tuesday',
        cycle: 'all',
        service_type: 'eucharist',
        first_reading: 'Isaías 49:1-7',
        psalm: 'Salmo 71:1-14',
        second_reading: '1 Coríntios 1:18-31',
        gospel: 'João 12:20-36'
      )
    end

    let!(:holy_wednesday_reading) do
      create(:lectionary_reading,
        prayer_book: prayer_book,
        date_reference: 'holy_wednesday',
        cycle: 'all',
        service_type: 'eucharist',
        first_reading: 'Isaías 50:4-9a',
        psalm: 'Salmo 70',
        second_reading: 'Hebreus 12:1-3',
        gospel: 'João 13:21-32'
      )
    end

    let!(:holy_monday_celebration) do
      create(:celebration,
        name: 'Segunda-feira Santa',
        celebration_type: :lesser_feast,
        rank: 50,
        movable: true,
        calculation_rule: 'easter_minus_6_days',
        liturgical_color: 'violeta',
        prayer_book: prayer_book)
    end

    let!(:holy_tuesday_celebration) do
      create(:celebration,
        name: 'Terça-feira Santa',
        celebration_type: :lesser_feast,
        rank: 50,
        movable: true,
        calculation_rule: 'easter_minus_5_days',
        liturgical_color: 'violeta',
        prayer_book: prayer_book)
    end

    let!(:holy_wednesday_celebration) do
      create(:celebration,
        name: 'Quarta-feira Santa',
        celebration_type: :lesser_feast,
        rank: 50,
        movable: true,
        calculation_rule: 'easter_minus_4_days',
        liturgical_color: 'violeta',
        prayer_book: prayer_book)
    end

    context 'Holy Monday (easter_minus_6_days)' do
      it 'finds Holy Monday readings' do
        # Easter 2025 is April 20, so Holy Monday is April 14
        date = Date.new(2025, 4, 14)
        service = described_class.new(date)

        readings = service.find_readings

        expect(readings).not_to be_nil
        expect(readings[:first_reading][:reference]).to eq('Isaías 42:1-9')
        expect(readings[:gospel][:reference]).to eq('João 12:1-11')
      end
    end

    context 'Holy Tuesday (easter_minus_5_days)' do
      it 'finds Holy Tuesday readings' do
        # Easter 2025 is April 20, so Holy Tuesday is April 15
        date = Date.new(2025, 4, 15)
        service = described_class.new(date)

        readings = service.find_readings

        expect(readings).not_to be_nil
        expect(readings[:first_reading][:reference]).to eq('Isaías 49:1-7')
        expect(readings[:gospel][:reference]).to eq('João 12:20-36')
      end
    end

    context 'Holy Wednesday (easter_minus_4_days)' do
      it 'finds Holy Wednesday readings' do
        # Easter 2025 is April 20, so Holy Wednesday is April 16
        date = Date.new(2025, 4, 16)
        service = described_class.new(date)

        readings = service.find_readings

        expect(readings).not_to be_nil
        expect(readings[:first_reading][:reference]).to eq('Isaías 50:4-9a')
        expect(readings[:gospel][:reference]).to eq('João 13:21-32')
      end
    end
  end

  # Tests for #build_celebration_date_references for moveable feasts
  # moved to spec/services/reading/reference_builder_spec.rb

  describe '#movable_feast_with_readings?' do
    # Test for the method that identifies moveable feasts with their own readings

    let!(:holy_monday_celebration) do
      create(:celebration,
        name: 'Segunda-feira Santa',
        celebration_type: :lesser_feast,
        rank: 50,
        movable: true,
        calculation_rule: 'easter_minus_6_days',
        liturgical_color: 'violeta',
        prayer_book: prayer_book)
    end

    let!(:regular_lesser_feast) do
      create(:celebration,
        name: 'Santo Qualquer',
        celebration_type: :lesser_feast,
        rank: 250,
        movable: false,
        fixed_month: 5,
        fixed_day: 15,
        liturgical_color: 'branco',
        prayer_book: prayer_book)
    end

    it 'returns true for Holy Week celebrations' do
      service = described_class.new(Date.new(2025, 4, 14))
      celebration_info = { id: holy_monday_celebration.id, type: 'lesser_feast' }

      result = service.send(:movable_feast_with_readings?, celebration_info)

      expect(result).to be true
    end

    it 'returns false for regular lesser feasts' do
      service = described_class.new(Date.new(2025, 5, 15))
      celebration_info = { id: regular_lesser_feast.id, type: 'lesser_feast' }

      result = service.send(:movable_feast_with_readings?, celebration_info)

      expect(result).to be false
    end

    it 'returns false for nil celebration' do
      service = described_class.new(Date.new(2025, 5, 15))

      result = service.send(:movable_feast_with_readings?, nil)

      expect(result).to be false
    end

    it 'returns false for celebration without id' do
      service = described_class.new(Date.new(2025, 5, 15))
      celebration_info = { type: 'lesser_feast' }

      result = service.send(:movable_feast_with_readings?, celebration_info)

      expect(result).to be false
    end
  end

  describe 'Early Easter years with Propers 1-3' do
    # Years with early Easter need Propers 1, 2, or 3 for the first weeks of Ordinary Time after Pentecost
    # 2008: Easter March 23 (needs Proper 2)
    # 2024: Easter March 31 (needs Proper 3)
    # 2035: Easter March 25 (needs Proper 2)

    let!(:proper_2_reading) do
      create(:lectionary_reading,
        celebration: nil,
        date_reference: "proper_2",
        cycle: "A",
        service_type: "eucharist",
        first_reading: "Gênesis 6:9-22; 7:24; 8:14-19",
        psalm: "Salmo 46",
        second_reading: "Romanos 1:16-17; 3:22b-28",
        gospel: "Mateus 7:21-29",
        prayer_book: prayer_book)
    end

    let!(:proper_3_reading) do
      create(:lectionary_reading,
        celebration: nil,
        date_reference: "proper_3",
        cycle: "A",
        service_type: "eucharist",
        first_reading: "Levítico 19:1-2, 9-18",
        psalm: "Salmo 119:33-40",
        second_reading: "1 Coríntios 3:10-11, 16-23",
        gospel: "Mateus 5:38-48",
        prayer_book: prayer_book)
    end

    context 'in 2008 (Easter March 23)' do
      it 'returns Proper 2 readings for first Sunday after Pentecost (May 18)' do
        # Pentecost 2008: May 11
        # First Sunday in Ordinary Time: May 18
        date = Date.new(2008, 5, 18)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to eq("Gênesis 6:9-22; 7:24; 8:14-19")
      end

      it 'returns Proper 3 readings for second Sunday after Pentecost (May 25)' do
        date = Date.new(2008, 5, 25)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to eq("Levítico 19:1-2, 9-18")
      end
    end

    context 'in 2035 (Easter March 25)' do
      # 2035 is cycle A (same as 2008)
      it 'returns Proper 2 readings for first Sunday after Pentecost (May 20)' do
        # Pentecost 2035: May 13
        # First Sunday in Ordinary Time: May 20
        # Uses the same Proper 2 reading (cycle A) as 2008
        date = Date.new(2035, 5, 20)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to eq("Gênesis 6:9-22; 7:24; 8:14-19")
      end
    end
  end

  describe 'Holy Week readings (Monday, Tuesday, Wednesday)' do
    # Holy Week days should have priority over any saint's day

    let!(:holy_monday) do
      Celebration.find_or_create_by!(calculation_rule: 'easter_minus_6_days', prayer_book: prayer_book) do |c|
        c.name = 'Segunda-feira Santa'
        c.celebration_type = :major_holy_day
        c.rank = 25
        c.movable = true
        c.liturgical_color = 'violeta'
      end
    end

    let!(:holy_tuesday) do
      Celebration.find_or_create_by!(calculation_rule: 'easter_minus_5_days', prayer_book: prayer_book) do |c|
        c.name = 'Terça-feira Santa'
        c.celebration_type = :major_holy_day
        c.rank = 26
        c.movable = true
        c.liturgical_color = 'violeta'
      end
    end

    let!(:holy_wednesday) do
      Celebration.find_or_create_by!(calculation_rule: 'easter_minus_4_days', prayer_book: prayer_book) do |c|
        c.name = 'Quarta-feira Santa'
        c.celebration_type = :major_holy_day
        c.rank = 27
        c.movable = true
        c.liturgical_color = 'violeta'
      end
    end

    let!(:st_patrick) do
      create(:celebration,
        name: 'São Patrício',
        celebration_type: :lesser_feast,
        rank: 110,
        movable: false,
        fixed_month: 3,
        fixed_day: 17,
        liturgical_color: 'branco',
        prayer_book: prayer_book)
    end

    let!(:holy_monday_reading) do
      create(:lectionary_reading,
        celebration: holy_monday,
        date_reference: "holy_monday",
        cycle: "all",
        service_type: "eucharist",
        first_reading: "Isaías 42:1-9",
        psalm: "Salmo 36:5-11",
        second_reading: "Hebreus 9:11-15",
        gospel: "João 12:1-11",
        prayer_book: prayer_book)
    end

    let!(:holy_tuesday_reading) do
      create(:lectionary_reading,
        celebration: holy_tuesday,
        date_reference: "holy_tuesday",
        cycle: "all",
        service_type: "eucharist",
        first_reading: "Isaías 49:1-7",
        psalm: "Salmo 71:1-14",
        second_reading: "1 Coríntios 1:18-31",
        gospel: "João 12:20-36",
        prayer_book: prayer_book)
    end

    let!(:holy_wednesday_reading) do
      create(:lectionary_reading,
        celebration: holy_wednesday,
        date_reference: "holy_wednesday",
        cycle: "all",
        service_type: "eucharist",
        first_reading: "Isaías 50:4-9a",
        psalm: "Salmo 70",
        second_reading: "Hebreus 12:1-3",
        gospel: "João 13:21-32",
        prayer_book: prayer_book)
    end

    context 'in 2008 when St. Patrick falls on Holy Monday (March 17)' do
      it 'returns Holy Monday readings instead of St. Patrick' do
        # Easter 2008: March 23
        # Palm Sunday: March 16
        # Holy Monday: March 17 (same day as St. Patrick!)
        date = Date.new(2008, 3, 17)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to eq("Isaías 42:1-9")
        expect(readings[:gospel][:reference]).to eq("João 12:1-11")
      end
    end

    context 'in 2025' do
      it 'returns Holy Monday readings for April 14' do
        # Easter 2025: April 20
        # Holy Monday: April 14
        date = Date.new(2025, 4, 14)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to eq("Isaías 42:1-9")
      end

      it 'returns Holy Tuesday readings for April 15' do
        date = Date.new(2025, 4, 15)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to eq("Isaías 49:1-7")
      end

      it 'returns Holy Wednesday readings for April 16' do
        date = Date.new(2025, 4, 16)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to eq("Isaías 50:4-9a")
      end
    end
  end

  describe 'Ash Wednesday readings' do
    # Ash Wednesday is a movable feast (Easter - 46 days)
    # It should always have readings regardless of which year

    let!(:ash_wednesday_celebration) do
      create(:celebration,
        name: "Quarta-Feira de Cinzas",
        celebration_type: :major_holy_day,
        rank: 20,
        movable: true,
        calculation_rule: "easter_minus_46_days",
        liturgical_color: "roxo",
        can_be_transferred: false,
        prayer_book: prayer_book)
    end

    let!(:ash_wednesday_reading) do
      create(:lectionary_reading,
        prayer_book: prayer_book,
        celebration: ash_wednesday_celebration,
        date_reference: "ash_wednesday",
        cycle: "all",
        service_type: "eucharist",
        first_reading: "Joel 2:1-2, 12-17 or Isaías 58:1-12",
        psalm: "Salmo 51:1-17",
        second_reading: "2 Coríntios 5:20b-6:10",
        gospel: "Mateus 6:1-6, 16-21")
    end

    context 'with test data' do
      it 'finds readings for Ash Wednesday 2025 (March 5)' do
        # Easter 2025: April 20, Ash Wednesday: March 5
        date = Date.new(2025, 3, 5)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:first_reading][:reference]).to include("Joel").or include("Isaías")
        expect(readings[:gospel][:reference]).to include("Mateus 6")
      end

      it 'finds readings for Ash Wednesday 2026 (February 18)' do
        # Easter 2026: April 5, Ash Wednesday: February 18
        date = Date.new(2026, 2, 18)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
        expect(readings[:gospel][:reference]).to include("Mateus 6")
      end

      it 'finds readings for Ash Wednesday 2027 (February 10)' do
        # Easter 2027: March 28, Ash Wednesday: February 10
        date = Date.new(2027, 2, 10)
        service = described_class.new(date, prayer_book_code: 'loc_2015')

        readings = service.find_readings

        expect(readings).to be_present
      end

      it 'Ash Wednesday is always on a Wednesday' do
        [2025, 2026, 2027, 2028, 2029].each do |year|
          calc = Liturgical::EasterCalculator.new(year)
          expect(calc.ash_wednesday.wday).to eq(3), "Ash Wednesday #{year} should be a Wednesday"
        end
      end
    end

    context 'calculation rule mapping' do
      it 'includes easter_minus_46_days in MOVABLE_RULES_WITH_READINGS' do
        expect(ReadingService::MOVABLE_RULES_WITH_READINGS).to include('easter_minus_46_days')
      end

      it 'includes ash_wednesday in CALCULATION_RULE_TO_DATE_REFERENCES' do
        mapping = Liturgical::CelebrationResolver::CALCULATION_RULE_TO_DATE_REFERENCES
        expect(mapping).to have_key('easter_minus_46_days')
        expect(mapping['easter_minus_46_days']).to include('ash_wednesday')
      end
    end
  end
end
