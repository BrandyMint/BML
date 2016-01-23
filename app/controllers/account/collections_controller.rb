class Account::CollectionsController < Landing::ApplicationController
  layout 'landing'

  def index
    render locals: { collections: current_landing.collections, form: form }
  end

  private

  def form
    (params[:form] || 1).to_i
  end
end
