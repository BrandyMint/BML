class SwaggerUI::ApplicationController < ApplicationController
  layout "swagger"

  helper_method :discovery_url, :api_key, :support_header_params

  def index
  end

  private

  def api_key
  end

  def support_header_params
    false
  end

  def discovery_url
    "http://<%= request.host%>:<%=request.port%>/api/swagger_doc"
  end
end
