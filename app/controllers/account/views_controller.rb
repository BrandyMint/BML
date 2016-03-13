class Account::ViewsController < Landing::BaseController
  include VariantInParameter
  layout 'views'

  def index
    render locals: { viewer: viewer, views: views }
  end

  private

  def viewer
    @_viewer ||= find_viewer
  end

  def find_viewer
    current_landing.viewers.find_by_uid(params[:viewer_uid]) || fail('No such viewer')
  end

  def views
    paginate ViewsQuery
      .new(landing_id: current_landing.id, viewer_uid: viewer.uid)
      .call
  end
end
