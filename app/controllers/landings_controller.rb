class LandingsController < ApplicationController
  include CurrentAccountSupport
  include CurrentLanding

  helper_method :current_landing_versoin

  def show
    render locals: { landing_version: current_landing_version }
  end
end
