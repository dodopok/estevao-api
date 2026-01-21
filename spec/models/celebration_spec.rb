require 'rails_helper'

RSpec.describe Celebration, type: :model do
  describe 'associations' do
    it { should belong_to(:prayer_book) }
    it { should have_many(:collects).dependent(:destroy) }
    it { should have_many(:lectionary_readings).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:celebration_type) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank).only_integer }

    context 'fixed_month validation' do
      it 'validates fixed_month is between 1 and 12 when present' do
        celebration = build(:celebration, fixed_month: 13)
        expect(celebration).not_to be_valid
        expect(celebration.errors[:fixed_month]).to be_present
      end

      it 'allows nil fixed_month' do
        celebration = build(:celebration, :movable)
        expect(celebration).to be_valid
      end
    end

    context 'fixed_day validation' do
      it 'validates fixed_day is between 1 and 31 when present' do
        celebration = build(:celebration, fixed_day: 32)
        expect(celebration).not_to be_valid
        expect(celebration.errors[:fixed_day]).to be_present
      end

      it 'allows nil fixed_day' do
        celebration = build(:celebration, :movable)
        expect(celebration).to be_valid
      end
    end
  end

  describe 'enums' do
    it 'defines celebration_type enum' do
      expect(Celebration.celebration_types).to include(
        'principal_feast' => 1,
        'major_holy_day' => 2,
        'festival' => 3,
        'lesser_feast' => 4,
        'commemoration' => 5
      )
    end

    it 'defines person_type enum' do
      expect(Celebration.person_types).to include(
        'event' => 0,
        'singular' => 1,
        'plural' => 2
      )
    end

    it 'defines gender enum' do
      expect(Celebration.genders).to include(
        'neutral' => 0,
        'masculine' => 1,
        'feminine' => 2,
        'mixed' => 3
      )
    end
  end

  describe 'scopes' do
    let(:prayer_book) { create(:prayer_book) }
    let!(:fixed_celebration) { create(:celebration, movable: false, prayer_book: prayer_book) }
    let!(:movable_celebration) { create(:celebration, :movable, prayer_book: prayer_book) }
    let!(:christmas) { create(:celebration, :christmas, prayer_book: prayer_book) }

    it '.fixed returns only fixed celebrations' do
      expect(Celebration.fixed).to include(fixed_celebration, christmas)
      expect(Celebration.fixed).not_to include(movable_celebration)
    end

    it '.movable returns only movable celebrations' do
      expect(Celebration.movable).to include(movable_celebration)
      expect(Celebration.movable).not_to include(fixed_celebration)
    end

    it '.for_date returns celebrations for a specific date' do
      expect(Celebration.for_date(12, 25)).to include(christmas)
      expect(Celebration.for_date(12, 25)).not_to include(fixed_celebration)
    end

    it '.for_prayer_book_id returns celebrations for a specific prayer book' do
      expect(Celebration.for_prayer_book_id(prayer_book.id).count).to eq(3)
    end
  end

  describe 'instance methods' do
    describe '#principal_feast?' do
      it 'returns true for principal feasts' do
        celebration = build(:celebration, :principal_feast)
        expect(celebration.principal_feast?).to be true
      end

      it 'returns false for other types' do
        celebration = build(:celebration, :festival)
        expect(celebration.principal_feast?).to be false
      end
    end

    describe '#supersedes_sunday?' do
      it 'returns true for principal feasts' do
        celebration = build(:celebration, :principal_feast)
        expect(celebration.supersedes_sunday?).to be true
      end

      it 'returns true for major holy days' do
        celebration = build(:celebration, :major_holy_day)
        expect(celebration.supersedes_sunday?).to be true
      end

      it 'returns false for lesser feasts' do
        celebration = build(:celebration, :lesser_feast)
        expect(celebration.supersedes_sunday?).to be false
      end
    end

    describe '#color' do
      it 'returns the liturgical_color' do
        celebration = build(:celebration, liturgical_color: "white")
        expect(celebration.color).to eq("white")
      end
    end

    describe '#possessive_pronoun' do
      it 'returns nil for events' do
        celebration = build(:celebration, person_type: :event, gender: :neutral)
        expect(celebration.possessive_pronoun).to be_nil
      end

      it 'returns "teu" for singular masculine' do
        celebration = build(:celebration, person_type: :singular, gender: :masculine)
        expect(celebration.possessive_pronoun).to eq("teu")
      end

      it 'returns "tua" for singular feminine' do
        celebration = build(:celebration, person_type: :singular, gender: :feminine)
        expect(celebration.possessive_pronoun).to eq("tua")
      end

      it 'returns "teus" for plural masculine' do
        celebration = build(:celebration, person_type: :plural, gender: :masculine)
        expect(celebration.possessive_pronoun).to eq("teus")
      end

      it 'returns "tuas" for plural feminine' do
        celebration = build(:celebration, person_type: :plural, gender: :feminine)
        expect(celebration.possessive_pronoun).to eq("tuas")
      end

      it 'returns "teus" for plural mixed gender' do
        celebration = build(:celebration, person_type: :plural, gender: :mixed)
        expect(celebration.possessive_pronoun).to eq("teus")
      end
    end

    describe '#servant_form' do
      it 'returns nil for events' do
        celebration = build(:celebration, person_type: :event, gender: :neutral)
        expect(celebration.servant_form).to be_nil
      end

      it 'returns "servo" for singular masculine' do
        celebration = build(:celebration, person_type: :singular, gender: :masculine)
        expect(celebration.servant_form).to eq("servo")
      end

      it 'returns "serva" for singular feminine' do
        celebration = build(:celebration, person_type: :singular, gender: :feminine)
        expect(celebration.servant_form).to eq("serva")
      end

      it 'returns "servos" for plural masculine' do
        celebration = build(:celebration, person_type: :plural, gender: :masculine)
        expect(celebration.servant_form).to eq("servos")
      end

      it 'returns "servas" for plural feminine' do
        celebration = build(:celebration, person_type: :plural, gender: :feminine)
        expect(celebration.servant_form).to eq("servas")
      end

      it 'returns "servos" for plural mixed gender' do
        celebration = build(:celebration, person_type: :plural, gender: :mixed)
        expect(celebration.servant_form).to eq("servos")
      end
    end

    describe '#servant_phrase' do
      it 'returns nil for events' do
        celebration = build(:celebration, name: "Batismo do Senhor", person_type: :event, gender: :neutral)
        expect(celebration.servant_phrase(celebration.name)).to be_nil
      end

      it 'returns correct phrase for singular masculine' do
        celebration = build(:celebration, name: "Policarpo", person_type: :singular, gender: :masculine)
        expect(celebration.servant_phrase(celebration.name)).to eq("teu servo Policarpo")
      end

      it 'returns correct phrase for singular feminine' do
        celebration = build(:celebration, name: "Inês", person_type: :singular, gender: :feminine)
        expect(celebration.servant_phrase(celebration.name)).to eq("tua serva Inês")
      end

      it 'returns correct phrase for plural masculine' do
        celebration = build(:celebration, name: "Timóteo e Tito", person_type: :plural, gender: :masculine)
        expect(celebration.servant_phrase(celebration.name)).to eq("teus servos Timóteo e Tito")
      end

      it 'returns correct phrase for plural feminine' do
        celebration = build(:celebration, name: "Lídia, Dorcas e Febe", person_type: :plural, gender: :feminine)
        expect(celebration.servant_phrase(celebration.name)).to eq("tuas servas Lídia, Dorcas e Febe")
      end

      it 'returns correct phrase for plural mixed' do
        celebration = build(:celebration, name: "Perpétua e seus companheiros", person_type: :plural, gender: :mixed)
        expect(celebration.servant_phrase(celebration.name)).to eq("teus servos Perpétua e seus companheiros")
      end
    end
  end
end
