class API::Collections < Grape::API
  include StrongParams
  include CurrentUserSupport
  include AvailableLandingSupport

  before do
    header 'Access-Control-Allow-Origin', '*'
  end

  params do
    requires :landing_uuid, type: String
  end
  resources :collections do
    desc 'Все коллекции'
    get do
      present available_landing.collections, with: Entities::CollectionEntity
    end
  end
end
