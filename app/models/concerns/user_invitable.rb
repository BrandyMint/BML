module UserInvitable
  extend ActiveSupport::Concern
  # Используется в форме регистрации
  # По нему идет привязка также, как и по email, телефон
  # Благодаря этому пользователь может изменить email/телефон при регистрации
  attr_accessor :invite_key

  included do
    after_commit :activate_invites!, on: :create

    validate :validate_invitation
  end

  def invited_account
    invite.try :account
  end

  def invite
    @invite ||= Invite.find_by_key invite_key
  end

  def validate_invitation
    return unless invite_key.present?
    return if invite.present?
    errors[:invite_key] = I18n.t('errors.invite.invalid')
  end

  private

  def activate_invites!
    Invite.by_user(self).each { |i| i.accept! self }
  end
end
