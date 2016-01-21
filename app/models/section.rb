class Section < ActiveRecord::Base
  # include RankedModel

  serialize :data_serialized, JSON

  belongs_to :landing_version

  before_create :generate_uuid

  scope :ordered, -> { rank :row_order }

  alias_attribute :data, :data_serialized

  private

  def generate_uuid
    self.uuid ||= UUID.new.generate
  end
end
