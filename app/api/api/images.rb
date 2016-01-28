class API::Images < Grape::API
  include StrongParams
  include Authorization

  before do
    header "Access-Control-Allow-Origin", "*"
  end

  desc 'Изображения'
  resources :images do

    desc 'Загружаем изображение'
    params do
      optional :landing_uuid,         type: String, desc: 'Лендинг к которому загружается это изображение'
      optional :landing_version_uuid, type: String, desc: 'Версия лендинга к которой загружается это изображение'
      requires :file,                 type: Rack::Multipart::UploadedFile, desc: 'Содержимое изображения дла загрузки'
    end
    post do
      image = current_account.asset_images.create! file: params[:file]

      present image, with: Entities::AssetImageEntity
    end

    desc 'Получаем список всех изображений в аккаунте'
    get do
      present current_account.asset_images.ordered, with: Entities::AssetImageEntity
    end
  end
end
