class Landing < ActiveRecord::Base
  include Activity

  belongs_to :account, counter_cache: true

  has_many :collections
  has_many :versions, class_name: 'LandingVersion'
  has_many :segments

  validates :title, presence: true

  scope :ordered, -> { order :id }
  scope :active, -> { all }

  def to_s
    title
  end

  def default_version
    versions.active.ordered.first
  end
end
