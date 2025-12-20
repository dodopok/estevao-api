# frozen_string_literal: true

# Shared date validation methods for controllers
# Eliminates duplication across Calendar, Lectionary, Journals, and DailyOffice controllers
module DateValidations
  extend ActiveSupport::Concern

  private

  def parse_date
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i

    validate_year_month_day(year, month, day)

    Date.new(year, month, day)
  end

  def validate_year(year)
    raise ArgumentError, "Ano deve estar entre 1900 e 2200" unless year.between?(1900, 2200)
  end

  def validate_year_month(year, month)
    validate_year(year)
    raise ArgumentError, "Mês deve estar entre 1 e 12" unless month.between?(1, 12)
  end

  def validate_year_month_day(year, month, day)
    validate_year_month(year, month)
    raise ArgumentError, "Dia inválido para o mês especificado" unless day.between?(1, 31)

    # Validate if the date is valid
    Date.new(year, month, day)
  rescue Date::Error
    raise ArgumentError, "Invalid date: #{year}-#{month}-#{day}"
  end
end
