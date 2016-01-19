class AccountConstraint
  extend CurrentAccount

  def self.matches?(request)
    account = Account.find_by_id request.subdomain

    if account.present?
      set_current_account account
      return true
    else
      set_current_account nil
      return false
    end
  end
end
