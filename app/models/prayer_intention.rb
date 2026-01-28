# == Schema Information
#
# Table name: prayer_intentions
#
#  id                :bigint           not null, primary key
#  user_id           :bigint           not null
#  title             :string           not null
#  description       :text
#  status            :integer          default("pending"), not null
#  category          :string
#  answered_at       :datetime
#  answer_notes      :text
#  generated_prayer  :text
#  ai_enriched_at    :datetime
#  ai_model_version  :string
#  prayer_count      :integer          default(0), not null
#  last_prayed_at    :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class PrayerIntention < ApplicationRecord
  # Associations
  belongs_to :user
  
  # Enums
  enum :status, {
    pending: 0,
    praying: 1,
    answered: 2,
    archived: 3
  }, prefix: true
  
  # Validations
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :description, length: { maximum: 5000 }, allow_blank: true
  validates :category, inclusion: { 
    in: %w[personal family community world thanksgiving intercession],
    allow_blank: true 
  }
  validates :status, presence: true
  validates :answer_notes, length: { maximum: 2000 }, allow_blank: true
  
  # Callbacks
  before_validation :strip_whitespace
  after_initialize :set_defaults, if: :new_record?
  
  # Scopes
  scope :active, -> { where(status: [:pending, :praying]) }
  scope :answered, -> { where(status: :answered) }
  scope :archived, -> { where(status: :archived) }
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :recently_created, -> { order(created_at: :desc) }
  scope :recently_prayed, -> { where.not(last_prayed_at: nil).order(last_prayed_at: :desc) }
  scope :ai_enriched, -> { where.not(ai_enriched_at: nil) }
  scope :needs_enrichment, -> { where(ai_enriched_at: nil) }
  
  # Class methods
  def self.categories
    %w[personal family community world thanksgiving intercession]
  end
  
  # Instance methods
  
  # Mark intention as answered
  def mark_as_answered!(notes: nil)
    update!(
      status: :answered,
      answered_at: Time.current,
      answer_notes: notes
    )
  end
  
  # Mark intention as archived
  def archive!
    update!(status: :archived)
  end
  
  # Increment prayer count
  def record_prayer!
    increment!(:prayer_count)
    touch(:last_prayed_at)
  end
  
  # Check if AI enrichment is needed
  def needs_ai_enrichment?
    ai_enriched_at.nil? || 
    (updated_at > ai_enriched_at && (title_changed? || description_changed?))
  end
  
  # Check if AI enriched
  def ai_enriched?
    ai_enriched_at.present?
  end
  
  # Mark as AI enriched
  def mark_as_ai_enriched!(model_version: nil)
    update!(
      ai_enriched_at: Time.current,
      ai_model_version: model_version || 'perplexity-1.0'
    )
  end
  
  # Get full prayer text for AI processing
  def full_text
    [title, description].compact.join("\n\n")
  end
  
  # Get prayer statistics
  def prayer_stats
    {
      total_prayers: prayer_count,
      last_prayed: last_prayed_at,
      days_since_created: (Time.current - created_at).to_i / 1.day,
      days_praying: status_praying? ? (Time.current - created_at).to_i / 1.day : nil,
      days_until_answered: answered_at ? (answered_at - created_at).to_i / 1.day : nil
    }
  end
  
  # Format for API response
  def as_json_api
    {
      id: id,
      title: title,
      description: description,
      status: status,
      category: category,
      answered_at: answered_at,
      answer_notes: answer_notes,
      generated_prayer: generated_prayer,
      ai_enriched_at: ai_enriched_at,
      ai_model_version: ai_model_version,
      prayer_count: prayer_count,
      last_prayed_at: last_prayed_at,
      created_at: created_at,
      updated_at: updated_at,
      stats: prayer_stats
    }
  end
  
  private
  
  def strip_whitespace
    self.title = title&.strip
    self.description = description&.strip
    self.answer_notes = answer_notes&.strip
  end
  
  def set_defaults
    self.status ||= :pending
    self.prayer_count ||= 0
  end
end
