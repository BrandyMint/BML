require 'uuid'

class AssetFile < ActiveRecord::Base
  include AssetFileDigest

  belongs_to :account
  belongs_to :landing
  belongs_to :variant
  belongs_to :wizard_answer

  mount_uploader :file, ImageUploader

  scope :ordered, -> { order :id }
  scope :shared,  -> { where account_id: nil }

  delegate :url, to: :file

  before_create :generate_uuid

  private

  def generate_uuid
    self.uuid ||= UUID.generate
  end
end
