module MembersHelper
  def member_sms_notification_label(member)
    if member.user.phone_confirmed?
      if member.sms_notification?
        content_tag :span, class: 'label label-success' do
          fa_icon :check, text: 'включены'
        end
      else
        content_tag :span, class: 'label label-default' do
          fa_icon :ban, text: 'отключены'
        end
      end
    else
      user_phone_confirmation_label member.user
    end
  end

  def member_email_notification_label(member)
    if member.user.email_confirmed?
      if member.email_notification?
        content_tag :span, class: 'label label-success' do
          fa_icon :check, text: 'включены'
        end
      else
        content_tag :span, class: 'label label-default' do
          fa_icon :ban, text: 'отключены'
        end
      end
    else
      user_email_confirmation_label member.user
    end
  end

  def user_phone_confirmation_label(user)
    return if user.phone_confirmed? || user.phone.blank?
    content_tag :span, 'Не подтвержден', class: 'label label-default'
  end

  def user_email_confirmation_label(user)
    return if user.email_confirmed? || user.email.blank?
    content_tag :span, 'Не подтвержден', class: 'label label-default'
  end

  def member_user_send_email_confirmation_link(member)
    return if member.user.email_confirmed? || member.user.email.blank?
    buffer = ''
    buffer << '&nbsp;'
    buffer << link_to('Подтвердить', send_email_confirmation_account_membership_url(member), method: :post)
    buffer.html_safe
  end

  def member_role_label(object)
    raise "Must be Member or Invite, but it is #{object.class}" unless object.is_a?(Invite) || object.is_a?(Membership)

    css = 'label '
    css << case object.role.to_sym
           when :owner
             'label-warning'
           when :master
             'label-primary'
           when :analyst
             'label-info'
           when :guest
             'label-default'
           else
             'label-default'
           end

    content_tag :span, class: css do
      object.role_text
    end
  end
end
