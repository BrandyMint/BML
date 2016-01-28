class API < Grape::API
  default_format :json

  # С этим не работает swagger
  # format :json
  version 'v1'

  mount API::Landings
  mount API::LandingVersions
  mount APIPing

  add_swagger_documentation api_version: 'v1',
                            markdown: GrapeSwagger::Markdown::KramdownAdapter,
                            base_path: '',
                            hide_documentation_path: true
  # ,
  # models: [API::Entity::GoodsResult, API::Entity::Good]
end
