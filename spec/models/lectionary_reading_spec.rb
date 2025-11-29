# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LectionaryReading, type: :model do
  let(:prayer_book) { PrayerBook.create!(code: 'test_loc', name: 'Test LOC') }

  describe 'validations' do
    it 'validates presence of required fields' do
      reading = LectionaryReading.new

      expect(reading).not_to be_valid
      expect(reading.errors[:date_reference]).to include("can't be blank")
      expect(reading.errors[:cycle]).to include("can't be blank")
      expect(reading.errors[:service_type]).to include("can't be blank")
    end

    it 'validates service_type inclusion' do
      reading = LectionaryReading.new(
        prayer_book: prayer_book,
        date_reference: 'test_sunday',
        cycle: 'A',
        service_type: 'invalid_type'
      )

      expect(reading).not_to be_valid
      expect(reading.errors[:service_type]).to include('is not included in the list')
    end

    it 'validates reading_type inclusion' do
      reading = LectionaryReading.new(
        prayer_book: prayer_book,
        date_reference: 'test_sunday',
        cycle: 'A',
        service_type: 'eucharist',
        reading_type: 'invalid'
      )

      expect(reading).not_to be_valid
      expect(reading.errors[:reading_type]).to include('is not included in the list')
    end

    it 'accepts valid reading_types' do
      %w[semicontinuous complementary].each do |type|
        reading = LectionaryReading.new(
          prayer_book: prayer_book,
          date_reference: 'test_sunday',
          cycle: 'A',
          service_type: 'eucharist',
          reading_type: type
        )

        expect(reading).to be_valid
      end
    end
  end

  describe 'scopes' do
    let!(:semicontinuous_reading) do
      LectionaryReading.create!(
        prayer_book: prayer_book,
        date_reference: 'test_sunday_spec',
        cycle: 'A',
        service_type: 'eucharist',
        reading_type: 'semicontinuous',
        first_reading: 'Isaiah 1:1-5',
        psalm: 'Psalm 1',
        gospel: 'Matthew 1:1-10'
      )
    end

    let!(:complementary_reading) do
      LectionaryReading.create!(
        prayer_book: prayer_book,
        date_reference: 'test_sunday_spec',
        cycle: 'A',
        service_type: 'eucharist',
        reading_type: 'complementary',
        first_reading: 'Isaiah 2:1-5',
        psalm: 'Psalm 2',
        gospel: 'Matthew 1:1-10'
      )
    end

    it 'filters by reading_type' do
      semicontinuous = LectionaryReading.where(date_reference: 'test_sunday_spec')
                                        .for_reading_type('semicontinuous')
      complementary = LectionaryReading.where(date_reference: 'test_sunday_spec')
                                       .for_reading_type('complementary')

      expect(semicontinuous.count).to eq(1)
      expect(complementary.count).to eq(1)
      expect(semicontinuous.first.first_reading).to eq('Isaiah 1:1-5')
      expect(complementary.first.first_reading).to eq('Isaiah 2:1-5')
    end

    it 'has semicontinuous scope' do
      readings = LectionaryReading.where(date_reference: 'test_sunday_spec')
                                  .semicontinuous

      expect(readings.count).to eq(1)
      expect(readings.first.reading_type).to eq('semicontinuous')
    end

    it 'has complementary scope' do
      readings = LectionaryReading.where(date_reference: 'test_sunday_spec')
                                  .complementary

      expect(readings.count).to eq(1)
      expect(readings.first.reading_type).to eq('complementary')
    end
  end

  describe '.cycle_for_year' do
    it 'returns correct cycle for year' do
      expect(LectionaryReading.cycle_for_year(2025)).to eq('C')
      expect(LectionaryReading.cycle_for_year(2026)).to eq('A')
      expect(LectionaryReading.cycle_for_year(2027)).to eq('B')
    end
  end

  describe '.even_or_odd_year?' do
    it 'returns correct weekday cycle' do
      expect(LectionaryReading.even_or_odd_year?(2024)).to eq('even')
      expect(LectionaryReading.even_or_odd_year?(2025)).to eq('odd')
    end
  end

  describe 'weekly readings' do
    describe 'validations' do
      it 'accepts weekly as service_type' do
        reading = LectionaryReading.new(
          prayer_book: prayer_book,
          date_reference: '1st_sunday_of_advent_monday',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous'
        )

        expect(reading).to be_valid
      end

      it 'validates all valid service types including weekly' do
        %w[eucharist morning_prayer evening_prayer vigil weekly].each do |service_type|
          reading = LectionaryReading.new(
            prayer_book: prayer_book,
            date_reference: 'test_ref',
            cycle: 'A',
            service_type: service_type,
            reading_type: 'semicontinuous'
          )

          expect(reading).to be_valid, "#{service_type} should be valid"
        end
      end
    end

    describe 'scope .weekly' do
      let!(:weekly_reading) do
        LectionaryReading.create!(
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

      let!(:eucharist_reading) do
        LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: '1st_sunday_of_advent',
          cycle: 'A',
          service_type: 'eucharist',
          reading_type: 'semicontinuous',
          first_reading: 'Isaiah 1:1-5',
          psalm: 'Psalm 1'
        )
      end

      it 'returns only weekly readings' do
        weekly_readings = LectionaryReading.weekly.where(id: [weekly_reading.id, eucharist_reading.id])

        expect(weekly_readings.count).to eq(1)
        expect(weekly_readings.first).to eq(weekly_reading)
        expect(weekly_readings.first.service_type).to eq('weekly')
      end

      it 'does not return eucharistic readings' do
        weekly_readings = LectionaryReading.weekly.where(id: [weekly_reading.id, eucharist_reading.id])

        expect(weekly_readings).not_to include(eucharist_reading)
      end
    end

    describe 'gospel vs epistle detection' do
      it 'stores gospels in gospel field' do
        reading = LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: '1st_sunday_of_advent_saturday',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          psalm: 'Salmo 122',
          first_reading: 'Gênesis 6.11-22',
          gospel: 'Mateus 24.1-22'
        )

        expect(reading.gospel).to eq('Mateus 24.1-22')
        expect(reading.second_reading).to be_nil
      end

      it 'stores epistles in second_reading field' do
        reading = LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: '1st_sunday_of_advent_thursday',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          psalm: 'Salmo 122',
          first_reading: 'Daniel 9.15-19',
          second_reading: 'Tiago 4.1-10'
        )

        expect(reading.second_reading).to eq('Tiago 4.1-10')
        expect(reading.gospel).to be_nil
      end

      it 'distinguishes João (gospel) from I João (epistle)' do
        gospel_reading = LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: 'test_gospel',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          gospel: 'João 1.1-14'
        )

        epistle_reading = LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: 'test_epistle',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          second_reading: 'I João 5.1-12'
        )

        expect(gospel_reading.gospel).to be_present
        expect(gospel_reading.second_reading).to be_nil
        expect(epistle_reading.second_reading).to be_present
        expect(epistle_reading.gospel).to be_nil
      end
    end

    describe 'complementary vs semicontinuous' do
      let!(:complementary) do
        LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: 'test_proper_thursday_spec',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'complementary',
          psalm: 'Salmo 31.1-5, 19-24',
          first_reading: 'Êxodo 24.1-8',
          second_reading: 'Romanos 2.17-29'
        )
      end

      let!(:semicontinuous) do
        LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: 'test_proper_thursday_spec',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          psalm: 'Salmo 46',
          first_reading: 'Gênesis 1.1–2.4a',
          second_reading: 'Romanos 2.17-29'
        )
      end

      it 'allows both reading types for same date_reference' do
        readings = LectionaryReading.where(
          date_reference: 'test_proper_thursday_spec',
          cycle: 'A',
          service_type: 'weekly'
        )

        expect(readings.count).to eq(2)
        expect(readings.pluck(:reading_type)).to contain_exactly('complementary', 'semicontinuous')
      end

      it 'retrieves correct reading by type' do
        comp_reading = LectionaryReading.find_by(
          date_reference: 'test_proper_thursday_spec',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'complementary'
        )

        semi_reading = LectionaryReading.find_by(
          date_reference: 'test_proper_thursday_spec',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous'
        )

        expect(comp_reading.psalm).to eq('Salmo 31.1-5, 19-24')
        expect(semi_reading.psalm).to eq('Salmo 46')
      end
    end

    describe 'fixed dates' do
      it 'supports fixed date references' do
        reading = LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: 'december_22',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          psalm: 'Lucas 1.46b-55 (Cântico)',
          first_reading: 'Isaías 33.17-22',
          second_reading: 'Apocalipse 22.6-7, 18-20'
        )

        expect(reading).to be_valid
        expect(reading.date_reference).to eq('december_22')
      end
    end

    describe 'canticles instead of psalms' do
      it 'accepts canticles in psalm field' do
        reading = LectionaryReading.create!(
          prayer_book: prayer_book,
          date_reference: 'week_of_christmas_monday',
          cycle: 'A',
          service_type: 'weekly',
          reading_type: 'semicontinuous',
          psalm: 'I Samuel 2.1-10 (Cântico)',
          first_reading: 'Gênesis 17.15-22',
          second_reading: 'Gálatas 4.8-20'
        )

        expect(reading).to be_valid
        expect(reading.psalm).to include('Cântico')
      end
    end
  end
end
