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
      expect(result[:modules]).to include(include(slug: 'opening'), include(slug: 'psalms'), include(slug: 'reading'), include(slug: 'prayers'), include(slug: 'collects'), include(slug: 'dismissal'))
    end
  end

  context 'when office_type is :evening' do
    let(:office_type) { :evening }

    it 'returns a hash with evening office content' do
      pb = PrayerBook.find_or_create_by!(code: 'loc_2019_en') do |p|
        p.name = 'ACNA 2019'
      end

      # Mock readings to ensure build_psalms and build_lessons_and_canticles have content
      allow_any_instance_of(DailyOffice::Builders::LocBase).to receive(:readings).and_return({
        psalm: { reference: "Psalm 23", content: { verses: [{ number: 1, text: "The Lord is my shepherd" }] } },
        first_reading: { reference: "Genesis 1", content: { verses: [{ number: 1, text: "In the beginning" }] } },
        second_reading: { reference: "John 1", content: { verses: [{ number: 1, text: "In the beginning was the Word" }] } }
      })
      
      allow(LiturgicalText).to receive(:texts_cache_for).and_return(
        Hash.new do |hash, key|
          LiturgicalText.new(content: "Content for #{key}", slug: key, title: "Title for #{key}", reference: "Ref for #{key}")
        end
      )

      result = builder.call
      
      expect(result[:office_type]).to eq('evening')
      expect(result[:modules].map { |m| m[:slug] }).to include('opening_sentence', 'psalms', 'magnificat', 'nunc_dimittis', 'prayers', 'collects')
    end
  end

  context 'when office_type is :compline' do
    let(:office_type) { :compline }

    it 'returns a hash with compline office content' do
      pb = PrayerBook.find_or_create_by!(code: 'loc_2019_en') do |p|
        p.name = 'ACNA 2019'
      end

      allow(LiturgicalText).to receive(:texts_cache_for).and_return(
        Hash.new do |hash, key|
          LiturgicalText.new(content: "Content for #{key}", slug: key, title: "Title for #{key}", reference: "Ref for #{key}")
        end
      )

      result = builder.call
      
      expect(result[:office_type]).to eq('compline')
      expect(result[:modules].map { |m| m[:slug] }).to include('opening', 'confession', 'invitatory', 'psalms', 'reading', 'responsory', 'prayers', 'nunc_dimittis')
    end
  end
end
