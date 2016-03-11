class ViewerController < ApplicationController
  include CurrentVariant
  include CurrentViewer

  layout 'viewer'

  before_action :log_request
  helper_method :current_variant
  helper_method :current_viewer

  def show
    render locals: {
      current_landing: current_variant.landing,
      variant: current_variant
    }
  end

  private

  def log_request
    RequestLogger.new(
      worker: LandingViewWorker,
      request: request,
      viewer: current_viewer,
      variant: current_variant
    ).call
  end
end
