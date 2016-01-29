class Section < ActiveRecord::Base
  serialize :content, JSON

  belongs_to :landing_version
  belongs_to :background_image, class_name: 'AssetImage'

  scope :ordered, -> { order :row_order }

  def meta
    {}
  end
end
