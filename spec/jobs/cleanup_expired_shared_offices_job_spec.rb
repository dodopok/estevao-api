# frozen_string_literal: true

require "rails_helper"

RSpec.describe CleanupExpiredSharedOfficesJob, type: :job do
  describe "#perform" do
    it "deletes expired shared offices" do
      _active = create(:shared_office)
      expired1 = create(:shared_office, :expired)
      expired2 = create(:shared_office, :expired)

      expect {
        described_class.new.perform
      }.to change(SharedOffice, :count).by(-2)

      expect(SharedOffice.exists?(expired1.id)).to be false
      expect(SharedOffice.exists?(expired2.id)).to be false
    end

    it "keeps active shared offices" do
      active = create(:shared_office)
      _expired = create(:shared_office, :expired)

      described_class.new.perform

      expect(SharedOffice.exists?(active.id)).to be true
    end

    it "returns the count of deleted records" do
      create(:shared_office, :expired)
      create(:shared_office, :expired)
      create(:shared_office, :expired)

      result = described_class.new.perform

      expect(result).to eq(3)
    end

    it "returns 0 when no expired records exist" do
      create(:shared_office)

      result = described_class.new.perform

      expect(result).to eq(0)
    end

    it "is enqueued in the default queue" do
      expect(described_class.new.queue_name).to eq("default")
    end
  end
end
