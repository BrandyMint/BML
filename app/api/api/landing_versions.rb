class API::LandingVersions < Grape::API
  include StrongParams
  include Authorization

  desc 'Варианты посадочных страниц'
  resources :landing_versions do
    params do
      requires :uuid, type: String, desc: 'UUID Варианта'
    end

    namespace ':uuid' do
      helpers do
        def landing_version
          current_account.versions.find_by_uuid! params[:uuid]
        end
      end

      desc 'Вносим изменения в существующий вариант'
      params do
        optional :blocks, type: String, desc: 'JSON-строка с массивом данных секции (пример: https://github.com/BrandyMint/BML/blob/master/app/models/landing_examples.rb#L2)'
      end
      put do
        if params[:blocks].present?
          blocks = JSON.parse params[:blocks]
          SectionsUpdater.new(landing_version).update blocks: blocks
        end

        present landing_version.reload, with: Entities::LandingVersionEntity
      end
    end
  end
end
