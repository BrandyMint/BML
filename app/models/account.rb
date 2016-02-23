class Account < ActiveRecord::Base
  include AccountAccessKey
  include AccountIdent
  include LandingSubdomain

  ROOT_IDENT = 'root'

  scope :ordered, -> { order 'id desc' }

  has_many :landings,    dependent: :destroy
  has_many :collections, through: :landings, dependent: :destroy

  has_many :versions, through: :landings

  has_many :asset_files, dependent: :destroy
  has_many :asset_images

  has_many :authentications, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def default_landing
    landings.ordered.first
  end

  def to_s
    "#{domain}"
  end

  def api_key
    access_key
  end

  def self.root_account
    find_by_ident ROOT_IDENT
  end
end
