class API::UtmValues < Grape::API
  include StrongParams
  include Authorization

  desc 'Значения utm'
  resources :utm_values do
    helpers do
      def current_landing
        @_current_landing ||= current_account.landings.find params[:landing_id]
      end
    end

    desc 'Autocomplete', entity: Entities::UtmValueEntity
    params do
      requires :key_type, type: String
      requires :query, type: String
    end
    get :autocomplete do
      utm_values = Entities::UtmValueEntity.represent current_landing.utm_values.by_key_value(params[:key_type], params[:query])
      present items: utm_values
    end
  end
end
