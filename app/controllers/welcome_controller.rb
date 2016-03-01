class WelcomeController < ApplicationController
  include HtmlOnly

  layout 'welcome'

  def index
    # redirect_to 'http://molodost.bz' if request.domain.ends_with? 'bmland.ru'
    # redirect_to 'http://molodost.bz'
    render locals: { variant_uuid: variant_uuid }
  end

  private

  def variant_uuid
    root_account.landings.ordered.last.variants.ordered.last.uuid
  end

  def root_account
    Account.root_account
  end
end
