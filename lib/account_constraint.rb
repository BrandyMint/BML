class AccountConstraint
  extend CurrentAccount

  def self.matches?(request)
    ident = request.subdomain

    account = Account.find_by_ident ident

    if account.present?
      set_current_account account
      return true
    else
      set_current_account nil
      return false
    end
  end
end
