class Account::ViewersController < Landing::BaseController
  include VariantInParameter
  layout 'viewers'

  def index
    render locals: { viewers: viewers }
  end

  private

  def viewers
    paginate ViewersQuery
      .new(landing_id: current_landing.id)
      .call
  end
end
