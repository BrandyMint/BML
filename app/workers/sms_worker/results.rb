class SmsWorker
  # Базовый класс
  #
  Result = Class.new StandardError

  # Все отлично!
  #
  AllRight = Class.new Result

  # Примеры ответов из Smsc:
  #
  # "OK - 1 SMS, ID - 279"
  # ERROR = 3 (no money), ID - 275
  # ERROR = 6 (message is denied), ID - 542
  # ERROR = 7 (invalid number), ID - 541
  # ERROR = 8 (can't to deliver), ID - 639)
  # ERROR = 9 (duplicate request, wait a minute)
  #
  class Error < Result
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
