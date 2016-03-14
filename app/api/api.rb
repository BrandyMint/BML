class API < Grape::API
  VERSION = 'v1'.freeze

  default_format :json

  # С этим не работает swagger
  # format :json
  version VERSION

  mount API::Landings
  mount API::Variants
  mount API::UtmValues
  mount API::Images
  mount APIPing

  add_swagger_documentation api_version: VERSION,
                            markdown: GrapeSwagger::Markdown::KramdownAdapter,
                            base_path: '',
                            hide_documentation_path: true
  # ,
  # models: [API::Entity::GoodsResult, API::Entity::Good]
end
