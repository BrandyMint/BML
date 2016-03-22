class UserMailer < BaseMailer
  def reset_password_email(user_id)
    @user = User.find user_id
    @url = edit_password_reset_url(@user.reset_password_token)

    raise NoEmail, "User: #{user_id}" unless @user.email.present?

    mail(to: @user.email,
         from: AppSettings.from,
         subject: I18n.t('mailers.user_mailer.reset_password_instructions.subject'))
  end

  def email_confirmation(user_id)
    @user = User.find user_id
    @url = @user.email_confirmation_url

    raise NoEmail, "User: #{user_id}" unless @user.email.present?

    mail(to: @user.email,
         from: AppSettings.from,
         subject: I18n.t('mailers.user_mailer.email_confirmation.subject', title: AppSettings.title))
  end
end
