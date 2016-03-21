class ApplicationController < ActionController::Base
  include CurrentAccount
  include CurrentMember
  include MessageVerifierConcern
  include HandleErrors
  include BugsnagSupport

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception unless Rails.env.development?

  before_action :setup_gon_locales

  private

  def paginate(scope)
    scope
      .page(params[:page])
      .per(params[:per])
  end

  def setup_gon_locales
    gon.i18n = {
      locale:        I18n.locale,
      defaultLocale: I18n.default_locale
    }
  end

  def authenticate_admin!
    authenticate_or_request_with_http_basic('Whatever') do |username, password|
      username == Secrets.sidekiq.username && password == Secrets.sidekiq.password
    end
  end
end
