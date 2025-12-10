# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Journal, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:date_reference) }
    it { is_expected.to validate_presence_of(:entry_type) }
    it { is_expected.to validate_presence_of(:content) }

    it 'validates entry_type inclusion' do
      journal = build(:journal, entry_type: 'invalid')
      expect(journal).not_to be_valid
      expect(journal.errors[:entry_type]).to include('invalid is not a valid entry type')
    end

    it 'accepts valid entry types' do
      %w[daily_office life_rule].each do |type|
        journal = build(:journal, entry_type: type)
        journal.office_type = 'morning' if type == 'daily_office'
        expect(journal).to be_valid
      end
    end

    context 'when entry_type is daily_office' do
      it 'validates office_type is present and valid' do
        journal = build(:journal, entry_type: 'daily_office', office_type: nil)
        expect(journal).not_to be_valid

        journal.office_type = 'invalid'
        expect(journal).not_to be_valid
        expect(journal.errors[:office_type]).to include('invalid is not a valid office type')

        %w[morning midday evening compline].each do |office|
          journal.office_type = office
          expect(journal).to be_valid
        end
      end
    end

    context 'when entry_type is life_rule' do
      it 'allows nil office_type' do
        journal = build(:journal, :life_rule)
        expect(journal).to be_valid
      end
    end

    it 'validates content length' do
      journal = build(:journal, content: '')
      expect(journal).not_to be_valid

      journal.content = 'a' * 10_001
      expect(journal).not_to be_valid

      journal.content = 'Valid content'
      expect(journal).to be_valid
    end
  end

  describe 'scopes' do
    let(:user) { create(:user) }
    let!(:journal1) { create(:journal, user: user, date_reference: Date.new(2025, 12, 1)) }
    let!(:journal2) { create(:journal, user: user, date_reference: Date.new(2025, 12, 15)) }
    let!(:journal3) { create(:journal, user: user, date_reference: Date.new(2025, 11, 20)) }

    describe '.for_date' do
      it 'returns journals for specific date' do
        journals = Journal.for_date(Date.new(2025, 12, 1))
        expect(journals).to include(journal1)
        expect(journals).not_to include(journal2, journal3)
      end
    end

    describe '.for_month' do
      it 'returns journals for specific month' do
        journals = Journal.for_month(2025, 12)
        expect(journals).to include(journal1, journal2)
        expect(journals).not_to include(journal3)
      end
    end

    describe '.daily_office_entries' do
      let!(:life_rule_journal) { create(:journal, :life_rule, user: user) }

      it 'returns only daily_office entries' do
        journals = Journal.daily_office_entries
        expect(journals).to include(journal1, journal2, journal3)
        expect(journals).not_to include(life_rule_journal)
      end
    end

    describe '.life_rule_entries' do
      let!(:life_rule_journal) { create(:journal, :life_rule, user: user) }

      it 'returns only life_rule entries' do
        journals = Journal.life_rule_entries
        expect(journals).to include(life_rule_journal)
        expect(journals).not_to include(journal1, journal2, journal3)
      end
    end

    describe '.ordered_by_date' do
      it 'returns journals ordered by date descending' do
        journals = Journal.ordered_by_date
        expect(journals.first).to eq(journal2)
        expect(journals.last).to eq(journal3)
      end
    end
  end
end
