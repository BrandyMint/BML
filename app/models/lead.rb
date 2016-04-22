class Lead < CollectionItem
  include TrackingSupport

  belongs_to :client

  validates :variant, presence: true
end
