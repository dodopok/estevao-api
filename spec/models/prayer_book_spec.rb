# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrayerBook, type: :model do
  describe 'associations' do
    it { should have_many(:collects).dependent(:restrict_with_error) }
    it { should have_many(:lectionary_readings).dependent(:restrict_with_error) }
    it { should have_many(:liturgical_texts).dependent(:restrict_with_error) }
    it { should have_many(:psalms).dependent(:restrict_with_error) }
    it { should have_many(:psalm_cycles).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it 'requires code' do
      prayer_book = PrayerBook.new(name: 'Test Book')
      expect(prayer_book).not_to be_valid
      expect(prayer_book.errors[:code]).to include("can't be blank")
    end

    it 'requires name' do
      prayer_book = PrayerBook.new(code: 'test')
      expect(prayer_book).not_to be_valid
      expect(prayer_book.errors[:name]).to include("can't be blank")
    end

    it 'requires unique code' do
      PrayerBook.create!(code: 'loc_2015', name: 'Test Book 1')
      prayer_book = PrayerBook.new(code: 'loc_2015', name: 'Test Book 2')

      expect(prayer_book).not_to be_valid
      expect(prayer_book.errors[:code]).to include('has already been taken')
    end

    it 'validates year is an integer' do
      prayer_book = PrayerBook.new(code: 'test', name: 'Test', year: 'not_a_number')
      expect(prayer_book).not_to be_valid
    end
  end

  describe 'scopes' do
    describe '.default' do
      it 'returns only default prayer books' do
        default_book = PrayerBook.create!(code: 'default', name: 'Default', is_default: true)
        _other_book = PrayerBook.create!(code: 'other', name: 'Other', is_default: false)

        expect(PrayerBook.default).to contain_exactly(default_book)
      end
    end
  end

  describe '.find_by_code!' do
    it 'finds prayer book by code' do
      prayer_book = PrayerBook.create!(code: 'loc_2015', name: 'LOC 2015')

      expect(PrayerBook.find_by_code!('loc_2015')).to eq(prayer_book)
    end

    it 'raises error when prayer book not found' do
      expect {
        PrayerBook.find_by_code!('nonexistent')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '.find_by_code_or_default' do
    let!(:default_book) { PrayerBook.create!(code: 'default', name: 'Default', is_default: true) }

    context 'when code is provided and exists' do
      it 'returns the prayer book with that code' do
        specific_book = PrayerBook.create!(code: 'specific', name: 'Specific', is_default: false)

        expect(PrayerBook.find_by_code_or_default('specific')).to eq(specific_book)
      end
    end

    context 'when code is provided but does not exist' do
      it 'returns the default prayer book' do
        expect(PrayerBook.find_by_code_or_default('nonexistent')).to eq(default_book)
      end
    end

    context 'when code is nil' do
      it 'returns the default prayer book' do
        expect(PrayerBook.find_by_code_or_default(nil)).to eq(default_book)
      end
    end

    context 'when code is empty string' do
      it 'returns the default prayer book' do
        expect(PrayerBook.find_by_code_or_default('')).to eq(default_book)
      end
    end
  end
end
