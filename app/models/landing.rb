class Landing < ActiveRecord::Base
  include Activity
  include LandingPath
  # include LandingSubdomain

  belongs_to :account, counter_cache: true

  has_many :collections, dependent: :destroy
  has_many :versions, class_name: 'LandingVersion', dependent: :destroy
  has_many :segments, dependent: :destroy
  has_many :clients, dependent: :destroy

  validates :title, presence: true

  after_create :create_default_version

  scope :ordered, -> { order 'id desc' }
  scope :active, -> { all }

  def url
    'http://' + account.host + path
  end

  def to_s
    title
  end

  def total_leads_count
    collections
      .sum(:leads_count)
  end

  def default_collection
    collections
      .first_or_create!
  end

  def default_version
    versions
      .active
      .ordered
      .first
  end

  private

  def create_default_version
    versions.create!
  end
end
