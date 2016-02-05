class LandingsController < ApplicationController
  include CurrentAccount
  include CurrentLanding
  include CurrentAccountSupport

  helper_method :current_landing_version

  def index
    render locals: { account: current_account }
  end

  def show
    render locals: { landing_version: current_landing_version }
  end
end
