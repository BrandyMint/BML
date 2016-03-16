class Viewer < ActiveRecord::Base
  belongs_to :landing

  delegate :count, to: :views, prefix: true

  def views
    LandingView.where(landing_id: landing_id, viewer_uid: uid)
  end

  def to_s
    uid
  end
end
