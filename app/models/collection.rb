class Collection < ActiveRecord::Base
  belongs_to :landing
  has_many :items, class_name: 'CollectionItem'
  has_many :fields, class_name: 'CollectionField'

  scope :ordered, -> { order :id }

  def to_s
    "Коллекция #{created_at.to_s}"
  end
end
