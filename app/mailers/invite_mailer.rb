class InviteMailer < BaseMailer
  def new_invite(invite_id)
    Rails.logger.info "user mail new_invite #{invite_id}"
    invite = Invite.find invite_id

    @invite = invite
    @url = invite.url

    mail(to: invite.email, subject: I18n.t('mailers.invite_mailer.new_invite.subject', account: invite.account.to_s))
  end
end
