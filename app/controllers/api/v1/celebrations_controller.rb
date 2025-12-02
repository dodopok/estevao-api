module Api
  module V1
    class CelebrationsController < ApplicationController
      include Authenticatable
      include Concerns::PreferencesResolver

      before_action :authenticate_user_optional
      before_action :validate_preferences!, except: [ :types ]

      # GET /api/v1/celebrations
      # Lista todas as celebrações
      def index
        prayer_book = resolved_prayer_book
        celebrations = Celebration.where(prayer_book_id: prayer_book.id).by_rank

        # Filtros opcionais
        celebrations = celebrations.where(celebration_type: params[:type]) if params[:type].present?
        celebrations = celebrations.where(movable: params[:movable]) if params[:movable].present?

        render json: {
          total: celebrations.count,
          celebracoes: celebrations.map { |c| format_celebration(c) }
        }
      end

      # GET /api/v1/celebrations/:id
      # Detalhes de uma celebração específica
      def show
        prayer_book = resolved_prayer_book
        celebration = Celebration.where(prayer_book_id: prayer_book.id).find(params[:id])

        render json: {
          celebracao: format_celebration_detailed(celebration)
        }
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Celebração não encontrada" }, status: :not_found
      end

      # GET /api/v1/celebrations/search
      # Busca celebrações por nome
      def search
        query = params[:q]

        if query.blank?
          render json: { error: "Parâmetro 'q' é obrigatório" }, status: :bad_request
          return
        end

        prayer_book = resolved_prayer_book
        celebrations = Celebration.where(prayer_book_id: prayer_book.id)
                                  .where("name ILIKE ?", "%#{query}%")
                                  .by_rank

        render json: {
          total: celebrations.count,
          celebracoes: celebrations.map { |c| format_celebration(c) }
        }
      end

      # GET /api/v1/celebrations/date/:month/:day
      # Celebrações em uma data específica (mês e dia)
      def by_date
        month = params[:month].to_i
        day = params[:day].to_i

        unless month.between?(1, 12) && day.between?(1, 31)
          render json: { error: "Data inválida" }, status: :bad_request
          return
        end

        prayer_book = resolved_prayer_book
        celebrations = Celebration.where(prayer_book_id: prayer_book.id)
                                  .for_date(month, day)
                                  .by_rank

        render json: {
          mes: month,
          dia: day,
          total: celebrations.count,
          celebracoes: celebrations.map { |c| format_celebration(c) }
        }
      end

      # GET /api/v1/celebrations/types
      # Lista os tipos de celebração
      def types
        render json: {
          tipos: Celebration.celebration_types.keys.map do |type|
            {
              valor: type,
              nome: type_name_pt(type),
              descricao: type_description_pt(type)
            }
          end
        }
      end

      private

      def format_celebration(celebration)
        {
          id: celebration.id,
          nome: celebration.name,
          nome_latino: celebration.latin_name,
          tipo: celebration.celebration_type,
          tipo_nome: type_name_pt(celebration.celebration_type),
          rank: celebration.rank,
          data_fixa: celebration.movable ? nil : {
            mes: celebration.fixed_month,
            dia: celebration.fixed_day
          },
          movel: celebration.movable,
          cor_liturgica: celebration.liturgical_color
        }
      end

      def format_celebration_detailed(celebration)
        basic = format_celebration(celebration)
        basic.merge({
          descricao: celebration.description,
          pode_ser_transferida: celebration.can_be_transferred,
          regras_transferencia: celebration.transfer_rules,
          regra_calculo: celebration.calculation_rule,
          coletas: celebration.collects.in_language("pt-BR").map { |c| { texto: c.text } },
          leituras: celebration.lectionary_readings.eucharistic.map { |r| format_reading(r) }
        })
      end

      def format_reading(reading)
        {
          ciclo: reading.cycle,
          primeira_leitura: reading.first_reading,
          salmo: reading.psalm,
          segunda_leitura: reading.second_reading,
          evangelho: reading.gospel
        }
      end

      def type_name_pt(type)
        {
          "principal_feast" => "Festa Principal",
          "major_holy_day" => "Dia Santo Principal",
          "festival" => "Festival",
          "lesser_feast" => "Festa Menor",
          "commemoration" => "Comemoração"
        }[type] || type
      end

      def type_description_pt(type)
        {
          "principal_feast" => "Festas Principais (CAIXA ALTA, negrito, vermelho) - precedem domingos",
          "major_holy_day" => "Dias Santos Principais - Quarta-feira de Cinzas, Quinta-feira Santa, Sexta-feira da Paixão",
          "festival" => "Festivais (vermelho) - dias de apóstolos, evangelistas e santos importantes",
          "lesser_feast" => "Festas Menores (texto simples) - outros santos e dias comemorativos",
          "commemoration" => "Comemorações - menções nas intercessões apenas"
        }[type] || ""
      end
    end
  end
end
