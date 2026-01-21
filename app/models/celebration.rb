class Celebration < ApplicationRecord
  # Enums para tipos de celebração conforme as normas
  enum :celebration_type, {
    principal_feast: 1,      # Festas Principais (CAIXA ALTA, negrito, vermelho)
    major_holy_day: 2,       # Dias Santos Principais
    festival: 3,              # Festivais (vermelho)
    lesser_feast: 4,          # Festas Menores (texto simples)
    commemoration: 5          # Comemorações
  }, validate: true

  # Enums para tipo de pessoa na celebração (usado para concordância gramatical em coletas)
  enum :person_type, {
    event: 0,         # Não é sobre pessoa(s), é um evento/data (ex: Batismo do Senhor)
    singular: 1,      # Uma única pessoa (ex: Inês, Policarpo)
    plural: 2         # Múltiplas pessoas (ex: Timóteo e Tito)
  }, validate: true

  # Enums para gênero (usado para concordância gramatical em coletas)
  enum :gender, {
    neutral: 0,       # Neutro (para eventos) ou não aplicável
    masculine: 1,     # Masculino (ex: Policarpo, teu servo)
    feminine: 2,      # Feminino (ex: Inês, tua serva)
    mixed: 3          # Misto (quando são várias pessoas de gêneros diferentes)
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

  # Check if this is a high-priority celebration (alias for supersedes_sunday)
  alias high_priority? supersedes_sunday?

  # Check if this celebration can be observed on a weekday
  def weekday_observance?
    !supersedes_sunday?
  end

  # Método para obter a cor litúrgica
  def color
    liturgical_color
  end

  # Retorna o pronome possessivo correto para usar em coletas
  # (ex: "teu servo", "tua serva", "teus servos", "tuas servas")
  def possessive_pronoun
    return nil if event?

    case [ person_type.to_sym, gender.to_sym ]
    when [ :singular, :masculine ]
      "teu"
    when [ :singular, :feminine ]
      "tua"
    when [ :plural, :masculine ], [ :plural, :mixed ]
      "teus"
    when [ :plural, :feminine ]
      "tuas"
    else
      "teu" # fallback padrão
    end
  end

  # Retorna a forma correta de "servo/serva/servos/servas"
  def servant_form
    return nil if event?

    case [ person_type.to_sym, gender.to_sym ]
    when [ :singular, :masculine ]
      "servo"
    when [ :singular, :feminine ]
      "serva"
    when [ :plural, :masculine ], [ :plural, :mixed ]
      "servos"
    when [ :plural, :feminine ]
      "servas"
    else
      "servo" # fallback padrão
    end
  end

  # Retorna a frase completa "teu servo N." ou equivalente
  # Retorna nil se for um evento (não deve usar essa substituição)
  def servant_phrase(name)
    return nil if event?

    "#{possessive_pronoun} #{servant_form} #{name}"
  end
end
