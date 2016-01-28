class Authentication < ActiveRecord::Base
  belongs_to :account

  serialize :auth_hash, JSON

  scope :by_provider, ->(provider) { where(provider: provider) }
  scope :by_uid, ->(uid) { where(uid: uid) }

  validates :provider, presence: true
  validates :uid, presence: true

  delegate :url, :nickname, :avatar_url, :username, :access_token, :expires_at, :expired?, to: :data

  def self.providers
    @providers ||= Authentication.group(:provider).order(:provider).pluck(:provider).map(&:to_sym)
  end

  def data
    AuthHashPresenter.new auth_hash
  end

  def to_s
    [provider, uid].join ':'
  end

  def vk_client
    @vk_client ||= VkontakteApi::Client.new access_token
  end

  def profile_url
    case provider.to_sym
    when :instagram
      'http://instagram.com/' + nickname
    when :facebook
      'http://facebook.com/' + uid
    when :vkontakte
      auth_hash['info']['urls']['Vkontakte']
    end
  end

  def info
    OpenStruct.new(auth_hash['info'] || {})
  end

  def image_url
    case provider.to_sym
    when :instagram, :facebook, :vkontakte
      info.image
    end
  end
end

# <Authentication id: 51, provider: "walletone", uid: "116123546647", auth_hash: {"provider"=>"walletone", "uid"=>116123546647, "info"=>{"user_id"=>116123546647, "name"=>nil}, "credentials"=>{"token"=>"2559215a-9eaa-4284-8055-265513c56d98", "expires"=>"2015-03-27T19:00:04.58Z"}, "extra"=>{"raw_info"=>{"ClientId"=>"kiiiosk.ru", "CreateDate"=>"2015-01-26T19:00:04.58Z", "ExpireDate"=>"2015-03-27T19:00:04.58Z", "Scope"=>"GetBalance.CurrencyId(643) GetOperationHistory", "Timeout"=>5184000, "Token"=>"2559215a-9eaa-4284-8055-265513c56d98", "UserId"=>116123546647}}}, created_at: "2015-01-26 19:00:07", updated_at: "2015-01-26 19:00:07", confirmed: false, authenticatable_id: 5, authenticatable_type: "Vendor">
