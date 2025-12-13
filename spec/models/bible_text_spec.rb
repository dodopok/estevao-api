# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BibleText, type: :model do
  describe '.parse_reference' do
    context 'basic references' do
      it 'parses a simple book and chapter' do
        result = described_class.parse_reference('João 3')
        expect(result).to eq({
          book: 'João',
          chapter: 3,
          verse_start: nil,
          verse_end: nil
        })
      end

      it 'parses book, chapter, and single verse' do
        result = described_class.parse_reference('João 3:16')
        expect(result).to eq({
          book: 'João',
          chapter: 3,
          verse_start: 16,
          verse_end: nil
        })
      end

      it 'parses book, chapter, and verse range' do
        result = described_class.parse_reference('João 3:16-17')
        expect(result).to eq({
          book: 'João',
          chapter: 3,
          verse_start: 16,
          verse_end: 17
        })
      end
    end

    context 'books with numbers' do
      it 'parses books with Arabic numbers' do
        result = described_class.parse_reference('1 Coríntios 13:1-13')
        expect(result).to eq({
          book: '1 Coríntios',
          chapter: 13,
          verse_start: 1,
          verse_end: 13
        })
      end

      it 'parses 2 Samuel' do
        result = described_class.parse_reference('2 Samuel 7:1-11')
        expect(result).to eq({
          book: '2 Samuel',
          chapter: 7,
          verse_start: 1,
          verse_end: 11
        })
      end

      it 'parses 2 Pedro' do
        result = described_class.parse_reference('2 Pedro 3:8-15')
        expect(result).to eq({
          book: '2 Pedro',
          chapter: 3,
          verse_start: 8,
          verse_end: 15
        })
      end
    end

    context 'Roman numerals normalization' do
      it 'converts I to 1' do
        result = described_class.parse_reference('I Pedro 3:16')
        expect(result).to eq({
          book: '1 Pedro',
          chapter: 3,
          verse_start: 16,
          verse_end: nil
        })
      end

      it 'converts II to 2' do
        result = described_class.parse_reference('II Pedro 3:8-15')
        expect(result).to eq({
          book: '2 Pedro',
          chapter: 3,
          verse_start: 8,
          verse_end: 15
        })
      end

      it 'converts III to 3' do
        result = described_class.parse_reference('III João 1:4')
        expect(result).to eq({
          book: '3 João',
          chapter: 1,
          verse_start: 4,
          verse_end: nil
        })
      end

      it 'converts II Coríntios' do
        result = described_class.parse_reference('II Coríntios 5:17')
        expect(result).to eq({
          book: '2 Coríntios',
          chapter: 5,
          verse_start: 17,
          verse_end: nil
        })
      end
    end

    context 'inverted verse ranges' do
      it 'normalizes verse range when end is less than start' do
        result = described_class.parse_reference('2 Pedro 3:11-8')
        expect(result).to eq({
          book: '2 Pedro',
          chapter: 3,
          verse_start: 8,
          verse_end: 11
        })
      end

      it 'normalizes II Pedro with inverted range' do
        result = described_class.parse_reference('II Pedro 3:11-8')
        expect(result).to eq({
          book: '2 Pedro',
          chapter: 3,
          verse_start: 8,
          verse_end: 11
        })
      end

      it 'keeps correct order when start is less than end' do
        result = described_class.parse_reference('João 3:5-10')
        expect(result).to eq({
          book: 'João',
          chapter: 3,
          verse_start: 5,
          verse_end: 10
        })
      end
    end

    context 'Salmo/Salmos normalization' do
      it 'normalizes "Salmo" to "Salmos"' do
        result = described_class.parse_reference('Salmo 23')
        expect(result).to eq({
          book: 'Salmos',
          chapter: 23,
          verse_start: nil,
          verse_end: nil
        })
      end

      it 'keeps "Salmos" as is' do
        result = described_class.parse_reference('Salmos 42')
        expect(result).to eq({
          book: 'Salmos',
          chapter: 42,
          verse_start: nil,
          verse_end: nil
        })
      end

      it 'normalizes Salmo with verse range' do
        result = described_class.parse_reference('Salmo 146:5-10')
        expect(result).to eq({
          book: 'Salmos',
          chapter: 146,
          verse_start: 5,
          verse_end: 10
        })
      end

      it 'normalizes Salmo with dot separator' do
        result = described_class.parse_reference('Salmo 146.5-10')
        expect(result).to eq({
          book: 'Salmos',
          chapter: 146,
          verse_start: 5,
          verse_end: 10
        })
      end
    end

    context 'dot separator' do
      it 'parses reference with dot instead of colon' do
        result = described_class.parse_reference('Gênesis 9.1-17')
        expect(result).to eq({
          book: 'Gênesis',
          chapter: 9,
          verse_start: 1,
          verse_end: 17
        })
      end
    end

    context 'complex formats' do
      it 'removes letter suffixes from verses' do
        result = described_class.parse_reference('2 Pedro 3:8-15a')
        expect(result).to eq({
          book: '2 Pedro',
          chapter: 3,
          verse_start: 8,
          verse_end: 15
        })
      end

      it 'handles optional verses in parentheses' do
        result = described_class.parse_reference('Lucas 1:39-45 (46-55)')
        expect(result).to eq({
          book: 'Lucas',
          chapter: 1,
          verse_start: 39,
          verse_end: 45
        })
      end

      it 'handles "or" alternatives by taking first option' do
        result = described_class.parse_reference('Baruque 5:1-9 or Malaquias 3:1-4')
        expect(result).to eq({
          book: 'Baruque',
          chapter: 5,
          verse_start: 1,
          verse_end: 9
        })
      end

      it 'handles multiple verse ranges by taking first segment' do
        result = described_class.parse_reference('Salmo 80:1-7, 17-19')
        expect(result).to eq({
          book: 'Salmos',
          chapter: 80,
          verse_start: 1,
          verse_end: 7
        })
      end
    end

    context 'edge cases' do
      it 'returns nil for blank reference' do
        expect(described_class.parse_reference('')).to be_nil
        expect(described_class.parse_reference(nil)).to be_nil
        expect(described_class.parse_reference('   ')).to be_nil
      end

      it 'handles whitespace around reference' do
        result = described_class.parse_reference('  João 3:16  ')
        expect(result).to eq({
          book: 'João',
          chapter: 3,
          verse_start: 16,
          verse_end: nil
        })
      end

      it 'returns nil for invalid format' do
        result = described_class.parse_reference('Invalid Reference')
        expect(result).to be_nil
      end
    end

    context 'real-world examples from lectionary' do
      it 'parses "Salmos 42, 43"' do
        result = described_class.parse_reference('Salmos 42, 43')
        expect(result[:book]).to eq('Salmos')
        expect(result[:chapter]).to eq(42)
      end

      it 'parses "II Pedro 3:11-8" (inverted range with Roman numeral)' do
        result = described_class.parse_reference('II Pedro 3:11-8')
        expect(result).to eq({
          book: '2 Pedro',
          chapter: 3,
          verse_start: 8,
          verse_end: 11
        })
      end

      it 'parses "I Coríntios 1:3-9"' do
        result = described_class.parse_reference('I Coríntios 1:3-9')
        expect(result).to eq({
          book: '1 Coríntios',
          chapter: 1,
          verse_start: 3,
          verse_end: 9
        })
      end
    end
  end
end
