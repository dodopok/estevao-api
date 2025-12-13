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

  before do
    prayer_book
  end

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

    it 'generates a seed if not provided' do
      builder = described_class.new(date: date, office_type: :morning)

      expect(builder.preferences[:seed]).not_to be_nil
      expect(builder.preferences[:seed]).to be_a(Integer)
    end

    it 'loads day info and readings' do
      builder = described_class.new(date: date, office_type: :morning)

      expect(builder.day_info).to be_a(Hash)
      expect(builder.readings).to be_a(Hash)
    end
  end

  describe 'component builders initialization' do
    # These are tested in subclasses like LocBase
    it 'provides access to component builders through subclasses' do
      # BaseBuilder doesn't initialize component builders
      # This is done in LocBase
      expect(described_class.instance_methods).not_to include(:initialize_component_builders)
    end
  end

  describe '#call' do
    it 'provides basic structure but requires subclass implementation' do
      builder = described_class.new(date: date, office_type: :morning)

      # BaseBuilder delegates to call which should be implemented by subclasses through LocBase
      # Direct instantiation should not be used in production
      expect(builder).to respond_to(:call)
    end
  end

  describe 'helper methods' do
    let(:builder) { described_class.new(date: date, office_type: :morning) }

    it 'provides liturgical_calendar' do
      calendar = builder.send(:liturgical_calendar)
      expect(calendar).to be_a(LiturgicalCalendar)
    end

    it 'provides prayer_book' do
      pb = builder.send(:prayer_book)
      expect(pb).to be_a(PrayerBook).or be_nil
    end

    it 'generates deterministic seed' do
      seed1 = builder.send(:generate_seed)
      seed2 = described_class.new(date: date, office_type: :morning).send(:generate_seed)

      expect(seed1).to eq(seed2)
    end

    it 'generates different seeds for different dates' do
      seed1 = builder.send(:generate_seed)
      seed2 = described_class.new(date: date + 1, office_type: :morning).send(:generate_seed)

      expect(seed1).not_to eq(seed2)
    end

    it 'generates different seeds for different office types' do
      seed1 = builder.send(:generate_seed)
      seed2 = described_class.new(date: date, office_type: :evening).send(:generate_seed)

      expect(seed1).not_to eq(seed2)
    end
  end
end
