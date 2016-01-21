module CurrentAccount
  NoCurrentAccount = Class.new StandardError

  def current_account
    if Thread.current[:account].present?
      Thread.current[:account]
    else
      fail NoCurrentAccount
    end
  end

  def set_current_account(account)
    Thread.current[:account] = account
  end

  def safe_current_account
    current_account
  rescue NoCurrentAccount
    nil
  end
end
