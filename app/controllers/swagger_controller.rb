class SwaggerController < SwaggerUI::ApplicationController
  private

  def discovery_url
    request.path + '/v1/swagger_doc'
  end
end
