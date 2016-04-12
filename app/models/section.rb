class Section < ActiveRecord::Base
  include SectionDataBuilder

  serialize :content, JSON
  serialize :form, JSON

  belongs_to :variant
  has_one :landing, through: :variant

  belongs_to :background_image, class_name: 'AssetImage'

  scope :ordered, -> { order :row_order }

  def meta
    {}
  end
end
