class LandingView < ActiveRecord::Base
  belongs_to :account
  belongs_to :landing
  belongs_to :variant
  has_one :viewer, primary_key: :viewer_uid, foreign_key: :uid
end
