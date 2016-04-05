# Отправляет sms
class SmsWorker
  autoload :Result,      'sms_worker/results'
  autoload :AllRight,    'sms_worker/results'
  autoload :Error,       'sms_worker/results'
  autoload :Credentials, 'sms_worker/credentials'

  LOG_ENTITY_MODEL = AccountSmsLogEntity
  SystemSender = Credentials.new(Secrets.smsc).to_hash

  include Sidekiq::Worker
  sidekiq_options queue: :critical, retry: true

  def perform(credentials, phones, message)
    @credentials = Credentials.new credentials
    @phones = prepare_phones phones
    @message = message.strip.chomp

    rails_log_start

    if Rails.env.production?
      production_send
    else
      develop_send
    end
  rescue Result => result
    log_sms result
  rescue => err
    Bugsnag.notify err, metaData: { credentials: @credentials, phones: phones, message: message }
    log_sms err
  else
    raise "Всегда должно завершаться ошибкой"
  end

  private

  attr_reader :phones, :message, :credentials

  def log_sms(result)
    LOG_ENTITY_MODEL.create!(
      account_id: credentials.account_id,
      smsc_login: credentials.login,
      smsc_sender: credentials.sender,
      message: message,
      phones: phones,
      result: result.to_s
    )
  end

  def develop_send
    if Rails.env.development?
      # rubocop:disable Rails/Output
      puts
      puts '---------------------------------'
      puts "SEND SMS to #{phones}: #{message}"
      puts '---------------------------------'
      puts
    end
    raise AllRight, 'dev-ok'
  end

  def production_send
    sms = Smsc::Sms.new credentials.login, credentials.password
    res = sms.message message, phones, sender: credentials.sender

    raise AllRight, res.body.to_s if res.body.start_with? 'OK'
    raise Error, res.body.to_s
  end

  def rails_log_start
    Rails.logger.debug "SEND SMS (#{credentials}: #{phones.join(', ')}: #{message}"
  end

  def prepare_phones(phones)
    (phones.is_a?(Array) ? phones : phones.to_s.split(/,\s/))
      .map! { |phone| phone.sub '+', '' }
  end
end
