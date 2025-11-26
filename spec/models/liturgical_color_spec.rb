require 'rails_helper'

RSpec.describe LiturgicalColor, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    context 'hex_code format validation' do
      it 'is valid with a proper hex code' do
        color = build(:liturgical_color, hex_code: "#FFFFFF")
        expect(color).to be_valid
      end

      it 'is invalid without # prefix' do
        color = build(:liturgical_color, hex_code: "FFFFFF")
        expect(color).not_to be_valid
        expect(color.errors[:hex_code]).to include("deve ser um código hexadecimal válido")
      end

      it 'is invalid with less than 6 digits' do
        color = build(:liturgical_color, hex_code: "#FFF")
        expect(color).not_to be_valid
      end

      it 'is invalid with more than 6 digits' do
        color = build(:liturgical_color, hex_code: "#FFFFFFF")
        expect(color).not_to be_valid
      end

      it 'is invalid with invalid characters' do
        color = build(:liturgical_color, hex_code: "#GGGGGG")
        expect(color).not_to be_valid
      end
    end
  end

  describe 'COLORS constant' do
    it 'defines standard liturgical colors' do
      expect(LiturgicalColor::COLORS).to include(:branco, :vermelho, :roxo, :violeta, :verde)
    end

    it 'includes color information with hex and description' do
      expect(LiturgicalColor::COLORS[:branco]).to include(:hex, :description)
      expect(LiturgicalColor::COLORS[:branco][:hex]).to eq("#FFFFFF")
    end
  end
end
