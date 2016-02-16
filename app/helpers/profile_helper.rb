module ProfileHelper
  def user_email_confirmation_hint(user)
    if user.email_confirmed?
      'E-mail подтвержден'
    else
      buffer = ''
      buffer << 'E-mail НЕ подтвержден'
      buffer << user_send_email_confirmation_link(user)
      buffer.html_safe
    end
  end

  def user_phone_confirmation_hint(user)
    if user.phone_confirmed?
      'Телефон подтвержден'
    else
      'Телефон НЕ подтвержден'
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

  def user_send_email_confirmation_link(user)
    return if user.email_confirmed? || user.email.blank?
    buffer = ''
    buffer << '&nbsp;'
    buffer << link_to('Подтвердить', send_email_confirmation_profile_url, method: :post)
    buffer.html_safe
  end
end
