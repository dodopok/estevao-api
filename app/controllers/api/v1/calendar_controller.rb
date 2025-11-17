module Api
  module V1
    class CalendarController < ApplicationController
      # GET /api/v1/calendar/:year/:month/:day
      # Retorna informações litúrgicas de um dia específico
      def day
        date = parse_date

        # Cache the response for 1 day since liturgical data doesn't change
        response = Rails.cache.fetch("liturgical_day_#{date}", expires_in: 1.day) do
          calendar = LiturgicalCalendar.new(date.year)
          info = calendar.day_info(date)
          format_day_response(info, date)
        end

        render json: response
      rescue ArgumentError => e
        render json: { error: "Data inválida: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/calendar/:year/:month
      # Retorna o calendário litúrgico de um mês
      def month
        year = params[:year].to_i
        month = params[:month].to_i

        validate_year_month(year, month)

        calendar = LiturgicalCalendar.new(year)
        days = calendar.month_calendar(month)

        render json: {
          year: year,
          month: month,
          month_name: month_name_pt(month),
          days: days.map { |info| format_day_response(info, Date.parse(info[:date])) }
        }
      rescue ArgumentError => e
        render json: { error: "Data inválida: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/calendar/:year
      # Retorna o calendário litúrgico completo de um ano
      def year
        year = params[:year].to_i

        validate_year(year)

        calendar = LiturgicalCalendar.new(year)

        # Retorna informações resumidas do ano
        render json: {
          year: year,
          movable_dates: EasterCalculator.new(year).all_movable_dates,
          seasons_summary: seasons_summary(calendar),
          important_dates: important_dates_summary(year)
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

      def validate_year_month(year, month)
        validate_year(year)
        raise ArgumentError, "Mês deve estar entre 1 e 12" unless month.between?(1, 12)
      end

      def validate_year_month_day(year, month, day)
        validate_year_month(year, month)
        raise ArgumentError, "Dia inválido para o mês especificado" unless day.between?(1, 31)
      end

      def format_day_response(info, date)
        {
          date: info[:date],
          day_of_week: info[:day_of_week],
          liturgical_season: info[:liturgical_season],
          liturgical_color: info[:color],
          liturgical_year: info[:liturgical_year],
          is_sunday: info[:is_sunday],
          is_holy_day: info[:is_holy_day],
          sunday_name: info[:sunday_name],
          week_of_season: info[:week_of_season],
          proper_week: info[:proper_week],
          sunday_after_pentecost: info[:sunday_after_pentecost],
          celebration: info[:celebration],
          saint: info[:saint],
          collect: CollectService.new(date).find_collects,
          readings: ReadingService.new(date).find_readings
        }
      end

      def seasons_summary(calendar)
        LiturgicalSeason::SEASONS.map do |season|
          {
            nome: season,
            cor_padrao: LiturgicalSeason.find_by(name: season)&.color
          }
        end
      end

      def important_dates_summary(year)
        calc = EasterCalculator.new(year)
        movable = calc.all_movable_dates

        {
          pascoa: movable[:easter],
          quarta_feira_de_cinzas: movable[:ash_wednesday],
          domingo_de_ramos: movable[:palm_sunday],
          sexta_feira_da_paixao: movable[:good_friday],
          ascensao: movable[:ascension],
          pentecostes: movable[:pentecost],
          trindade: movable[:trinity_sunday],
          cristo_rei: movable[:christ_the_king],
          advento: movable[:first_sunday_of_advent]
        }
      end

      def month_name_pt(month)
        %w[_ Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro][month]
      end
    end
  end
end
