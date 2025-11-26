# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrayerBookUserPreference, type: :model do
  let(:user) { User.create!(email: 'test@example.com', provider_uid: 'test123') }
  let(:prayer_book_with_features) do
    PrayerBook.create!(
      code: 'test_loc',
      name: 'Test Prayer Book',
      features: {
        'lectionary' => {
          'reading_types' => [ 'semicontinuous', 'complementary' ],
          'default_reading_type' => 'semicontinuous'
        },
        'daily_office' => {
          'supports_family_rite' => true
        }
      }
    )
  end
  let(:prayer_book_without_family_rite) do
    PrayerBook.create!(
      code: 'test_loc_no_family',
      name: 'Test Prayer Book No Family',
      features: {
        'lectionary' => {
          'reading_types' => [ 'semicontinuous' ],
          'default_reading_type' => 'semicontinuous'
        },
        'daily_office' => {
          'supports_family_rite' => false
        }
      }
    )
  end

  describe 'associations' do
    it 'belongs to user' do
      preference = PrayerBookUserPreference.new(user: user, prayer_book: prayer_book_with_features)
      expect(preference.user).to eq(user)
    end

    it 'belongs to prayer_book' do
      preference = PrayerBookUserPreference.new(user: user, prayer_book: prayer_book_with_features)
      expect(preference.prayer_book).to eq(prayer_book_with_features)
    end
  end

  describe 'validations' do
    it 'validates uniqueness of user_id scoped to prayer_book_id' do
      PrayerBookUserPreference.create!(user: user, prayer_book: prayer_book_with_features)
      duplicate = PrayerBookUserPreference.new(user: user, prayer_book: prayer_book_with_features)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to include('has already been taken')
    end

    context 'reading_type validation' do
      it 'accepts valid reading_type' do
        preference = PrayerBookUserPreference.new(
          user: user,
          prayer_book: prayer_book_with_features,
          options: {
            'lectionary' => {
              'reading_type' => 'complementary'
            }
          }
        )

        expect(preference).to be_valid
      end

      it 'rejects invalid reading_type' do
        preference = PrayerBookUserPreference.new(
          user: user,
          prayer_book: prayer_book_with_features,
          options: {
            'lectionary' => {
              'reading_type' => 'invalid_type'
            }
          }
        )

        expect(preference).not_to be_valid
        expect(preference.errors[:options]).to include(match(/não é suportado/))
      end
    end

    context 'family_rite validation' do
      it 'accepts family_rite when supported' do
        preference = PrayerBookUserPreference.new(
          user: user,
          prayer_book: prayer_book_with_features,
          options: {
            'daily_office' => {
              'use_family_rite' => true
            }
          }
        )

        expect(preference).to be_valid
      end

      it 'rejects family_rite when not supported' do
        preference = PrayerBookUserPreference.new(
          user: user,
          prayer_book: prayer_book_without_family_rite,
          options: {
            'daily_office' => {
              'use_family_rite' => true
            }
          }
        )

        expect(preference).not_to be_valid
        expect(preference.errors[:options]).to include('rito familiar não é suportado por este Prayer Book')
      end
    end
  end

  describe '#options_with_defaults' do
    it 'merges user options with prayer book defaults' do
      preference = PrayerBookUserPreference.create!(
        user: user,
        prayer_book: prayer_book_with_features,
        options: {
          'lectionary' => {
            'reading_type' => 'complementary'
          }
        }
      )

      result = preference.options_with_defaults

      expect(result['lectionary']['reading_type']).to eq('complementary')
      expect(result['daily_office']['use_family_rite']).to eq(false) # from defaults
    end
  end
end
