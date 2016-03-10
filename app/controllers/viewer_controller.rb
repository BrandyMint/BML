class ViewerController < ApplicationController
  include CurrentLanding

  layout 'viewer'

  before_action :log_request
  helper_method :current_variant

  def show
    render locals: {
      current_landing: current_variant.landing,
      variant: current_variant
    }
  end

  def log_request
    RequestLogger.new(
      worker: LandingViewWorker,
      request: request,
      variant: current_variant
    ).call
  end
end
