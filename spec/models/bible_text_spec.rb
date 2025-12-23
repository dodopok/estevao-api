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

      it 'handles semicolon separator for multiple verse ranges' do
        result = described_class.parse_reference('Salmo 80.1-7; 17-19')
        expect(result).to eq({
          book: 'Salmos',
          chapter: 80,
          verse_start: 1,
          verse_end: 7
        })
      end

      it 'handles semicolon separator for multiple chapters' do
        result = described_class.parse_reference('1 Pedro 4:12-14; 5:6-11')
        expect(result).to eq({
          book: '1 Pedro',
          chapter: 4,
          verse_start: 12,
          verse_end: 14
        })
      end

      it 'handles Atos with semicolon separator' do
        result = described_class.parse_reference('Atos 6:8-10; 7:54-60')
        expect(result).to eq({
          book: 'Atos',
          chapter: 6,
          verse_start: 8,
          verse_end: 10
        })
      end

      it 'handles Hebreus with semicolon separator' do
        result = described_class.parse_reference('Hebreus 1:1-4; 2:5-12')
        expect(result).to eq({
          book: 'Hebreus',
          chapter: 1,
          verse_start: 1,
          verse_end: 4
        })
      end

      it 'handles Gênesis with semicolon separator' do
        result = described_class.parse_reference('Gênesis 2:15-17; 3:1-7')
        expect(result).to eq({
          book: 'Gênesis',
          chapter: 2,
          verse_start: 15,
          verse_end: 17
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

  describe '.parse_all_references' do
    context 'single segment references' do
      it 'returns array with one element for simple reference' do
        result = described_class.parse_all_references('João 3:16-17')
        expect(result).to eq([ {
          book: 'João',
          chapter: 3,
          verse_start: 16,
          verse_end: 17
        } ])
      end
    end

    context 'multiple chapters with semicolon' do
      it 'parses "1 Pedro 4:12-14; 5:6-11" into two segments' do
        result = described_class.parse_all_references('1 Pedro 4:12-14; 5:6-11')
        expect(result.length).to eq(2)
        expect(result[0]).to eq({
          book: '1 Pedro',
          chapter: 4,
          verse_start: 12,
          verse_end: 14
        })
        expect(result[1]).to eq({
          book: '1 Pedro',
          chapter: 5,
          verse_start: 6,
          verse_end: 11
        })
      end

      it 'parses "Atos 6:8-10; 7:54-60" into two segments' do
        result = described_class.parse_all_references('Atos 6:8-10; 7:54-60')
        expect(result.length).to eq(2)
        expect(result[0]).to eq({
          book: 'Atos',
          chapter: 6,
          verse_start: 8,
          verse_end: 10
        })
        expect(result[1]).to eq({
          book: 'Atos',
          chapter: 7,
          verse_start: 54,
          verse_end: 60
        })
      end

      it 'parses "Hebreus 1:1-4; 2:5-12" into two segments' do
        result = described_class.parse_all_references('Hebreus 1:1-4; 2:5-12')
        expect(result.length).to eq(2)
        expect(result[0]).to eq({
          book: 'Hebreus',
          chapter: 1,
          verse_start: 1,
          verse_end: 4
        })
        expect(result[1]).to eq({
          book: 'Hebreus',
          chapter: 2,
          verse_start: 5,
          verse_end: 12
        })
      end

      it 'parses "Gênesis 2:15-17; 3:1-7" into two segments' do
        result = described_class.parse_all_references('Gênesis 2:15-17; 3:1-7')
        expect(result.length).to eq(2)
        expect(result[0]).to eq({
          book: 'Gênesis',
          chapter: 2,
          verse_start: 15,
          verse_end: 17
        })
        expect(result[1]).to eq({
          book: 'Gênesis',
          chapter: 3,
          verse_start: 1,
          verse_end: 7
        })
      end
    end

    context 'multiple verse ranges in same chapter' do
      it 'parses "Salmo 80:1-7, 17-19" into two segments' do
        result = described_class.parse_all_references('Salmo 80:1-7, 17-19')
        expect(result.length).to eq(2)
        expect(result[0]).to eq({
          book: 'Salmos',
          chapter: 80,
          verse_start: 1,
          verse_end: 7
        })
        expect(result[1]).to eq({
          book: 'Salmos',
          chapter: 80,
          verse_start: 17,
          verse_end: 19
        })
      end

      it 'parses "Salmo 80.1-7; 17-19" into two segments' do
        result = described_class.parse_all_references('Salmo 80.1-7; 17-19')
        expect(result.length).to eq(2)
        expect(result[0]).to eq({
          book: 'Salmos',
          chapter: 80,
          verse_start: 1,
          verse_end: 7
        })
        expect(result[1]).to eq({
          book: 'Salmos',
          chapter: 80,
          verse_start: 17,
          verse_end: 19
        })
      end
    end

    context 'edge cases' do
      it 'returns empty array for blank reference' do
        expect(described_class.parse_all_references('')).to eq([])
        expect(described_class.parse_all_references(nil)).to eq([])
      end

      it 'handles Roman numerals' do
        result = described_class.parse_all_references('I Pedro 4:12-14; 5:6-11')
        expect(result.length).to eq(2)
        expect(result[0][:book]).to eq('1 Pedro')
        expect(result[1][:book]).to eq('1 Pedro')
      end
    end

    context 'cross-chapter references' do
      it 'parses "Apocalipse 20:11-21:8" into multiple segments' do
        result = described_class.parse_all_references('Apocalipse 20:11-21:8')
        expect(result.length).to eq(2)

        # First segment: chapter 20, verse 11 to end
        expect(result[0][:book]).to eq('Apocalipse')
        expect(result[0][:chapter]).to eq(20)
        expect(result[0][:verse_start]).to eq(11)
        expect(result[0][:fetch_all_from_verse]).to eq(true)

        # Second segment: chapter 21, verses 1-8
        expect(result[1][:book]).to eq('Apocalipse')
        expect(result[1][:chapter]).to eq(21)
        expect(result[1][:verse_start]).to eq(1)
        expect(result[1][:verse_end]).to eq(8)
      end

      it 'parses "Gênesis 1:1-2:3" spanning two chapters' do
        result = described_class.parse_all_references('Gênesis 1:1-2:3')
        expect(result.length).to eq(2)

        expect(result[0][:book]).to eq('Gênesis')
        expect(result[0][:chapter]).to eq(1)
        expect(result[0][:verse_start]).to eq(1)
        expect(result[0][:fetch_all_from_verse]).to eq(true)

        expect(result[1][:book]).to eq('Gênesis')
        expect(result[1][:chapter]).to eq(2)
        expect(result[1][:verse_start]).to eq(1)
        expect(result[1][:verse_end]).to eq(3)
      end

      it 'parses cross-chapter reference spanning multiple chapters' do
        result = described_class.parse_all_references('Isaías 52:13-53:12')
        expect(result.length).to eq(2)

        expect(result[0][:book]).to eq('Isaías')
        expect(result[0][:chapter]).to eq(52)
        expect(result[0][:verse_start]).to eq(13)
        expect(result[0][:fetch_all_from_verse]).to eq(true)

        expect(result[1][:book]).to eq('Isaías')
        expect(result[1][:chapter]).to eq(53)
        expect(result[1][:verse_start]).to eq(1)
        expect(result[1][:verse_end]).to eq(12)
      end

      it 'parses cross-chapter reference with dot separator' do
        result = described_class.parse_all_references('Apocalipse 20.11-21.8')
        expect(result.length).to eq(2)

        expect(result[0][:book]).to eq('Apocalipse')
        expect(result[0][:chapter]).to eq(20)
        expect(result[0][:verse_start]).to eq(11)

        expect(result[1][:book]).to eq('Apocalipse')
        expect(result[1][:chapter]).to eq(21)
        expect(result[1][:verse_end]).to eq(8)
      end
    end
  end
end
