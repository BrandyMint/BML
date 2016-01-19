class Landing::ApplicationController < Account::ApplicationController
  layout 'landing'

  helper_method :current_landing

  private

  def current_landing
    @_current_landing ||= current_account.landings.find params[:landing_id]
  end
end
