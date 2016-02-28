class WelcomeController < ApplicationController
  include HtmlOnly

  layout 'welcome'

  def index
    # redirect_to 'http://molodost.bz' if request.domain.ends_with? 'bmland.ru'
    # redirect_to 'http://molodost.bz'
    render locals: { landing_version_uuid: landing_version_uuid }
  end

  private

  def landing_version_uuid
    root_account.landings.ordered.last.versions.ordered.last.uuid
  end

  def root_account
    Account.root_account
  end
end
