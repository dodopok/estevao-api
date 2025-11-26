require 'rails_helper'

RSpec.describe Collect, type: :model do
  describe 'associations' do
    it { should belong_to(:prayer_book) }
    it { should belong_to(:celebration).optional }
    it { should belong_to(:season).class_name('LiturgicalSeason').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:language) }

    context 'custom validations' do
      it 'requires either celebration, season, or sunday_reference' do
        collect = build(:collect, celebration: nil, season: nil, sunday_reference: nil)
        expect(collect).not_to be_valid
        expect(collect.errors[:base]).to include("Coleta deve ter uma celebração, quadra ou referência de domingo")
      end

      it 'is valid with a celebration' do
        prayer_book = create(:prayer_book)
        celebration = create(:celebration, prayer_book: prayer_book)
        collect = build(:collect, celebration: celebration, prayer_book: prayer_book)
        expect(collect).to be_valid
      end

      it 'is valid with a season' do
        prayer_book = create(:prayer_book)
        season = create(:liturgical_season)
        collect = build(:collect, celebration: nil, season: season, prayer_book: prayer_book)
        expect(collect).to be_valid
      end

      it 'is valid with a sunday_reference' do
        collect = build(:collect, :with_sunday_reference)
        expect(collect).to be_valid
      end
    end
  end

  describe 'scopes' do
    let(:prayer_book) { create(:prayer_book) }
    let(:celebration) { create(:celebration, prayer_book: prayer_book) }
    let(:season) { create(:liturgical_season) }

    let!(:collect_celebration) { create(:collect, celebration: celebration, prayer_book: prayer_book) }
    let!(:collect_season) { create(:collect, season: season, celebration: nil, prayer_book: prayer_book) }
    let!(:collect_sunday) { create(:collect, :with_sunday_reference, prayer_book: prayer_book) }
    let!(:collect_pt) { create(:collect, :portuguese, :with_celebration, prayer_book: prayer_book) }

    it '.for_celebration returns collects for a specific celebration' do
      expect(Collect.for_celebration(celebration.id)).to include(collect_celebration)
      expect(Collect.for_celebration(celebration.id)).not_to include(collect_season)
    end

    it '.for_season returns collects for a specific season' do
      expect(Collect.for_season(season.id)).to include(collect_season)
      expect(Collect.for_season(season.id)).not_to include(collect_celebration)
    end

    it '.for_sunday returns collects for a specific sunday reference' do
      expect(Collect.for_sunday("advent_1")).to include(collect_sunday)
      expect(Collect.for_sunday("advent_1")).not_to include(collect_celebration)
    end

    it '.in_language returns collects in a specific language' do
      expect(Collect.in_language("pt-BR")).to include(collect_pt)
      expect(Collect.in_language("en")).not_to include(collect_pt)
    end

    it '.for_prayer_book_id returns collects for a specific prayer book id' do
      expect(Collect.for_prayer_book_id(prayer_book.id).count).to eq(4)
    end
  end
end
