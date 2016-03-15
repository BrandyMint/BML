module CurrentViewer
  extend ActiveSupport::Concern

  included do
    before_action :save_viewer
  end

  private

  def current_viewer_uid
    viewers_session[current_variant.landing.uuid] ||= UUID.generate
  end

  def viewers_session
    session[:viewers] ||= {}
  end

  def save_viewer
    TouchOrCreateViewer
      .new(viewer_uid: current_viewer_uid, remote_ip: request.remote_ip, user_agent: request.user_agent || '', landing_id: current_landing.id)
      .call
  end
end
