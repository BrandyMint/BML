class ViewerController < ApplicationController
  include CurrentLanding

  layout 'viewer'

  def show
    render locals: {
      current_landing: current_variant.landing,
      variant: current_variant
    }
  end
end
