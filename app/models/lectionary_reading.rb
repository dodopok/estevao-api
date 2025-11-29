class LectionaryReading < ApplicationRecord
  # Relacionamento - celebration é opcional pois pode ser leitura de domingo
  belongs_to :celebration, optional: true
  belongs_to :prayer_book

  # Validações
  validates :date_reference, presence: true
  validates :cycle, presence: true
  validates :service_type, presence: true
  validates :service_type, inclusion: { in: %w[eucharist morning_prayer evening_prayer vigil weekly] }
  validates :reading_type, inclusion: { in: %w[semicontinuous complementary], allow_nil: false }

  # Scopes
  scope :for_cycle, ->(cycle) { where(cycle: cycle) }
  scope :for_date_reference, ->(ref) { where(date_reference: ref) }
  scope :eucharistic, -> { where(service_type: "eucharist") }
  scope :service_type_eucharist, -> { where(service_type: "eucharist") }
  scope :service_type_morning_prayer, -> { where(service_type: "morning_prayer") }
  scope :service_type_evening_prayer, -> { where(service_type: "evening_prayer") }
  scope :for_prayer_book_id, ->(prayer_book_id) { where(prayer_book_id: prayer_book_id) }
  scope :for_prayer_book, ->(code) {
    prayer_book = PrayerBook.find_by(code: code)
    where(prayer_book_id: prayer_book&.id)
  }
  scope :for_reading_type, ->(type) { where(reading_type: type) }
  scope :semicontinuous, -> { where(reading_type: "semicontinuous") }
  scope :complementary, -> { where(reading_type: "complementary") }
  scope :weekly, -> { where(service_type: "weekly") }

  # Método para determinar o ciclo baseado no ano litúrgico
  def self.cycle_for_year(year)
    # O ciclo litúrgico é determinado pela fórmula:
    # - Anos divisíveis por 3 (resto 0) = Ciclo C
    # - Anos com resto 1 ao dividir por 3 = Ciclo A
    # - Anos com resto 2 ao dividir por 3 = Ciclo B
    #
    # Exemplos:
    # 2025 % 3 = 0 → Ciclo C
    # 2026 % 3 = 1 → Ciclo A
    # 2027 % 3 = 2 → Ciclo B

    case year % 3
    when 0 then "C"
    when 1 then "A"
    when 2 then "B"
    end
  end

  # Método para determinar par/ímpar
  def self.even_or_odd_year?(year)
    year.even? ? "even" : "odd"
  end
end
