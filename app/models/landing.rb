class Landing < ActiveRecord::Base
  include Activity

  belongs_to :account, counter_cache: true

  has_many :collections, dependent: :destroy
  has_many :versions, class_name: 'LandingVersion', dependent: :destroy
  has_many :segments, dependent: :destroy

  has_one :subdomain, dependent: :destroy

  validates :title, presence: true

  scope :ordered, -> { order :id }
  scope :active, -> { all }

  accepts_nested_attributes_for :subdomain

  after_create :create_subdomain

  delegate :current_domain, to: :subdomain

  def to_s
    title
  end

  def default_version
    versions.active.ordered.first
  end

  def host
    'http://' + current_domain
  end

  private

  def create_subdomain
    create_subdomain! subdomain: account.subdomain
  end
end
