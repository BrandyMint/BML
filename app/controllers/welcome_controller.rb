class WelcomeController < ApplicationController
  include HtmlOnly
  include CurrentViewer
  include ViewerLogger

  layout 'welcome'

  def index
    render locals: { variant_uuid: current_variant.uuid }
  end

  private

  def current_landing
    @_current_landing ||= Account.root.landings.active.where(path: '/').first
  end

  def current_variant
    current_landing.default_variant
  end
end
