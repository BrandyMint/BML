class SiteController < ApplicationController
  include CurrentAccountSupport

  def index
    render locals: { landings: current_account.landings.active.ordered }
  end
end
