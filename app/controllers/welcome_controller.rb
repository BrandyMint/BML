class WelcomeController < ApplicationController
  include HtmlOnly

  layout 'welcome'

  def index
    # redirect_to 'http://molodost.bz' if request.domain.ends_with? 'bmland.ru'
    # redirect_to 'http://molodost.bz'
    render locals: { variant_uuid: default_variant.uuid }
  end

  private

  delegate :default_landing, to: :account_root
  delegate :default_variant, to: :default_landing

  def account_root
    Account.root
  end
end
