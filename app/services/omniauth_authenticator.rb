require 'securerandom'

class OmniauthAuthenticator
  include Virtus.model

  attribute :account, Account, required: true
  attribute :auth_hash, Hash,  required: true

  def authentificate
    return find || attach || raise_error
  rescue StandardError => err
    Bugsnag.notify err, metaData: { account_id: account.id, provider: provider, uid: uid, auth_hash: auth_hash }
    raise err
  end

  private

  delegate :provider, :uid, to: :auth_hash_p

  def auth_hash_p
    AuthHashPresenter.new auth_hash
  end

  def raise_error
    raise 'Auth is not found and not created'
  end

  def find
    auth = account.authentications.where(provider: provider, uid: uid).first
    return nil unless auth.present?
    auth.update_attribute :auth_hash, auth_hash
    auth
  end

  def attach
    account.authentications.create! do |a|
      a.provider   = provider
      a.uid        = uid
      a.auth_hash  = auth_hash
    end
  end
end
