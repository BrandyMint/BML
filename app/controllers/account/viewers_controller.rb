class Account::ViewersController < Landing::BaseController
  include VariantInParameter
  layout 'viewers'

  def index
    render locals: { viewers: viewers }
  end

  def show
    viewer = current_landing.viewers.find params[:id]
    redirect_to account_landing_views_url(current_landing, viewer_uid: viewer.uid)
  end

  private

  def viewers
    paginate ViewersQuery
      .new(landing_id: current_landing.id)
      .call
  end
end
