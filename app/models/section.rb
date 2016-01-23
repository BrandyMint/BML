class Section < ActiveRecord::Base
  # include RankedModel

  serialize :data_serialized, JSON

  belongs_to :landing_version

  scope :ordered, -> { order :row_order }

  alias_attribute :data, :data_serialized
end
