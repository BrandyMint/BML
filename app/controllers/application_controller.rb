class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception unless Rails.env.development?
  include ApplicationHelper

  before_action :setup_gon

  private

  def setup_gon
    gon.i18n = {
      locale:        I18n.locale,
      defaultLocale: I18n.default_locale
    }
  end
end
