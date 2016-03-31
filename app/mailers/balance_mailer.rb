class BalanceMailer < BaseMailer
  def charge_error_email(account_id, year, month)
    @account = Account.find account_id
    @user = @account.memberships.with_role(:owner).first
    @payments_url = account_payments_url
    @billing_url = account_billing_url
    @date = Date.new year.to_i, month.to_i

    raise NoEmail, "User: #{user_id}" unless @user.email.present?

    mail(to: @user.email,
         from: AppSettings.from,
         subject: I18n.t('mailers.balance_mailer.charge_error_email.subject'))
  end
end
