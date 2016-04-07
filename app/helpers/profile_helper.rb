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

  def user_sms_notification_checkbox(f)
    if f.object.user.phone_confirmed?
      f.input :sms_notification, label: false
    else
      checkbox_with_tooltip 'Необходимо подтвердить телефон' do
        f.input :sms_notification, label: false, disabled: true
      end
    end
  end

  def user_email_notification_checkbox(f)
    if f.object.user.email_confirmed?
      f.input :email_notification, label: false
    else
      checkbox_with_tooltip 'Необходимо подтвердить e-mail' do
        f.input :email_notification, label: false, disabled: true
      end
    end
  end

  def checkbox_with_tooltip(title)
    content_tag :div, class: 'checkbox-tooltip', title: title, tooltip: true do
      yield
    end
  end
end
