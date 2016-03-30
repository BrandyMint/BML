class API::Variants < Grape::API
  include StrongParams
  include Authorization

  DEFAULT_TITLE = 'Без названия'.freeze
  BLANK_UUID = 'blank'.freeze

  before do
    header 'Access-Control-Allow-Origin', '*'
  end

  helpers do
    def update_variant(params, uuid = nil)
      if uuid.present?
        variant = current_account.variants.find_by_uuid! uuid unless uuid == BLANK_UUID
      else
        landing = current_account.landings.create! title: params[:title] || DEFAULT_TITLE
        variant = landing.variants.create!
      end

      if params[:blocks].is_a? Array
        SectionsUpdater.new(variant).update blocks: params[:blocks]
      end

      variant_attributes = params.slice(:is_boxed, :theme_name, :title)
      variant.update_attributes! variant_attributes

      present variant.reload, with: Entities::VariantEntity
    end
  end

  desc 'Варианты посадочных страниц'
  resources :variants do
    params do
      requires :uuid, type: String, desc: 'UUID Варианта'
    end

    desc 'Создаем новый вариант'
    params do
      optional :title,      type: String
      optional :theme_name, type: String
      optional :is_boxed,   type: Boolean
      optional :blocks,     type: Array[Hash], desc: 'JSON-строка с массивом данных секции (пример: https://github.com/BrandyMint/BML/blob/master/app/models/landing_examples.rb#L2)'
    end
    post do
      update_variant params
    end

    namespace ':uuid' do
      desc 'Вносим изменения в существующий вариант'
      params do
        optional :title,      type: String
        optional :theme_name, type: String
        optional :is_boxed,   type: Boolean
        optional :blocks,     type: Array[Hash], desc: 'JSON-строка с массивом данных секции (пример: https://github.com/BrandyMint/BML/blob/master/app/models/landing_examples.rb#L2)'
      end
      put do
        update_variant params, params[:uuid]
      end

      desc 'Получаем данные сайта'
      get do
        variant = current_account.variants.find_by_uuid! params[:uuid]
        present variant, with: Entities::VariantEntity
      end
    end
  end
end
