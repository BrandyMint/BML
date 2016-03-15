module UserPasswordReset
  # Переопределяем sorcery-методы для асинхронной отправки писем
  def send_reset_password_email!
    UserMailer.delay.reset_password_email id
  end

  def deliver_reset_password_instructions!
    mail = false
    config = sorcery_config
    # hammering protection
    return false if config.reset_password_time_between_emails.present? && send(config.reset_password_email_sent_at_attribute_name) && send(config.reset_password_email_sent_at_attribute_name) > config.reset_password_time_between_emails.seconds.ago.utc

    generate_reset_password_token!
    mail = send_reset_password_email! unless config.reset_password_mailer_disabled

    mail
  end
end
