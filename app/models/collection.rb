class Collection < ActiveRecord::Base
  belongs_to :landing
  has_many :items, class_name: 'CollectionItem'
  has_many :fields, class_name: 'CollectionField'
end
