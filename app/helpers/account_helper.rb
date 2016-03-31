module AccountHelper
  def account_billing_title
    "Баланс (#{humanized_money_with_symbol current_account.billing_account.amount})"
  end
end
