class Landing::BaseController < Account::BaseController
  layout 'landing'

  helper_method :current_landing, :current_variant

  private

  def current_landing
    @_current_landing ||= current_account.landings.find params[:landing_id]
  end

  def current_variant
    nil
  end
end
