module NotifierHelpers
  def send_email(emails, mailer, method, payload)
    if emails.present?
      mailer.delay.send(method, emails, payload)
    else
      log "No emails to send SMS #{emails} #{key} #{payload}"
    end
  end

  def send_sms(phones, key, payload = nil)
    if phones.present?
      SmsWorker.perform_async phones, sms_text(key, payload)
    else
      log "No phones to send SMS #{phones} #{key} #{payload}"
    end
  end

  def safe
    yield
  rescue => error
    log_error "error #{error}"
    raise error if Rails.env.test?
    Bugsnag.notify error
  end

  private

  def sms_text(key, payload = {})
    I18n.t key, payload.merge!(scope: [:notifications, :sms], raise: true)
  end

  def log(message)
    Rails.logger.info message
  end

  def log_error(message)
    Rails.logger.error message
  end
end
