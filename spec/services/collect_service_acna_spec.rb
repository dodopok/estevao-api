require 'rails_helper'

RSpec.describe CollectService do
  let(:prayer_book) { PrayerBook.find_by(code: 'loc_2019_en') }
  
  before do
    # Ensure LOC 2019 EN exists
    unless prayer_book
      pb = PrayerBook.create!(
        code: 'loc_2019_en',
        name: 'Book of Common Prayer 2019 (ACNA)',
        year: 2019,
        language: 'en'
      )
      
      # Create some seasons
      christmas_s = LiturgicalSeason.find_or_create_by!(name: 'Natal') do |s|
        s.color = 'branco'
      end
      
      # Create some collects
      Collect.create!(
        prayer_book: pb,
        sunday_reference: 'common_martyrs',
        text: 'Almighty God, you gave your servant N. boldness...',
        language: 'en'
      )
      
      Collect.create!(
        prayer_book: pb,
        sunday_reference: '1st_sunday_after_christmas',
        text: 'Almighty God, you have poured upon us the new light...',
        language: 'en'
      )
      
      # Create Holy Innocents celebration (Festival)
      # Rank for festival is usually around 100
      Celebration.create!(
        name: 'The Holy Innocents',
        celebration_type: :festival,
        rank: 100,
        fixed_month: 12,
        fixed_day: 28,
        prayer_book: pb,
        liturgical_color: 'red'
      )
      
      # Collect for Holy Innocents
      c_innocents = Celebration.find_by(name: 'The Holy Innocents', prayer_book: pb)
      Collect.create!(
        celebration: c_innocents,
        prayer_book: pb,
        text: 'Almighty God, out of the mouths of children...',
        language: 'en'
      )
      
      # Create Thomas Becket celebration (Lesser Feast)
      Celebration.create!(
        name: 'Thomas Becket',
        celebration_type: :lesser_feast,
        rank: 200,
        fixed_month: 12,
        fixed_day: 29,
        prayer_book: pb,
        liturgical_color: 'red',
        description: 'Archbishop of Canterbury, Martyr'
      )
      
      # Create fixed office collect
      LiturgicalText.create!(
        slug: 'morning_collect_monday',
        category: 'prayer',
        content: 'O God, the King eternal, whose light divides...',
        title: 'A COLLECT FOR THE RENEWAL OF LIFE',
        prayer_book: pb,
        language: 'en'
      )
    end
  end

  describe 'ACNA multiple collects scenario (Dec 29, 2025)' do
    let(:date) { Date.new(2025, 12, 29) } # Monday
    let(:service) { described_class.new(date, prayer_book_code: 'loc_2019_en') }

    it 'returns multiple collects including transferred festivals, seasonal, saints, and fixed' do
      # Dec 28, 2025 was Sunday. Holy Innocents (Dec 28) falls on Sunday.
      # TransferRules should transfer it to Monday Dec 29.
      
      # Thomas Becket is Dec 29.
      # Monday after 1st Sunday after Christmas is Dec 29.
      # Morning Collect for Monday is also required.
      
      collects = service.find_collects
      
      expect(collects).to be_an(Array)
      
      module_titles = collects.map { |c| c[:module_title] }
      titles = collects.map { |c| c[:title] }
      texts = collects.map { |c| c[:text] }
      
      # 1. Holy Innocents (transferred)
      expect(module_titles).to include('Collect of the Day')
      expect(titles).to include('The Holy Innocents')
      expect(texts).to include('Almighty God, out of the mouths of children...')
      
      # 2. Thomas Becket (Saint of the day - uses Common of Martyrs with substitution)
      expect(module_titles).to include('Collect of the Day')
      expect(titles.any? { |t| t.include?('Thomas Becket') && t.include?('Archbishop of Canterbury') }).to be true
      expect(texts).to include('Almighty God, you gave your servant Thomas Becket boldness...')
      
      # 3. Monday after 1st Sunday after Christmas (Seasonal)
      expect(module_titles).to include('Collect of the Day')
      expect(titles).to include('Monday after the First Sunday of Christmas')
      expect(texts).to include('Almighty God, you have poured upon us the new light...')
      
      # 4. Fixed Office Collect
      expect(module_titles).to include('A COLLECT FOR THE RENEWAL OF LIFE')
      expect(titles).to include('Monday')
      expect(texts).to include('O God, the King eternal, whose light divides...')
    end
  end
end
