module Api
  module V1
    class LectionaryController < ApplicationController
      include Authenticatable

      before_action :authenticate_user_optional
      # GET /api/v1/lectionary/:year/:month/:day
      # Retorna as leituras para um dia específico
      def day
        date = parse_date
        cycle = determine_cycle(date)

        # Busca leituras
        readings = find_readings_for_date(date, cycle)

        if readings
          render json: format_readings_response(readings, date, cycle)
        else
          render json: {
            data: date.to_s,
            ciclo: cycle,
            mensagem: "Leituras não encontradas para esta data. Por favor, adicione-as ao banco de dados."
          }, status: :not_found
        end
      rescue ArgumentError => e
        render json: { error: "Data inválida: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/lectionary/:year/:month/:day/all_services
      # Retorna leituras para todos os ofícios do dia (Eucaristia, Matinas, Vésperas)
      def all_services
        date = parse_date
        cycle = determine_cycle(date)

        eucharist = find_readings_for_date(date, cycle, "eucharist")
        morning = find_readings_for_date(date, cycle, "morning_prayer")
        evening = find_readings_for_date(date, cycle, "evening_prayer")

        render json: {
          data: date.to_s,
          dia_da_semana: day_name_pt(date),
          ciclo: cycle,
          santa_eucaristia: eucharist ? format_reading(eucharist) : nil,
          oracao_matutina: morning ? format_reading(morning) : nil,
          oracao_vespertina: evening ? format_reading(evening) : nil
        }
      rescue ArgumentError => e
        render json: { error: "Data inválida: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/lectionary/cycle/:year
      # Retorna o ciclo litúrgico do ano
      def cycle_info
        year = params[:year].to_i
        validate_year(year)

        sunday_cycle = LectionaryReading.cycle_for_year(year)
        weekday_cycle = LectionaryReading.even_or_odd_year?(year)

        render json: {
          ano: year,
          ciclo_dominical: sunday_cycle,
          ciclo_semanal: weekday_cycle,
          descricao: {
            dominical: "Leituras dos domingos seguem o ciclo #{sunday_cycle} (rotação trienal A, B, C)",
            semanal: "Leituras dos dias de semana seguem o ano #{weekday_cycle} (rotação bienal par/ímpar)"
          }
        }
      rescue ArgumentError => e
        render json: { error: "Ano inválido: #{e.message}" }, status: :bad_request
      end

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

      def validate_year_month_day(year, month, day)
        validate_year(year)
        raise ArgumentError, "Mês deve estar entre 1 e 12" unless month.between?(1, 12)
        raise ArgumentError, "Dia inválido para o mês especificado" unless day.between?(1, 31)

        # Valida se a data é válida
        Date.new(year, month, day)
      rescue Date::Error
        raise ArgumentError, "Data inválida: #{year}-#{month}-#{day}"
      end

      def determine_cycle(date)
        if date.sunday?
          LectionaryReading.cycle_for_year(date.year)
        else
          LectionaryReading.even_or_odd_year?(date.year)
        end
      end

      def find_readings_for_date(date, cycle, service_type = "eucharist")
        prayer_book = PrayerBook.find_by_code(prayer_book_code)

        # TODO: Implementar suporte a reading_type (semicontinuous vs complementary)
        # Quando implementado, buscar a preferência do usuário:
        # reading_type = get_user_reading_type_preference(prayer_book.code)
        # E filtrar as leituras por reading_type também

        # Primeiro tenta encontrar por celebração fixa
        celebration = Celebration.fixed.for_date(date.month, date.day).where(prayer_book_id: prayer_book.id).first

        if celebration
          reading = LectionaryReading
                      .where(celebration_id: celebration.id)
                      .where(service_type: service_type)
                      .where(prayer_book_id: prayer_book.id)
                      .where("cycle = ? OR cycle = ?", cycle, "all")
                      .first
          return reading if reading
        end

        # Se não encontrou, busca por referência de data (domingo ou dia da semana)
        calendar = LiturgicalCalendar.new(date.year)
        date_ref = if date.sunday?
          calendar.sunday_name(date)&.parameterize(separator: "_")
        else
          season = calendar.season_for_date(date)
          "#{season.parameterize(separator: '_')}_weekday"
        end

        return nil unless date_ref

        LectionaryReading
          .for_date_reference(date_ref)
          .where(service_type: service_type)
          .where(prayer_book_id: prayer_book.id)
          .where("cycle = ? OR cycle = ?", cycle, "all")
          .first
      end

      # Helper method para obter a preferência de reading_type do usuário
      # def get_user_reading_type_preference(prayer_book_code)
      #   return params[:reading_type] if params[:reading_type].present?
      #   return current_user&.prayer_book_preferences_for(prayer_book_code)&.dig("lectionary", "reading_type") || "semicontinuous"
      # end

      def prayer_book_code
        # Priority: URL param > User preference > Default
        return params[:prayer_book_code] if params[:prayer_book_code].present?
        return current_user.preferences["prayer_book_code"] if current_user&.preferences&.dig("prayer_book_code")

        "loc_2015"
      end

      def format_readings_response(reading, date, cycle)
        {
          data: date.to_s,
          dia_da_semana: day_name_pt(date),
          ciclo: cycle,
          tipo_servico: service_type_pt(reading.service_type),
          leituras: format_reading(reading)
        }
      end

      def format_reading(reading)
        {
          primeira_leitura: reading.first_reading,
          salmo: reading.psalm,
          segunda_leitura: reading.second_reading,
          evangelho: reading.gospel,
          notas: reading.notes
        }
      end

      def day_name_pt(date)
        names = %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado]
        names[date.wday]
      end

      def service_type_pt(service_type)
        {
          "eucharist" => "Santa Eucaristia",
          "morning_prayer" => "Oração Matutina",
          "evening_prayer" => "Oração Vespertina"
        }[service_type] || service_type
      end
    end
  end
end
