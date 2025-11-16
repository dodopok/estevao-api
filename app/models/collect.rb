class Collect < ApplicationRecord
  # Relacionamentos - celebration e season são opcionais
  # pois uma coleta pode ser de uma celebração OU de um domingo/quadra
  belongs_to :celebration, optional: true
  belongs_to :season, class_name: "LiturgicalSeason", optional: true

  # Validações
  validates :text, presence: true
  validates :language, presence: true
  validate :must_have_celebration_or_season_or_sunday

  # Scopes
  scope :for_celebration, ->(celebration_id) { where(celebration_id: celebration_id) }
  scope :for_season, ->(season_id) { where(season_id: season_id) }
  scope :for_sunday, ->(sunday_ref) { where(sunday_reference: sunday_ref) }
  scope :in_language, ->(lang) { where(language: lang) }

  private

  def must_have_celebration_or_season_or_sunday
    if celebration_id.blank? && season_id.blank? && sunday_reference.blank?
      errors.add(:base, "Coleta deve ter uma celebração, quadra ou referência de domingo")
    end
  end
end
