class ViewerController < ApplicationController
  include HtmlOnly
  include CurrentVariant
  include CurrentViewer
  include ViewerLogger

  layout 'viewer'

  helper_method :current_variant

  def show
    cache [AppVersion.to_s, :viewer, current_variant] do
      render locals: {
        current_landing: current_landing,
        variant:         current_variant,
        viewer_uid:      current_viewer_uid
      }
    end
  end

  private

  def current_landing
    @_current_landing ||= current_variant.landing
  end
end
