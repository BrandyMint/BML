class AssetFile < ActiveRecord::Base
  include AssetFileDigest

  belongs_to :account
  belongs_to :landing
  belongs_to :landing_version

  mount_uploader :file, ImageUploader

  scope :ordered, -> { order :id }
  scope :shared,  -> { where account_id: nil }

  delegate :url, to: :file
end
