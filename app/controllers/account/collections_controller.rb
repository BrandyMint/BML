class Account::CollectionsController < Landing::ApplicationController
  def index
    render locals: { collections: current_landing.collections }
  end
end
