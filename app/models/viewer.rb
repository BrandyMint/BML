class Viewer < ActiveRecord::Base
  has_many :views, class_name: 'LandingView', primary_key: :uid, foreign_key: :viewer_uid
end
