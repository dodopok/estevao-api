# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::BaseBuilder do
  let(:prayer_book) do
    PrayerBook.create!(
      code: 'test_loc',
      name: 'Test Prayer Book',
      features: {
        'lectionary' => {
          'reading_types' => [ 'semicontinuous' ],
          'default_reading_type' => 'semicontinuous'
        },
        'daily_office' => {
          'supports_family_rite' => true
        }
      }
    )
  end

  let(:date) { Date.new(2025, 11, 25) }

  describe '#initialize' do
    it 'initializes with date, office_type, and preferences' do
      builder = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'test_loc' }
      )

      expect(builder.date).to eq(date)
      expect(builder.office_type).to eq(:morning)
      expect(builder.preferences[:prayer_book_code]).to eq('test_loc')
    end

    it 'initializes component builders' do
      builder = described_class.new(date: date, office_type: :morning)

      expect(builder.psalm_builder).to be_a(DailyOffice::Components::PsalmBuilder)
      expect(builder.canticle_builder).to be_a(DailyOffice::Components::CanticleBuilder)
      expect(builder.reading_builder).to be_a(DailyOffice::Components::ReadingBuilder)
      expect(builder.prayer_builder).to be_a(DailyOffice::Components::PrayerBuilder)
    end
  end

  describe '#call' do
    it 'returns structured daily office data' do
      builder = described_class.new(date: date, office_type: :morning)
      result = builder.call

      expect(result).to be_a(Hash)
      expect(result[:date]).to eq('2025-11-25')
      expect(result[:office_type]).to eq('morning')
      expect(result[:modules]).to be_an(Array)
      expect(result[:metadata]).to be_a(Hash)
    end

    it 'includes metadata about prayer book and preferences' do
      builder = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { prayer_book_code: 'loc_2015', bible_version: 'nvi' }
      )
      result = builder.call

      expect(result[:metadata][:prayer_book_code]).to eq('loc_2015')
      expect(result[:metadata][:bible_version]).to eq('nvi')
    end
  end

  describe '#assemble_morning_prayer' do
    it 'returns full morning prayer structure' do
      builder = described_class.new(date: date, office_type: :morning)
      modules = builder.send(:assemble_morning_prayer)

      expect(modules).to be_an(Array)
      expect(modules.length).to be >= 2
      expect(modules).to all(be_a(Hash))
    end

    it 'returns family rite structure when family_rite is true' do
      builder = described_class.new(
        date: date,
        office_type: :morning,
        preferences: { family_rite: true }
      )
      modules = builder.send(:assemble_morning_prayer)

      expect(modules.length).to be <= 10
      expect(modules).to all(be_a(Hash))
    end
  end

  describe '#assemble_evening_prayer' do
    it 'returns full evening prayer structure' do
      builder = described_class.new(date: date, office_type: :evening)
      modules = builder.send(:assemble_evening_prayer)

      expect(modules).to be_an(Array)
      expect(modules.length).to be >= 2
      expect(modules).to all(be_a(Hash))
    end

    it 'returns family rite structure when family_rite is true' do
      builder = described_class.new(
        date: date,
        office_type: :evening,
        preferences: { family_rite: true }
      )
      modules = builder.send(:assemble_evening_prayer)

      expect(modules.length).to be <= 10
      expect(modules).to all(be_a(Hash))
    end
  end

  describe '#assemble_midday_prayer' do
    it 'returns midday prayer structure' do
      builder = described_class.new(date: date, office_type: :midday)
      modules = builder.send(:assemble_midday_prayer)

      expect(modules).to be_an(Array)
      expect(modules.length).to be >= 1
      expect(modules).to all(be_a(Hash))
    end
  end

  describe '#assemble_compline' do
    it 'returns compline structure' do
      builder = described_class.new(date: date, office_type: :compline)
      modules = builder.send(:assemble_compline)

      expect(modules).to be_an(Array)
      expect(modules.length).to be >= 2
      expect(modules).to all(be_a(Hash))
    end
  end
end
