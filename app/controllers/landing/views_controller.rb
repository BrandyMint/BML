class Landing::ViewsController < Landing::BaseController
  include VariantInParameter
  layout 'analytics'

  def index
    render locals: { viewer: viewer, views: views }
  end

  private

  def viewer
    @_viewer ||= find_viewer
  end

  def find_viewer
    return unless params[:viewer_uid]
    current_landing.viewers.find_by_uid(params[:viewer_uid]) || raise('No such viewer')
  end

  def views
    paginate ViewsQuery
      .new(landing_id: current_landing.id, viewer_uid: viewer.try(:uid))
      .call
  end
end
