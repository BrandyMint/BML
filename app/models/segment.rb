class Segment < ActiveRecord::Base
  belongs_to :landing, counter_cache: :segments_count

  validates :title, presence: true

  scope :ordered, -> { order :id }

  def details
  end
end
