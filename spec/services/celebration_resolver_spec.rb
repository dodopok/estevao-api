require 'rails_helper'

RSpec.describe Liturgical::CelebrationResolver do
  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.year = 2015
      pb.is_recommended = true
      pb.features = {
        "lectionary" => {
          "reading_types" => [ "semicontinuous", "complementary" ],
          "default_reading_type" => "semicontinuous"
        },
        "daily_office" => {
          "supports_family_rite" => false
        }
      }
    end
  end

  let!(:easter) do
    create(:celebration,
      name: "Páscoa",
      celebration_type: :principal_feast,
      rank: 0,
      movable: true,
      calculation_rule: "easter",
      liturgical_color: "branco",
      can_be_transferred: false,
      prayer_book: prayer_book)
  end

  let!(:holy_saturday) do
    create(:celebration,
      name: "Sábado Santo",
      celebration_type: :major_holy_day,
      rank: 23,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "preto",
      can_be_transferred: false,
      prayer_book: prayer_book)
  end

  let!(:easter_vigil) do
    create(:celebration,
      name: "Vigília Pascal",
      celebration_type: :principal_feast,
      rank: 1,
      movable: true,
      calculation_rule: "easter_minus_1_day",
      liturgical_color: "branco",
      can_be_transferred: false,
      prayer_book: prayer_book)
  end

  let!(:good_friday) do
    create(:celebration,
      name: "Sexta-Feira da Paixão",
      celebration_type: :major_holy_day,
      rank: 22,
      movable: true,
      calculation_rule: "easter_minus_2_days",
      liturgical_color: "vermelho",
      can_be_transferred: false,
      prayer_book: prayer_book)
  end

  let!(:annunciation) do
    create(:celebration,
      name: "Anunciação de nosso Senhor Jesus Cristo à Bem-Aventurada Virgem Maria",
      celebration_type: :principal_feast,
      rank: 10,
      movable: false,
      fixed_month: 3,
      fixed_day: 25,
      liturgical_color: "branco",
      can_be_transferred: true,
      prayer_book: prayer_book)
  end

  let!(:saint_joseph) do
    create(:celebration,
      name: "José de Nazaré",
      celebration_type: :festival,
      rank: 30,
      movable: false,
      fixed_month: 3,
      fixed_day: 19,
      liturgical_color: "branco",
      can_be_transferred: true,
      prayer_book: prayer_book)
  end

  let!(:all_saints) do
    create(:celebration,
      name: "Todos os Santos e Santas",
      celebration_type: :principal_feast,
      rank: 11,
      movable: false,
      fixed_month: 11,
      fixed_day: 1,
      liturgical_color: "branco",
      can_be_transferred: true,
      prayer_book: prayer_book)
  end

  let!(:lesser_feast) do
    create(:celebration,
      name: "Santo Teste",
      celebration_type: :lesser_feast,
      rank: 250,
      movable: false,
      fixed_month: 5,
      fixed_day: 15,
      liturgical_color: "branco",
      can_be_transferred: false,
      prayer_book: prayer_book)
  end

  describe 'movable date calculation' do
    let(:resolver) { described_class.new(2026) }

    it 'calculates Easter date correctly' do
      date = resolver.send(:calculate_movable_date, easter)
      expect(date).to eq(Date.new(2026, 4, 5))
    end

    it 'calculates Holy Saturday date correctly' do
      date = resolver.send(:calculate_movable_date, holy_saturday)
      expect(date).to eq(Date.new(2026, 4, 4))
    end

    it 'calculates Good Friday date correctly' do
      date = resolver.send(:calculate_movable_date, good_friday)
      expect(date).to eq(Date.new(2026, 4, 3))
    end

    it 'returns nil for unknown calculation_rule' do
      celebration = build(:celebration,
        name: "Teste",
        movable: true,
        calculation_rule: "unknown_rule",
        prayer_book: prayer_book)

      resolver = described_class.new(2025)
      date = resolver.send(:calculate_movable_date, celebration)

      expect(date).to be_nil
    end
  end

  describe '#resolve_for_date' do
    let(:resolver) { described_class.new(2026) }

    context 'when multiple celebrations occur on the same date' do
      it 'resolves by hierarchy (lower rank wins)' do
        # Holy Saturday and Easter Vigil both fall on 2026-04-04
        date = Date.new(2026, 4, 4)
        result = resolver.resolve_for_date(date)

        # Easter Vigil has rank 1, Holy Saturday has rank 23
        # Lower rank = higher precedence
        expect(result).to be_present
        expect(result.name).to eq("Vigília Pascal")
        expect(result.rank).to eq(1)
        expect(result.principal_feast?).to be true
      end
    end

    context 'when there are no celebrations' do
      it 'returns nil' do
        resolver = described_class.new(2025)
        date = Date.new(2025, 5, 20)

        result = resolver.resolve_for_date(date)
        expect(result).to be_nil
      end
    end

    context 'when there is only one celebration' do
      it 'returns that celebration' do
        resolver = described_class.new(2025)
        date = Date.new(2025, 5, 15) # lesser_feast date

        result = resolver.resolve_for_date(date)
        expect(result.id).to eq(lesser_feast.id)
      end
    end
  end

  describe '#actual_date_for_celebration' do
    context 'Annunciation' do
      it 'is not transferred when there is no conflict' do
        # 2025: March 25 is a Tuesday, no conflict
        resolver = described_class.new(2025)
        date = resolver.actual_date_for_celebration(annunciation)

        expect(date).to eq(Date.new(2025, 3, 25)),
          "Annunciation should not be transferred when there is no conflict"
      end

      it 'is transferred when it falls on a Sunday' do
        # 2029: March 25 is a Sunday
        resolver = described_class.new(2029)
        original_date = Date.new(2029, 3, 25)

        expect(original_date).to be_sunday

        transferred_date = resolver.actual_date_for_celebration(annunciation)

        # Should be transferred to Monday
        expect(transferred_date).to eq(Date.new(2029, 3, 26)),
          "Annunciation should be transferred to Monday when falling on Sunday"
      end
    end

    context 'All Saints' do
      it 'can be transferred to nearest Sunday' do
        # 2025: November 1 is Saturday
        resolver = described_class.new(2025)
        transferred_date = resolver.actual_date_for_celebration(all_saints)

        # Should be transferred to Sunday between Oct 30 and Nov 5
        expect(transferred_date).to be_sunday
        expect(transferred_date).to be >= Date.new(2025, 10, 30)
        expect(transferred_date).to be <= Date.new(2025, 11, 5)
      end

      it 'remains on November 1 if already a Sunday' do
        # 2026: November 1 is Sunday
        resolver = described_class.new(2026)
        date = resolver.actual_date_for_celebration(all_saints)

        expect(date).to eq(Date.new(2026, 11, 1)),
          "All Saints should not be transferred if already on Sunday"
      end
    end

    context 'fixed celebrations that cannot be transferred' do
      it 'maintain their original date' do
        resolver = described_class.new(2025)
        date = resolver.actual_date_for_celebration(lesser_feast)

        expect(date).to eq(Date.new(2025, 5, 15))
      end
    end
  end

  describe 'protected period identification' do
    let(:resolver) { described_class.new(2026) }

    it 'correctly identifies Holy Week protected period' do
      # Palm Sunday through Second Sunday of Easter
      palm_sunday = Date.new(2026, 3, 29)
      holy_saturday = Date.new(2026, 4, 4)
      easter_day = Date.new(2026, 4, 5)

      expect(resolver.send(:in_protected_period?, palm_sunday)).to be true
      expect(resolver.send(:in_protected_period?, holy_saturday)).to be true
      expect(resolver.send(:in_protected_period?, easter_day)).to be true

      # Outside protected period
      before_palm = Date.new(2026, 3, 28)
      expect(resolver.send(:in_protected_period?, before_palm)).to be false
    end
  end

  describe 'major season identification' do
    it 'identifies Advent as a major season' do
      resolver = described_class.new(2025)
      date = Date.new(2025, 11, 30) # First Sunday of Advent 2025

      expect(resolver.send(:in_major_season?, date)).to be true
    end

    it 'identifies Lent as a major season' do
      resolver = described_class.new(2025)
      date = Date.new(2025, 3, 15) # During Lent

      expect(resolver.send(:in_major_season?, date)).to be true
    end

    it 'identifies Easter as a major season' do
      resolver = described_class.new(2025)
      date = Date.new(2025, 4, 27) # During Easter

      expect(resolver.send(:in_major_season?, date)).to be true
    end

    it 'identifies Christmas as a major season' do
      resolver = described_class.new(2025)
      date = Date.new(2025, 12, 25) # Christmas

      result = resolver.send(:in_major_season?, date)
      expect(result).to be_truthy
    end

    it 'does not identify Ordinary Time as a major season' do
      resolver = described_class.new(2025)
      date = Date.new(2025, 6, 15) # Ordinary Time

      expect(resolver.send(:in_major_season?, date)).to be false
    end
  end

  describe 'candidate collection' do
    it 'collects fixed celebrations correctly' do
      resolver = described_class.new(2025)
      date = Date.new(2025, 3, 19) # Saint Joseph

      candidates = resolver.send(:collect_candidates, date)

      expect(candidates.any? { |c| c.id == saint_joseph.id }).to be_truthy
    end

    it 'collects movable celebrations correctly' do
      resolver = described_class.new(2026)
      date = Date.new(2026, 4, 5) # Easter 2026

      candidates = resolver.send(:collect_candidates, date)

      expect(candidates.any? { |c| c.id == easter.id }).to be_truthy
    end
  end

  describe 'specific case: 2026-04-04' do
    it 'returns Easter Vigil (not Holy Saturday)' do
      resolver = described_class.new(2026)
      date = Date.new(2026, 4, 4)

      result = resolver.resolve_for_date(date)

      expect(result).to be_present
      expect(result.name).to eq("Vigília Pascal")
      expect(result.principal_feast?).to be true
    end
  end
end
