class UserMailer < BaseMailer
  def reset_password_email(user_id)
    @user = User.find user_id
    @url = edit_password_reset_url(@user.reset_password_token)

    fail NoEmail, "User: #{user_id}" unless @user.email.present?

    mail(to: @user.email,
         subject: I18n.t('mailers.user_mailer.reset_password_instructions.subject'))
  end

  def email_confirmation(user_id)
    @user = User.find user_id
    @url = @user.email_confirmation_url

    fail NoEmail, "User: #{user_id}" unless @user.email.present?

    mail(to: @user.email,
         subject: "#{Settings.app.title}: E-mail confirmation")
  end
end
