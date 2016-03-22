class InviteMailer < BaseMailer
  def new_invite(invite_id)
    Rails.logger.info "user mail new_invite #{invite_id}"
    invite = Invite.find invite_id

    @invite = invite
    @url = invite.url

    mail(to: invite.email,
         from: AppSettings.from,
         subject: I18n.t('mailers.invite_mailer.new_invite.subject', account: invite.account.to_s))
  end

  def added_to_account(inviter_id, user_id, account_id, role)
    @inviter = User.find inviter_id
    @user = User.find user_id
    @account = Account.find account_id
    @role = role

    raise NoEmail, "User: #{user_id}" unless @user.email.present?

    mail(to: @user.email,
         from: AppSettings.from,
         subject: I18n.t('mailers.invite_mailer.added_to_account.subject', account: @account.to_s))
  end
end
