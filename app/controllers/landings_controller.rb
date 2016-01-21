class LandingsController < ApplicationController
  include CurrentAccountSupport

  def show
    landing = current_account.landings.find params[:id]

    landing_version = if params[:version_id]
      landing.versions.find params[:version_id]
    else
      landing.default_version
    end

    render locals: { landing_version: landing_version }
  end
end
