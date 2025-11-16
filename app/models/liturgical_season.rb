class LiturgicalSeason < ApplicationRecord
  # Validações
  validates :name, presence: true, uniqueness: true
  validates :color, presence: true

  # Relacionamentos
  has_many :collects, foreign_key: :season_id, dependent: :destroy

  # Constantes para as quadras do ano litúrgico
  SEASONS = %w[Advento Natal Epifania Quaresma Páscoa Tempo\ Comum].freeze
end
