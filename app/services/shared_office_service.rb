# frozen_string_literal: true

class SharedOfficeService
  attr_reader :date, :office_type, :prayer_book_code, :seed, :preferences, :user

  def initialize(date:, office_type:, prayer_book_code:, seed:, preferences: {}, user: nil)
    @date = date.to_date
    @office_type = office_type.to_s
    @prayer_book_code = prayer_book_code
    @seed = seed.to_i
    @preferences = preferences || {}
    @user = user
  end

  # Creates a new shared office and returns it
  def create
    SharedOffice.create!(
      user: user,
      date: date,
      office_type: office_type,
      prayer_book_code: prayer_book_code,
      seed: seed,
      preferences: sanitized_preferences
    )
  end

  # Find or create a shared office with the same parameters
  # Useful to avoid creating duplicates for the same office configuration
  def find_or_create
    existing = find_existing
    return existing if existing

    create
  end

  private

  # Find an existing active shared office with the same configuration
  def find_existing
    scope = SharedOffice.active.where(
      date: date,
      office_type: office_type,
      prayer_book_code: prayer_book_code,
      seed: seed
    )

    # If user is provided, prefer their shared office
    scope = scope.where(user: user) if user

    scope.find_by(preferences: sanitized_preferences)
  end

  # Remove non-serializable or sensitive data from preferences
  def sanitized_preferences
    prefs = preferences.deep_dup

    # Remove the seed from preferences as it's stored separately
    prefs.delete(:seed)
    prefs.delete("seed")

    # Keep only relevant preferences for the office
    allowed_keys = %w[
      bible_version
      language
      lords_prayer_version
      confession_type
      creed_type
      family_rite
      opening_sentence_general
      opening_sentence_seasonal
      confession_prayer
      absolution_type
      invitatory_antiphon
      magnificat_antiphon
      nunc_dimittis_antiphon
      intercession_type
      general_thanksgiving
      closing_prayer
    ]

    prefs.slice(*allowed_keys)
  end
end
