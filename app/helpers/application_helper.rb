module ApplicationHelper
  def account_home_url(account)
    account_root_url(subdomain: account.subdomain)
  end
end
