class Account::ClientsController < Landing::BaseController
  def index
    render locals: {
      clients: clients
    }
  end

  private

  def clients
    current_landing.clients
  end
end
