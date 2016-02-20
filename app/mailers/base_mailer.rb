class BaseMailer < ActionMailer::Base
  helper :application
  # helper :money

  default Settings.mailer_defaults.symbolize_keys

  self.default_url_options = Settings.action_mailer.default_url_options.symbolize_keys

  def self.delay
    Proxy.new(self)
  end

  def test_email(email)
    Rails.logger.info "test mail mail to #{email}"
    mail to: email, subject: "Тестовое письмо #{Settings.app.title}"
  end

  class CancelMailing < StandardError; end
  class NoEmail < CancelMailing; end

  class Proxy
    def initialize(mailer)
      @mailer = mailer
    end

    def method_missing(method, *args)
      if @mailer.instance_methods.include? method.to_sym
        @mailer.send_mail_with_worker @mailer.name, method, *args
      else
        fail NameError, "No such method #{method} in mailer #{@mailer}"
      end
    end
  end

  def send_mail_with_worker(name, method, *args)
    MailerWorker.perform_async name, method, *args
  end

  private

  # Способ избавиться от повторной попытки
  # отправить sidekiq-ом письмо, если реально
  # этого не требуется
  def smart_retry
    yield
  rescue ActiveRecord::RecordNotFound, CancelMailing, NoEmail => err
    Rails.logger.error err

    mail_stub
  end

  # Пустышка для sidekiq, чтобы ему было что вызвать, когда
  # мы реально письмо не составляли
  def mail_stub
    OpenStruct.new deliver_now: true
  end
end