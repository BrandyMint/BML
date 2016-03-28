class ApplicationController < ActionController::Base
  include CurrentAccount
  include CurrentMember
  include MessageVerifierConcern
  include HandleErrors
  include BugsnagSupport
  include InvitesHelper
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception unless Rails.env.development?

  before_action :setup_gon_locales

  private

  def after_login!(user, credentials)
    user.confirm_some_phone!(*credentials)
    invite.accept! user if invite.present?
  end

  def paginate(scope)
    scope
      .page(params[:page])
      .per(safe_per_page)
  end

  def safe_per_page
    per_page.to_i <= Settings.maximal_per_page ? per_page : Settings.maximal_per_page
  end

  def per_page
    params[:per]
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
