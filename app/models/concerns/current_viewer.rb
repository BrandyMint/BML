module CurrentViewer
  extend ActiveSupport::Concern

  SESSION_KEY = :viewer_uid

  private

  def current_viewer
    @_current_viewer ||= session_viewer
  end

  def set_session_viewer(request)
    request.session[current_variant.landing.uuid] = { SESSION_KEY => request.session.id }
  end

  def session_viewer_uid
    session[current_variant.landing.uuid][SESSION_KEY]
  end

  def session_viewer
    return nil unless session_viewer_uid

    FindOrCreateViewer.new(uid: session.id).call
  end
end
