class LandingController < ApplicationController
  include CurrentLanding

  layout 'public'

  def show
    render locals: {
      current_landing: current_landing_version.landing,
      variant: current_landing_version
    }
  end
end
