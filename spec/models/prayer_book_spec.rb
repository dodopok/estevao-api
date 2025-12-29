# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrayerBook, type: :model do
    describe 'order column' do
      it 'has an order attribute' do
        prayer_book = PrayerBook.create!(code: 'order_test', name: 'Order Test', order: 42)
        expect(prayer_book.order).to eq(42)
      end
    end

    describe 'default ordering' do
      it 'returns prayer books ordered by order asc' do
        pb1 = PrayerBook.create!(code: 'order1', name: 'Order 1', order: 2)
        pb2 = PrayerBook.create!(code: 'order2', name: 'Order 2', order: 1)
        pb3 = PrayerBook.create!(code: 'order3', name: 'Order 3', order: 3)
        expect(PrayerBook.all.map(&:code)).to include('order1', 'order2', 'order3')
        ordered_codes = PrayerBook.where(code: [ 'order1', 'order2', 'order3' ]).pluck(:order, :code).sort.map(&:last)
        expect(PrayerBook.where(code: [ 'order1', 'order2', 'order3' ]).map(&:code)).to eq(ordered_codes)
      end
    end
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

    it 'requires language' do
      prayer_book = PrayerBook.new(code: 'test_lang', name: 'Test', language: nil)
      expect(prayer_book).not_to be_valid
      expect(prayer_book.errors[:language]).to include("can't be blank")
    end

    it 'validates language is one of pt-BR, en, es' do
      valid_languages = %w[pt-BR en es]
      valid_languages.each do |lang|
        prayer_book = PrayerBook.new(code: "test_#{lang}", name: 'Test', language: lang)
        expect(prayer_book).to be_valid
      end

      invalid_prayer_book = PrayerBook.new(code: 'test_invalid', name: 'Test', language: 'fr')
      expect(invalid_prayer_book).not_to be_valid
      expect(invalid_prayer_book.errors[:language]).to include('fr is not a valid language')
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

    describe '.premium' do
      it 'returns only premium prayer books' do
        free_book = PrayerBook.create!(code: 'free_test', name: 'Free', premium_required: false)
        premium_book = PrayerBook.create!(code: 'premium_test', name: 'Premium', premium_required: true)

        expect(PrayerBook.premium).to include(premium_book)
        expect(PrayerBook.premium).not_to include(free_book)
      end
    end

    describe '.free' do
      it 'returns only free prayer books' do
        free_book = PrayerBook.create!(code: 'free_test_2', name: 'Free', premium_required: false)
        premium_book = PrayerBook.create!(code: 'premium_test_2', name: 'Premium', premium_required: true)

        expect(PrayerBook.free).to include(free_book)
        expect(PrayerBook.free).not_to include(premium_book)
      end
    end

    describe '.by_language' do
      it 'returns prayer books for the specified language' do
        pt_book = PrayerBook.create!(code: 'pt_test', name: 'Portuguese', language: 'pt-BR')
        en_book = PrayerBook.create!(code: 'en_test', name: 'English', language: 'en')
        es_book = PrayerBook.create!(code: 'es_test', name: 'Spanish', language: 'es')

        expect(PrayerBook.by_language('pt-BR')).to include(pt_book)
        expect(PrayerBook.by_language('pt-BR')).not_to include(en_book, es_book)

        expect(PrayerBook.by_language('en')).to include(en_book)
        expect(PrayerBook.by_language('en')).not_to include(pt_book, es_book)
      end
    end

    describe '.available_for_user' do
      let!(:free_book) { PrayerBook.create!(code: 'free_available', name: 'Free', premium_required: false) }
      let!(:premium_book) { PrayerBook.create!(code: 'premium_available', name: 'Premium', premium_required: true) }

      context 'when user is premium' do
        let(:user) { create(:user, premium_expires_at: 1.year.from_now) }

        it 'returns all prayer books' do
          result = PrayerBook.available_for_user(user)
          expect(result).to include(free_book, premium_book)
        end
      end

      context 'when user is not premium' do
        let(:user) { create(:user, premium_expires_at: nil) }

        it 'returns only free prayer books' do
          result = PrayerBook.available_for_user(user)
          expect(result).to include(free_book)
          expect(result).not_to include(premium_book)
        end
      end

      context 'when user is nil' do
        it 'returns only free prayer books' do
          result = PrayerBook.available_for_user(nil)
          expect(result).to include(free_book)
          expect(result).not_to include(premium_book)
        end
      end

      context 'when user premium has expired' do
        let(:user) { create(:user, premium_expires_at: 1.day.ago) }

        it 'returns only free prayer books' do
          result = PrayerBook.available_for_user(user)
          expect(result).to include(free_book)
          expect(result).not_to include(premium_book)
        end
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

  describe 'instance methods' do
    describe '#requires_premium?' do
      it 'returns true for premium prayer books' do
        premium_book = PrayerBook.create!(code: 'premium_method', name: 'Premium', premium_required: true)
        expect(premium_book.requires_premium?).to be true
      end

      it 'returns false for free prayer books' do
        free_book = PrayerBook.create!(code: 'free_method', name: 'Free', premium_required: false)
        expect(free_book.requires_premium?).to be false
      end
    end

    describe '#accessible_by?' do
      let(:free_book) { PrayerBook.create!(code: 'free_accessible', name: 'Free', premium_required: false) }
      let(:premium_book) { PrayerBook.create!(code: 'premium_accessible', name: 'Premium', premium_required: true) }

      context 'with a free prayer book' do
        it 'is accessible by anyone including nil user' do
          expect(free_book.accessible_by?(nil)).to be true
        end

        it 'is accessible by non-premium user' do
          user = create(:user, premium_expires_at: nil)
          expect(free_book.accessible_by?(user)).to be true
        end

        it 'is accessible by premium user' do
          user = create(:user, premium_expires_at: 1.year.from_now)
          expect(free_book.accessible_by?(user)).to be true
        end
      end

      context 'with a premium prayer book' do
        it 'is not accessible by nil user' do
          expect(premium_book.accessible_by?(nil)).to be false
        end

        it 'is not accessible by non-premium user' do
          user = create(:user, premium_expires_at: nil)
          expect(premium_book.accessible_by?(user)).to be false
        end

        it 'is accessible by premium user' do
          user = create(:user, premium_expires_at: 1.year.from_now)
          expect(premium_book.accessible_by?(user)).to be true
        end

        it 'is not accessible by expired premium user' do
          user = create(:user, premium_expires_at: 1.day.ago)
          expect(premium_book.accessible_by?(user)).to be false
        end
      end
    end
  end
end
