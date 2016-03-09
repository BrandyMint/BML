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
      optional :full, type: Boolean, desc: 'Презентировать весь лендос', default: false
    end
    namespace ':landing_uuid' do
      helpers do
        def landing
          current_account.landings.find_by_uuid! params[:landing_uuid]
        end
      end

      desc 'Варианты лендинга'
      resources :variants do
        desc 'Список вариантов'
        get do
          if params[:full]
            present landing.variants.active.ordered, with: Entities::VariantEntity
          else
            present landing.variants.active.ordered, with: Entities::VariantInfoEntity
          end
        end
      end
    end
  end
end
