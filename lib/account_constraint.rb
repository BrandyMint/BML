class AccountConstraint
  PREFIX = 'a-'

  extend CurrentAccount

  def self.matches?(request)
    ident = request.subdomain

    return false unless ident.start_with? PREFIX
    account = Account.find_by_ident ident.sub PREFIX, ''

    if account.present?
      set_current_account account
      return true
    else
      set_current_account nil
      return false
    end
  end
end
