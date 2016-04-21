class ViewerController < ApplicationController
  include HtmlOnly
  include CurrentVariant
  include CurrentViewer
  include ViewerLogger

  around_action :cache_action

  layout 'viewer'

  helper_method :current_variant

  def show
    render locals: {
      current_landing: current_landing,
      variant:         current_variant,
      viewer_uid:      current_viewer_uid
    }
  end

  private

  # Пример: https://github.com/rails/actionpack-action_caching/blob/master/lib/action_controller/caching/actions.rb
  #
  def cache_action
    self.response_body = cache [AppVersion.to_s, :viewer, current_variant.viewer_cache_key] do
      yield
    end
  end

  def current_landing
    @_current_landing ||= current_variant.landing
  end
end
