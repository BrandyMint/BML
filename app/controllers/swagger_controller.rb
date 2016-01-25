class ::SwaggerController < ApplicationController
  layout 'swagger'

  def index
    render locals: {
      title:         Settings.app.title,
      home_url:      system_root_url,
      discovery_url: request.path + '/v1/swagger_doc'
    }
  end
end
