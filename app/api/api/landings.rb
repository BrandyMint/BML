class API::Landings < Grape::API
  include StrongParams
  include CurrentAccountSupport

  desc 'Посадочные страницы'
  resources :landings do
    desc 'Список доступных сайтов'
    get do
      present current_account.landings.ordered, with: Entities::LandingEntity
    end
  end
end
