class API::Variants < Grape::API
  include StrongParams
  include Authorization

  before do
    header 'Access-Control-Allow-Origin', '*'
  end

  desc 'Варианты посадочных страниц'
  resources :variants do
    params do
      requires :uuid, type: String, desc: 'UUID Варианта'
    end

    namespace ':uuid' do
      helpers do
        def variant
          current_account.variants.find_by_uuid! params[:uuid]
        end
      end

      desc 'Вносим изменения в существующий вариант'
      params do
        optional :blocks, type: Array[Hash], desc: 'JSON-строка с массивом данных секции (пример: https://github.com/BrandyMint/BML/blob/master/app/models/landing_examples.rb#L2)'
      end
      put do
        if params[:blocks].is_a? Array
          SectionsUpdater.new(variant).update blocks: params[:blocks]
        end

        present variant.reload, with: Entities::VariantEntity
      end

      desc 'Получаем данные сайта'
      get do
        present variant, with: Entities::VariantEntity
      end
    end
  end
end
