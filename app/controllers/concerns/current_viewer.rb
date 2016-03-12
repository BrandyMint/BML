module CurrentViewer
  extend ActiveSupport::Concern

  included do
    before_filter :save_viewer
  end

  private

  def current_viewer_uid
    viewers_session[current_variant.landing.uuid] ||= UUID.generate
  end

  def viewers_session
    session[:viewers] ||= {}
  end

  def save_viewer
    Viewer.touch_or_create current_viewer_uid
  end
end
