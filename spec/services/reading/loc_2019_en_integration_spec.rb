# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "LOC 2019 English (ACNA) Integration" do
  let(:date) { Date.new(2025, 12, 29) }

  # Ensure prayer book exists
  let!(:prayer_book) do
    PrayerBook.find_or_create_by!(code: 'loc_2019_en') do |pb|
      pb.name = 'ACNA 2019 English'
    end
  end

  # Setup minimal liturgical texts to avoid crashes in builder
  before do
    [
      'morning_opening_sentence_1', 'morning_confession_rubric', 'morning_confession_invitation_short',
      'morning_confession_body', 'prayer_for_pardon_lay_rubric', 'prayer_for_pardon_lay',
      'morning_inv_v1', 'morning_inv_r1', 'morning_inv_v2', 'morning_inv_r2',
      'morning_inv_v3', 'morning_inv_r3', 'morning_inv_v4', 'morning_inv_r4',
      'venite_body', 'apostles_creed', 'kyrie_v', 'kyrie_r', 'kyrie_v2',
      'our_father_contemporary', 'suff_v1', 'suff_r1', 'suff_v2', 'suff_r2',
      'suff_v3', 'suff_r3', 'suff_v4', 'suff_r4', 'suff_v5', 'suff_r5',
      'suff_v6', 'suff_r6', 'suff_v7', 'suff_r7', 'prayer_for_mission_1',
      'general_thanksgiving', 'chrysostom_prayer', 'dismissal_v', 'dismissal_r',
      'concluding_sentence_1', 'gloria_patri'
    ].each do |slug|
      LiturgicalText.find_or_create_by!(slug: slug, prayer_book: prayer_book) do |t|
        t.content = "Content for #{slug}"
        t.title = slug.humanize
        t.category = "general"
        t.language = "en"
      end
    end
  end

  # Setup the scenario: Holy Innocents (Dec 28) transferred to Dec 29 because Dec 28 is a Sunday
  let!(:holy_innocents) do
    Celebration.find_or_create_by!(
      name: "The Holy Innocents",
      prayer_book: prayer_book
    ) do |c|
      c.celebration_type = :major_holy_day
      c.rank = 10
      c.fixed_month = 12
      c.fixed_day = 28
    end
  end

  let!(:reading) do
    LectionaryReading.find_or_create_by!(
      celebration: holy_innocents,
      prayer_book: prayer_book,
      date_reference: 'the_holy_innocents',
      service_type: 'eucharist'
    ) do |r|
      r.first_reading = 'Jeremiah 31:15-17'
      r.psalm = 'Psalm 124'
      r.second_reading = 'Revelation 21:1-7'
      r.gospel = 'Matthew 2:13-18'
      r.cycle = 'all'
    end
  end

  let!(:morning_reading) do
    LectionaryReading.find_or_create_by!(
      celebration: holy_innocents,
      prayer_book: prayer_book,
      date_reference: 'the_holy_innocents',
      service_type: 'morning_prayer'
    ) do |r|
      r.first_reading = 'Jeremiah 31:15-17'
      r.psalm = 'Psalm 124'
      r.second_reading = 'Revelation 21:1-7'
      r.gospel = 'Matthew 2:13-18'
      r.cycle = 'all'
    end
  end

  it 'correctly identifies the major holy day and returns its readings' do
    # This specifically tests that ReadingService uses the correct liturgical rules for loc_2019_en
    service = ReadingService.for(date, prayer_book_code: 'loc_2019_en')

    # 1. Verify liturgical info identifies it as Holy Innocents (transferred)
    day_info = service.calendar.day_info(date)
    expect(day_info[:celebration][:name]).to eq("The Holy Innocents")
    expect(day_info[:celebration][:type]).to eq("major_holy_day")
    expect(day_info[:celebration][:transferred]).to be true

    # 2. Verify readings are found
    readings = service.find_readings
    expect(readings).not_to be_nil
    expect(readings[:first_reading][:reference]).to eq('Jeremiah 31:15-17')
    expect(readings[:psalm][:reference]).to eq('Psalm 124')
    expect(readings[:gospel][:reference]).to eq('Matthew 2:13-18')
  end

  it 'integrates with DailyOfficeService to include readings in modules' do
    service = DailyOfficeService.new(
      date: date,
      office_type: :morning,
      preferences: { prayer_book_code: 'loc_2019_en' }
    )

    result = service.call
    modules = result[:modules]

    # Find lessons modules
    first_lesson = modules.find { |m| m[:slug] == 'first_lesson' }
    psalms = modules.find { |m| m[:slug] == 'psalms' }

    expect(first_lesson).not_to be_nil
    expect(first_lesson[:reference]).to eq('Jeremiah 31:15-17')

    expect(psalms).not_to be_nil
    expect(psalms[:lines].any? { |l| l[:text]&.include?('Psalm 124') || l[:type] == 'heading' && l[:text]&.include?('124') }).to be true
  end
end
