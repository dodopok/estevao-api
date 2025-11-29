# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('script/import_weekly_readings.rb')

RSpec.describe WeeklyReadingsImporter do
  let!(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2015') do |pb|
      pb.name = 'Test LOC 2015'
    end
  end
  let(:temp_csv) { Tempfile.new([ 'weekly_readings', '.csv' ]) }

  after do
    temp_csv.close
    temp_csv.unlink
  end

  describe 'constants' do
    it 'has week name mapping' do
      expect(WeeklyReadingsImporter::WEEK_NAME_MAPPING).to be_a(Hash)
      expect(WeeklyReadingsImporter::WEEK_NAME_MAPPING.size).to eq(95)
    end

    it 'has weekday mapping' do
      expect(WeeklyReadingsImporter::WEEKDAY_MAPPING).to be_a(Hash)
      expect(WeeklyReadingsImporter::WEEKDAY_MAPPING.size).to eq(6)
    end

    it 'has month mapping' do
      expect(WeeklyReadingsImporter::MONTH_MAPPING).to be_a(Hash)
      expect(WeeklyReadingsImporter::MONTH_MAPPING).to include('Jan', 'Dez')
    end

    it 'has gospel books list' do
      expect(WeeklyReadingsImporter::GOSPEL_BOOKS).to eq(%w[Mateus Marcos Lucas João])
    end
  end

  describe '#initialize' do
    it 'initializes with csv path' do
      importer = WeeklyReadingsImporter.new('test.csv')
      expect(importer.instance_variable_get(:@csv_path)).to eq('test.csv')
    end

    it 'finds the prayer book' do
      importer = WeeklyReadingsImporter.new('test.csv')
      expect(importer.instance_variable_get(:@prayer_book)).to eq(prayer_book)
    end

    it 'initializes stats hash' do
      importer = WeeklyReadingsImporter.new('test.csv')
      stats = importer.instance_variable_get(:@stats)

      expect(stats).to have_key(:created)
      expect(stats).to have_key(:updated)
      expect(stats).to have_key(:skipped)
      expect(stats).to have_key(:errors)
    end
  end

  describe 'week name mapping' do
    it 'maps Advent weeks correctly' do
      mapping = WeeklyReadingsImporter::WEEK_NAME_MAPPING
      expect(mapping['Primeiro Domingo do Advento']).to eq('1st_sunday_of_advent')
      expect(mapping['Segundo Domingo do Advento']).to eq('2nd_sunday_of_advent')
      expect(mapping['Advento 1']).to eq('1st_sunday_of_advent')
    end

    it 'maps Lent weeks correctly' do
      mapping = WeeklyReadingsImporter::WEEK_NAME_MAPPING
      expect(mapping['Primeiro Domingo da Quaresma']).to eq('1st_sunday_of_lent')
      expect(mapping['Quinto Domingo da Quaresma']).to eq('5th_sunday_of_lent')
      expect(mapping['Quaresma 1']).to eq('1st_sunday_of_lent')
    end

    it 'maps Easter weeks correctly' do
      mapping = WeeklyReadingsImporter::WEEK_NAME_MAPPING
      expect(mapping['Segundo Domingo da Páscoa']).to eq('2nd_sunday_of_easter')
      expect(mapping['Páscoa 2']).to eq('2nd_sunday_of_easter')
    end

    it 'maps Propers correctly' do
      mapping = WeeklyReadingsImporter::WEEK_NAME_MAPPING
      expect(mapping['Próprio 3']).to eq('proper_3')
      expect(mapping['Próprio 20']).to eq('proper_20')
      expect(mapping['Próprio 29']).to eq('christ_the_king')
    end

    it 'maps special weeks correctly' do
      mapping = WeeklyReadingsImporter::WEEK_NAME_MAPPING
      expect(mapping['Semana Santa']).to eq('holy_week')
      expect(mapping['Santíssima Trindade']).to eq('trinity_sunday')
      expect(mapping['Batismo de nosso Senhor Jesus Cristo']).to eq('baptism_of_christ')
    end
  end

  describe 'gospel detection' do
    let(:importer) { WeeklyReadingsImporter.new('test.csv') }

    it 'identifies Mateus as gospel' do
      expect(importer.send(:gospel_book?, 'Mateus 24.1-22')).to be true
    end

    it 'identifies Marcos as gospel' do
      expect(importer.send(:gospel_book?, 'Marcos 1.1-8')).to be true
    end

    it 'identifies Lucas as gospel' do
      expect(importer.send(:gospel_book?, 'Lucas 1.26-38')).to be true
    end

    it 'identifies João as gospel' do
      expect(importer.send(:gospel_book?, 'João 1.1-14')).to be true
    end

    it 'does NOT identify I João as gospel' do
      expect(importer.send(:gospel_book?, 'I João 5.1-12')).to be false
    end

    it 'does NOT identify II João as gospel' do
      expect(importer.send(:gospel_book?, 'II João 1-13')).to be false
    end

    it 'does NOT identify III João as gospel' do
      expect(importer.send(:gospel_book?, 'III João 1-15')).to be false
    end

    it 'does NOT identify epistles as gospel' do
      expect(importer.send(:gospel_book?, 'Tiago 4.1-10')).to be false
      expect(importer.send(:gospel_book?, 'Romanos 13.11-14')).to be false
      expect(importer.send(:gospel_book?, 'I Coríntios 1.3-9')).to be false
    end

    it 'returns false for nil or empty text' do
      expect(importer.send(:gospel_book?, nil)).to be false
      expect(importer.send(:gospel_book?, '')).to be false
      expect(importer.send(:gospel_book?, '   ')).to be false
    end
  end

  describe 'date reference building' do
    let(:importer) { WeeklyReadingsImporter.new('test.csv') }

    it 'builds reference for weekday' do
      ref = importer.send(:build_date_reference,
                          'Primeiro Domingo do Advento',
                          'Qui')
      expect(ref).to eq('1st_sunday_of_advent_thursday')
    end

    it 'builds reference for fixed date in December' do
      ref = importer.send(:build_date_reference,
                          'Natal',
                          '22 Dez')
      expect(ref).to eq('december_22')
    end

    it 'builds reference for fixed date in January' do
      ref = importer.send(:build_date_reference,
                          'Epifania',
                          '2 Jan')
      expect(ref).to eq('january_2')
    end

    it 'builds reference for Proper weeks' do
      ref = importer.send(:build_date_reference,
                          'Próprio 4',
                          'Qui')
      expect(ref).to eq('proper_4_thursday')
    end

    it 'raises error for unknown week name' do
      expect {
        importer.send(:build_date_reference, 'Unknown Week', 'Seg')
      }.to raise_error(/Unknown week name/)
    end

    it 'raises error for unknown weekday' do
      expect {
        importer.send(:build_date_reference,
                      'Primeiro Domingo do Advento',
                      'XXX')
      }.to raise_error(/Unknown weekday/)
    end
  end

  describe 'reading type extraction' do
    let(:importer) { WeeklyReadingsImporter.new('test.csv') }

    it 'returns complementary when marked' do
      expect(importer.send(:extract_reading_type, 'Complementar')).to eq('complementary')
    end

    it 'returns semicontinuous when marked' do
      expect(importer.send(:extract_reading_type, 'Semicontínua')).to eq('semicontinuous')
    end

    it 'returns nil by default' do
      expect(importer.send(:extract_reading_type, nil)).to be_nil
      expect(importer.send(:extract_reading_type, '')).to be_nil
    end
  end

  describe 'cycle extraction' do
    let(:importer) { WeeklyReadingsImporter.new('test.csv') }

    it 'extracts cycle A' do
      expect(importer.send(:extract_cycle, 'Ano A')).to eq('A')
    end

    it 'extracts cycle B' do
      expect(importer.send(:extract_cycle, 'Ano B')).to eq('B')
    end

    it 'extracts cycle C' do
      expect(importer.send(:extract_cycle, 'Ano C')).to eq('C')
    end
  end

  describe '#import' do
    context 'with valid CSV' do
      before do
        temp_csv.write("ano,semana,dia,tipo,salmo,antigo_testamento,novo_testamento\n")
        temp_csv.write("Ano A,Primeiro Domingo do Advento,Qui,,Salmo 122,Daniel 9.15-19,Tiago 4.1-10\n")
        temp_csv.write("Ano A,Primeiro Domingo do Advento,Sex,,Salmo 122,Gênesis 6.1-10,Hebreus 11.1-7\n")
        temp_csv.write("Ano A,Primeiro Domingo do Advento,Sab,,Salmo 122,Gênesis 6.11-22,Mateus 24.1-22\n")
        temp_csv.rewind
      end

      it 'imports readings successfully' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)

        expect {
          importer.import
        }.to change { LectionaryReading.where(service_type: 'weekly').count }.by(3)
      end

      it 'creates readings with correct attributes' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)
        importer.import

        reading = LectionaryReading.find_by(
          cycle: 'A',
          service_type: 'weekly',
          date_reference: '1st_sunday_of_advent_thursday'
        )

        expect(reading).not_to be_nil
        expect(reading.psalm).to eq('Salmo 122')
        expect(reading.first_reading).to eq('Daniel 9.15-19')
        expect(reading.second_reading).to eq('Tiago 4.1-10')
        expect(reading.gospel).to be_nil
        expect(reading.reading_type).to be_nil
      end

      it 'correctly identifies gospels' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)
        importer.import

        gospel_reading = LectionaryReading.find_by(
          cycle: 'A',
          service_type: 'weekly',
          date_reference: '1st_sunday_of_advent_saturday'
        )

        expect(gospel_reading.gospel).to eq('Mateus 24.1-22')
        expect(gospel_reading.second_reading).to be_nil
      end
    end

    context 'with complementary and semicontinuous readings' do
      before do
        temp_csv.write("ano,semana,dia,tipo,salmo,antigo_testamento,novo_testamento\n")
        temp_csv.write("Ano A,Próprio 4,Qui,Complementar,Salmo 31.1-5,Êxodo 24.1-8,Romanos 2.17-29\n")
        temp_csv.write("Ano A,Próprio 4,Qui,Semicontínua,Salmo 46,Gênesis 1.1–2.4a,Romanos 2.17-29\n")
        temp_csv.rewind
      end

      it 'creates both reading types' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)
        importer.import

        readings = LectionaryReading.where(
          cycle: 'A',
          service_type: 'weekly',
          date_reference: 'proper_4_thursday'
        )

        expect(readings.count).to eq(2)
        expect(readings.pluck(:reading_type)).to contain_exactly('complementary', 'semicontinuous')
      end

      it 'stores different psalms for each type' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)
        importer.import

        comp = LectionaryReading.find_by(
          date_reference: 'proper_4_thursday',
          reading_type: 'complementary'
        )
        semi = LectionaryReading.find_by(
          date_reference: 'proper_4_thursday',
          reading_type: 'semicontinuous'
        )

        expect(comp.psalm).to eq('Salmo 31.1-5')
        expect(semi.psalm).to eq('Salmo 46')
      end
    end

    context 'with fixed dates' do
      before do
        temp_csv.write("ano,semana,dia,tipo,salmo,antigo_testamento,novo_testamento\n")
        temp_csv.write("Ano A,Natal,22 Dez,,Lucas 1.46b-55 (Cântico),Isaías 33.17-22,Apocalipse 22.6-7\n")
        temp_csv.rewind
      end

      it 'creates readings with fixed date references' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)
        importer.import

        reading = LectionaryReading.find_by(
          cycle: 'A',
          service_type: 'weekly',
          date_reference: 'december_22'
        )

        expect(reading).not_to be_nil
        expect(reading.psalm).to eq('Lucas 1.46b-55 (Cântico)')
      end
    end

    context 'with update scenario' do
      before do
        # Create existing reading
        LectionaryReading.create!(
          prayer_book: prayer_book,
          cycle: 'A',
          service_type: 'weekly',
          date_reference: '1st_sunday_of_advent_thursday',
          reading_type: nil,
          psalm: 'Old Psalm',
          first_reading: 'Old Reading'
        )

        temp_csv.write("ano,semana,dia,tipo,salmo,antigo_testamento,novo_testamento\n")
        temp_csv.write("Ano A,Primeiro Domingo do Advento,Qui,,Salmo 122,Daniel 9.15-19,Tiago 4.1-10\n")
        temp_csv.rewind
      end

      it 'updates existing reading instead of creating duplicate' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)

        expect {
          importer.import
        }.not_to change { LectionaryReading.where(service_type: 'weekly').count }
      end

      it 'updates the reading values' do
        importer = WeeklyReadingsImporter.new(temp_csv.path)
        importer.import

        reading = LectionaryReading.find_by(
          cycle: 'A',
          service_type: 'weekly',
          date_reference: '1st_sunday_of_advent_thursday'
        )

        expect(reading.psalm).to eq('Salmo 122')
        expect(reading.first_reading).to eq('Daniel 9.15-19')
      end
    end
  end
end
