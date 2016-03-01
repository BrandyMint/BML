class Section < ActiveRecord::Base
  serialize :content, JSON
  serialize :form, JSON

  belongs_to :variant
  belongs_to :background_image, class_name: 'AssetImage'

  scope :ordered, -> { order :row_order }

  def meta
    {}
  end
end
