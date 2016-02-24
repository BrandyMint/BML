class LandingController < ApplicationController
  include CurrentLanding

  def show
    render locals: { current_landing: current_landing_version.landing }, layout: 'public'
  end
end
