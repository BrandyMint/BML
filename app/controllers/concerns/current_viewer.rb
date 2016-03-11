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
    now = Time.now
    sql = ActiveRecord::Base.send(:sanitize_sql_array, ["INSERT INTO viewers (uid, created_at, updated_at) VALUES (?, ?, ?) ON CONFLICT (uid) DO UPDATE SET updated_at = ?", current_viewer_uid, now, now, now])
    ActiveRecord::Base.connection.execute(sql)
  end
end
