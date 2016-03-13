class Viewer < ActiveRecord::Base
  belongs_to :landing

  def views
    LandingView.where(landing_id: landing_id, viewer_uid: uid)
  end

  def to_s
    uid
  end

  def views_count
    @_views_count ||= views.count
  end
end
