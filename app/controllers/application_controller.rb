class ApplicationController < ActionController::Base
  include CurrentAccount
  include CurrentMember
  include MessageVerifierConcern

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception unless Rails.env.development?

  before_action :setup_gon

  private

  def paginate(scope)
    scope
      .page(params[:page])
      .per(params[:per])
  end

  def setup_gon
    gon.i18n = {
      locale:        I18n.locale,
      defaultLocale: I18n.default_locale
    }
  end
end
