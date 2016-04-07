# Хелперы для отправки писем и SMS
# TODO: Перевести на сервис
class NotifierHelpers
  # Верительные грамоты отправителя
  class Sender
    include Virtus.model
    # TODO: email
    attribute :sms, SmsWorker::Credentials
  end

  def send_email(sender, emails, mailer, method, payload)
    raise unless sender.is_a? Sender
    if emails.present?
      mailer.delay.send(method, emails, payload)
    else
      log "No emails to send SMS #{emails} #{key} #{payload}"
    end
  end

  def send_sms(sender, phones, key, payload = nil)
    raise unless sender.is_a? Sender

    if phones.present?
      SmsWorker.perform_async sender.sms.to_hash, phones, sms_text(key, payload)
    else
      log "No phones to send SMS #{phones} #{key} #{payload}"
    end
  end

  def log(message)
    Rails.logger.info message
  end

  def log_error(message)
    Rails.logger.error message
  end

  private

  def sms_text(key, payload = {})
    I18n.t key, payload.merge!(scope: [:notifications, :sms], raise: true)
  end
end
