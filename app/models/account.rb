class Account < ActiveRecord::Base
  include AccountAccessKey
  include AccountIdent

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

  def to_s
    "#{domain}"
  end

  def domain
    subdomain + '.bmland.ru'
  end

  def subdomain
    AccountConstraint::DOMAIN_PREFIX + ident
  end

  def api_key
    access_key
  end

  def self.root_account
    find_by_ident ROOT_IDENT
  end
end
