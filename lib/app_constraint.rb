require 'domain_helper'

class AppConstraint
  include DomainHelper

  def matches?(request)
    app = find_app request

    AppSettings.current_app = app

    request.tld_length = AppSettings.tld_length
    Rails.application.routes.default_url_options = AppSettings.default_url_options.symbolize_keys

    app
  end
end
