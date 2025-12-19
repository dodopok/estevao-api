# frozen_string_literal: true

# Shared utility methods for formatting liturgical responses
# Provides consistent formatting across calendar, lectionary, and office endpoints
module LiturgicalFormatting
  extend ActiveSupport::Concern

  private

  # Format day names in Portuguese
  def day_name_pt(date)
    %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado][date.wday]
  end

  # Format month names in Portuguese
  def month_name_pt(month_number)
    [
      "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
      "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
    ][month_number - 1]
  end

  # Format liturgical season names
  def season_name_pt(season_key)
    {
      "Advento" => "Advento",
      "Natal" => "Natal",
      "Epifania" => "Epifania",
      "Quaresma" => "Quaresma",
      "Páscoa" => "Páscoa",
      "Tempo Comum" => "Tempo Comum"
    }[season_key] || season_key
  end

  # Format celebration type names
  def celebration_type_pt(type)
    {
      "principal_feast" => "Festa Principal",
      "major_holy_day" => "Dia Santo Principal",
      "festival" => "Festival",
      "lesser_feast" => "Festa Menor",
      "commemoration" => "Comemoração"
    }[type] || type
  end

  # Format office type names
  def office_type_pt(office_type)
    {
      "morning" => "Oração Matutina",
      "midday" => "Oração do Meio-Dia",
      "evening" => "Oração Vespertina",
      "compline" => "Completas"
    }[office_type.to_s] || office_type
  end
end
