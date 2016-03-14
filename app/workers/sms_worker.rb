class SmsWorker
  include Sidekiq::Worker
  sidekiq_options queue: :critical, retry: true

  def perform(phones, message)
    phones = phones.to_s.split(/,\s/) unless phones.is_a? Array
    phones.map! { |phone| phone.sub '+', '' }

    Rails.logger.debug "SEND SMS: #{phones.join(', ')}: #{message}"

    if Rails.env.production?
      sms = Smsc::Sms.new Secrets.smsc.login, Secrets.smsc.password
      res = sms.message message.strip.chomp, phones, sender: Secrets.smsc.sender

      raise Error, 'raise message' if message == 'raise'

      if res.body.start_with? 'OK'
        Rails.logger.debug "SMS #{res.body}"
      else
        Rails.logger.error "SMS #{res.body}"
        error = Error.new res.body.to_s
        # SupportMailer.sos_mail('На SMSC кончились деньги: https://smsc.ru/pay/') if error.code == 3 || error.message == 'no money'
        raise error if error.fatal?
      end
    elsif !Rails.env.test?

      # rubocop:disable Rails/Output
      puts
      puts '---------------------------------'
      puts "SEND SMS to #{phones}: #{message}"
      puts '---------------------------------'
      puts
    end
  end

  # Примеры ответов из Smsc:
  #
  # "OK - 1 SMS, ID - 279"
  # ERROR = 3 (no money), ID - 275
  # ERROR = 6 (message is denied), ID - 542
  # ERROR = 7 (invalid number), ID - 541
  # ERROR = 8 (can't to deliver), ID - 639)
  # ERROR = 9 (duplicate request, wait a minute)
  #
  class Error < StandardError
    REGEXP = /ERROR = (\d+) \((.+)\)/

    attr_reader :code, :body

    def initialize(message)
      @code, @body = parse message

      super message
    end

    def fatal?
      !soft?
    end

    def soft?
      code == 6 || code == 7 || code == 8 || code == 9
    end

    private

    def parse(message)
      m = REGEXP.match message

      raise "Unknown body format #{message}" unless m

      [m[1].to_i, m[2]]
    end

    alias message body
  end
end
