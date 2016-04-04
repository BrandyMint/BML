class API::Variants < Grape::API
  include StrongParams
  include CurrentAccountSupport
  include AvailableLandingSupport

  DEFAULT_TITLE = 'Без названия'.freeze
  BLANK_UUID = 'blank'.freeze

  EXAMPLE_UUID = '5fe7acad-e5bf-4cc5-8dab-7e2e21a7cc6b'.freeze
  EXAMPLE_UUID_NAME = 'example'.freeze

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

  resources :variants do
    desc 'Список вариантов'
    params do
      requires :landing_uuid, type: String, desc: 'UUID Сайта'
      optional :full, type: Boolean, desc: 'Презентировать весь сайт', default: false
    end
    get do
      variants = available_landing.variants.active.ordered
      if params[:full]
        present variants, with: Entities::VariantEntity
      else
        present variants, with: Entities::VariantInfoEntity
      end
    end

    desc 'Создаем новый вариант'
    params do
      optional :uuid, type: String, desc: 'UUID Варианта'
      optional :title,      type: String
      optional :theme_name, type: String
      optional :is_boxed,   type: Boolean
      optional :blocks,     type: Array[Hash], desc: 'JSON-строка с массивом данных секции (пример: https://github.com/BrandyMint/BML/blob/master/app/models/landing_examples.rb#L2)'
    end
    post do
      update_variant params
    end

    namespace ':uuid' do
      helpers do
        def uuid
          if params[:uuid] == EXAMPLE_UUID_NAME
            current_account.variants.first.uuid
          else
            params[:uuid]
          end
        end
      end

      desc 'Вносим изменения в существующий вариант'
      params do
        optional :title,      type: String
        optional :theme_name, type: String
        optional :is_boxed,   type: Boolean
        optional :blocks,     type: Array[Hash], desc: 'JSON-строка с массивом данных секции (пример: https://github.com/BrandyMint/BML/blob/master/app/models/landing_examples.rb#L2)'
      end
      put do
        update_variant params, uuid
      end

      desc 'Получаем данные сайта'
      get do
        variant = current_account.variants.find_by_uuid! uuid
        present variant, with: Entities::VariantEntity
      end
    end
  end
end
