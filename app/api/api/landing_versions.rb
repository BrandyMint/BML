class API::LandingVersions < Grape::API
  include StrongParams
  include Authorization

  before do
    header 'Access-Control-Allow-Origin', '*'
  end

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

      # content-type: application/json
      desc 'Вносим изменения в существующий вариант'
      params do
        optional :blocks, type: Array[Hash], desc: 'JSON-строка с массивом данных секции (пример: https://github.com/BrandyMint/BML/blob/master/app/models/landing_examples.rb#L2)'
      end
      put do
        if params[:blocks].is_a? Array
          SectionsUpdater.new(landing_version).update blocks: params[:blocks]
        end

        present landing_version.reload, with: Entities::LandingVersionEntity
      end
    end
  end
end
