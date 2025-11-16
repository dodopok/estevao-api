module Api
  module V1
    class CalendarController < ApplicationController
      # GET /api/v1/calendar/:year/:month/:day
      # Retorna informações litúrgicas de um dia específico
      def day
        date = parse_date
        calendar = LiturgicalCalendar.new(date.year)
        info = calendar.day_info(date)

        render json: format_day_response(info, date)
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
          is_sunday: info[:is_sunday],
          is_holy_day: info[:is_holy_day],
          sunday_name: info[:sunday_name],
          week_of_season: info[:week_of_season],
          sunday_after_pentecost: info[:sunday_after_pentecost],
          celebration: info[:celebration],
          saint: info[:saint],
          collect: collect_for_day(date),
          readings: readings_for_day(date)
        }
      end

      def collect_for_day(date)
        # Busca a coleta do dia
        # Prioridade: celebração > domingo > quadra
        celebration = Celebration.fixed.for_date(date.month, date.day).first

        collect = if celebration
          Collect.for_celebration(celebration.id).in_language("pt-BR").first
        else
          # Buscar coleta de domingo ou quadra
          calendar = LiturgicalCalendar.new(date.year)
          season_name = calendar.season_for_date(date)
          season = LiturgicalSeason.find_by(name: season_name)
          season ? Collect.for_season(season.id).in_language("pt-BR").first : nil
        end

        collect ? { text: collect.text } : nil
      end

      def readings_for_day(date)
        # Determina o ciclo do ano
        cycle = date.sunday? ? LectionaryReading.cycle_for_year(date.year) : LectionaryReading.even_or_odd_year?(date.year)

        # Busca leituras
        celebration = Celebration.fixed.for_date(date.month, date.day).first

        if celebration
          readings = LectionaryReading.where(celebration_id: celebration.id, cycle: ["all", cycle])
                                      .service_type_eucharist
                                      .first
        else
          # Buscar leituras do domingo ou dia
          calendar = LiturgicalCalendar.new(date.year)
          date_ref = calendar.sunday_name(date)&.parameterize(separator: "_") || "weekday"
          readings = LectionaryReading.for_date_reference(date_ref)
                                      .for_cycle(cycle)
                                      .service_type_eucharist
                                      .first
        end

        if readings
          {
            first_reading: readings.first_reading,
            psalm: readings.psalm,
            second_reading: readings.second_reading,
            gospel: readings.gospel
          }
        end
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
