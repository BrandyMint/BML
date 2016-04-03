class API::UtmValues < Grape::API
  include StrongParams
  include CurrentAccountSupport

  desc 'Значения utm'
  resources :utm_values do
    helpers do
      def current_landing
        @_current_landing ||= current_account.landings.find params[:landing_id]
      end

      def autocomplete_query
        UtmValuesQuery.new.search(params[:key_type], params[:query], current_landing.id)
      end
    end

    desc 'Autocomplete', entity: Entities::UtmValueEntity
    params do
      requires :key_type, type: String
      requires :query, type: String
    end
    get :autocomplete do
      utm_values = Entities::UtmValueEntity.represent autocomplete_query
      present items: utm_values
    end
  end
end
