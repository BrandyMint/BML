module ProfileHelper
  def user_email_confirmation_hint(user)
    return if user.email_confirmed?
    buffer = ''
    buffer << 'E-mail НЕ подтвержден'
    buffer.html_safe
  end

  def user_phone_confirmation_hint(user)
    return if user.phone_confirmed?
    buffer = ''
    buffer << 'Телефон НЕ подтвержден'
    buffer.html_safe
  end

  def user_phone_confirmation_label(user)
    return if user.phone_confirmed? || user.phone.blank?
    content_tag :span, 'Не подтвержден', class: 'label label-default'
  end

  def user_email_confirmation_label(user)
    return if user.email_confirmed? || user.email.blank?
    content_tag :span, 'Не подтвержден', class: 'label label-default'
  end

  def user_send_email_confirmation_link
    link_to('Отправить ссылку для подтверждения',
                      send_email_confirmation_profile_url,
                      class: 'btn btn-sm btn-warning-outline',
                      method: :post)
  end

  def user_send_phone_confirmation_link(phone)
    link_to('Отправить SMS для подтверждения',
                      new_profile_phone_confirmation_url(phone: phone, backurl: request.url),
                      class: 'btn btn-sm btn-warning-outline'
           )
  end
end
