# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyOffice::Builders::Loc2019EnBuilder, type: :service do
  let(:date) { Date.new(2025, 12, 29) } # A Monday
  let(:office_type) { :midday }
  let(:preferences) { { prayer_book_code: 'loc_2019_en' } }
  
  subject(:builder) { described_class.new(date: date, office_type: office_type, preferences: preferences) }

  describe '#call' do
    it 'returns a hash with office content' do
      # Create a real prayer book to avoid serialization issues with mocks in cache
      pb = PrayerBook.find_or_create_by!(code: 'loc_2019_en') do |p|
        p.name = 'ACNA 2019'
      end
      
      # Mocking liturgical text fetching since we're testing the builder logic
      allow(LiturgicalText).to receive(:texts_cache_for).and_return(
        Hash.new do |hash, key|
          LiturgicalText.new(content: "Content for #{key}", slug: key, title: "Title for #{key}", reference: "Ref for #{key}")
        end
      )

      result = builder.call
      
      expect(result[:office_type]).to eq('midday')
      expect(result[:modules]).to be_an(Array)
      expect(result[:modules].map { |m| m[:slug] }).to include('opening', 'psalms', 'reading', 'prayers', 'collects', 'dismissal')
    end
  end
end
