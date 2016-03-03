class ViewerController < ApplicationController
  include CurrentLanding

  layout 'viewer'

  helper_method :current_variant

  def show
    render locals: {
      current_landing: current_variant.landing,
      variant: current_variant
    }
  end
end
