module CurrentAccount
  extend ActiveSupport::Concern

  SESSION_KEY = :account_id

  included do
    helper_method :current_account
  end

  private

  def current_account
    session_account
  end

  def set_current_account(account)
    session[SESSION_KEY] = account.id
  end

  def delete_current_account
    session[SESSION_KEY] = nil
  end

  def session_account_id
    session[SESSION_KEY]
  end

  def session_account
    return nil unless session_account_id

    Account.find_by_id(session_account_id) || fail("No suche account #{session_account_id} in database")
  end
end
