class ViewerController < ApplicationController
  include CurrentVariant
  include CurrentViewer
  include ViewerLogger

  layout 'viewer'

  helper_method :current_variant

  def show
    render locals: {
      current_landing: current_variant.landing,
      variant: current_variant,
      viewer_uid: current_viewer_uid
    }
  end
end
