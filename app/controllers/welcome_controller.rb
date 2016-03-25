class WelcomeController < ApplicationController
  include HtmlOnly
  include CurrentViewer
  include CurrentVariant
  include ViewerLogger

  layout 'welcome'

  def index
    render locals: { variant_uuid: current_variant.uuid, tariffs: tariffs }
  end

  private

  def current_landing
    @_current_landing ||= Account.root.landings.active.where(path: '/').first || raise("У рутового аккаунта нет ни одного активного сайта с путем '/'")
  end

  def current_variant
    current_landing.default_variant
  end

  def tariffs
    Tariff.published
  end
end
