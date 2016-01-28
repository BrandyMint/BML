class API::Landings < Grape::API
  include StrongParams
  include Authorization

  desc 'Посадочные страницы'
  resources :landings do

    desc 'Список доступных лендингов'
    get do
      present current_account.landings.ordered, with: Entities::LandingEntity
    end

    params do
      requires :landing_uuid, type: String, desc: 'UUID Лендинга'
    end
    namespace ':landing_uuid' do
      helpers do
        def landing
          current_account.landings.find_by_uuid! params[:landing_uuid]
        end
      end

      desc 'Варианты лендинга'
      resources :landing_versions do

        desc 'Список вариантов'
        get do
          present landing.versions.ordered, with: Entities::LandingVersionEntity
        end
      end
    end
  end
end
