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
end
