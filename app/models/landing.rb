class Landing < ActiveRecord::Base
  include Activity

  belongs_to :account, counter_cache: true

  has_many :collections, dependent: :destroy
  has_many :versions, class_name: 'LandingVersion', dependent: :destroy
  has_many :segments, dependent: :destroy

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
