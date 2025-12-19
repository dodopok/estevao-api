class Celebration < ApplicationRecord
  # Enums para tipos de celebração conforme as normas
  enum :celebration_type, {
    principal_feast: 1,      # Festas Principais (CAIXA ALTA, negrito, vermelho)
    major_holy_day: 2,       # Dias Santos Principais
    festival: 3,              # Festivais (vermelho)
    lesser_feast: 4,          # Festas Menores (texto simples)
    commemoration: 5          # Comemorações
  }, validate: true

  # Validações
  validates :name, presence: true, uniqueness: { scope: :prayer_book_id, message: "já existe para este livro de oração" }
  validates :celebration_type, presence: true
  validates :rank, presence: true, numericality: { only_integer: true }
  validates :fixed_month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }, allow_nil: true
  validates :fixed_day, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }, allow_nil: true

  # Relacionamentos
  belongs_to :prayer_book
  has_many :collects, dependent: :destroy
  has_many :lectionary_readings, dependent: :destroy

  # Scopes úteis
  scope :fixed, -> { where(movable: false) }
  scope :movable, -> { where(movable: true) }
  scope :by_rank, -> { order(rank: :asc) }
  scope :for_date, ->(month, day) { where(fixed_month: month, fixed_day: day) }
  scope :for_prayer_book_id, ->(prayer_book_id) {
    where(prayer_book_id: prayer_book_id)
  }
  scope :for_prayer_book, ->(code) {
    prayer_book = PrayerBook.find_by(code: code)
    where(prayer_book_id: prayer_book&.id)
  }

  # Método para verificar se é uma festa principal
  def principal_feast?
    celebration_type == "principal_feast"
  end

  # Método para verificar se é um dia santo principal
  def major_holy_day?
    celebration_type == "major_holy_day"
  end

  # Método para verificar se tem precedência sobre domingo
  def supersedes_sunday?
    principal_feast? || major_holy_day?
  end

  # Check if this is a high-priority celebration (Principal Feast or Major Holy Day)
  def high_priority?
    principal_feast? || major_holy_day?
  end

  # Check if this celebration can be observed on a weekday
  def weekday_observance?
    !supersedes_sunday?
  end

  # Método para obter a cor litúrgica
  def color
    liturgical_color
  end
end
