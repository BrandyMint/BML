module CurrentViewer
  extend ActiveSupport::Concern

  included do
    before_action :save_viewer
  end

  private

  def session_key
    "viewer_#{current_variant.landing_id}"
  end

  def current_viewer_uid
    params[:viewer_uid] || session[session_key] ||= UUID.generate
  end

  def save_viewer
    TouchOrCreateViewer
      .new(viewer_uid: current_viewer_uid, remote_ip: request.remote_ip, user_agent: request.user_agent || '', landing_id: current_landing.id)
      .call
  end
end
