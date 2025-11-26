require 'rails_helper'

RSpec.describe LiturgicalSeason, type: :model do
  describe 'associations' do
    it { should have_many(:collects).with_foreign_key(:season_id).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:color) }
  end

  describe 'SEASONS constant' do
    it 'defines the liturgical seasons' do
      expect(LiturgicalSeason::SEASONS).to include("Advento", "Natal", "Epifania", "Quaresma", "Páscoa", "Tempo Comum")
    end

    it 'has exactly 6 seasons' do
      expect(LiturgicalSeason::SEASONS.length).to eq(6)
    end
  end

  describe 'factory' do
    it 'can create a valid liturgical season' do
      season = build(:liturgical_season)
      expect(season).to be_valid
    end

    it 'can create seasons with specific traits' do
      advent = build(:liturgical_season, :advent)
      expect(advent.name).to eq("Advento")
      expect(advent.color).to eq("violet")

      lent = build(:liturgical_season, :lent)
      expect(lent.name).to eq("Quaresma")
      expect(lent.color).to eq("purple")

      easter = build(:liturgical_season, :easter)
      expect(easter.name).to eq("Páscoa")
      expect(easter.color).to eq("white")
    end
  end
end
