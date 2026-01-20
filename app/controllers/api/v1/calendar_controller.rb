module Api
  module V1
    class CalendarController < ApplicationController
      include Authenticatable
      include Concerns::PreferencesResolver
      include DateValidations
      include LiturgicalFormatting

      before_action :authenticate_user_optional
      before_action :validate_preferences!

      # GET /api/v1/calendar/today
      # Retorna informações litúrgicas do dia de hoje
      def today
        date = Date.today
        cache_key = "calendar/today/#{date}/#{resolved_prayer_book_code}/#{resolved_bible_version}"

        response = Rails.cache.fetch(cache_key, expires_in: 1.day) do
          calendar = LiturgicalCalendar.new(date.year, prayer_book_code: resolved_prayer_book_code)
          info = calendar.day_info(date)
          format_day_response(info, date)
        end

        render json: response
      rescue ArgumentError => e
        render json: { error: "Erro ao buscar dados: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/calendar/:year/:month/:day
      # Retorna informações litúrgicas de um dia específico
      def day
        date = parse_date
        cache_key = "calendar/day/#{date}/#{resolved_prayer_book_code}/#{resolved_bible_version}"

        response = Rails.cache.fetch(cache_key, expires_in: 1.day) do
          calendar = LiturgicalCalendar.new(date.year, prayer_book_code: resolved_prayer_book_code)
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
        month_num = params[:month].to_i

        validate_year_month(year, month_num)

        calendar = LiturgicalCalendar.new(year, prayer_book_code: resolved_prayer_book_code)
        days = calendar.month_calendar(month_num)

        render json: {
          year: year,
          month: month_num,
          month_name: month_name_pt(month_num),
          days: days.map { |info| format_day_response(info, Date.parse(info[:date])) }
        }
      rescue ArgumentError => e
        render json: { error: "Data inválida: #{e.message}" }, status: :bad_request
      end

      # GET /api/v1/calendar/:year
      # Retorna o calendário litúrgico completo de um ano
      def year
        year_num = params[:year].to_i

        validate_year(year_num)

        calendar = LiturgicalCalendar.new(year_num, prayer_book_code: resolved_prayer_book_code)

        render json: {
          year: year_num,
          movable_dates: Liturgical::EasterCalculator.new(year_num).all_movable_dates,
          seasons_summary: seasons_summary(calendar),
          important_dates: important_dates_summary(year_num)
        }
      rescue ArgumentError => e
        render json: { error: "Ano inválido: #{e.message}" }, status: :bad_request
      end

      private

      def format_day_response(info, date)
        {
          season_post_slug: info[:season_post_slug],
          date: info[:date],
          day_of_week: info[:day_of_week],
          liturgical_season: info[:liturgical_season],
          liturgical_color: info[:color],
          liturgical_year: info[:liturgical_year],
          is_sunday: info[:is_sunday],
          is_holy_day: info[:is_holy_day],
          sunday_name: info[:sunday_name],
          description: info[:description],
          week_of_season: info[:week_of_season],
          proper_week: info[:proper_week],
          sunday_after_pentecost: info[:sunday_after_pentecost],
          celebration: info[:celebration],
          saint: info[:saint],
          collect: CollectService.new(date, prayer_book_code: resolved_prayer_book_code).find_collects,
          readings: ReadingService.for(date, prayer_book_code: resolved_prayer_book_code, translation: resolved_bible_version).find_readings
        }
      end

      def seasons_summary(calendar)
        LiturgicalSeason::SEASONS.map do |season|
          {
            nome: season,
            cor_padrao: LiturgicalSeason.find_by(name: season)&.color,
            post_slug: Liturgical::SeasonDeterminator::SEASON_SLUGS[season]
          }
        end
      end

      def important_dates_summary(year)
        calc = Liturgical::EasterCalculator.new(year)
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
    end
  end
end
