class API::Landings < Grape::API
  include StrongParams
  include Authorization

  desc 'Посадочные страницы'
  resources :landings do

    desc 'Список доступных лендингов'
    get do
      current_account.landings.ordered
    end

    params do
      requires :landing_uuid, type: String, desc: 'iUUID Лендинга'
    end
    namespace ':landing_uuid' do
      helpers do
        def landing
          current_account.landings.find_by_uuid params[:panding_uuid]
        end
      end

      desc 'Варианты лендинга'
      resources :landing_versions do

        desc 'Список вариантов'
        get do
          present landing.versions.ordered
        end

        params do
          requires :uuid, type: String, desc: 'UUID Лендинга'
        end

        namespace ':uuid' do
          helpers do
            def landing_version
              landing.versions.find_by_uuid params[:panding_uuid]
            end
          end


          desc 'Вносим изменения в существующий вариант'
          params do
            optional :title, String
            optional :data, String, desc: 'JSON-строка с данными'
          end
          put do
            landing_version
            current_account.
              UserRequest.create! strong_params.permit(*UserRequest::FIELDS)
          end

        end

      end

    end

  end
end
