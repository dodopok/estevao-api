module Api
  module V1
    class LectionaryController < ApplicationController
      include Authenticatable
      include Concerns::PreferencesResolver
      include DateValidations
      include LiturgicalFormatting

      before_action :authenticate_user_optional
      before_action :validate_preferences!

      # GET /api/v1/lectionary/:year/:month/:day
      # Retorna as leituras para um dia específico
      def day
        date = parse_date

        # Usa o ReadingService para buscar leituras
        reading_service = ReadingService.for(
          date,
          prayer_book_code: resolved_prayer_book_code,
          translation: resolved_bible_version,
          reading_type: resolved_preferences[:reading_type]
        )

        readings = reading_service.find_readings

        if readings && readings[:first_reading]
          render json: {
            data: date.to_s,
            dia_da_semana: day_name_pt(date),
            ciclo: reading_service.cycle,
            leituras: {
              primeira_leitura: readings[:first_reading][:reference],
              salmo: readings[:psalm][:reference],
              segunda_leitura: readings[:second_reading]&.dig(:reference),
              evangelho: readings[:gospel]&.dig(:reference)
            }
          }
        else
          render json: {
            data: date.to_s,
            ciclo: reading_service.cycle,
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

        # TODO: Implementar lógica para buscar leituras de múltiplos serviços
        # Por enquanto, retorna apenas leituras eucarísticas
        reading_service = ReadingService.for(
          date,
          prayer_book_code: resolved_prayer_book_code,
          translation: resolved_bible_version,
          reading_type: resolved_preferences[:reading_type]
        )

        readings = reading_service.find_readings

        render json: {
          data: date.to_s,
          dia_da_semana: day_name_pt(date),
          ciclo: reading_service.cycle,
          santa_eucaristia: readings && readings[:first_reading] ? {
            primeira_leitura: readings[:first_reading][:reference],
            salmo: readings[:psalm][:reference],
            segunda_leitura: readings[:second_reading]&.dig(:reference),
            evangelho: readings[:gospel]&.dig(:reference)
          } : nil,
          oracao_matutina: nil,
          oracao_vespertina: nil
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

      def resolved_prayer_book_code
        resolved_preferences[:prayer_book_code] || "loc_2015"
      end

      def resolved_bible_version
        resolved_preferences[:bible_version] || "nvi"
      end
    end
  end
end
