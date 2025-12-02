# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrayerBook, type: :model do
  describe 'associations' do
    let(:prayer_book) { PrayerBook.create!(code: 'test_associations', name: 'Test') }

    it 'has many collects' do
      expect(prayer_book).to respond_to(:collects)
      expect(prayer_book.collects).to eq([])
    end

    it 'has many lectionary_readings' do
      expect(prayer_book).to respond_to(:lectionary_readings)
      expect(prayer_book.lectionary_readings).to eq([])
    end

    it 'has many liturgical_texts' do
      expect(prayer_book).to respond_to(:liturgical_texts)
      expect(prayer_book.liturgical_texts).to eq([])
    end

    it 'has many psalms' do
      expect(prayer_book).to respond_to(:psalms)
      expect(prayer_book.psalms).to eq([])
    end

    it 'has many psalm_cycles' do
      expect(prayer_book).to respond_to(:psalm_cycles)
      expect(prayer_book.psalm_cycles).to eq([])
    end

    it 'has many preference_categories' do
      expect(prayer_book).to respond_to(:preference_categories)
      expect(prayer_book.preference_categories).to eq([])
    end

    it 'has many user_onboardings' do
      expect(prayer_book).to respond_to(:user_onboardings)
      expect(prayer_book.user_onboardings).to eq([])
    end

    it 'configures restrict_with_error dependency for core associations' do
      expect(prayer_book.association(:collects).options[:dependent]).to eq(:restrict_with_error)
      expect(prayer_book.association(:lectionary_readings).options[:dependent]).to eq(:restrict_with_error)
      expect(prayer_book.association(:liturgical_texts).options[:dependent]).to eq(:restrict_with_error)
      expect(prayer_book.association(:psalms).options[:dependent]).to eq(:restrict_with_error)
      expect(prayer_book.association(:psalm_cycles).options[:dependent]).to eq(:restrict_with_error)
    end

    it 'configures destroy dependency for preference_categories' do
      expect(prayer_book.association(:preference_categories).options[:dependent]).to eq(:destroy)
    end

    it 'configures restrict_with_error dependency for user_onboardings' do
      expect(prayer_book.association(:user_onboardings).options[:dependent]).to eq(:restrict_with_error)
    end
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
      PrayerBook.create!(code: 'test_unique_1', name: 'Test Book 1')
      prayer_book = PrayerBook.new(code: 'test_unique_1', name: 'Test Book 2')

      expect(prayer_book).not_to be_valid
      expect(prayer_book.errors[:code]).to include('has already been taken')
    end

    it 'validates year is an integer' do
      prayer_book = PrayerBook.new(code: 'test', name: 'Test', year: 'not_a_number')
      expect(prayer_book).not_to be_valid
    end
  end

  describe 'scopes' do
    describe '.recommended' do
      it 'returns only recommended prayer books' do
        # Clear existing recommended books to avoid conflicts
        PrayerBook.where(is_recommended: true).update_all(is_recommended: false)

        recommended_book = PrayerBook.create!(code: 'recommended_test', name: 'Recommended', is_recommended: true)
        _other_book = PrayerBook.create!(code: 'other_test', name: 'Other', is_recommended: false)

        expect(PrayerBook.recommended).to contain_exactly(recommended_book)
      end
    end
  end

  describe '.find_by_code!' do
    it 'finds prayer book by code' do
      prayer_book = PrayerBook.create!(code: 'test_find_by_code', name: 'Test Book')

      expect(PrayerBook.find_by_code!('test_find_by_code')).to eq(prayer_book)
    end

    it 'raises error when prayer book not found' do
      expect {
        PrayerBook.find_by_code!('definitely_nonexistent_code_xyz')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '.find_by_code_or_default' do
    before do
      # Clear existing recommended books and create a fresh one for these tests
      PrayerBook.where(is_recommended: true).update_all(is_recommended: false)
    end

    let!(:recommended_book) { PrayerBook.create!(code: 'recommended_test_2', name: 'Recommended', is_recommended: true) }

    context 'when code is provided and exists' do
      it 'returns the prayer book with that code' do
        specific_book = PrayerBook.create!(code: 'specific_test', name: 'Specific', is_recommended: false)

        expect(PrayerBook.find_by_code_or_default('specific_test')).to eq(specific_book)
      end
    end

    context 'when code is provided but does not exist' do
      it 'returns the recommended prayer book' do
        expect(PrayerBook.find_by_code_or_default('definitely_nonexistent_xyz')).to eq(recommended_book)
      end
    end

    context 'when code is nil' do
      it 'returns the recommended prayer book' do
        expect(PrayerBook.find_by_code_or_default(nil)).to eq(recommended_book)
      end
    end

    context 'when code is empty string' do
      it 'returns the recommended prayer book' do
        expect(PrayerBook.find_by_code_or_default('')).to eq(recommended_book)
      end
    end
  end
end
