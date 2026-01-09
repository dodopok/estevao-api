require 'rails_helper'

RSpec.describe CollectService do
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

  let!(:advent_season) do
    LiturgicalSeason.find_by(name: "Advento") ||
      LiturgicalSeason.create!(name: "Advento", color: "violeta")
  end

  let!(:celebration) do
    Celebration.find_or_create_by!(
      name: "São José Teste",
      prayer_book: prayer_book
    ) do |c|
      c.celebration_type = :festival
      c.rank = 30
      c.movable = false
      c.fixed_month = 3
      c.fixed_day = 19
      c.liturgical_color = "branco"
    end
  end

  let!(:celebration_collect) do
    create(:collect,
      celebration: celebration,
      text: "Ó Deus, que fizeste de São José...",
      prayer_book: prayer_book)
  end

  let!(:proper_collect) do
    create(:collect,
      celebration: nil,
      season: nil,
      sunday_reference: "proper_25",
      text: "Senhor Deus Onipotente, que chamaste...",
      prayer_book: prayer_book)
  end

  let!(:season_collect) do
    create(:collect,
      celebration: nil,
      season: advent_season,
      text: "Onipotente Deus, dá-nos a graça...",
      prayer_book: prayer_book)
  end

  let!(:sunday_collect) do
    create(:collect,
      celebration: nil,
      season: nil,
      sunday_reference: "advent_1",
      text: "Deus Onipotente, dá-nos a graça de entrar com alegria...",
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
        response = service.send(:format_response, [ celebration_collect ])

        expect(response).to be_an(Array)
        expect(response.first[:text]).to eq(celebration_collect.text)
      end
    end

    context 'with multiple collects' do
      let!(:collect2) do
        create(:collect,
          prayer_book: prayer_book,
          celebration: celebration,
          text: "Segunda coleta de São José...")
      end

      it 'returns array of hashes' do
        response = service.send(:format_response, [ celebration_collect, collect2 ])

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
          preface: "Prefácio especial...")
      end

      it 'includes preface when present' do
        response = service.send(:format_response, [ collect_with_preface ])

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
        Celebration.find_or_create_by!(
          name: "Festa em Domingo",
          prayer_book: prayer_book
        ) do |c|
          c.celebration_type = :festival
          c.rank = 30
          c.movable = false
          c.fixed_month = 11
          c.fixed_day = 30 # First Sunday of Advent 2025
          c.liturgical_color = "branco"
        end
      end

      let!(:sunday_celebration_collect) do
        create(:collect,
          prayer_book: prayer_book,
          celebration: sunday_celebration,
          text: "Coleta da celebração em domingo")
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

  describe 'specific cases' do
    it 'returns nil for date with no defined collect' do
      Collect.destroy_all

      service = described_class.new(Date.new(2025, 6, 15))
      collects = service.find_collects

      expect(collects).to be_nil
    end
  end

  describe 'year boundary handling (find_by_season)' do
    # Test for the fix: when weekday is in January but last Sunday is in December
    # the service should use the correct calendar year for the Sunday

    let!(:christmas_collect) do
      create(:collect,
        celebration: nil,
        season: nil,
        sunday_reference: "1st_sunday_after_christmas",
        text: "Coleta do 1º Domingo após Natal...",
        prayer_book: prayer_book)
    end

    context 'when weekday is in January but last Sunday is in December' do
      it 'finds collect using correct calendar year for the Sunday' do
        # January 2, 2025 is a Thursday
        # Last Sunday is December 29, 2024 (1st Sunday after Christmas)
        date = Date.new(2025, 1, 2)
        service = described_class.new(date)

        collects = service.find_collects

        expect(collects).not_to be_nil
        if collects.is_a?(Array)
          expect(collects.first[:text]).to include("Natal")
        else
          expect(collects[:text]).to include("Natal")
        end
      end

      it 'correctly maps 1st Sunday after Christmas across year boundary' do
        # December 29, 2024 should be 1st Sunday after Christmas
        # when accessed from January 2025
        date = Date.new(2025, 1, 3) # Friday
        service = described_class.new(date)

        # The service should find the collect for 1st Sunday after Christmas
        collects = service.find_collects
        expect(collects).not_to be_nil
      end
    end
  end

  describe 'Easter week collect (celebration_id lookup)' do
    # Test for the fix: weekdays after Easter should find the Easter collect
    # which is stored by celebration_id, not sunday_reference

    let!(:easter_celebration) do
      Celebration.find_or_create_by!(
        name: "Páscoa",
        prayer_book: prayer_book
      ) do |c|
        c.celebration_type = :principal_feast
        c.rank = 1
        c.movable = true
        c.calculation_rule = "easter"
        c.liturgical_color = "branco"
      end
    end

    let!(:easter_collect) do
      create(:collect,
        celebration: easter_celebration,
        sunday_reference: nil,
        text: "Ó Deus, que para a nossa redenção...",
        prayer_book: prayer_book)
    end

    context 'when weekday is after Easter Sunday' do
      it 'finds Easter collect for Monday after Easter via find_collect_for_sunday_celebration' do
        # Easter 2025 is April 20
        # Monday after Easter is April 21
        date = Date.new(2025, 4, 21)
        service = described_class.new(date)

        # Mock the Liturgical::CelebrationResolver to return our test celebration
        resolver_mock = instance_double(Liturgical::CelebrationResolver)
        allow(Liturgical::CelebrationResolver).to receive(:new).and_return(resolver_mock)
        allow(resolver_mock).to receive(:resolve_for_date).and_return(easter_celebration)
        allow(resolver_mock).to receive(:resolve_all_for_date).and_return([ easter_celebration ])

        last_sunday = Date.new(2025, 4, 20)

        collects = service.send(:find_collect_for_sunday_celebration, last_sunday)

        # Should find the Easter collect through celebration lookup
        expect(collects).not_to be_empty
        expect(collects.first.text).to include("redenção")
      end

      it 'returns collects from find_collects when Easter celebration exists in DB' do
        date = Date.new(2025, 4, 22)
        service = described_class.new(date)

        # Mock the Liturgical::CelebrationResolver
        resolver_mock = instance_double(Liturgical::CelebrationResolver)
        allow(Liturgical::CelebrationResolver).to receive(:new).and_return(resolver_mock)
        allow(resolver_mock).to receive(:resolve_for_date).and_return(easter_celebration)
        allow(resolver_mock).to receive(:resolve_all_for_date).and_return([ easter_celebration ])

        collects = service.find_collects

        expect(collects).not_to be_nil
        expect(collects).to be_an(Array)
        expect(collects.first[:text]).to include("redenção")
      end
    end
  end

  describe 'Pentecost week collect (celebration_id lookup)' do
    let!(:pentecost_celebration) do
      Celebration.find_or_create_by!(
        name: "Pentecostes",
        celebration_type: :principal_feast,
        rank: 2,
        movable: true,
        calculation_rule: "easter_plus_49_days",
        liturgical_color: "vermelho",
        prayer_book: prayer_book)
    end

    let!(:pentecost_collect) do
      create(:collect,
        celebration: pentecost_celebration,
        sunday_reference: nil,
        text: "Ó Deus, que no dia de Pentecostes...",
        prayer_book: prayer_book)
    end

    context 'when weekday is after Pentecost' do
      it 'finds Pentecost collect via find_collect_for_sunday_celebration' do
        # Pentecost 2025 is June 8
        # Monday after Pentecost is June 9
        date = Date.new(2025, 6, 9)
        service = described_class.new(date)

        # Mock the Liturgical::CelebrationResolver
        resolver_mock = instance_double(Liturgical::CelebrationResolver)
        allow(Liturgical::CelebrationResolver).to receive(:new).and_return(resolver_mock)
        allow(resolver_mock).to receive(:resolve_for_date).and_return(pentecost_celebration)

        last_sunday = Date.new(2025, 6, 8)

        collects = service.send(:find_collect_for_sunday_celebration, last_sunday)

        # Should find collects through celebration lookup
        expect(collects).not_to be_empty
        expect(collects.first.text).to include("Pentecostes")
      end
    end
  end

  describe 'Trinity Sunday week collect (celebration_id lookup)' do
    let!(:trinity_celebration) do
      cel = Celebration.find_or_create_by!(
        name: "Santíssima Trindade",
        prayer_book: prayer_book
      ) do |c|
        c.celebration_type = :principal_feast
        c.rank = 3
        c.movable = true
        c.calculation_rule = "easter_plus_56_days"
        c.liturgical_color = "branco"
      end

      cel
    end

    let!(:trinity_collect) do
      create(:collect,
        celebration: trinity_celebration,
        sunday_reference: nil,
        text: "Deus nosso Pai, enviaste ao mundo a Palavra da verdade...",
        prayer_book: prayer_book)
    end

    context 'when weekday is after Trinity Sunday' do
      it 'finds Trinity collect via find_collect_for_sunday_celebration' do
        # Trinity Sunday 2025 is June 15
        date = Date.new(2025, 6, 16)
        service = described_class.new(date)

        # Mock the Liturgical::CelebrationResolver
        resolver_mock = instance_double(Liturgical::CelebrationResolver)
        allow(Liturgical::CelebrationResolver).to receive(:new).and_return(resolver_mock)
        allow(resolver_mock).to receive(:resolve_for_date).and_return(trinity_celebration)

        last_sunday = Date.new(2025, 6, 15)

        collects = service.send(:find_collect_for_sunday_celebration, last_sunday)

        # Should find collects through celebration lookup
        expect(collects).not_to be_empty
        expect(collects.first.text).to include("Palavra da verdade")
      end
    end
  end
end
