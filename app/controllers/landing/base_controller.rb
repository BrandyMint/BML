class Landing::BaseController < Account::BaseController
  layout 'landing'

  helper_method :current_landing, :current_variant

  private

  def setup_gon
    gon.i18n = {
      locale:        I18n.locale,
      defaultLocale: I18n.default_locale,
    }
    gon.api_url = api_url
    gon.access_token = current_account.access_key
    gon.current_landing_id = current_landing.id
  end

  def current_landing
    @_current_landing ||= current_account.landings.find params[:landing_id]
  end

  def current_variant
    nil
  end
end
