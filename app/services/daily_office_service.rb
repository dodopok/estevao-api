# frozen_string_literal: true

# Factory service that delegates to Prayer Book-specific builders
# This allows each LOC to have its own unique Daily Office structure
class DailyOfficeService
  attr_reader :date, :office_type, :preferences

  def initialize(date:, office_type: :morning, preferences: {})
    @date = date.to_date
    @office_type = office_type.to_sym
    @preferences = default_preferences.merge(preferences)
  end

  def call
    builder = builder_for_prayer_book
    builder.call
  end

  private

  def builder_for_prayer_book
    prayer_book_code = preferences[:prayer_book_code] || "loc_2015"

    builder_class = case prayer_book_code
    when "loc_2015"
                      DailyOffice::Builders::Loc2015Builder
    when "loc_2019"
                      # Future: DailyOffice::Builders::Loc2019Builder
                      DailyOffice::Builders::BaseBuilder
    when "loc_2012"
                      # Future: DailyOffice::Builders::Loc2012Builder
                      DailyOffice::Builders::BaseBuilder
    when "loc_1987", "locb_2008", "loc_1662"
                      # Use base builder for LOCs without specific customizations
                      DailyOffice::Builders::BaseBuilder
    else
                      # Default to base builder
                      DailyOffice::Builders::BaseBuilder
    end

    builder_class.new(
      date: date,
      office_type: office_type,
      preferences: preferences
    )
  end

  def default_preferences
    {
      prayer_book_code: "loc_2015",
      bible_version: "nvi",
      language: "pt-BR",
      confession_type: "long",
      lords_prayer_version: "traditional",
      creed_type: :apostles,
      family_rite: false
    }
  end
end
