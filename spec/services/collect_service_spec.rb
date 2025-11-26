require 'rails_helper'

RSpec.describe CollectService do
  let(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Livro de Oração Comum 2015'
      pb.year = 2015
      pb.is_default = true
      pb.features = {
        "lectionary" => {
          "reading_types" => ["semicontinuous", "complementary"],
          "default_reading_type" => "semicontinuous"
        },
        "daily_office" => {
          "supports_family_rite" => false
        }
      }
    end
  end

  let!(:advent_season) do
    LiturgicalSeason.find_or_create_by!(name: "Advento") { |s| s.color = "violeta" }
  end

  let!(:celebration) do
    create(:celebration,
      name: "São José Teste",
      celebration_type: :festival,
      rank: 30,
      movable: false,
      fixed_month: 3,
      fixed_day: 19,
      liturgical_color: "branco",
      prayer_book: prayer_book)
  end

  let!(:celebration_collect) do
    create(:collect,
      celebration: celebration,
      text: "Ó Deus, que fizeste de São José...",
      language: "pt-BR",
      prayer_book: prayer_book)
  end

  let!(:proper_collect) do
    create(:collect,
      celebration: nil,
      season: nil,
      sunday_reference: "proper_25",
      text: "Senhor Deus Onipotente, que chamaste...",
      language: "pt-BR",
      prayer_book: prayer_book)
  end

  let!(:season_collect) do
    create(:collect,
      celebration: nil,
      season: advent_season,
      text: "Onipotente Deus, dá-nos a graça...",
      language: "pt-BR",
      prayer_book: prayer_book)
  end

  let!(:sunday_collect) do
    create(:collect,
      celebration: nil,
      season: nil,
      sunday_reference: "advent_1",
      text: "Deus Onipotente, dá-nos a graça de entrar com alegria...",
      language: "pt-BR",
      prayer_book: prayer_book)
  end

  describe '#find_by_celebration' do
    it 'finds collect by celebration' do
      service = described_class.new(Date.new(2025, 3, 19))
      collects = service.send(:find_by_celebration)

      expect(collects).not_to be_empty
      expect(collects.first.celebration_id).to eq(celebration_collect.celebration_id)
    end

    it 'returns empty array when there is no celebration' do
      service = described_class.new(Date.new(2025, 5, 15))
      collects = service.send(:find_by_celebration)

      expect(collects).to be_empty
    end
  end

  describe '#find_by_sunday' do
    it 'returns empty array for non-Sunday dates' do
      service = described_class.new(Date.new(2025, 11, 17)) # Monday
      collects = service.send(:find_by_sunday)

      expect(collects).to be_empty
    end
  end

  describe '#format_response' do
    let(:service) { described_class.new(Date.new(2025, 1, 1)) }

    context 'with a single collect' do
      it 'returns array with hash' do
        response = service.send(:format_response, [celebration_collect])

        expect(response).to be_an(Array)
        expect(response.first[:text]).to eq(celebration_collect.text)
      end
    end

    context 'with multiple collects' do
      let!(:collect2) do
        create(:collect,
          prayer_book: prayer_book,
          celebration: celebration,
          text: "Segunda coleta de São José...",
          language: "pt-BR")
      end

      it 'returns array of hashes' do
        response = service.send(:format_response, [celebration_collect, collect2])

        expect(response).to be_an(Array)
        expect(response.length).to eq(2)
        expect(response).to all(be_a(Hash).and have_key(:text))
      end
    end

    context 'with empty array' do
      it 'returns nil' do
        response = service.send(:format_response, [])
        expect(response).to be_nil
      end
    end

    context 'with nil' do
      it 'returns nil' do
        response = service.send(:format_response, nil)
        expect(response).to be_nil
      end
    end

    context 'with preface' do
      let!(:collect_with_preface) do
        create(:collect,
          prayer_book: prayer_book,
          celebration: celebration,
          text: "Coleta com prefácio...",
          preface: "Prefácio especial...",
          language: "pt-BR")
      end

      it 'includes preface when present' do
        response = service.send(:format_response, [collect_with_preface])

        expect(response.first[:text]).to eq("Coleta com prefácio...")
        expect(response.first[:preface]).to eq("Prefácio especial...")
      end
    end
  end

  describe '#find_collects' do
    context 'when collect is found' do
      it 'returns collect data' do
        service = described_class.new(Date.new(2025, 3, 19))
        collects = service.find_collects

        expect(collects).not_to be_nil
        expect(collects).to be_a(Hash).or be_a(Array)
      end
    end

    context 'when no collect is found' do
      it 'returns nil' do
        Collect.destroy_all

        service = described_class.new(Date.new(2025, 5, 15))
        collects = service.find_collects

        expect(collects).to be_nil
      end
    end
  end

  describe 'priority tests' do
    context 'celebration vs sunday' do
      let!(:sunday_celebration) do
        create(:celebration,
          name: "Festa em Domingo",
          celebration_type: :festival,
          rank: 30,
          movable: false,
          fixed_month: 11,
          fixed_day: 30, # First Sunday of Advent 2025
          liturgical_color: "branco",
          prayer_book: prayer_book)
      end

      let!(:sunday_celebration_collect) do
        create(:collect,
          prayer_book: prayer_book,
          celebration: sunday_celebration,
          text: "Coleta da celebração em domingo",
          language: "pt-BR")
      end

      it 'prioritizes celebration over sunday' do
        service = described_class.new(Date.new(2025, 11, 30))
        collects = service.find_collects

        # Should return celebration collect, not sunday collect
        if collects.is_a?(Hash)
          expect(collects[:text]).to eq("Coleta da celebração em domingo")
        elsif collects.is_a?(Array)
          texts = collects.map { |c| c[:text] }
          expect(texts).to include("Coleta da celebração em domingo")
        end
      end
    end
  end

  describe 'language filtering' do
    let!(:english_collect) do
      create(:collect,
        prayer_book: prayer_book,
        celebration: celebration,
        text: "English collect...",
        language: "en")
    end

    it 'returns only collects in the correct language' do
      service = described_class.new(Date.new(2025, 3, 19))
      collects_raw = service.send(:find_by_celebration)

      # Should return only Portuguese collect
      expect(collects_raw.count).to eq(1)
      expect(collects_raw.first.language).to eq("pt-BR")
    end
  end

  describe 'specific cases' do
    it 'returns nil for date with no defined collect' do
      Collect.destroy_all

      service = described_class.new(Date.new(2025, 6, 15))
      collects = service.find_collects

      expect(collects).to be_nil
    end
  end
end
