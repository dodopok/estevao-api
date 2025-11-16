class LectionaryReading < ApplicationRecord
  # Relacionamento - celebration é opcional pois pode ser leitura de domingo
  belongs_to :celebration, optional: true

  # Validações
  validates :date_reference, presence: true
  validates :cycle, presence: true
  validates :service_type, presence: true
  validates :service_type, inclusion: { in: %w[eucharist morning_prayer evening_prayer] }

  # Scopes
  scope :for_cycle, ->(cycle) { where(cycle: cycle) }
  scope :for_date_reference, ->(ref) { where(date_reference: ref) }
  scope :eucharistic, -> { where(service_type: "eucharist") }
  scope :service_type_eucharist, -> { where(service_type: "eucharist") }
  scope :service_type_morning_prayer, -> { where(service_type: "morning_prayer") }
  scope :service_type_evening_prayer, -> { where(service_type: "evening_prayer") }

  # Método para determinar o ciclo baseado no ano
  def self.cycle_for_year(year)
    # Ano litúrgico começa no Advento (aproximadamente 4 domingos antes do Natal)
    # Para simplificar, usamos o ano civil
    cycles = %w[A B C]
    cycles[year % 3]
  end

  # Método para determinar par/ímpar
  def self.even_or_odd_year?(year)
    year.even? ? "even" : "odd"
  end
end
