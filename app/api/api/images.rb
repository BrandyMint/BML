class API::Images < Grape::API
  include StrongParams
  include Authorization

  before do
    header 'Access-Control-Allow-Origin', '*'
  end

  desc 'Изображения'
  resources :images do
    desc 'Загружаем изображение'
    params do
      optional :landing_uuid, type: String, desc: 'Сайт к которому загружается это изображение'
      optional :variant_uuid, type: String, desc: 'Версия сайта к которой загружается это изображение'
      requires :file, type: Rack::Multipart::UploadedFile, desc: 'Содержимое изображения дла загрузки'
    end
    post do
      new_image = current_account.asset_images.build file: params[:file]
      image = current_account.asset_images.find_by_digest new_image.file.digest

      unless image
        new_image.save!
        image = new_image
      end

      present image, with: Entities::AssetImageEntity
    end

    desc 'Получаем список всех изображений в аккаунте'
    get do
      present current_account.asset_images.ordered, with: Entities::AssetImageEntity
    end
  end
end
