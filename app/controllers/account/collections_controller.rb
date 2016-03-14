class Account::CollectionsController < Landing::BaseController
  layout 'landing_settings'

  def index
    render locals: { collections: current_landing.collections }
  end
end
